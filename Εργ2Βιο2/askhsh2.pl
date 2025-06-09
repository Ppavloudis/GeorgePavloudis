use strict;
use warnings;

my %genetic_code = (
    'ATA'=>'I', 'ATC'=>'I', 'ATT'=>'I', 'ATG'=>'M',
    'ACA'=>'T', 'ACC'=>'T', 'ACG'=>'T', 'ACT'=>'T',
    'AAC'=>'N', 'AAT'=>'N', 'AAA'=>'K', 'AAG'=>'K',
    'AGC'=>'S', 'AGT'=>'S', 'AGA'=>'R', 'AGG'=>'R',
    'CTA'=>'L', 'CTC'=>'L', 'CTG'=>'L', 'CTT'=>'L',
    'CCA'=>'P', 'CCC'=>'P', 'CCG'=>'P', 'CCT'=>'P',
    'CAC'=>'H', 'CAT'=>'H', 'CAA'=>'Q', 'CAG'=>'Q',
    'CGA'=>'R', 'CGC'=>'R', 'CGG'=>'R', 'CGT'=>'R',
    'GTA'=>'V', 'GTC'=>'V', 'GTG'=>'V', 'GTT'=>'V',
    'GCA'=>'A', 'GCC'=>'A', 'GCG'=>'A', 'GCT'=>'A',
    'GAC'=>'D', 'GAT'=>'D', 'GAA'=>'E', 'GAG'=>'E',
    'GGA'=>'G', 'GGC'=>'G', 'GGG'=>'G', 'GGT'=>'G',
    'TCA'=>'S', 'TCC'=>'S', 'TCG'=>'S', 'TCT'=>'S',
    'TTC'=>'F', 'TTT'=>'F', 'TTA'=>'L', 'TTG'=>'L',
    'TAC'=>'Y', 'TAT'=>'Y', 'TAA'=>'_', 'TAG'=>'_', 'TGA'=>'_'
);

my $dna = "ATGAATTTCGGGCTTAGGGTTTAA"; 

sub reverse_complement {
    my $seq = shift;
    $seq =~ tr/ACGTacgt/TGCAtgca/;
    return reverse($seq);
}

sub find_orfs {
    my ($seq) = @_;
    my @orfs;

    for (my $i = 0; $i < length($seq) - 2; $i++) {
        if (substr($seq, $i, 3) eq "ATG") {
            for (my $j = $i + 3; $j < length($seq) - 2; $j += 3) {
                my $codon = substr($seq, $j, 3);
                if ($codon eq "TAA" or $codon eq "TAG" or $codon eq "TGA") {
                    my $orf_seq = substr($seq, $i, $j + 3 - $i);
                    push @orfs, $orf_seq;
                    last;
                }
            }
        }
    }
    return @orfs;
}

sub translate {
    my ($seq) = @_;
    my $protein = "";
    for (my $i = 0; $i < length($seq) - 2; $i += 3) {
        my $codon = substr($seq, $i, 3);
        $protein .= $genetic_code{$codon} // '?';
    }
    return $protein;
}

my @orfs_forward = find_orfs($dna);
foreach my $orf (@orfs_forward) {
    print "Forward ORF: $orf => ", translate($orf), "\n";
}

my $revcomp = reverse_complement($dna);
my @orfs_reverse = find_orfs($revcomp);
foreach my $orf (@orfs_reverse) {
    print "Reverse ORF: $orf => ", translate($orf), "\n";
}
