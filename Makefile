all: ipxe
	./generate_config > configuration.ipxe
	cd ipxe/src && make -j4 bin/ipxe.iso EMBED=../../configuration.ipxe
	mv ipxe/src/bin/ipxe.iso opensuse-ipxe.iso
ipxe:
	git clone http://git.ipxe.org/ipxe.git

clean:
	rm -vrf configuration.ipxe opensuse-ipxe.iso ipxe *~
	