all: ipxe config iso usb efi

config:
	./generate_config > configuration.ipxe

ipxe:
	git clone http://git.ipxe.org/ipxe.git

iso:
	cd ipxe/src && make -j4 bin/ipxe.iso EMBED=../../configuration.ipxe
	mv ipxe/src/bin/ipxe.iso opensuse-ipxe.iso

usb:
	cd ipxe/src && make -j4 bin/ipxe.usb EMBED=../../configuration.ipxe
	mv ipxe/src/bin/ipxe.usb opensuse-ipxe.usb

efi:
	cd ipxe/src && make -f Makefile.efi -j4 bin-x86_64-efi/ipxe.efi EMBED=../../configuration.ipxe
	mv ipxe/src/bin-x86_64-efi/ipxe.efi opensuse-ipxe.efi

clean:
	rm -vrf configuration.ipxe opensuse-ipxe.iso ipxe *~
	