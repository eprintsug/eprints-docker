=head1 NAME

EPrints::Plugin::Screen::EPrint::Box

=cut

package EPrints::Plugin::Screen::EPrint::Box;

our @ISA = ( 'EPrints::Plugin::Screen' );

use strict;

sub new
{
	my( $class, %params ) = @_;

	my $self = $class->SUPER::new(%params);

	# Register sub-classes but not this actual class.
	if( $class ne "EPrints::Plugin::Screen::EPrint::Box" )
	{
		$self->{appears} = [
			{
				place => "summary_right",
				position => 1000,
			},
		];
	}

	return $self;
}

sub render_collapsed { return 0; }

sub can_be_viewed { return 1; }

sub render
{
	my( $self ) = @_;

	return $self->{session}->make_text( "Please add a 'render' method to this box!" );
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

