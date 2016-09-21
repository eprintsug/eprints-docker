=head1 NAME

EPrints::Plugin::Export::TextFile

=cut

package EPrints::Plugin::Export::TextFile;

# This virtual super-class supports Unicode output

our @ISA = qw( EPrints::Plugin::Export );

sub new
{
	my( $class, %params ) = @_;

	$params{mimetype} = exists $params{mimetype} ? $params{mimetype} : "text/plain; charset=utf-8";
	$params{suffix} = exists $params{suffix} ? $params{suffix} : ".txt";

	return $class->SUPER::new( %params );
}

sub initialise_fh
{
	my( $plugin, $fh ) = @_;

	binmode($fh, ":utf8");
}

# Windows Notepad and other text editors will use a BOM to determine the
# character encoding
sub byte_order_mark
{
	return chr(0xfeff);
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

