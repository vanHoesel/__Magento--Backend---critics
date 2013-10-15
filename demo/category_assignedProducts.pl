use strict;
use warnings;

use Magento::Backend;
# use Magento::Backend::Resource::CatalogProduct;

my %config = (
#    'Connector::Default' => "MISSING",
    'Connector::XMLRPC' => {
        host_url => "http://networkserver.boekhandel-lighthouse.nl/magento/index.php/api/xmlrpc",
        username => "xml-rpc_user",
        password => "top-secret",
    },
    'Connector::DBI' => {
        dbi_handle => "dbi:CSV:f_dir=$ENV{HOME}/magento/",
#       username => "database_user",
#       password => "top-secret",
    },
    'Resource::CatalogProduct' => {
        connector => "XMLRPC",
        cachetime => 7 * 24 * 3600,
    },
);

my $backend = Magento::Backend->new(config => \%config);

print <<DEMO;
####
#### \@product_list = \$backend->catalogCategory_assignedProducts;
#### catalogCatagory_assignedProducts returns an ARRAY
####
DEMO

my @products_list = $backend->catalogCategory_assignedProducts(
    categoryID => 4336,
);
foreach (@products_list) {
    printf "%-15s %s\n", $_->sku, $_->get('name');
};

__END__