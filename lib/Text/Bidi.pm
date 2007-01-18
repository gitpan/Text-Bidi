package Text::Bidi;

use warnings;
use strict 'vars';
use Exporter;
use base qw(Exporter);
use Carp;

=head1 NAME

Text::Bidi - Unicode bidi algorithm using libfribidi

=cut

our $VERSION = '0.03';


use Encode;
use Text::Bidi::private;
use Text::Bidi::mirrored;

=head1 SYNOPSIS

    use Text::Bidi;
    $visual = log2vis($logical);

    ($visual, $paradir, $l2v, $v2l, $embedding) =
        log2vis($logical, $paradir);


=head1 EXPORT

The following functions can be exported:

=over

=item *

L</log2vis()>

=item *

L</caprtl_to_unicode()>

=item *

L</unicode_to_caprtl()>

=item *

L</get_width()>

=item *

L</set_width()>

=item *

L</get_reset()>

=item *

L</set_reset()>

=item *

L</get_clean()>

=item *

L</set_clean()>

=back

All of them can be exported together using the C<:all> tag.

=cut

BEGIN {
    our %EXPORT_TAGS = (
        'all' => [ qw(
            log2vis
            caprtl_to_unicode
            unicode_to_caprtl
            set_width
            get_width
            set_reset
            get_reset
            set_clean
            get_clean
        ) ],
    );
    our @EXPORT_OK = ( @{$EXPORT_TAGS{'all'}} );
    our @EXPORT = qw(); ## no critic
}

=head1 Description

This module provides basic support for the Unicode bidirectional text (Bidi) 
algorithm, for displaying text consisting of both left-to-right and 
right-to-left written languages (like Hebrew and Arabic.) It does so using a 
I<swig> interface file to the I<libfribidi> library.

Though several libfribidi functions are provided by the swig interface file, 
the standard usage of this module is provided by one function, L</log2vis()>, 
that translates a logical string into a visual one. In addition, there are 
several utility functions, and some functions that implement part of the 
algorithm (see L</"Comparison with libfribidi and FriBidi.pm"> for the reason 
this is needed.)

=head2 The object oriented approach

All functions here can be called using either a procedural or an object 
oriented approach. For example, you may do either

        $visual = log2vis($logical);

or

        $bidi = new Text::Bidi;
        $visual = $bidi->log2vis($logical);

The advantages of the second form is that it is easier to move to a 
sub-class, and that two or more objects with different parameters can be used 
simultaneously.

If you do sub-class this class, and want the procedural interface to use your 
functions, put a line like

        $Text::Bidi::GlobalClass = __PACKAGE__;

in your module.

=cut

# The following mechanism is used to provide both kinds of interface: Every 
# method starts with 'my $self = S(@_)' instead of 'my $self = shift'. S 
# shifts and returns the object if there is one, or returns a global object, 
# stored in $Global, if there is in @_. The first time $Global is needed, it 
# is created with type $GlobalClass.

my $Global;
our $GlobalClass = __PACKAGE__;

sub S(\@) {
    my $l = shift;
    my $s = $l->[0];
    return shift @$l if eval { $s->isa('Text::Bidi') };
    $Global = new $GlobalClass unless $Global;
    $Global
}

=head1 Types and Namespaces

The following constants are imported from the fribidi library:

=over

=item *

Constants of the form B<FRIBIDI_TYPE_FOO> are available as 
C<$Text::Bidi::Type::FOO> (note that, though these are variables, they are 
read-only)

=item *

Constants of the form B<FRIBIDI_MASK_FOO> are converted to 
C<$Text::Bidi::Mask::FOO>.

=item *

Constants of the form B<UNI_FOO> are converted to the character they 
represent, and assigned to C<$Text::Bidi::Unicode::FOO>.

=back

In addition, the hash C<%Mirrored> maps mirrored characters to their counter 
parts, and the scalar C<$Mirrored> is a pattern that matches one mirrored 
character.

=cut

