package Magento::Backend;

use Magento::Backend::Connector::XMLRPC;

use Module::Load;

use Moose;

has config => (
    is  => 'ro',
);

has connectors => (
    is  => 'ro',
    isa => 'HashRef[Magento::Backend::Connector]',
    lazy => 1,
    default => sub { {} },
);

# return the full module name for a given data-source
# the full name includes the connector-type
#
sub resource_for {
    my $self = shift;
    my $source_name = shift;
    my $conn_type = $self->_connector_type($source_name);
    return "Magento::Backend::Connector::".$conn_type."::Resource::".$source_name;
}

# returns a Magento::Backend::Connector
# for a given data-source name
# if it does not exisits in the %connectors, it will be instantiated
#
sub connector_for {
    my $self = shift;
    my $source_name = shift;
    my $conn_type = $self->_connector_type($source_name);
    if (!exists $self->connectors->{$conn_type}) {
        my $conn_class = "Magento::Backend::Connector::".$conn_type;
        my $conn_settings = $self->config->{"Connector::".$conn_type};
        $self->connectors->{$conn_type} = $conn_class->new(settings=>$conn_settings, _backend=>$self);
    }
    return $self->connectors->{$conn_type};
};

# helper methode that returns a connector_type
# given a data-source name
# checks several defaults in the config or returns XMLRPC
#
sub _connector_type {
    my $self = shift;
    use Data::Dumper;
    my $source_name = shift;
    return $self->config->{"Resource::".$source_name}{connector}
        || $self->config->{"Connector::Default"}
        || "XMLRPC";
}

sub AUTOLOAD {
    my $self = $_[0];
    my $method = our $AUTOLOAD;
    $method =~ s/.*:://;
    my ($source, $call) = $method =~ /(.*)_(.*)/;
    $source = ucfirst $source;
    Module::Load::load $self->resource_for($source);
    my $result = $self->resource_for($source)->$method(@_);
    return wantarray ? %$result : $result if (ref $result eq 'HASH');
    return wantarray ? @$result : $result if (ref $result eq 'ARRAY');
    return $result;

return;

}

1;