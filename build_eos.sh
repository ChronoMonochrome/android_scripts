export USE_CCACHE=1
export CCACHE_DIR=/home/chronomonochrome/android_5.0_ccache
export USE_PREBUILT_CHROMIUM=1
. build/envsetup.sh

lunch eos_codina-userdebug
mka bacon
