package WWW::EZTV::UA;
{
  $WWW::EZTV::UA::VERSION = '0.01';
}
use Moose::Role;
use Mojo::UserAgent;

# ABSTRACT: User agent for EZTV scrapper.

has ua  => ( is => 'ro', lazy => 1, default => sub { $EZTV::Global::UA || ($EZTV::Global::UA = Mojo::UserAgent->new) } );

sub get_response {
    my ($self, $url) = (shift, shift);

    my $tx = $self->ua->get( $url );
    if ( my $res = $tx->success ) {
        return $res;
    }
    else {
        my ($err, $code) = $tx->error;
        my $message = shift || 'User agent error';
        die "$message: $err ($code)";
    }
}

1;

__END__
=pod

=head1 NAME

WWW::EZTV::UA - User agent for EZTV scrapper.

=head1 VERSION

version 0.01

=head1 METHODS

=head2 get_response

=head1 AUTHOR

Diego Kuperman <diego@freekeylabs.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Diego Kuperman.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
