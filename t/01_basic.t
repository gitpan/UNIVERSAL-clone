use Test::More tests => 4;
use strict;
use lib qw(blib/lib);
use warnings;

use_ok( 'UNIVERSAL::clone' );

use_ok( 'UNIVERSAL::clone', '_nonexistent');
can_ok( 'UNIVERSAL', 'clone' );

ok( 'foo'->clone, "class name acceptable" );
