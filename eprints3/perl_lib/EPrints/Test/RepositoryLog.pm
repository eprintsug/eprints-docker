package EPrints::Test::RepositoryLog;

=head1 NAME

EPrints::Test::RepositoryLog - capture repository log messages

=cut

use strict;

our @logs;

{
no warnings;
sub EPrints::Repository::log
{
	my( $repo, $msg ) = @_;

	push @logs, $msg;
}
}

sub logs
{
	my @r = @logs;
	@logs = ();

	return @r;
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

