package Text::Bidi::CapRTL;

use warnings;
use strict;
use Text::Bidi qw(caprtl_to_unicode unicode_to_caprtl);
use base qw(Text::Bidi);

our @EXPORT_OK = qw(log2vis);

$Text::Bidi::GlobalClass = __PACKAGE__;

sub log2vis {
    my $self = Text::Bidi::S(@_);
    my $in = caprtl_to_unicode(shift);
    my ($out, @res);
    if ( wantarray ) {
        ($out, @res) = $self->SUPER::log2vis($in, @_);
    } else {
        $out = $self->SUPER::log2vis($in, @_);
    }
    $out = unicode_to_caprtl($out);
    wantarray ? ($out, @res) : $out;
}

=pod

=head1 NAME

Text::Bidi::CapRTL - bidi algorithm with RTL capital letters

=head1 SYNOPSIS

        use Text::Bidi::CapRTL qw(log2vis);

        print scalar log2vis('car is THE CAR in arabic');
        # prints 'car is RAC EHT in arabic'

=head1 DESCRIPTION

This is a sub class of L<Text::Bidi> that overrides L<Text::Bidi/log2vis()> 
in that CAPITAL letters in the input and output strings are interpreted as 
right-to-left. It is mainly useful for testing and demonstration. The new 
I<log2vis()> function has exactly the same interface.

Loading this package will make all procedural calls to I<log2vis()> (without 
an explicit object) to use this convention.

=head1 SEE ALSO

L<Text::Bidi>

=head1 AUTHOR

Moshe Kamensky, L<mailto:kamensky@cpan.org>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Moshe Kamensky, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Text::Bidi::CapRTL

