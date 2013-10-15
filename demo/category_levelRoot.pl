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
#### \@categories_root = \$backend->catalogCategory_levelRoot;
#### catalogCatagory_levelRoot returns an ARRAY
####
DEMO

my @categories_root = $backend->catalogCategory_level;

foreach my $category (@categories_root) {
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
#### We can only retrieve the root level
#### not from any arbritrary category_ID
####
DEMO

__END__