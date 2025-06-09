$protein_line = "MNVEHE_123! LLVE \$";
$protein_line =~ s/[^A-Z]/1/g;
print "Cleaned sequence: $protein_line\n";

