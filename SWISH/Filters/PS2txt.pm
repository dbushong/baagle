package SWISH::Filters::PS2txt;
use strict;
use vars qw/ $VERSION /;

$VERSION = '0.01';

sub new {
    my ( $class ) = @_;

    my $self = bless {
        mimetypes   => [ qr!application/postscript! ], # list of types this filter handles
    }, $class;


    # check for helpers
    return $self->set_programs( 'ps2ascii' );

}


sub filter {
    my ( $self, $doc ) = @_;

    my $content = $self->run_ps2ascii( $doc->fetch_filename ) || return;

    # update the document's content type
    $doc->set_content_type( 'text/plain' );

    # return the document
    return \$content;
}
1;

__END__

=head1 NAME

SWISH::Filters::PS2txt - Perl extension for filtering Postscript documents with Swish-e

=head1 DESCRIPTION

This is a plug-in module that uses the "ps2ascii" program from Ghostscript to convert Postscript documents
to text for indexing by Swish-e.  "ghostscript" can be downloaded from:

    http://www.cs.wisc.edu/~ghost/

The program "ps2ascii" must be installed and your PATH before running Swish-e.

This module is distributed as part of the Baagle Desktop Search system.

=head1 AUTHOR

David Bushong

=head1 SEE ALSO

L<SWISH::Filter>


