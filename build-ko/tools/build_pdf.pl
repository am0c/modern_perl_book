#!/usr/bin/perl

use strict;
use warnings;

use File::Spec::Functions qw( catfile catdir splitpath );

# getting chapter list
my @chapters = get_chapter_list();

# Check if pod2pdf is available
require App::pod2pdf
    or die "pod2pdf is not present in your PATH; please install App::pod2pdf\n";

my $outpath = catdir( qw( build-ko pdf ) );

for my $chapter ( @chapters ){
    my @filename = split( /\./ , $chapter );
    print "Converting $chapter to pdf\n";
    system( 'pod2pdf', '--noheader', $chapter, '--output-file',
        catfile(qw( build-ko pdf ), (splitpath($filename[0]))[-1] . '.pdf' ) );
}

print "PDFs have been generated in build-ko/pdf\n";

sub get_chapter_list
{
    my $glob_path = catfile( qw( build-ko chapters chapter_??.pod.txt ) );
    return glob $glob_path;
}
