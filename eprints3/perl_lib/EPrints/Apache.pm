=head1 NAME

EPrints::Apache

=cut

package EPrints::Apache;

=item $conf = EPrints::Apache::apache_conf( $repo )

Generate and return the <VirtualHost> declaration for this repository. 
Note that Apache v2.4 introduced some new API for access-control which
deprecates the former "Order allow,deny" directive.
We detect Apache's version by testing if mod_authz_core.c is available 
(that module was added in 2.4).
=cut

sub apache_conf
{
	my( $repo ) = @_;

	my $id = $repo->get_id;
	my $adminemail = $repo->config( "adminemail" );
	my $host = $repo->config( "host" );
	my $port = $repo->config( "port" );
	$port = 80 if !defined $port;
	my $hostport = $host;
	if( $port != 80 ) { $hostport.=":$port"; }
	my $http_root = $repo->config( "http_root" );
	my $virtualhost = $repo->config( "virtualhost" );
	$virtualhost = "*" if !EPrints::Utils::is_set( $virtualhost );

	my $conf = <<EOC;
#
# apache.conf include file for $id
#
# Any changes made here will be lost if you run generate_apacheconf
# with the --replace option
#
EOC

	my $aliasinfo;
	my $aliases = "";
	foreach $aliasinfo ( @{$repo->config( "aliases" ) || []} )
	{
		if( $aliasinfo->{redirect} eq 'yes' )
		{
			my $vname = $aliasinfo->{name};
			$conf .= <<EOC;

# Redirect to the correct hostname
<VirtualHost $virtualhost:$port>
  ServerName $vname
  Redirect / http://$hostport/
</VirtualHost>
EOC
		}
		else
		{
			$aliases.="  ServerAlias ".$aliasinfo->{name}."\n";
		}
	}

		$conf .= <<EOC;

# The main virtual host for this repository
<VirtualHost $virtualhost:$port>
  ServerName $host
$aliases
  ServerAdmin $adminemail

  <Location "$http_root">
    PerlSetVar EPrints_ArchiveID $id

    Options +ExecCGI
    <IfModule mod_authz_core.c>
       Require all granted
    </IfModule>
    <IfModule !mod_authz_core.c>
       Order allow,deny
       Allow from all
    </IfModule>
  </Location>

EOC

	# backwards compatibility
	my $apachevhost = $repo->config( "config_path" )."/apachevhost.conf";
	if( -e $apachevhost )
	{
		$conf .= "  # Include any legacy directives\n";
		$conf .= "  Include $apachevhost\n\n";
	}

	$conf .= <<EOC;

  # Note that PerlTransHandler can't go inside
  # a "Location" block as it occurs before the
  # Location is known.
  PerlTransHandler +EPrints::Apache::Rewrite
  
</VirtualHost>

EOC

	return $conf;
}

sub apache_secure_conf
{
	my( $repo ) = @_;

	my $id = $repo->get_id;
	my $https_root = $repo->config( "https_root" );

	return <<EOC
#
# secure.conf include file for $id
#
# Any changes made here will be lost if you run generate_apacheconf
# with the --replace option
#

  <Location "$https_root">
    PerlSetVar EPrints_ArchiveID $id
    PerlSetVar EPrints_Secure yes

    Options +ExecCGI
    <IfModule mod_authz_core.c>
       Require all granted
    </IfModule>
    <IfModule !mod_authz_core.c>
       Order allow,deny
       Allow from all
    </IfModule>
  </Location>
EOC
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

