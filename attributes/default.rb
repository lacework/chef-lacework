default['chef-lacework']['accesstoken'] = ''
default['chef-lacework']['install_method'] = 'script' # script, repo, and pacakge are supported values for this attribute
default['chef-lacework']['config'] = {} # Config template will render any hash of key/val pairs

# Install Script attributes
default['chef-lacework']['install_script']['dir'] = '/tmp'
default['chef-lacework']['install_script']['version'] = '2.9.13'
default['chef-lacework']['install_script']['commit_hash'] = '2.9.13_2019-10-23_master_03b7d71ca3585ddcf0e2a1474a1f7e41a2fada86'
default['chef-lacework']['install_script']['deb_sha1'] = 'f648a003000b362ecf4a7abb57e7971c99527cd1'
default['chef-lacework']['install_script']['rpm_sha1'] = 'eb7b0c0fe7316d247c0aa4b81f5be216fb275f37'
default['chef-lacework']['install_script']['dc_sha1'] = '1a2ae93d9f10894a3cd075a2a8c8790046653d31'

# Artifact Installation Attributes
default['chef-lacework']['package_dir'] = '/tmp' # default directory to download and install packages
default['chef-lacework']['deb_package']['url'] = ''
default['chef-lacework']['deb_package']['package_name'] = 'lacework_latest_amd64.deb'
default['chef-lacework']['deb_package']['shasum'] = ''
default['chef-lacework']['rpm_package']['url'] = ''
default['chef-lacework']['rpm_package']['package_name'] = 'lacework-latest-1.x86_64.rpm'
default['chef-lacework']['rpm_package']['shasum'] = ''
