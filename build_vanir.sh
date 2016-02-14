export USE_CCACHE=1
export CCACHE_DIR=/home/chronomonochrome/vanir_ccache
. build/envsetup.sh

lunch vanir_codina-userdebug
mka bacon
