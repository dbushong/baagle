BEGIN { 
  use YAML '!:DEFAULT';

  -f 'baagle.conf' ||
    (print STDERR (
      "$0: Missing baagle.conf; read the Installation section of the README.\n"
    )) && exit;

  %::CONFIG = %{YAML::LoadFile('baagle.conf')};

  push(@INC, $::CONFIG{SWISH_PERL_LIB});
};

package DirectorySearch;

our @ISA    = qw(Exporter);
our @EXPORT = qw(modTime max min ceil touch);

use strict;
use warnings;

our $VERSION = '2.0';

sub modTime(@) {
  my @m = map { (stat($_))[9] || 0 } @_;
  wantarray ? @m : $m[0];
}

sub touch($) {
  my ($f) = @_;
  if (-f $f) {
    utime(undef, undef, $f);
  } else {
    open(T, ">$f");
    close(T);
  }
}

sub ceil($) {
  my ($n) = @_;
  my $i = int($n);
  ($i < $n) ? $i+1 : $i;
}

sub max(@) {
  my $m = shift;
  for (@_) { $m = $_ if $_ > $m }
  $m;
}

sub min(@) {
  my $m = shift;
  for (@_) { $m = $_ if $_ < $m }
  $m;
}

1;
