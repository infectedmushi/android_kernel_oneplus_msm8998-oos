KBUILD_OUTPUT=/mnt/Building/out
#MODULES_DIR=/mnt/Building/AnyKernel2-stock/modules

cd /mnt/Building/blu_spark-treble-pie
export HASH=`git rev-parse --short=8 HEAD`
export LOCALVERSION=~blu_spark-r150-oos-pie-$(date +%y%m%d)-$HASH
export ARCH=arm64
export CROSS_COMPILE="/mnt/Building/gcc-arm-8.2-2018.11-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-"
make O=../out clean
make O=../out mrproper
make O=../out blu_spark_defconfig
make -j$(nproc --all) O=../out  
#cd /mnt/Building/out
#find $KBUILD_OUTPUT -name '*.ko' -exec cp -v {} $MODULES_DIR \;
#${CROSS_COMPILE}strip --strip-unneeded $MODULES_DIR/*.ko
#find $MODULES_DIR -name '*.ko' -exec $KBUILD_OUTPUT/scripts/sign-file sha512 $KBUILD_OUTPUT/certs/signing_key.pem $KBUILD_OUTPUT/certs/signing_key.x509 {} \;
#/mnt/Building/out/scripts/sign-file sha512 /mnt/Building/out/certs/signing_key.pem /mnt/Building/out/certs/signing_key.x509 *.ko
## copy assets
#cp -v *.ko /mnt/Building/AnyKernel2-stock/modules
cd $KBUILD_OUTPUT/arch/arm64/boot
cp -v Image.gz-dtb /mnt/Building/AnyKernel2-blu_spark/Image.gz-dtb
cd /mnt/Building/AnyKernel2-blu_spark
zip -r9 blu_spark_r150-oos-pie-op5t-$(date +%y%m%d)-$HASH.zip *
mv -v blu_spark_r150-oos-pie-op5t-*.zip /mnt/Building/Out_Zips
echo "Done!!!"
