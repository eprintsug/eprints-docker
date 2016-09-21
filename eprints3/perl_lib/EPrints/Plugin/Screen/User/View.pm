=head1 NAME

EPrints::Plugin::Screen::User::View

=cut


package EPrints::Plugin::Screen::User::View;

use EPrints::Plugin::Screen;

@ISA = ( 'EPrints::Plugin::Screen' );

use strict;

sub new
{
	my( $class, %params ) = @_;

	my $self = $class->SUPER::new(%params);

	$self->{appears} = [
		{
			place => "key_tools",
			position => 200,
		},
	];

	return $self;
}

sub can_be_viewed
{
	my( $self ) = @_;

	return 0 if !defined $self->{session}->current_user;
	return $self->{session}->current_user->allow( "user/view", $self->{session}->current_user );
}

sub from
{
	my( $self ) = @_;

	my $userid = $self->{session}->param( "userid" );
	$userid = $self->{session}->current_user->id if !defined $userid;

	my $url = $self->{session}->current_url( path => "cgi", "users/home" );
	$url->query_form(
		screen => 'Workflow::View',
		dataset => 'user',
		dataobj => $userid,
	);

	$self->{session}->redirect( $url );
	exit;
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

