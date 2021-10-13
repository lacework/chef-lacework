name 'chef-lacework'
maintainer 'Lacework, Inc.'
maintainer_email 'tech-ally@lacework.net'
license 'Apache-2.0'
description 'Installs the Lacework agent for workload protection'
version '0.2.2'
chef_version '>= 13.12'
%w( amazon centos fedora debian oracle redhat suse opensuse ubuntu ).each do |os|
  supports os
end

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/lacework/chef-lacework/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/lacework/chef-lacework'
