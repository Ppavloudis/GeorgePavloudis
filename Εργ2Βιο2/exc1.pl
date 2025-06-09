while(<>){
    if(/^>\S+\|(\W+)\|/){
        print "Found accession: $1\n";
    }
}