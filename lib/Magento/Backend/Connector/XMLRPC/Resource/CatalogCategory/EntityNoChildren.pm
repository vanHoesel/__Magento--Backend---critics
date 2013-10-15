package Magento::Backend::Connector::XMLRPC::Resource::CatalogCategory::EntityNoChildren;

use Moose;

extends 'Magento::Backend::Connector::XMLRPC::Resource::CatalogCategory';

with 'Magento::Backend::Resource::CatalogCategory::EntityNoChildren';

1;