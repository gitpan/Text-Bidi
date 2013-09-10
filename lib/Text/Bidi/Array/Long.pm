# $Id$
# Created: Tue 27 Aug 2013 06:12:39 PM IDT
# Last Changed: Tue 27 Aug 2013 06:40:54 PM IDT

=head1 NAME

Text::Bidi::Array::Long - XXX

=head1 SYNOPSIS

XXX

=head1 DESCRIPTION

XXX

=cut

package Text::Bidi::Array::Long;

use 5.10.0;
use warnings;
use integer;
use strict;
use Carp;


our $VERSION = 1.0;

use Tie::Array;
use base qw(Tie::Array);
use overload '${}' => 'as_scalar', '@{}' => 'as_array', fallback => 1;

BEGIN {
# fribidi uses native endianness, vec uses N (big-endian)

    use Config;

    if ( $Config{'byteorder'} % 10 == 1 ) {
        # big-endian
        *big_to_native = sub { @_ };
        *native_to_big = sub { @_ };
    } else {
        *big_to_native = sub { unpack('L*', pack('N*', @_)) };
        *native_to_big = sub { unpack('N*', pack('L*', @_)) };
    }
}

=head1 METHODS

=cut


sub TIEARRAY {
    my $class = shift;
    my $data = shift || 0;
    if ( ref($data) ) {
        my @data = eval { @$data };
        croak $@ if $@;
        $data = pack('L*', @data); # unless $@;
    }
    my $self = { data => $data, @_ };
    bless $self => $class
}

sub data : lvalue { $_[0]->{'data'} }

sub new {
    my $class = shift;
    my $self = tie(my @magic, $class, @_);
    $self->{'magic'} = \@magic;
    $self
}

sub as_scalar { \$_[0]->{'data'} }

sub as_array { $_[0]->{'magic'} }

sub STORE {
    my ( $self, $i, $v ) = @_;
    vec($self->{'data'}, $i, 32) = native_to_big($v)
}

sub FETCH {
    my ( $self, $i ) = @_;
    big_to_native(vec($self->{'data'}, $i, 32))
}

sub FETCHSIZE {
    length($_[0]->{'data'})/4
}

sub STORESIZE {
    my ($self, $s) = @_;
    if ($self->FETCHSIZE >= $s ) {
        substr($self->{'data'}, $s * 4) = '';
    } else {
        $self->STORE($s - 1, 0);
    }
}

sub CLEAR {
    $_[0]->{'data'} = 0
}


1;

__END__

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 FILES

=head1 BUGS

=head1 AUTHOR

Moshe Kamensky  (E<lt>samvimes@fastmail.fmE<gt>) - Copyright (c) 2013

=head1 LICENSE

This program is free software. You may copy or 
redistribute it under the same terms as Perl itself.

=cut

