## GlusterFS

FHS-2.3 isn't entirely clear on where data shared by the server should reside. It does state that "/srv contains site-specific data which is served by this system", but is GlusterFS data site-specific?

> /srv/<brick>/brick/<volume>

In this example, <brick> is the filesystem that is mounted.

## Options

Options Reconfigured:
  auth.allow: 10.222.*.*,10.192.*.*,10.10.*.*,10.8.*.*,23.251.140.205
  nfs.rpc-auth-allow: 10.222.*.*,10.192.*.*,10.10.*.*,10.8.*.*,23.251.140.205
  nfs.disable: off
  nfs.addr-namelookup: off
  nfs.export-volumes: on

### Bastion:

Volume Name: YogiBerra
  Type: Distribute
  750G ext4 /srv/xvdf
Bricks:
  Brick1: 10.192.0.155:/srv/xvdf/YogiBerra

### Dash:

Volume Name: MickeyMouse
  Type: Distribute
  100G ext4 /srv/xvdf
Bricks:
  Brick1: 10.192.*.*:/srv/xvdf/MickeyMouse

Bricks:
  - '10.192.64.221:/export/brick11'
  - '10.192.65.4:/export/brick12'
  - '10.192.67.81:/export/brick13'
  - '10.192.78.202:/export/brick14'




### Kube:
Volume Name: HerbertHoover
  Type: Distribute
  100G ext4 /srv/xvdf
Bricks:
  Brick1: 10.192.*.*:/srv/xvdf/HerbertHoover

Bricks:
  - '10.192.69.188:/export/brick21'
  - '10.192.72.243:/export/brick22'
  - '10.192.76.35:/export/brick23'
  - '10.192.76.79:/export/brick24'

## Puppet

We use some custom facts:
group: The group this node belongs to. (This is usually either a department of our business, or a large-scale function shared by many nodes.)
stage: The deployment stage of this node (dev, test, or prod).

hierarchy:
nodes/%{trusted.certname} for per-node overrides.
groups/%{facts.group}/%{facts.stage} for setting stage-specific data within a group.
groups/%{facts.group} for setting group-specific data.
role/%{calling_class}
common for global fallback data.

Kurt Cobain kurt.cobain
ip-10-192-0-155.kurt.cobain.wrrr
1.2.3.4 full.hostname.com full

10.192.0.155    -                ip-10-192-0-155.eu-west-1.compute.internal     ip-10-192-0-155
10.192.64.221   -                ip-10-192-64-221.eu-west-1.compute.internal    ip-10-192-64-221
10.192.64.221   54.229.27.225    ip-10-192-65-4.eu-west-1.compute.internal      ip-10-192-65-4
10.192.65.4     54.229.223.37    ip-10-192-67-81.eu-west-1.compute.internal     ip-10-192-67-81
10.192.67.81    54.154.232.190   ip-10-192-69-188.eu-west-1.compute.internal    ip-10-192-69-188
10.192.69.188   54.194.174.9     ip-10-192-72-243.eu-west-1.compute.internal    ip-10-192-72-243
10.192.72.243   54.194.111.179   ip-10-192-74-37.eu-west-1.compute.internal     ip-10-192-74-37
10.192.76.35    54.194.253.97    ip-10-192-76-35.eu-west-1.compute.internal     ip-10-192-76-35
10.192.76.79    54.194.194.136   ip-10-192-76-79.eu-west-1.compute.internal     ip-10-192-76-79
10.192.78.202   54.171.155.88    ip-10-192-78-202.eu-west-1.compute.internal    ip-10-192-78-202


# Example of routing PTR queries to nameservers: this will send all
# address->name queries for 192.168.3/24 to nameserver 10.1.2.3
server=/3.168.192.in-addr.arpa/10.1.2.3

server=/155.0.192.10.in-addr.arpa/kurt.cobain.wrrr
server=/202.78.192.10.in-addr.arpa/kurt.cobain.wrrr
server=/221.64.192.10.in-addr.arpa/spence.gerry.wrrr
server=/4.65.192.10.in-addr.arpa/hales.dianne.wrrr
server=/81.67.192.10.in-addr.arpa/almond.steve.wrrr
server=/188.69.192.10.in-addr.arpa/dodds.mccallister.wrrr
server=/243.72.192.10.in-addr.arpa/trudeau.pierre.wrrr
server=/35.76.192.10.in-addr.arpa/yaroshinskaya.alla.wrrr
server=/79.76.192.10.in-addr.arpa/marshall.peter.wrrr
server=/202.78.192.10.in-addr.arpa/kilmer.joyce.wrrr

address=/ip-10-192-0-155.kurt.cobain.wrrr/10.192.0.155
address=/ip-10-192-78-202.kurt.cobain.wrrr/10.192.78.202
address=/ip-10-192-64-221.spence.gerry.wrrr/10.192.64.221
address=/ip-10-192-65-4.hales.dianne.wrrr/10.192.65.4
address=/ip-10-192-67-81.almond.steve.wrrr/10.192.67.81
address=/ip-10-192-69-188.dodds.mccallister.wrrr/10.192.69.188
address=/ip-10-192-72-243.trudeau.pierre.wrrr/10.192.72.243
address=/ip-10-192-76-35.yaroshinskaya.alla.wrrr/10.192.76.35
address=/ip-10-192-76-79.marshall.peter.wrrr/10.192.76.79
address=/ip-10-192-78-202.kilmer.joyce.wrrr/10.192.78.202

address=/kurt.cobain.wrrr/10.192.78.202
address=/spence.gerry.wrrr/10.192.64.221
address=/hales.dianne.wrrr/10.192.65.4
address=/almond.steve.wrrr/10.192.67.81
address=/dodds.mccallister.wrrr/10.192.69.188
address=/trudeau.pierre.wrrr/10.192.72.243
address=/yaroshinskaya.alla.wrrr/10.192.76.35
address=/marshall.peter.wrrr/10.192.76.79
address=/kilmer.joyce.wrrr/10.192.78.202

server=/142.10.15.10.in-addr.arpa      px3proxy.balakala
address=/double-click.net/127.0.0.1