foreach ( keys %Text::Bidi::private:: ) {
    *{"Text::Bidi::Type::$1"} = *{"Text::Bidi::private::$_"} 
        if /^FRIBIDI_TYPE_([A-Z]*)$/;
    *{"Text::Bidi::Mask::$1"} = *{"Text::Bidi::private::$_"} 
        if /^FRIBIDI_MASK_([A-Z]*)$/;
    no warnings 'once'; ## no critic
    ${"Text::Bidi::Unicode::$1"} = chr(${"Text::Bidi::private::$_"})
        if /^UNI_([A-Z]*)$/;
}

=head1 Functions

=head2 The following functions are of interest to the user

=head3 new()

Create a new instance of a bidi translator. The following key-value 
parameters are allowed:

=over

=item width

The width, in characters, of the displayed string. This affects the 
reordering algorithm. The default is B<undef>, which will assume that no 
line-breaking happens.

=item reset

A string of the characters that function as field (segment) separators. The 
default is B<"\x{2029}\x{09}\x{11}">, which is (to my understanding) the 
unicode specification.

=item clean

If true, L</log2vis()> will remove any explicit bidi marks in the visual 
string, and adjust the mapping arrays accordingly. Default is B<true>.

=back

These parameters can be accessed using L</get_width()>, L</set_width()> and 
similar functions.

=cut

sub new {
    my $class = shift;
    my $self = {
        'reset' => "\x{2029}\x{09}\x{11}",
        'clean' => 1,
        'width' => undef,
        @_ };
    bless $self => $class;
}

=head3 get_width()

=head3 set_width()

=head3 get_reset()

=head3 set_reset()

=head3 get_clean()

=head3 set_clean()

Query or set the values of the corresponding parameters. See L</new()> for 
details about the parameters.

=cut

for my $param ( qw(width reset clean) ) {
    *{"set_$param"} = sub {
        my $s = S(@_);
        $s->{$param} = shift;
    };

    *{"get_$param"} = sub {
        my $s = S(@_);
        $s->{$param}
    };
}

=head3 log2vis()

This function provides the main functionality. It can be called, similarly to  
C<fribidi_log2vis> of the I<fribidi> library, as follows:

        ($vis, $dir, $l2v, $v2l, $levels) =
            log2vis($log[, $dir[, $width]])

The arguments are:

=over

=item $log

The logical string

=item $dir

Override the base direction of the paragraph. The possible values are 
C<$Text::Bidi::Type::RTL>, C<$Text::Bidi::Type::LTR> or 
C<$Text::Bidi::Type::ON>. The default, if not given, is 
C<$Text::Bidi::Type::ON>, which means that the direction should be determined 
according to the bidi algorithm.

=item $width

The width at which the string is broken. This overrides, and has the same 
meaning, as the width parameter set by L</set_width()>. As with that 
parameter, a value of C<undef> means that no line breaking should be done.

=back

The outputs are as follows:

=over

=item $vis

The visual string. In scalar context, this is the only parameter returned 
(and in this case the function may work slightly faster.)

=item $l2v

An arrayref representing the map from the logical string to the visual one, 
so the C<$i>-th character of the logical string will be in position 
C<$l2v->[$i]> of the visual one.

=item $v2l

The inverse function, mapping characters in the visual string to the logical 
one.

=item $levels

The embedding levels - an arrayref assigning to each character of the logical 
string the nesting level of text of different directions to which it belongs.  
Pure left-to-right text has embedding level 0. A character is left-to-right 
(within this string) iff it has even embedding level.

=back

=cut

