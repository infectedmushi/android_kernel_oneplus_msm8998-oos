KBUILD_OUTPUT=/mnt/Building/bluspark_pie_upstream/out
MODULES_DIR=/mnt/Building/AnyKernel2-blu_spark/modules

cd /mnt/Building/bluspark_pie_upstream
export USE_CCACHE=1
export VARIANT="p"
export HASH=`git rev-parse --short=6 HEAD`
#export KERNEL_ZIP="blu_spark-op5t-$VARIANT-unofficial-$(date +%y%m%d)-$HASH"
export LOCALVERSION=~"infected-$VARIANT-$HASH"
export ARCH=arm64
export CROSS_COMPILE="/mnt/Building/linaro_aarch64-linux-gnu_10.2.0-2020.07/bin/aarch64-linux-"
make prepare
make clean
make mrproper
make blu_spark_defconfig
ccache make -j48
cd $KBUILD_OUTPUT
#find ./ -name "*.ko" -exec cp -v --target-directory=$MODULES_DIR {} +
find -name '*.ko' -exec cp -v {} $MODULES_DIR \;
${CROSS_COMPILE}strip --strip-unneeded $MODULES_DIR/*.ko
#find $MODULES_DIR -name '*.ko' -exec $KBUILD_OUTPUT/scripts/sign-file sha512 $KBUILD_OUTPUT/certs/signing_key.pem $KBUILD_OUTPUT/certs/signing_key.x509 {} \;
#$KBUILD_OUTPUT/scripts/sign-file sha512 /mnt/Building/out/certs/signing_key.pem /mnt/Building/out/certs/signing_key.x509 *.ko
## copy assets
#cp -v *.ko /mnt/Building/AnyKernel2-blu_spark/modules
cd $KBUILD_OUTPUT/arch/arm64/boot
cp -v Image.gz-dtb /mnt/Building/AnyKernel2-blu_spark/Image.gz-dtb
cd /mnt/Building/AnyKernel2-blu_spark
zip -r9 infected-op5t-pie-$(date +%y%m%d)-$HASH.zip *
mv -v infected-op5t-pie-$(date +%y%m%d)-$HASH.zip /mnt/Building/Out_Zips
echo "Done!!!"
