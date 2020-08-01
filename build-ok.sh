KBUILD_OUTPUT=/mnt/Building/teste/out
MODULES_DIR=/mnt/Building/AnyKernel2-blu_spark/modules

cd /mnt/Building/teste
export USE_CCACHE=1
export VARIANT="pie"
export HASH=`git rev-parse --short=8 HEAD`
#export KERNEL_ZIP="blu_spark-op5t-$VARIANT-unofficial-$(date +%y%m%d)-$HASH"
#export LOCALVERSION=~"blu_spark-op5t-$VARIANT-unofficial"
export ARCH=arm64
export CROSS_COMPILE="/mnt/Building/aarch64-linux-gnu-10.1.0/bin/aarch64-linux-gnu-"
#make prepare
make clean
make mrproper
make blu_spark_defconfig
ccache make -j64
#cd $KBUILD_OUTPUT
#find $KBUILD_OUTPUT -name '*.ko' -exec cp -v {} $MODULES_DIR \;
#${CROSS_COMPILE}strip --strip-unneeded $MODULES_DIR/*.ko
#find $MODULES_DIR -name '*.ko' -exec $KBUILD_OUTPUT/scripts/sign-file sha512 $KBUILD_OUTPUT/certs/signing_key.pem $KBUILD_OUTPUT/certs/signing_key.x509 {} \;
#/mnt/Building/$KBUILD_OUTPUT/out/scripts/sign-file sha512 /mnt/Building/out/certs/signing_key.pem /mnt/Building/out/certs/signing_key.x509 *.ko
## copy assets
#cp -v *.ko /mnt/Building/AnyKernel2-blu_spark/modules
cd $KBUILD_OUTPUT/arch/arm64/boot
cp -v Image.gz-dtb /mnt/Building/AnyKernel2-blu_spark/Image.gz-dtb
cd /mnt/Building/AnyKernel2-blu_spark
zip -r9 blu_spark-op5t-q-test-unofficial-$(date +%y%m%d)-$HASH.zip *
mv -v blu_spark-op5t-q-test-unofficial-$(date +%y%m%d)-$HASH.zip /mnt/Building/Out_Zips
echo "Done!!!"
