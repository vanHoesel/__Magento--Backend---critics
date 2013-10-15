package Magento::Backend::Connector::XMLRPC::Resource::CatalogCategory;

use constant _RESOURCE_ => 'CatalogCategory';

use Moose;

with 'Magento::Backend::Resource::CatalogCategory';

sub catalogCategory_info {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    my %requested ;
    
   !exists $params{attributes} && return; # debatable
    # make the attribute list into a hash
    # don't ask why, but the keys can be arbitrary
    if ($params{attributes}) {
        for (0..$#{$params{attributes}}) {
            $requested{$params{attributes}[$_]} = $params{attributes}[$_];
        };
        $params{attributes} = \%requested;
    };
    
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_category.info',
        [
            $params{categoryID},
            $params{storeView},
            $params{attributes},
        ],
    );
    
    if ($params{attributes}) {
        for (keys %$response) {
            if (! exists $requested{$_} ) {
                delete $response->{$_};
            };
        };
    };
    
    return $response;
}; # catalogCategory_info


# Due to a severe bug in the API implementation of Magento it self
# this methood can't do what it is supposed to do.
# turned into a private method to get the root level categories
sub catalogCategory_level { # due to a bug in the API
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_category.level',
        [
#             $params{Website},
#             $params{storeView},
#             $params{categoryID},
        ],
    );
    my @categorylist;
    Module::Load::load $backend->resource_for(_RESOURCE_."::EntityNoChildren");
    foreach (@{$response}) {
        my $entity = $backend->resource_for(_RESOURCE_."::EntityNoChildren")->new(%$_);
        $entity->{_backend} = $backend;
        push (@categorylist, $entity );
    }
    return \@categorylist;
} # catalogCategory_level

sub catalogCategory_levelRoot { 
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_category.level',
        [
        ],
    );
    my @categorylist;
    Module::Load::load $backend->resource_for(_RESOURCE_."::EntityNoChildren");
    foreach (@{$response}) {
        my $entity = $backend->resource_for(_RESOURCE_."::EntityNoChildren")->new(%$_);
        $entity->{_backend} = $backend;
        push (@categorylist, $entity );
    }
    return \@categorylist;
} # catalogCategory_levelRoot

sub catalogCategory_assignedProducts {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_category.assignedProducts',
        [
            $params{categoryID},
        ],
    );
    my @productlist;
    Module::Load::load $backend->resource_for(_RESOURCE_."::AssignedProduct");
    foreach (@{$response}) {
        my $entity = $backend->resource_for(_RESOURCE_."::AssignedProduct")->new(%$_);
        $entity->{_backend} = $backend;
        push (@productlist, $entity );
    }
    return \@productlist;
} # catalogCategor_assignedProducts

1;
























