use Test::More tests => 6;
use strict;
use lib qw(blib/lib);
use warnings;

my $foo = bless { bar => bless [], 'Bar' }, 'Foo';

SKIP: {
    eval "require Clone";
    skip 'Clone not installed', 6, if $@;

    use_ok( 'UNIVERSAL::clone', 'clone');
    can_ok( 'UNIVERSAL', 'clone' );
    is_deeply( $foo->clone, $foo, "Check if Clone::clone'd data ok" );

    ok( $foo->clone, "self acceptable" );
    ok( $foo->clone( "this is a test." ), "scalar acceptable" );
    ok( $foo->clone( {} ), "reference acceptable" );
};

