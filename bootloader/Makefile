boot.bin:
	nasm boot.asm -o boot.bin

loader.bin:
	nasm loader.asm -o loader.bin

build: boot.bin loader.bin

all: build copy_boot