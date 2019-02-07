KERNEL_DIR=/mnt/Building/infected-kernel
KBUILD_OUTPUT=/mnt/Building/out
MODULES_DIR=/mnt/Building/AnyKernel2/modules/
ZIP_DIR=/mnt/Building/AnyKernel2/
REL="r3"
cd $KERNEL_DIR 
export HASH=`git rev-parse --short=8 HEAD`
export LOCALVERSION=~infected-oos-$REL-pie-$(date +%y%m%d)-$HASH
export ARCH=arm64
export CROSS_COMPILE="/mnt/Building/gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-"
make O=../out clean
make O=../out mrproper
make O=../out infected_defconfig
ccache make -j32 O=../out  
#cd $KBUILD_OUTPUT
#find $KBUILD_OUTPUT -name '*.ko' -exec cp -v {} $MODULES_DIR \;
#${CROSS_COMPILE}strip --strip-unneeded $MODULES_DIR/*.ko
#find $MODULES_DIR -name '*.ko' -exec $KBUILD_OUTPUT/scripts/sign-file sha512 $KBUILD_OUTPUT/certs/signing_key.pem 
#$KBUILD_OUTPUT/certs/signing_key.x509 {} \;
#/mnt/Building/out/scripts/sign-file sha512 /mnt/Building/out/certs/signing_key.pem /mnt/Building/out/certs/signing_key.x509 
## copy assets
cd $KBUILD_OUTPUT/arch/arm64/boot
cp -v Image.gz-dtb /mnt/Building/AnyKernel2/zImage
cd $ZIP_DIR
zip -r9 infected-oos-$REL-pie-$(date +%y%m%d)-$HASH.zip *
mv -v infected-oos-$REL-pie-*.zip /mnt/Building/Out_Zips
echo "Done!!!"
