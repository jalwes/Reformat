#!c:/perl/bin/perl.exe -w
#written by Jon Alwes
#November 14th, 2013

#This program will reformat a file based on several criteria. If the data beings with 01, 02, or 03 it will then check to make sure 
#the data following the + is 5 characters in length, including the decimal. If it is, it will then make sure it ends with a decimal. 
#if it isnn't 5 characters, it will prepend a 0.

print "Enter the name of the file (and path if not in same directory) for reformatting: \n";
$file = <STDIN>;
chomp $file;

#Create output file name based on input filename
my @output = split (/\.+/, $file, 3);
my $outputFile = $output[0]."_reformatted.".$output[1];

open INPUTFILE, $file or die "Couldn't open $file: $!";
open OUTPUTFILE, ">$outputFile" or die "Couldn't open $outputFile: $!";

while (<INPUTFILE>){
	#Read a line
	my $line = $_;
	
	#Split the line by whitespace. $id will store the first column (beginning with 01), $jda (julian day) will store
	#second column (beginning with 02), $clock will store third column (beginning with 03), and $remainder will hold the 
	#remainder of the line (including newline) which we are not altering. 
	my ($id, $jda, $clock, $remainder) = split(/\s+/, $line, 4);
	
	#get prefix of id
	my ($id_prefix, $id_operator, $id_suffix) = split(/([+,-])/, $id);
	
	#If the id = 01, it is the beginning of a new line. We only
	#want to process those lines. 
	if ($id_prefix == 01) {
		
		##################################################################
		####################  Block for id  ##############################
		##################################################################
		
		if ($id_suffix =~ m/\.$/ && length($id_suffix) == 5) {
			#No changes needed
			print OUTPUTFILE "$id ";
		} else {
			#If id field is 5 characters long but does not end with a decimal. 
			if (length($id_suffix) == 5) {
				#split but keep the period. We won't keep anything trailing the decimal point. 
				my ($front, $junk) = split (/(?<=\.)/, $id_suffix);
				$id_suffix = $front;
			}
			
			#prepend 0s until we have 5 characters, including the decimal
			my $id_length = length($id_suffix);
			while ($id_length < 5) {
				$id_suffix = "0".$id_suffix;
				$id_length = $id_length+1;
			}
			
			#piece together new $id field for printing
			$id = $id_prefix . $id_operator . $id_suffix;
			print OUTPUTFILE "$id ";
		} 
		
		##################################################################
		##################### Block for jda ##############################
		##################################################################
	
		my ($jda_prefix, $jda_operator, $jda_suffix) = split(/([+,-])/, $jda);
		if ($jda_suffix =~ m/\.$/ && length($jda_suffix) == 5) {
			#No changes needed
			print OUTPUTFILE "$jda ";
		} else {
			#If id field is 5 characters long but does not end with a decimal. 
			if (length($jda_suffix) == 5) {
				#split but keep the period. We won't keep anything trailing the decimal point.
				my ($front, $junk) = split (/(?<=\.)/, $jda_suffix);
				$jda_suffix = $front;
			}
			
			#prepend 0s until we have 5 characters, including the decimal
			my $jda_length = length($jda_suffix);
			while ($jda_length < 5) {
				$jda_suffix = "0".$jda_suffix;
				$jda_length = $jda_length+1;
			}
			
			#piece together new $jda field for printing
			$jda = $jda_prefix . $jda_operator . $jda_suffix;
			print OUTPUTFILE "$jda ";
		} 
		
		##################################################################
		##################### Block for clock ############################
		##################################################################
	
		my ($clock_prefix, $clock_operator, $clock_suffix) = split(/([+,-])/, $clock);
		if ($clock_suffix =~ m/\.$/ && length($clock_suffix) == 5) {
			#No changes needed
			print OUTPUTFILE "$clock ";
		} else {
			#If id field is 5 characters long but does not end with a decimal. 
			if (length($clock_suffix) == 5) {
				#split but keep the period. We won't keep anything trailing the decimal point.
				my ($front, $junk) = split (/(?<=\.)/, $clock_suffix);
				$clock_suffix = $front;
			}
			
			#prepend 0s until we have 5 characters, including the decimal
			my $clock_length = length($clock_suffix);
			while ($clock_length < 5) {
				$clock_suffix = "0".$clock_suffix;
				$clock_length = $clock_length+1;
			}
			#piece together new $clock field for printing
			$clock = $clock_prefix . $clock_operator . $clock_suffix;
			print OUTPUTFILE "$clock ";
		} 
		#print the remainder of the line (columns 4+, which we didn't alter)
		print OUTPUTFILE $remainder;
	} else {
		#If the line does not begin with 01, just write line to output
		print OUTPUTFILE $_;
	}
}

close INPUTFILE;
close OUTPUTFILE;