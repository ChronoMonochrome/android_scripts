export USE_CCACHE=1
export CCACHE_DIR=/home/chronomonochrome/cm-10.2_ccache
. build/envsetup.sh

lunch cm_codina-userdebug
mka bacon
