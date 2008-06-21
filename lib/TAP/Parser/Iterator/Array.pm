package TAP::Parser::Iterator::Array;

use strict;
use vars qw($VERSION @ISA);

use TAP::Parser::Iterator ();

@ISA = 'TAP::Parser::Iterator';

=head1 NAME

TAP::Parser::Iterator::Array - Internal TAP::Parser array Iterator

=head1 VERSION

Version 3.12

=cut

$VERSION = '3.12';

=head1 SYNOPSIS

  # see TAP::Parser::IteratorFactory for preferred usage

  # to use directly:
  use TAP::Parser::Iterator::Array;
  my @data = ('foo', 'bar', baz');
  my $it   = TAP::Parser::Iterator::Array->new(\@data);
  my $line = $it->next;

=head1 DESCRIPTION

This is a simple iterator wrapper for arrays of scalar content, used by
L<TAP::Parser>.  Unless you're subclassing, you probably won't need to use
this module directly.

=head1 METHODS

=head2 Class Methods

=head3 C<new>

Create an iterator.  Takes one argument: an C<$array_ref>

=head2 Instance Methods

=head3 C<next>

Iterate through it, of course.

=head3 C<next_raw>

Iterate raw input without applying any fixes for quirky input syntax.

=head3 C<wait>

Get the wait status for this iterator. For an array iterator this will always
be zero.

=head3 C<exit>

Get the exit status for this iterator. For an array iterator this will always
be zero.

=cut

# new() implementation supplied by TAP::Object

sub _initialize {
    my ( $self, $thing ) = @_;
    chomp @$thing;
    $self->{idx}   = 0;
    $self->{array} = $thing;
    $self->{exit}  = undef;
    return $self;
}

sub wait { shift->exit }

sub exit {
    my $self = shift;
    return 0 if $self->{idx} >= @{ $self->{array} };
    return;
}

sub next_raw {
    my $self = shift;
    return $self->{array}->[ $self->{idx}++ ];
}

1;


=head1 ATTRIBUTION

Originally ripped off from L<Test::Harness>.

=head1 SEE ALSO

L<TAP::Object>,
L<TAP::Parser>,
L<TAP::Parser::Iterator>,
L<TAP::Parser::IteratorFactory>,

=cut

