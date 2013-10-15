use strict;
use warnings;

use Magento::Backend;
# use Magento::Backend::Resource::CatalogProduct;

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

print <<DEMO;
####
#### \@category_level = \$backend->catalogCategory_level(...;
#### catalogCatagory_level returns an ARRAY
####
DEMO

my @category_level = $backend->catalogCategory_level;

foreach my $category (@category_level) {
    printf "%-30s => %s\n", $_, $category->{$_} || '<undef>' 
        foreach (keys %$category);
    print "\n";
}

# use Data::Dumper;
# $Data::Dumper::Indent = 1;
# 
# 
# 
# print Dumper \@category_level;

print <<DEMO;
#### What a waste of time,
#### There is a bug in the API, not returning any data,
#### Only errors!
####
DEMO

__END__