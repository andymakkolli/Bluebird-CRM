#!/usr/bin/env /bin/bash

# define your database name here
DBNAME='crm_33'

# define the root of your svn directory here
SVNROOT='/Users/lobo/svn/crm_33'

pushd .
cd $SVNROOT
svn up .
cd $SVNROOT/bin
./setup.sh
cd $SVNROOT/sql
mysqladmin -f drop $DBNAME
mysqladmin create $DBNAME
mysql $DBNAME < civicrm.mysql
mysql $DBNAME < civicrm_data.mysql
mysql $DBNAME < civicrm_sample.mysql
mysql $DBNAME < zipcodes.mysql
php GenerateData.php
mysql $DBNAME -e 'DROP TABLE zipcodes; UPDATE civicrm_domain SET config_backend = NULL'
mysqldump -cent $DBNAME > civicrm_generated.mysql
#cat civicrm_sample_report.mysql >> civicrm_generated.mysql
cat civicrm_sample_custom_data.mysql >> civicrm_generated.mysql
#cat civicrm_devel_config.mysql >> civicrm_generated.mysql
cat ../CRM/Case/xml/configuration.sample/SampleConfig.mysql >> civicrm_generated.mysql
mysqladmin -f drop $DBNAME
mysqladmin create $DBNAME
mysql $DBNAME < civicrm.mysql
mysql $DBNAME < civicrm_generated.mysql
popd
