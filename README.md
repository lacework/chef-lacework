<img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600">

Lacework Agent Cookbook
=========================
[![lacework](https://circleci.com/gh/lacework/chef-lacework.svg?style=shield)](https://circleci.com/gh/lacework/chef-lacework)

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
* Ubuntu 16.04/18.04
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
- `node['chef-lacework']['config']['proxy_url'] = nil` - The Lacework agent can be configured to use a network proxy by adding proxy information to the configuration file or by creating a https_proxy environment variable. For more information, see [Required Connectivity, Proxies & Certificates](https://support.lacework.com/hc/en-us/articles/360008149354).
- `node['chef-lacework']['config']['tags'] = []` - Specify name/value tags to categorize your agents, for example, identifying critical assets. For more information, see [Adding Agent Tags](https://support.lacework.com/hc/en-us/articles/360008466893).
- `node['chef-lacework']['config']['cpulimit'] = nil` - Specify the maximum number of CPU units that the Lacework agent can use on the machine that has the agent installed as shown by the following example. If the agent measures CPU usage over the specified limit during a 5 minute window, the agent restarts. Example `500m` In this example, the suffix 'm' stands for one hundred millicpu.
- `node['chef-lacework']['config']['memlimit'] = nil` - Specify the maximum amount of memory that the Lacework agent can use on the machine that has the agent installed. Specify the size as a suffix as shown in the following example: 'm' or 'M' is Megabytes, 'g' or 'G' is Gigabytes. i.e. `750M` In this example, the suffix 'M' stands for Megabytes.
- `node['chef-lacework']['config']['fim']['fileignore'] = []` - By default, Lacework excludes monitoring a set of default paths. You can optionally override these non-monitored default paths using this property as shown in the following example. For the default paths and more information, see [File Integrity Monitoring](https://support.lacework.com/hc/en-us/articles/360005261314). `["/etc/fstab"]`
- `node['chef-lacework']['config']['fim']['path'] = []` - By default, Lacework monitors a set of default paths. You can optionally override these default paths using this property as shown in the following example. [For the default paths and more information, see File Integrity Monitoring](https://support.lacework.com/hc/en-us/articles/360005261314).
-`node['chef-lacework']['config']['runat'] = []` - By default, Lacework runs the FIM scan at an undetermined time once per day. To control the start time of the daily FIM scan, enter the start time as HH:MM as shown in the following example. `23:50`
- `node['chef-lacework']['deb_package']['url'] = ''` - URL to download `.deb` package to install the Lacework agent
- `node['chef-lacework']['deb_package']['package_name'] = 'lacework_latest_amd64.deb'` - Name of `.deb` package to install on Debian/Ubuntu Linux
- `node['chef-lacework']['deb_package']['shasum'] = ''` = sha256 sum of `.deb` package
- `node['chef-lacework']['rpm_package']['url'] = ''` - URL to download `.rpm` package to install the Lacework agent
- `node['chef-lacework']['rpm_package']['package_name'] = 'lacework-latest-1.x86_64.rpm'` - Name of `.rpm` package to install on RHEL/Centos/SUSE Linux 
- `node['chef-lacework']['rpm_package']['shasum'] = '' ` = sha256 sum of `.rpm` package 


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
