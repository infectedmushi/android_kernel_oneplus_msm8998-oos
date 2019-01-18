KBUILD_OUTPUT=/mnt/Building/out
#MODULES_DIR=/mnt/Building/AnyKernel2-stock/modules

cd /mnt/Building/rzbroken
export USE_CCACHE=1
export VARIANT="OP5T-OOS-P-EAS"
export HASH=`git rev-parse --short=8 HEAD`
export KERNEL_ZIP="RZ-$VARIANT-$(date +%y%m%d)-$HASH"
export LOCALVERSION=~`echo $KERNEL_ZIP`
export ARCH=arm64
export CROSS_COMPILE="/mnt/Building/gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-"
make O=../out clean
make O=../out mrproper
make O=../out oneplus5_defconfig
make -j32 O=../out  
#cd /mnt/Building/out
#find $KBUILD_OUTPUT -name '*.ko' -exec cp -v {} $MODULES_DIR \;
#${CROSS_COMPILE}strip --strip-unneeded $MODULES_DIR/*.ko
#find $MODULES_DIR -name '*.ko' -exec $KBUILD_OUTPUT/scripts/sign-file sha512 $KBUILD_OUTPUT/certs/signing_key.pem $KBUILD_OUTPUT/certs/signing_key.x509 {} \;
#/mnt/Building/out/scripts/sign-file sha512 /mnt/Building/out/certs/signing_key.pem /mnt/Building/out/certs/signing_key.x509 *.ko
## copy assets
#cp -v *.ko /mnt/Building/AnyKernel2-stock/modules
cd $KBUILD_OUTPUT/arch/arm64/boot
cp -v Image.gz-dtb /mnt/Building/AnyKernel2-render/zImage                     
cd /mnt/Building/AnyKernel2-render
zip -r9 RZ-$VARIANT-$(date +%y%m%d)-$HASH.zip *
mv -v RZ-$VARIANT-$(date +%y%m%d)-$HASH.zip /mnt/Building/Out_Zips
echo "Done!!!"
