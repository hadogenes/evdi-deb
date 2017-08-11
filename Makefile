VERSION=$(shell dpkg-parsechangelog | sed -nr '/^Version:/s/Version: (.*)-(.*)/\1/p')
RELEASE=$(shell dpkg-parsechangelog | sed -nr '/^Version:/s/Version: (.*)-(.*)/\2/p')

.PHONY: srpm rpm

TARGETS = evdi_$(VERSION)-$(RELEASE)_amd64.deb

all: $(TARGETS)

clean:
	rm -f $(TARGETS) evdi_$(VERSION).orig.tar.gz

evdi_$(VERSION).orig.tar.gz:
	wget -O evdi_$(VERSION).orig.tar.gz https://github.com/DisplayLink/evdi/archive/v$(VERSION).tar.gz

deb: evdi_$(VERSION)-$(RELEASE)_amd64.deb evdi-dkms_$(VERSION)-$(RELEASE)_amd64.deb

evdi_$(VERSION)-$(RELEASE)_amd64.deb: evdi_$(VERSION).orig.tar.gz
	tar -xzf evdi_$(VERSION).orig.tar.gz
	cd evdi-$(VERSION) && \
		cp -r ../debian . && \
		debuild -us -uc 
