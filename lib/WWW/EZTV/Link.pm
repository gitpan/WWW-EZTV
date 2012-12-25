package WWW::EZTV::Link;
{
  $WWW::EZTV::Link::VERSION = '0.02';
}
use Moose;
with 'WWW::EZTV::UA';

# ABSTRACT: EZTV episode link

has url => is => 'ro', isa => 'Str', required => 1;

1;

__END__
=pod

=head1 NAME

WWW::EZTV::Link - EZTV episode link

=head1 VERSION

version 0.02

=head1 AUTHOR

Diego Kuperman <diego@freekeylabs.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Diego Kuperman.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

