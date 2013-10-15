package Magento::Backend::Connector::XMLRPC::Resource::CatalogProduct;

use constant _RESOURCE_ => 'CatalogProduct';

use Moose;

with 'Magento::Backend::Resource::CatalogProduct';

sub catalogProduct_create {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    print $params{productData}{name}, "\n";
    $params{productSKU}  = delete $params{productData}{productSKU};
    $params{productType} = delete $params{productData}{productType};
    $params{setID}       = delete $params{productData}{setID};
    use Data::Dumper;
    $Data::Dumper::Indent = 1;
#    print Dumper %@_;
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_product.create',
        [
            $params{productType},
            $params{setID},
            $params{productSKU},
            $params{productData},
            $params{storeView},
        ],
    );
    if ($response) {
        my $new_product = $backend->resource_for(_RESOURCE_)->new(
            product_id => $response,
        );
        $new_product->{_backend} = $backend;
        return $new_product;
    }
    return $response;
}

sub catalogProduct_list {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_product.list',
        [
            ($params{filter}) ,
            $params{storeView},
        ],
    );
    my @productlist;
    Module::Load::load $backend->resource_for(_RESOURCE_."::Entity");
    foreach (@{$response}) {
        my $entity = $backend->resource_for(_RESOURCE_."::Entity")->new(%$_);
        $entity->{_backend} = $backend;
        push (@productlist, $entity );
    }
    return \@productlist;
} # catalogProduct_list

sub info {
    my $self = shift;
    my %params = @_;
    $params{productID} = $self->product_id;
    delete $params{productSKU};
    my %product_return_entities = $self->_backend->
        catalogProduct_info(%params);
    return wantarray ? %product_return_entities : \%product_return_entities;
}

sub catalogProduct_info {
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
    
    # when querying based on productSKU
    # the last argument needs to be litteral 'sku'
    if (exists $params{productSKU}) {
        $params{productID} = $params{productSKU};
        $params{productSKU} = 'sku';
    }

    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_product.info',
        [
            $params{productID},
            $params{storeView},
            $params{attributes},
            $params{productSKU},
        ],
    );
    
    # fix stupid returns like:
    # categories are actually a list of id's
    # websites are actually a list of id's
    # TODO make categories into a list of Category objects
    $response->{category_ids} = delete $response->{categories}
        if exists $response->{categories};
    $response->{website_ids}  = delete $response->{websites}
        if exists $response->{websites};
    $response->{set_id}       = delete $response->{set}
        if exists $response->{set};
    
    # remove unrequested attributes
    if ($params{attributes}) {
        for (keys %$response) {
            if (! exists $requested{$_} ) {
                delete $response->{$_};
            };
        };
    };
    
    return $response;
}; # catalogProduct_info

sub value {
    my $self = shift;
    my $attribute = shift;
    my %params = @_;
    $params{productID} = $self->product_id;
    delete $params{productSKU};
    my $result = $self->_backend->
        catalogProduct_value($attribute, %params);
    return $result;
}

sub catalogProduct_value {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my $attribute = shift;
    my %params = @_;
    $params{attributes} = [ ( $attribute ) ];
    my %product_return_entities = $backend->
        catalogProduct_info(%params);
    my $result = $product_return_entities{$attribute};
    return $result;
}

sub update {
    my $self = shift;
    my %params = @_;
    $params{productID} = $self->product_id;
    delete $params{productSKU};
    my $response = $self->_backend->
        catalogProduct_update(%params);
    return $response;
}

sub catalogProduct_update {
    my $class = shift;
    my $backend = shift; # from Magento::Backend::AUTOLOAD
    my %params = @_;
    
    if (exists $params{productSKU}) {
        $params{productID} = $params{productSKU};
        $params{productSKU} = 'sku';
    }
    
    my $response = $backend->connector_for(_RESOURCE_)->_client_call(
        'catalog_product.update',
        [
            $params{productID},
            $params{productData},
            $params{storeView},
            $params{productSKU},
        ],
    );
    
    return $response;
} # catalogProduct_update

1;
