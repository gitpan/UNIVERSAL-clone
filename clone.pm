#
# $Id: clone.pm 2 2005-12-19 01:04:49Z ryo $
#

package UNIVERSAL::clone;

use strict;
use vars qw($VERSION);
use warnings;
no  warnings "redefine";

$VERSION = '0.01';

my $preset = {
    clone    => 'Clone::clone',
    storable => 'Storable::dclone',
};

sub import {
    my $class = shift;
    my $cloner = shift || 'clone';

    my $sub = $preset->{ lc $cloner } || 'Clone::clone';

    # load module
    ( my $module = $sub ) =~ s/::[^:]+$//o;
    $module =~ s@::@/@go;
    eval "use $module";

    no strict 'refs';
    *{"UNIVERSAL::clone"} = sub {
	my $self = shift;
	if( defined $_[0] ){
	    return ref $_[0]
	      ? $sub->( @_ )
	      : $_[0];
	}
	else{
	    return ref $self
	      ? $sub->( $self )
	      : $self;
	}
    }
}

1;

__END__

=pod

=head1 NAME

UNIVERSAL::clone - add clone method to all classes and objects

=head1 SYNOPSIS

 use UNIVERSAL::clone;

 $foo = new Foo;
 $bar = $foo->clone;                  # $bar is a copy of $foo itself
 $bar = $foo->clone( $something );    # $bar is a copy of $something

 # or

 use UNIVERSAL::clone qw(Storable);    # use Storable::dclone
 use UNIVERSAL::clone qw(Clone);       # use Clone::clone (default)

=head1 DESCRIPTION

Loading the UNIVERSAL::clone module adds clone method to all classes and methods.
You can get a 'complete' copy of an object. This kind of copying is known as deep
(recursive) copy. See Storable or Clone perldoc for more details.

Internally Clone::clone() is called by default, but you can use standard Storable
module instead (but slower. plus, GLOB and CODE references are not acceptable).

=head1 SEE ALSO

Storable, Clone

=head1 AUTHOR

Okamoto RYO <ryo@aquahill.net>

=cut

