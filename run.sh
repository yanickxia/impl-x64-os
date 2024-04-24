#!/bin/bash


RED_COLOR='\E[1;31m'
RESET='\E[0m'

cd kernel || exit

make 
if [ $? -ne 0 ];then
    echo -e "${RED_COLOR}==kernel make failed!Please checkout first!==${RESET}"
    exit 1
fi

cd ..


cd bootloader || exit
make 
if [ $? -ne 0 ];then
    echo -e "${RED_COLOR}==kernel make failed!Please checkout first!==${RESET}"
    exit 1
fi

cd ..

dd if=bootloader/boot.bin of=boot.img bs=512 count=1 conv=notrunc
mkdir tmp
sudo mount -t vfat -o loop boot.img tmp/
sudo cp bootloader/loader.bin tmp/
sudo cp kernel/kernel.bin tmp/
sudo sync
sudo umount tmp/
rm -rf tmp



bochs -f bochsrc