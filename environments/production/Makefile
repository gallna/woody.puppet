noop ?= noop
role ?= make
group ?= file
collective ?= mcollective
clientcert ?= web01.example.com
environment ?= production

SHELL = /bin/bash
user_facts = environment=$(environment) clientcert=$(clientcert) role=$(role) group=$(group) collective=$(collective)
spec_classes = $(wildcard spec/classes/*.rb)
spec_acceptance = $(wildcard spec/acceptance/*.rb)
environmentpath = environments
manifestpath = manifests
localmodules  = site
modulepath  = modules
hiera = hiera.yaml
manifests ?= $(wildcard $(manifestpath)/*.pp)
puppet = /opt/puppetlabs/bin/puppet
facter = /opt/puppetlabs/bin/facter
verbose = $(addprefix --,verbose show_diff summarize report test $(noop))
facter_facts = /home/tomasz/.puppetlabs/opt/facter

.PHONY: apply agent noop info

disable:
	$(puppet) agent --disable

enable:
	$(puppet) agent --enable

facts: ; $(puppet_facts)

define puppet_facts =
	$(call SAY,1,$(user_facts))
	$(call SAY,2,$(shell $(facter) environment clientcert role group collective))
endef

.ONESHELL:
SHELL = /bin/bash
define puppet_apply =
	$(puppet) apply --noop $(verbose) --hiera_config $(hiera) --environment $(environment) $@ || \
	case "$$?" in
		0) echo "info: The run succeeded with no changes or failures; the system was already in the desired state." ;;
		1) echo "error: The run failed." ;;
		2) echo "info: The run succeeded, and some resources were changed." ;;
		4) echo "warning: The run succeeded, and some resources failed." ;;
		6) echo "warning: The run succeeded, and included both changes and failures." ;;
		*) echo "error: Unknown code" ;;
	esac
endef

define puppet_agent =
	$(puppet) agent --noop $(verbose)
endef

define puppet_tags =
	$(puppet) agent --noop $(verbose) --waitforcert=60 --tags $(shell sed -n "s/class \+\([a-zA-Z0-9:]*$$(basename $@ .pp)\).*/\1/p" $@)
endef

site/%.pp: librarian facts.d/site.txt facts ; $(puppet_tags)

manifests/%.pp: librarian facts.d/site.txt facts ; $(puppet_apply)

apply:
	$(MAKE) manifests/site.pp

agent: ; $(puppet_agent)

server:
	puppet master --no-daemonize --verbose

classes: facts.d/facter.yaml
	/opt/puppetlabs/bin/hiera --config $(hiera) --debug -y facts.d/facter.yaml classes $($(user_facts))
	/opt/puppetlabs/bin/puppet apply --noop -e "notice(lookup('classes', {merge => unique}))"

facts.d:
	mkdir -p $@ $(facter_facts)/$@

facts.d/%.txt: facts.d
	@printf '%s\n' $(user_facts) >$@
	@printf '%s\n' $(user_facts) >$(facter_facts)/$@

facts.d/%.yaml: facts.d
	$(facter) -py >$@

clean:
	rm -rf facts.d

define librarian =
	@if [[ $$(expr $$(date +%s) - $$(date --reference=Puppetfile.lock +%s)) -gt 3600 ]]; then \
		librarian-puppet install --verbose && touch Puppetfile.lock; \
	fi
endef

librarian: ; $(librarian)

define bundle =
	@if [[ $$(expr $$(date +%s) - $$(date --reference=Rakefile +%s)) -gt 3600 ]]; then \
		bundle && touch Rakefile; \
	fi
endef

bundle: ; $(bundle)

$(spec_classes): bundle
	rspec $@

$(spec_acceptance): bundle
	rspec $@

SAY = $(info $(shell echo -e "\e[9$(1)m\e[7;1mSAY:\e[27m ")$(2)$(shell echo -e "\x1b[0m"))
