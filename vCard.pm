
# Code to bootstrap your vCard module

package Text::vCard;

# See this module for your basic parser functions
use Text::vFile::Base;
use vars qw(@ISA);
push @ISA, qw(Text::vCard::Base);

# Tell vFile that BEGIN:VCARD line creates one of these objects
$Text::vFile::classMap{'VCARD'}=__PACKAGE__;

# This shows mapping of data type based on RFC to the appropriate handler
sub varHandler {
	return {
        'FN'          => 'singleText',
        'N'           => 'N',
        'NICKNAME'    => 'multipleText',
        'PHOTO'       => 'singleBinary',
        'BDAY'        => 'singleText',
        'ADR'         => 'ADR',
        'LABEL'       => 'singleTextTyped',
        'TEL'         => 'singleTextTyped',
        'EMAIL'       => 'singleTextTyped',
        'MAILER'      => 'singleText',
        'TZ'          => 'singleText',
        'GEO'         => 'GEO',
        'TITLE'       => 'singleText',
        'ROLE'        => 'singleText',
        'LOGO'        => 'singleBinary',
        'AGENT'       => 'singleText',
        'ORG'         => 'multipleText',
        'CATEGORIES'  => 'multipleText',
        'NOTE'        => 'singleText',
        'PRODID'      => 'singleText',
        'REV'         => 'singleText',
        'SORT-STRING' => 'singleText',
        'SOUND'       => 'singleBinary',
        'UID'         => 'singleText',
        'URL'         => 'singleText',
        'VERSION'     => 'singleText',
        'CLASS'       => 'singleText',
        'KEY'         => 'singleBinary',
	};
};

sub typeDefault {

    return {
        'ADR'     => [ qw(intl postal parcel work) ],
        'LABEL'   => [ qw(intl postal parcel work) ],
        'TEL'     => [ qw(voice) ],
        'EMAIL'   => [ qw(internet) ],
    };

}


sub load_ADR {

	my $self=shift;
	# This is what an address is based upon
	my $item = $self->SUPER::load_singleTextTyped(@_);
	bless $item, "Text::vCard::ADR";

	my @parts=split /,/, $item->{'value'};


	# Off top of head
	$item->{'street'} = $parts[2];

	# etc.

}

sub load_N {

	my $self=shift;

	my $item = $self->SUPER::load_singleText(@_);
	my @parts = split /,/, $item->{'value'};

	$item->{'name_given'}=$parts[1];
	# etc.

}	

1;
