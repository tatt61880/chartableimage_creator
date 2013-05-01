#!/usr/bin/perl -w
# CopyRight (C) 2013 @tatt61880
# Last Modified: 2013/05/02 01:20:47.

use strict;
use warnings;
use Getopt::Long;
use Encode;
use File::Basename;
use Image::Magick;

my $input_dir = 'input';

# output

my $char_table = "input\\chartable.txt";
my $font_file;
my $output_file;

GetOptions(
    'char_table:s' => \$char_table,
    'input:s' => \$font_file,
    'output:s' => \$output_file,
);

my $output_dir = dirname($output_file);
mkdir $output_dir if (!-d $output_dir);

die "There isn't $font_file.\n" unless open(F, "<$font_file");
close F;

open(FH, "<$char_table") or die "$char_table couldn't be opened.\n";

my @char;
my @temp;
my @table;
my $max_row = 0;
my $max_col = 0;

while(<FH>){
    chomp;
    @temp = split /\t| /;
    $max_row++;
    $max_col = @temp > $max_col ? @temp : $max_col;
    push @table, @temp;
}
print "max_row = $max_row\n";
print "max_col = $max_col\n";

push @char, map {/(.+)/} @table;
close(FH);

my $i = 0;
use constant {
    FONT_WIDTH => 64,
    FONT_HEIGHT => 64
};

my $output_image = Image::Magick->new;
$output_image->Set(size=>(FONT_WIDTH * $max_col) . "x" . (FONT_HEIGHT * $max_row));
$output_image->ReadImage('xc:black');
#$output_image->ReadImage('xc:transparent'); # transparent-png

for (@char) {
    print ".";
    my ($row, $col) = (int($i / $max_col), $i % $max_col);
    my ($x, $y) = (FONT_WIDTH * $col, FONT_HEIGHT * $row);

    # canvas
    my $image = Image::Magick->new;
    $image->Set(size=>FONT_WIDTH . "x" . FONT_HEIGHT);
    $image->ReadImage('xc:transparent');

    # draw char(/chars)
    $image->Annotate(
        encoding=>'UTF-8',
        font=>$font_file,
        text=>$_,
        gravity=>'Center',
        fill=>'white',
        #stroke=>'red',
        pointsize=>52
    );
    $output_image->Composite(
        image=>$image,
        x=>$x,
        y=>$y,
    );
    $i++;
}

# Save image
$output_image->Write($output_file);

exit;

