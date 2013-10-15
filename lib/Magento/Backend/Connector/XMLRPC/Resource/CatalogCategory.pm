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
}; # catalogProduct_info

1;