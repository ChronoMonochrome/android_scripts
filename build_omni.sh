export USE_CCACHE=1
export CCACHE_DIR=/home/chronomonochrome/omni_ccache
export USE_PREBUILT_CHROMIUM=1
. build/envsetup.sh

lunch omni_codina-userdebug
mka bacon
