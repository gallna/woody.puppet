# Puppet configuration

This repository contains complete Puppet configuration used to provision Kubernetes cluster on top of GCE/AWS instances build on top of Rancher infrastructure.

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

### Links

https://github.com/dalen/puppetexplorer
https://github.com/vshn/puppet-in-docker
