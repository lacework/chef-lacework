# Cookbook TESTING doc

This document describes the process for testing the chef-lacework cookbook using Chef Workstation.

## Testing Prerequisites

A working Chef Workstation installation set as your system's default ruby. Chef Workstation can be downloaded at <https://downloads.chef.io/chef-workstation/>

Hashicorp's [Vagrant](https://www.vagrantup.com/downloads.html) and Oracle's [Virtualbox](https://www.virtualbox.org/wiki/Downloads) for integration testing.

## Local Delivery

For consistent testing across the 100+ Chef managed community cookbooks we use the Delivery CLI tool and the local delivery mode. This allows us to remotely host a single [Delivery project.toml file](https://github.com/chef-cookbooks/community_cookbook_tools/blob/master/delivery/project.toml) that applies to all of our cookbooks.

Delivery defines testing in phases and cookbooks utilize `lint`, `syntax`, and `unit` phases.

To run an individual phase:

```shell
delivery local unit
```

To run all phases:

```shell
delivery local all
```

### lint stage

The lint stage runs Ruby specific code linting using cookstyle (<https://github.com/chef/cookstyle>). Cookstyle offers a tailored RuboCop configuration enabling / disabling rules to better meet the needs of cookbook authors. Cookstyle ensures that projects with multiple authors have consistent code styling.

### syntax stage

The syntax stage runs Chef cookbook specific linting and syntax checks with Foodcritic (<http://www.foodcritic.io/>). Foodcritic tests for over 60 different cookbook conditions and helps authors avoid bad patterns in their cookbooks.

### unit stage

The unit stage runs unit testing with ChefSpec (<https://github.com/chefspec/chefspec/>). ChefSpec is an extension of Rspec, specially formulated for testing Chef cookbooks. ChefSpec compiles your cookbook code and converges the run in memory, without actually executing the changes. The user can write various assertions based on what they expect to have happened during the Chef run. ChefSpec is very fast and is useful for testing complex logic as you can easily converge a cookbook many times in different ways.

## Integration Testing

Integration testing is performed by Test Kitchen. After a successful converge, tests are uploaded and ran out of band of Chef. Tests should be designed to ensure that a recipe has accomplished its goal.

## Integration Testing using Vagrant

Integration tests can be performed on a local workstation using either VirtualBox or VMWare as the virtualization hypervisor. To run tests against all available instances run:

```shell
chef exec kitchen test
```

To see a list of available test instances run:

```shell
chef exec kitchen list
```

To test specific instance run:

```shell
chef exec kitchen test INSTANCE_NAME
```