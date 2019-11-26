Lacework Agent Cookbook
=========================
[Lacework](https://lacework.com) is an end to end security platform designed to meet the demands of modern application deployments. The lacework cookbook handles the installation of the Lacework agent and its configuration.

Requirements
============
- chef-client >= 13.x

Platforms
---------

* Amazon Linux
* CentOS
* Debian
* RedHat (RHEL 8 requires chef >= 15)
* Scientific Linux
* Ubuntu
* Windows
* SUSE (requires chef >= 13.3)


Recipes
=======

default
-------
Running the default recipe will invoke the installation as set in the default attributes (default is `install.sh`)

config
------
The config recipe manages the lacework configuration `config.json`

Attributes
==========
The following attributes affect the behavior of the of the lacework agent and its configuration

- `node['lacework']['install_method'] = 'install_sh'` - Sets the method to install the agent (options include: `yum`, `apt`, `rpm`, `deb`) 
- `node['lacework']['config']['token'] = nil` - API token associated with your Lacework account. Docs for creating a new API token can be found [here](https://support.lacework.com/hc/en-us/articles/360036425594-Download-Agent-Installers-and-Get-the-Agent-Access-Token)
- `node['lacework']['config']['proxy_url'] = nil` - The Lacework agent can be configured to use a network proxy by adding proxy information to the configuration file or by creating a https_proxy environment variable. For more information, see [Required Connectivity, Proxies & Certificates](https://support.lacework.com/hc/en-us/articles/360008149354).
- `node['lacework']['config']['tags'] = []` - Specify name/value tags to categorize your agents, for example, identifying critical assets. For more information, see [Adding Agent Tags](https://support.lacework.com/hc/en-us/articles/360008466893).
- `node['lacework']['config']['cpulimit'] = nil` - Specify the maximum number of CPU units that the Lacework agent can use on the machine that has the agent installed as shown by the following example. If the agent measures CPU usage over the specified limit during a 5 minute window, the agent restarts. Example `500m` In this example, the suffix 'm' stands for one hundred millicpu.
- `node['lacework']['config']['memlimit'] = nil` - Specify the maximum amount of memory that the Lacework agent can use on the machine that has the agent installed. Specify the size as a suffix as shown in the following example: 'm' or 'M' is Megabytes, 'g' or 'G' is Gigabytes. i.e. `750M` In this example, the suffix 'M' stands for Megabytes.
- `node['lacework']['config']['fim']['fileignore'] = []` - Array of files to ignore by Lacework's File Integrity Monitoring. Files should be expressed with absolute path i.e. `["/etc/fstab"]`
- `node['lacework']['config']['fim']['path'] = []` - By default, Lacework monitors a set of default paths. You can optionally override these default paths using this property as shown in the following example. [For the default paths and more information, see File Integrity Monitoring](https://support.lacework.com/hc/en-us/articles/360005261314).
