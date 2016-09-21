=head1 NAME

EPrints::Apache::RobotsTxt

=cut

######################################################################
#
# EPrints::Apache::RobotsTxt
#
######################################################################
#
#
######################################################################

package EPrints::Apache::RobotsTxt;

use EPrints::Apache::AnApache; # exports apache constants

use strict;
use warnings;

sub handler
{
	my( $r ) = @_;

	my $repository = $EPrints::HANDLE->current_repository;


	my $langid = EPrints::Session::get_session_language( $repository, $r );
	my @static_dirs = $repository->get_static_dirs( $langid );
	my $robots;
	foreach my $static_dir ( @static_dirs )
	{
		my $file = "$static_dir/robots.txt";
		next if( !-e $file );
		
		open( ROBOTS, $file ) || EPrints::abort( "Can't read $file: $!" );
		$robots = join( "", <ROBOTS> );
		close ROBOTS;
		last;
	}	
	if( !defined $robots )
	{ 
		$robots = <<END;
User-agent: *
Disallow: /cgi/
END
	}

	my $sitemap = "Sitemap: ".$repository->config( 'http_url' )."/sitemap.xml";
	if( ! ($robots =~ s/User-agent: \*\n/User-agent: \*\n$sitemap\n/ ) )
	{
		$robots = "User-agent: \*\n$sitemap\n\n$robots";	
	}

	binmode( *STDOUT, ":utf8" );
	$repository->send_http_header( "content_type"=>"text/plain; charset=UTF-8" );
	print $robots;

	return DONE;
}


1;

=head1 COPYRIGHT

=for COPYRIGHT BEGIN

Copyright 2016 University of Southampton.
EPrints 3.4 preview 1 is supplied by EPrints Services.
This software is supplied as is and is for demonstration purposes.
This software may be used with permission and must not be redistributed.
http://www.eprints.org/eprints-3.4/

=for COPYRIGHT END

=for LICENSE BEGIN

This file is part of EPrints 3.4 L<http://www.eprints.org/>.

EPrints 3.4 and this file are released under the terms of the
GNU Lesser General Public License version 3 as published by
the Free Software Foundation unless otherwise stated.

EPrints 3.4 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with EPrints 3.4.
If not, see L<http://www.gnu.org/licenses/>.

=for LICENSE END

