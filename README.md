# NAME

Sort::Hash - Sort hash.

# SYNOPSIS

    use Sort::Hash qw( sort_hash );

    my %hash = (
        1 => 'a',
        2 => 'b',
        3 => 'c',
    );

    my $default_sort = sort_hash(\%hash);
    # "keys %$default_sort" always returns "( 1, 2, 3 )".

    my $sort_by_value
        = sort_hash( \%hash, sub { $_[1]->{value} cmp $_[0]->{value} } );
    # "values %$sort_by_value" always returns "( 'c', 'b', 'a' )".

# DESCRIPTION

Sort::Hash module provides 'sort\_hash' function, which enable to sort hash.

- sort\_hash($hash\_ref\[, $sub\])

    Sort hash indicated by $hash\_ref.

    $sub is used when sorting $hash\_ref. When $sub is not set, the following subroutine is used.

        sub _sub_default {
            if (   defined is_numeric( $_[0]->{key} )
                && defined is_numeric( $_[1]->{key} ) )
            {
                $_[0]->{key} <=> $_[1]->{key};
            }
            else {
                $_[0]->{key} cmp $_[1]->{key};
            }
        }

# LICENSE

Copyright (C) Masahiro Iuchi.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Masahiro Iuchi &lt;masahiro.iuchi@gmail.com>
