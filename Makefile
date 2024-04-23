boot.bin:
	nasm boot.asm -o boot.bin

loader.bin:
	nasm loader.asm -o loader.bin

build: boot.bin loader.bin

copy_boot:
	dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc

# modprobe loop 
copy_loader:
	mkdir tmp
	sudo mount -t vfat -o loop boot.img tmp/
	sudo cp loader.bin tmp/
	sudo sync
	sudo umount tmp/
	rm -rf tmp

run: build copy_boot copy_loader
	bochs -f bochsrc
