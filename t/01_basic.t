use strict;
use warnings;

use Test::More;
use Sort::Hash qw( sort_hash );

my $ord_a = ord('a');
my %hash = map { $_ => chr( $ord_a + $_ - 1 ) } ( 1 .. 10 );

my $default_sort = sort_hash( \%hash );
is_deeply( [ keys %$default_sort ], [ 1 .. 10 ], 'Default sort' );

my $sort_by_value
    = sort_hash( \%hash, sub { $_[1]->{value} cmp $_[0]->{value} } );
is_deeply(
    [ values %$sort_by_value ],
    [ map { chr( $ord_a + $_ ) } reverse( 0 .. 9 ) ],
    'Reverse sort by value'
);

done_testing;

