#!/bin/bash

# generate AUTHORS, modify .mailmap in case of duplicates
git log --reverse --format='%aN <%aE>' | perl -we '
BEGIN {
  %seen = (), @authors = ();
}
while (<>) {
  next if $seen{$_};
  $seen{$_} = push @authors, $_;
}
END {
  print "# Repository contributors (ordered by first contribution)\n";
  print "\n", @authors, "\n";
  print "P.S. Generated by ./tools/authors.sh\n";
}
' > "${BASH_SOURCE%/*}/../AUTHORS.md"
