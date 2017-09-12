# Puppet configuration

This repository contains complete Puppet configuration used to provision Kubernetes cluster on top of GCE/AWS instances using Rancher infrastructure.

When GCE/AWS autoscaling group adds new instance, initial script installs puppet-agent and connects agent with master server, where present configuration is distributed

## Role overview:

- foreman
  + Puppet Master
  + PuppetDB
  + Foreman
  + Heketi
- server
  + Rancher server
  + Jenkins
- agent (hosts)
  + install Docker + run Rancher agent
  + setup syslog to forward logs to Graylog/Logstash collectors
  + install and configure Mcollective
  + install GlusterFS

## Roles/groups

+ role
  - agent
  - server
  - foreman
+ group
  - kube
  - dash
+ collective
  - mcollective
+ hostgroup
  - foreman
  - rancher-server
  - rancher-agent
  - rancher-agent/dash
  - rancher-agent/kube

## Usage (through Makefile):

+ Disable/enable working on the local system.
  - `make disable`
  - `make enable`
+ Launch `puppet agent`
  - `make agent`
+ Apply configuration to the local host.
  - `make manifests/%.pp`
  - `make site/%.pp` - would include class from file end run puppet apply
  - `make apply` - equivalent of `make manifests/site.pp`
+ Install dependencies
  - `make librarian`
+ Launch tests
  - `make spec/classes/*.rb`
  - `make spec/acceptance/*.rb`
+ Retrieve facts, see invoked classes
  - `make facts`
  - `make classes`

### Links

https://github.com/dalen/puppetexplorer
https://github.com/vshn/puppet-in-docker
http://rspec-puppet.com/documentation/
