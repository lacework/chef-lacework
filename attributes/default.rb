default['chef-lacework']['accesstoken'] = ''
default['chef-lacework']['install_method'] = 'install_script' # script, repo, and pacakge are supported values for this attribute
default['chef-lacework']['config'] = {} # Config template will render any hash of key/val pairs

# Install Script attributes
default['chef-lacework']['install_script']['dir'] = '/tmp'

# Artifact Installation Attributes
default['chef-lacework']['package_dir'] = '/tmp' # default directory to download and install packages
default['chef-lacework']['deb_package']['url'] = ''
default['chef-lacework']['deb_package']['package_name'] = 'lacework_latest_amd64.deb'
default['chef-lacework']['deb_package']['shasum'] = ''
default['chef-lacework']['rpm_package']['url'] = ''
default['chef-lacework']['rpm_package']['package_name'] = 'lacework-latest-1.x86_64.rpm'
default['chef-lacework']['rpm_package']['shasum'] = ''
