package WWW::EZTV;
{
  $WWW::EZTV::VERSION = '0.01';
}
use Moose;
with 'WWW::EZTV::UA';
use WWW::EZTV::Show;

# ABSTRACT: EZTV scrapper

has url       => ( is => 'ro', lazy => 1, default => sub { Mojo::URL->new('http://eztv.it/') } );
has url_shows => ( is => 'ro', lazy => 1, default => sub { shift->url->clone->path('/showlist/') } );

has shows => 
    is      => 'ro',
    lazy    => 1,
    builder => '_build_shows',
    handles => {
        find_show    => 'first',
        has_shows    => 'size',
    };

sub _build_shows {
    my $self = shift;

    $self->get_response( $self->url_shows )->dom->find('table.forum_header_border tr[name="hover"]')->map(sub {
        my $tr = shift;
        my $link = $tr->at('td:nth-child(1) a');
        WWW::EZTV::Show->new(
            title  => $link->all_text,
            url    => $self->url->clone->path($link->attrs('href')),
            status => lc($tr->at('td:nth-child(2)')->all_text),
            rating => $tr->at('td:nth-child(3)')->all_text
        );
    });
}






1;

__END__
=pod

=head1 NAME

WWW::EZTV - EZTV scrapper

=head1 VERSION

version 0.01

=head1 SYNOPSIS

First create a WWW::EZTV object to navigate.

    use WWW::EZTV;

    my $eztv = WWW::EZTV->new;

    my $show = $eztv->find_show(sub{ $_->name =~ /Walking dead/i });

    my $episode = $show->find_episode(sub{ 
        $_->season == 3 && 
        $_->number == 8 && 
        $_->quality eq 'standard' 
    });

=head1 ATTRIBUTES

=head2 url
EZTV URL.

=head2 url_shows
EZTV shows URL.

=head2 shows
L<Mojo::Collection> of L<WWW::EZTV::Show> objects.

=head2 has_shows
How many shows exists.

=head1 METHODS

=head2 find_show
Find first L<WWW::EZTV::Show> object matching the given criteria. 
This method accept an anon function.

=head1 AUTHOR

Diego Kuperman <diego@freekeylabs.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Diego Kuperman.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

