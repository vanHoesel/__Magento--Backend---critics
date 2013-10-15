package Magento::Backend::Connector::XMLRPC::Resource::Store;

use constant _RESOURCE_ => 'Store';

use Moose;

with 'Magento::Backend::Resource::Store';

sub store_list {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my @list;
    Module::Load::load $backend->resource_for(_RESOURCE_."::Entity");
    foreach (@{$backend->connector_for(_RESOURCE_)->_client_call(
        'store.list',
    )}) {
        my $store = $backend->resource_for(_RESOURCE_."::Entity")->new($_);
        $store->{_backend} = $backend;
        push (@list, $store );
    }
    return \@list;
}

sub store_info {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'store.info',
        [
            ($params{storeID}),
        ],
    );
    return $response;
}

sub info {
    my $self = shift;
    my %params = @_;
    $params{storeID} = $self->store_id;
    my %info = $self->_backend->
        store_info(%params);
    return wantarray ? %info : \%info;
}

1;
