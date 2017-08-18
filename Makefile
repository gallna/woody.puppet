.PHONY: disable apply agent librarian

disable apply agent librarian:
	$(MAKE) -C environments/$(environment)/Makefile $@
