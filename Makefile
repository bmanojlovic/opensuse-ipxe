all: ipxe config iso usb lkrn efi

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

lkrn:
	cd ipxe/src && make -f Makefile.efi -j4 bin/ipxe.lkrn EMBED=../../configuration.ipxe
	mv ipxe/src/bin/ipxe.lkrn opensuse-ipxe.lkrn
efi:
	cd ipxe/src && make -j4 bin-x86_64-efi/ipxe.efi EMBED=../../configuration.ipxe
	mv ipxe/src/bin-x86_64-efi/ipxe.efi opensuse-ipxe.efi

clean:
	rm -vrf configuration.ipxe opensuse-ipxe.iso ipxe *~
	