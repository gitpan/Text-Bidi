# $Id$
# Created: Tue 27 Aug 2013 06:09:42 PM IDT
# Last Changed: Tue 27 Aug 2013 06:11:00 PM IDT

=head1 NAME

Text::Bidi::Array::Byte - XXX

=head1 SYNOPSIS

XXX

=head1 DESCRIPTION

XXX

=cut

package Text::Bidi::Array::Byte;

use 5.10.0;
use warnings;
use integer;
use strict;

our $VERSION = 1.0;

use Tie::Array;
use base qw(Tie::Array);
use overload 
    '${}' => 'as_scalar', '@{}' => 'as_array', '""' => 'data', fallback => 1;

=head1 METHODS

=cut

sub TIEARRAY {
    my $class = shift;
    my $data = shift || 0;
    if ( ref($data) ) {
        my @data = eval { @$data };
        $data = pack('C*', @data) unless $@;
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
    vec($self->{'data'}, $i, 8) = $v
}

sub FETCH {
    my ( $self, $i ) = @_;
    vec($self->{'data'}, $i, 8)
}

sub FETCHSIZE {
    length($_[0]->{'data'})
}

sub STORESIZE {
    my ($self, $s) = @_;
    if ($self->FETCHSIZE >= $s ) {
        substr($self->{'data'}, $s) = '';
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

