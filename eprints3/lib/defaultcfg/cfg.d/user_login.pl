
=pod

# Please see http://wiki.eprints.org/w/User_login.pl
$c->{check_user_password} = sub {
	my( $repo, $username, $password ) = @_;

	... check whether $password is ok

	return $ok ? $username : undef;
};

=cut

# Maximum time (in seconds) before a user must log in again
# $c->{user_session_timeout} = undef; 

# Time (in seconds) to allow between user actions before logging them out
# $c->{user_inactivity_timeout} = 86400 * 7;

# Set the cookie expiry time
# $c->{user_cookie_timeout} = undef; # e.g. "+3d" for 3 days

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

