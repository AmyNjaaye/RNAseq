#!/usr/bin/perl
###################
#
# Written by Aminata NDIAYE 
# 		This script take as input a tab separated matrix wich contains results from DESeq analysis. 
#		It filters the input matrix and outputs a file with tab separated columns describing gene deferentially expressed with p-adj < 0.01 
# 		
#
####################


if (scalar @ARGV < 2)
{
	print "\n\nUsage : perl FilterPval.pl input_matrix_file output_file \n\n";
	exit;
}

#~~~~~~~~Arguments settings
my $input_matrix_file = $ARGV[0];
my $output_file = $ARGV[1];


#~~~~~~~~Opening input file for reading
open OUTPUT, '>', "$output_file.txt" or die "Cannot open $output_file\n";

#~~~~~~~~Opening output file for writing and set headers. 
printf OUTPUT ("%-20s %-20s\n", "Gene", "P-adj"); 

#~~~~~~~~Filter according to p-adj and output result in a .txt format
open my $file, '<', $input_matrix_file or die "Cannot open $input_matrix_file\n";
my @list_lines;
while (my $line = <$file>)
{
	chomp $line;
	next if($line =~ m/^"base"/);
	push @list_lines, $line;
}
                        
foreach my $list_line (@list_lines)
{
		my @attributes = split(/ /,$list_line);
		my $padj = $attributes[6];
		if (($padj < 0.01) and ($padj ne "NA"))
		{
			printf OUTPUT ("%-20s %-20s\n", "$attributes[0]", "$attributes[6]");
		}
}

close(OUTPUT);
close($file);
