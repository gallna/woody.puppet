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

### Links

https://github.com/dalen/puppetexplorer
https://github.com/vshn/puppet-in-docker
