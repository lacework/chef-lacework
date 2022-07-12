<img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600">

Lacework Agent Cookbook
=========================
[![lacework](https://circleci.com/gh/lacework/chef-lacework.svg?style=shield)](https://circleci.com/gh/lacework/chef-lacework) [![Cookbook Version](https://img.shields.io/cookbook/v/chef-lacework.svg)](https://supermarket.chef.io/cookbooks/chef-lacework)

[Lacework](https://lacework.com) is an end to end security platform designed to meet the demands of modern application deployments. The chef-lacework cookbook handles the installation and configuration of the Lacework agent.

Requirements
============
- chef-client >= 13.x

Platforms
---------

* Amazon Linux 1/2
* CentOS 7/8
* Debian 9/10
* RedHat 7/8 (RHEL 8 requires chef >= 15)
* Scientific Linux
* Ubuntu 16.04/18.04/20.04/21.04
* SUSE (requires chef >= 13.3)


Recipes
=======

default
-------
Running the default recipe will run the config recipe to invoke the installation as set in the default attributes (default installation method downloads the `install.sh` script from `packages.lacework.com` and installs the latest version of the datacollector agent)

config
------
The config recipe manages the lacework configuration `/var/lib/lacework/config/config.json` for the lacework agent. All configurations are added using Chef attributes. For more information on available configuration for the Lacework agent visit the [Lacework documentation](https://support.lacework.com/hc/en-us/articles/360024365753-Configure-Agent-Behavior-in-config-json-File).

#### Example

```
{
  'tokens' => {
    'AccessToken' => 'ACCESS_TOKEN'
  },
  'cpulimit' => '500m',
  'memlimit' => '750m',
  'tags' => {
    'test_01' => 'value_01',
    'test_02' => 'value_02'
  }
}
```

install
-------
The install recipe handles the logic for choosing the correct method to install the agent, which is determined by the attribute `node['chef-lacework']['install_method']`. The default method for install action is `install_script` which dowloads the latest version of the Lacework `install.sh` script from `packages.lacework.net` and executes it.

This cookbook also provides the ability to configure `yum` and `apt` repos, or you can specify installing an `rpm` or `deb` package from another source directly.

Attributes
==========
The following attributes affect the behavior of the of this cookbook, the lacework agent, and its configuration

- `node['chef-lacework']['install_method'] = 'install_script'` - Sets the method to install the agent (options include: `install_script`, `yum`, `apt`, `rpm`, `deb`)
- `node['chef-lacework']['config']['token'] = nil` - API token associated with your Lacework account. Docs for creating a new API token can be found [here](https://support.lacework.com/hc/en-us/articles/360036425594-Download-Agent-Installers-and-Get-the-Agent-Access-Token)
- `node['chef-lacework']['config']['proxyurl'] = nil` - The Lacework agent can be configured to use a network proxy by adding proxy information to the configuration file or by creating a https_proxy environment variable. For more information, see [Required Connectivity, Proxies & Certificates](https://support.lacework.com/hc/en-us/articles/360008149354).
- `node['chef-lacework']['config']['tags'] = []` - Specify name/value tags to categorize your agents, for example, identifying critical assets. For more information, see [Adding Agent Tags](https://support.lacework.com/hc/en-us/articles/360008466893).
- `node['chef-lacework']['config']['cpulimit'] = nil` - Specify the maximum number of CPU units that the Lacework agent can use on the machine that has the agent installed as shown by the following example. If the agent measures CPU usage over the specified limit during a 5 minute window, the agent restarts. Example `500m` In this example, the suffix 'm' stands for one hundred millicpu.
- `node['chef-lacework']['config']['memlimit'] = nil` - Specify the maximum amount of memory that the Lacework agent can use on the machine that has the agent installed. Specify the size as a suffix as shown in the following example: 'm' or 'M' is Megabytes, 'g' or 'G' is Gigabytes. i.e. `750M` In this example, the suffix 'M' stands for Megabytes.
- `node['chef-lacework']['config']['fim']['fileignore'] = []` - By default, Lacework excludes monitoring a set of default paths. You can optionally override these non-monitored default paths using this property as shown in the following example. For the default paths and more information, see [File Integrity Monitoring](https://support.lacework.com/hc/en-us/articles/360005261314). `["/etc/fstab"]`
- `node['chef-lacework']['config']['fim']['path'] = []` - By default, Lacework monitors a set of default paths. You can optionally override these default paths using this property as shown in the following example. [For the default paths and more information, see File Integrity Monitoring](https://support.lacework.com/hc/en-us/articles/360005261314).
- `node['chef-lacework']['config']['runat'] = []` - By default, Lacework runs the FIM scan at an undetermined time once per day. To control the start time of the daily FIM scan, enter the start time as HH:MM as shown in the following example. `23:50`
- `node['chef-lacework']['config']['serverurl'] = ''` - Specify the endpoint the agent uses to communicate with Lacework. EU region should set `'https://api.fra.lacework.net'`. Leaving serverurl unset defaults to US region. [ See more details about serverurl](https://support.lacework.com/hc/en-us/articles/1500007918841-Agent-Server-URL).
- `node['chef-lacework']['deb_package']['url'] = ''` - URL to download `.deb` package to install the Lacework agent
- `node['chef-lacework']['deb_package']['package_name'] = 'lacework_latest_amd64.deb'` - Name of `.deb` package to install on Debian/Ubuntu Linux
- `node['chef-lacework']['deb_package']['shasum'] = ''` = sha256 sum of `.deb` package
- `node['chef-lacework']['rpm_package']['url'] = ''` - URL to download `.rpm` package to install the Lacework agent
- `node['chef-lacework']['rpm_package']['package_name'] = 'lacework-latest-1.x86_64.rpm'` - Name of `.rpm` package to install on RHEL/Centos/SUSE Linux
- `node['chef-lacework']['rpm_package']['shasum'] = '' ` = sha256 sum of `.rpm` package


Patterns for protecting Tokens
=======

All of the configuration is exposed as a namespace in chef. There are sensitive properties such as the access key.

Using `node.run_state` and a secret manager
------

If you are using a secret manager such as [aws ssm]() or [hashicorp valt]() this is probably the easiest and safest approach.

Here is an example using aws ssm in your wrapper cookbook:
```ruby
directory '/var/lib/lacework/config' do
  recursive true
end
​
aws_ssm_parameter_store 'get lacework access token' do
  path "/my/namespace/to/find/access_token"
  return_key 'lacework_access_token'
  with_decryption true
  action :get_parameters
end
​
config = node['chef-lacework']['config'].merge(
  {
    'tokens' => {
      'AccessToken' => node.run_state['lacework_access_token']
    }
  }
)
​
template '/var/lib/lacework/config/config.json' do
  source 'config.json.erb'
  cookbook 'chef-lacework'
  variables(
    config: config
  )
  sensitive true
end
​
​
# install
include_recipe 'chef_lacework::install'
```

Using [Attribute Precedence](https://docs.chef.io/attribute_persistence/) to deny the client from writing the node object to the chef server
------

Please refer to the [upstream documentation](https://docs.chef.io/attribute_persistence/#attribute-blocklist) for further information

In your `client.rb` file:
```ruby
# We don't have an automatic because there is currently no
# ohai plugin that would pick this up. Should you create one
# you should add a similar block. You can choose to only set
# one of these but you run the risk of someone overriding and
# accidentally exposing a key.
blocked_default_attributes  = ['chef-lacework/accesstoken']
blocked_normal_attributes   = %w(chef-lacework/accesstoken)
blocked_override_attributes = %w(chef-lacework/accesstoken)
```

## License and Copyright
Copyright 2020, Lacework Inc.
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