sub log2vis {
    my $self = S(@_);
    my $str = shift;
    my $width = exists $_[1] ? pop : $self->get_width;
    my $wa = wantarray;
    my $in = encode('UTF-32LE', $str);
    my ($res, $Dir, $L2v, $V2l, $Levels);
    if ( $width and $width < length($str) ) {
        # log2vis doesn't take the display width into account, so we have to 
        # do it ourselves. Get just the embedding levels
        ($Dir, my $emb) = 
            Text::Bidi::private::fribidi_log2vis_get_embedding_levels($in, @_);
        my $i = 0;
        while ( $i < length($str) ) {
            my $vis;
            if ($wa) {
                my ($v2l, $levels, $int);
                ($v2l, $levels, $int, $vis) = 
                    $self->reorder($str, $emb, $Dir, $i, $width);
                push @$V2l, @$v2l;
                push @$Levels, @$levels;
            } else {
                $vis = $self->reorder($str, $emb, $Dir, $i, $width);
            }
            $res .= $vis;
            $i += $width;
        }
        $res = encode('UTF-32LE', $res) if $self->get_clean;
    } else {
        # no width required - may use log2vis from fribidi
        if ($wa) {
            ($res, $Dir, $L2v, $V2l, $Levels) = 
                Text::Bidi::private::log2vis($in, @_);
        } else {
            $res = Text::Bidi::private::log2vis($in, @_);
        }
        $res = decode('UTF-32LE', $res) unless $self->get_clean;
    }
    if ( $self->get_clean ) {
        ($res, $V2l) = 
            Text::Bidi::private::fribidi_remove_bidi_marks($res, $V2l);
        $res = decode('UTF-32LE', $res); 
        if ($V2l) {
            $L2v = $self->invert($V2l);
        }
    } elsif ( $wa and not $L2v ) {
        $L2v = $self->invert($V2l);
    }
    return $wa ? ($res, $Dir, $L2v, $V2l, $Levels) : $res;
}

=head2 Functions implementing parts of the algorithm

The following functions, that implement parts of the algorithm, are used by 
L</log2vis()>

=head3 levels2intervals()

This function accepts an arrayref of embedding levels and returns an arrayref 
that, at place C<$i>, contains a hash of intervals (to the index of the start 
of the interval it assigns the index of the end of it), such that each of 
them is a maximal interval of embedding levels at least C<$i>. For example, 
to the embedding levels:

        0011122111333220001

we get

        [
        { 0 => 18 },
        { 2 => 14, 18 => 18 },
        { 5 => 6, 10 => 14 },
        { 10 => 12 }
        ]

=cut

sub levels2intervals {
    S(@_);
    my $lvl = shift;
    return [] unless @$lvl;
    my @int;
    push @{$int[$_]}, 0 foreach ( 0 .. $lvl->[0] );
    for my $i (0 .. $#$lvl - 1 ) {
        if ($lvl->[$i+1] >= $lvl->[$i]) {
            foreach ( $lvl->[$i] + 1 .. $lvl->[$i+1] ) {
                push @{$int[$_]}, $i+1;
            }
        } else {
            foreach ( $lvl->[$i+1] + 1 .. $lvl->[$i] ) {
                push @{$int[$_]}, $i;
            }
        }
    }
    push @{$int[$_]}, $#$lvl foreach ( 0 .. $lvl->[-1] );
    my $res;
    for my $i ( 0..$#int ) {
        %{$res->[$i]} = @{$int[$i]};
    }
    $res
}

sub _reorder {
    my $self = S(@_);
    my ($level, $from, $to) = @_;
    my @res;
    $level++;
    foreach ( sort { $a <=> $b } keys %{$self->{'_int'}[$level]} ) {
        next if $_ < $from;
        last if $_ > $to;
        my $t = $self->{'_int'}[$level]{$_};
        $t = $to if $t > $to;
        $self->_reorder($level, $_, $t);
        @{$self->{'_chars'}}[$_..$t] = reverse @{$self->{'_chars'}}[$_..$t];
        @{$self->{'_v2l'}}[$_..$t] = reverse @{$self->{'_v2l'}}[$_..$t] 
            if $self->{'_v2l'};
        $from = $t + 1;
    }
}

=head3 reorder()

This function implements the reordering part of the bidi algorithm (section 
3.4, L1-L4.) The input is the logical string, the (arrayref of) embedding
levels, the base dir of the paragraph, a position in the logical string, and 
a length. The default for the position is 0, and for the length till the end 
of the string. The function will return the v2l mapping, the modified 
embedding levels, the intervals for these levels (as computed by 
L</levels2intervals()>) and the visual string, all for the part of the string 
given by the position and the length, and assuming that the string is broken 
after this segment. In scalar context, only the visual string is returned.

=cut

