package Sort::Hash;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use base qw( Exporter );
our @EXPORT_OK = qw( sort_hash );

use Data::Validate qw( is_numeric );
use Tie::IxHash;

sub sort_hash {
    my ( $data, $sub ) = @_;
    $sub ||= \&_sub_default;
    my $ref = ref $data;
    if ( $ref && $ref eq 'ARRAY' ) {
        return [ map { sort_hash( $_, $sub ) } @$data ];
    }
    elsif ( $ref && $ref eq 'HASH' ) {
        my @temp = map { +{ key => $_, value => $data->{$_} } } keys %$data;
        my @sorted_temp = sort { $sub->( $a, $b ) } @temp;
        tie my %sorted_hash, 'Tie::IxHash',
            map { $_->{key} => sort_hash( $_->{value}, $sub ) } @sorted_temp;
        return \%sorted_hash;
    }
    else {
        return $data;
    }
}

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

1;
__END__

=encoding utf-8

=head1 NAME

Sort::Hash - Sort hash.

=head1 SYNOPSIS

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

=head1 DESCRIPTION

Sort::Hash module provides 'sort_hash' function, which enable to sort hash.

=over 4

=item sort_hash($hash_ref[, $sub])

Sort hash indicated by $hash_ref.

$sub is used when sorting $hash_ref. When $sub is not set, the following subroutine is used.

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

=back

=head1 LICENSE

Copyright (C) Masahiro Iuchi.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Masahiro Iuchi E<lt>masahiro.iuchi@gmail.comE<gt>

=cut

