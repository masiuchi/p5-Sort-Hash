requires 'perl', '5.008001';

requires 'Data::Validate';
requires 'Tie::IxHash';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

