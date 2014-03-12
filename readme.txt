This program will reformat a file based on several criteria. If the data beings with 01, 02, or 03 it will then check to make sure 
the data following the + is 5 characters in length, including the decimal. If it is, it will then make sure it ends with a decimal. 
if it isn't 5 characters, it will prepend a 0.

I will start by splitting the line by whitespace. $id will store the first column (beginning with 01), $jda (julian day) will store
second column (beginning with 02), $clock will store third column (beginning with 03), and $remainder will hold the remainder of the
 line (including newline) which we are not altering. 
 
The newly formatted version will be output as "OriginalName"_formatted."OriginalExtension"

Please see Reformat.pl code for further documentation. 

