use strict;
use warnings;

my $sequence = "ATGCTAGC";

my $string_len = length($sequence);
print "Length of sequence is : $string_len\n";
my $lowercase = lc($sequence);
print "Changed String : $lowercase\n";
my $reversed = reverse($sequence);
print "Reversed sequence : $reversed\n";

