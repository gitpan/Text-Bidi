# $Id$
# Created: Wed 11 Sep 2013 09:47:56 AM IDT
# Last Changed: Wed 11 Sep 2013 11:36:45 AM IDT

=head1 NAME

Text::Bidi::Array - Base class for dual life arrays

=head1 SYNOPSIS

    use Text::Bidi::Array::Byte;
    my $a = new Text::Bidi::Array::Byte "abc";
    say $a->[1]; # says 98
    say $$a; # says abc
    say "$a"; # also says abc


=head1 DESCRIPTION

This is an abstract base class for objects that function as ``dual-life'' 
arrays: When viewed as an array reference, it functions as a usual array of 
numbers. When used as a scalar reference, it returns the same array as a 
packed string. The packing specification depends on the sub-class. These 
classes are used in L<Text::Bidi> to conveniently pass arrays to the 
underlying fribidi library, but could be of independent interest.

=cut

package Text::Bidi::Array;

use 5.10.0;
use warnings;
use integer;
use strict;
use Carp;

our $VERSION = 1.0;

use Tie::Array;
use base qw(Tie::Array);

=head1 OVERLOADED OPERATORS

An object of this type can be dereferenced either as a scalar or as an array.  
In the first case, it returns the packed (string) representation of the 
array. In the second, it returns the unpacked array of numbers.

The packed representation is also returned when the object is used as a 
string.

=cut

use overload 
    '${}' => 'as_scalar', '@{}' => 'as_array', '""' => 'data', fallback => 1;

=head1 CONSTRUCTION

    $a = new Text::Bidi::Array::<Type> $data

Create a new array of the given B<Type>, and initialise it with I<$data>.  
I<$data> can be either a string, which the new object then view as an array 
of the given type, or an array reference (more precisely, anything that can 
be dereferenced as an array), which is then packed according to the rules of 
B<Type>. If no I<$data> is given, it defaults to 0.

=cut

sub new {
    my $class = shift;
    my $self = tie(my @magic, $class, @_);
    $self->{'magic'} = \@magic;
    $self
}

=head1 SEE ALSO

L<Text::Bidi::Array::Byte>, L<Text::Bidi::Array::Long>

=head1 FOR IMPLEMENTORS

The rest of this documentation is for writing specific derived classes. The 
object is represented internally as a hashref. To implement a particular 
instance, the following methods should be implemented.  Each of these should 
manipulate the field C<data>, which is the string that stores the actual 
value. Unimplemented methods will lead to croaking. See 
L<Text::Bidi::Array::Byte> and L<Text::Bidi::Array::Long> for examples.

=over

=item $self->pack(@data)

Convert (pack) an array of numbers into a string according to the format of 
the current class (this will probably be a class method). Returns the string.

=back

The following methods should behave as described in L<Tie::Array>.

=over

=item $self->STORE($index, $value)

Store the I<$value> in the part of C<$self-E<gt>{'data'}> corresponding to 
I<$index>.

=item $self->FETCH($index)

Fetch the value at I<$index> from the correct part of C<$self-E<gt>{'data'}>.

=item $self->STORESIZE($count)

Modify C<$self-E<gt>{'data'}> to represent an array of size I<$count>.

=item $self->FETCHSIZE()

Return the size of the array represented by C<$self-E<gt>{'data'}>.

=back

=cut

sub TIEARRAY {
    my $class = shift;
    my $data = shift || 0;
    my $self = { @_ };
    bless $self => $class;
    $self->init($data)
}

sub init {
    my ($self, $data) = @_;
    if ( ref($data) ) {
        my @data = eval { @$data };
        croak $@ if $@;
        $data = $self->pack(@data);
    }
    $self->{'data'} = $data;
    return $self
}

sub data { $_[0]->{'data'} }

sub as_scalar { \$_[0]->{'data'} }

sub as_array { $_[0]->{'magic'} }

sub CLEAR {
    $_[0]->{'data'} = 0
}

1;

=head1 AUTHOR

Moshe Kamensky  (E<lt>kamensky@cpan.org<gt>) - Copyright (c) 2013

=head1 LICENSE

This program is free software. You may copy or 
redistribute it under the same terms as Perl itself.

=cut