sub reorder {
    my $self = S(@_);
    my ($log, $levels, $dir, $from, $len) = @_;
    $from = 0 unless $from;
    $len = length($log) - $from if (not $len or $len > length($log) - $from);
    $dir = ($dir == $Text::Bidi::Type::RTL) ? 1 : 0;
    $self->{'_chars'} = [split '', substr($log, $from, $len)];
    $len--;
    my @levels = @$levels[$from .. $from + $len];
    $self->{'_v2l'} = wantarray ? [$from .. ($from+$len)] : undef;
    my $reset = $self->get_reset;
    $reset = qr/[\Q$reset\E]/o;
    # L1
    my $j = -1;
    for my $i ( 0 .. $len ) {
        if ( $self->{'_chars'}[$i] =~ $reset ) {
            $levels[$_] = $dir foreach ($j+1 .. $i);
            $j = $i;
        } elsif ( $self->{'_chars'}[$i] =~ /\S/ ) {
            $j = $i;
        }
    }
    $levels[$_] = $dir foreach ($j+1 .. $len );
    $self->{'_int'} = $self->levels2intervals(\@levels);

    # L2
    $self->_reorder(0, 0, $len);

    # L3, L4 TODO

    my $out = join('', @{$self->{'_chars'}});
    wantarray ? ($self->{'_v2l'}, \@levels, $self->{'_int'}, $out) : $out;
}

=head3 invert()

Compute the inverse of a function given by an array. This is used to convert 
the L</$v2l> mapping to L</$l2v>.

=cut

sub invert {
    S(@_);
    my @res;
    @res[@{$_[0]}] = 0..$#{$_[0]};
    \@res
}

=head2 Utility functions

The following functions are available mainly for testing. See also 
L<Text::Bidi::CapRTL> for a possibly simpler interface.

=head3 caprtl_to_unicode()

Convert a string where right-to-left text is represented by capital letters, 
and bidi marks by control sequences, to a string with actual right-to-left 
characters and bidi marks. The control sequences are of the form C<_C>, where 
C<C> is a character. Run

        fribidi --charsetdesc CapRTL

for a description of the translation table.

=cut

sub caprtl_to_unicode {
    Text::Bidi::private::fribidi_char_set_enter_cap_rtl();
    decode('UTF-32LE', Text::Bidi::private::fribidi_cap_rtl_to_unicode(@_))
}

=head3 unicode_to_caprtl()

Perform the inverse of L</caprtl_to_unicode()>

=cut

sub unicode_to_caprtl {
    Text::Bidi::private::fribidi_char_set_enter_cap_rtl();
    Text::Bidi::private::fribidi_unicode_to_cap_rtl(encode('UTF-32LE', shift));
}

=head1 Comparison with libfribidi and FriBidi.pm

The module has mostly the same interface as L<FriBidi>, the module written 
originally with the fribidi library. The main differences are:

=over

=item *

The function L</log2vis()> in the current implementation returns the rest of 
the data returned by C<fribidi_log2vis>, namely, the mappings between the 
strings and the embedding levels.

=item *

The translation of the logical to visual strings optionally takes into 
account the display width, for the purpose of line breaks. As far as I can 
see, this functionality is not available in libfribidi. For this reason, part 
of the implementation of the algorithm that deals with reordering, and is not 
provided as a separate function in libfribidi, is re-implemented here.

=item *

In this implementation, L</log2vis()> works with native perl strings.  
Functions like C<iso88598_to_unicode> are not provided, since their 
functionality is provided by the L<Encode> module.

=item *

The paragraph direction is given by fribidi constants rather than strings.

=back

=head1 BUGS

The L</caprtl_to_unicode()> and L</unicode_to_caprtl()> functions currently 
do not work, because of what appears to be a bug in libfribidi. The details 
are in L<https://bugs.freedesktop.org/show_bug.cgi?id=8040>.

=head1 SEE ALSO

L<Text::Bidi::CapRTL>, L<Encode>

The fribidi library: L<http://fribidi.org/>, 
L<http://imagic.weizmann.ac.il/~dov/freesw/FriBidi/>

Swig: L<http://www.swig.org>

The unicode bidi algorithm: L<http://www.unicode.org/unicode/reports/tr9/>

=head1 AUTHOR

Moshe Kamensky, L<mailto:kamensky@cpan.org>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Moshe Kamensky, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Text::Bidi
