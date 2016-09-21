# These configuration variables are mostly unused and should be deprecated.

{
	my $uri = URI->new( "http://" );
	if( EPrints::Utils::is_set( $c->{host} ) )
	{
		$uri->scheme( "http" );
		$uri->host( $c->{host} );
		$uri->port( $c->{port} );
		$uri = $uri->canonical;
		$uri->path( $c->{http_root} );
	}
	else
	{
		$uri->scheme( "https" );
		$uri->host( $c->{securehost} );
		$uri->port( $c->{secureport} );
		$uri = $uri->canonical;
		$uri->path( $c->{https_root} );
	}

# EPrints base URL without trailing slash
	$c->{base_url} = "$uri";
# CGI base URL without trailing slash
	$c->{perl_url} = "$uri/cgi";
}

# If you don't want EPrints to respond to a specific URL add it to the
# exceptions here. Each exception is matched against the uri using regexp:
#  e.g. /myspecial/cgi
# Will match http://yourrepo/myspecial/cgi
#$c->{rewrite_exceptions} = [];

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

