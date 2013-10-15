use strict;
use warnings;

use Magento::Backend;
use Magento::Backend::Resource::CatalogProduct;

my %config = (
#    'Connector::Default' => "MISSING",
    'Connector::XMLRPC' => {
        host_url => "http://networkserver.boekhandel-lighthouse.nl/magento/index.php/api/xmlrpc",
        username => "GitHub_test_products_136",
        password => "GitHub_136!",
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

print "Creating\n";

my $latest_product = $backend->catalogProduct_create(
    productData =>{
        productSKU => "hiephiep15",
        productType => "simple",
        setID => 10,
        name => "happy birthday",
        description => "this is the lates birthday song by the choir",
        short_description => "birthday song by the choir",
        price => 8.90,
        weight => 12.45,
        status => 1,
        visibility => 4,
        tax_class_id => 6,
        isbn => 999999999,
        pages => 1234,
    },
);

print "Done\n";
print "Checking\n";

my %info = $latest_product->info(attributes => undef); # that means... all!


printf "%-30s => %s\n", $_, $info{$_} || '<undef>' 
    foreach (keys %info);


# use Data::Dumper;
# $Data::Dumper::Indent = 1;
# 
# print Dumper $response;
# print Dumper $backend;

__END__
