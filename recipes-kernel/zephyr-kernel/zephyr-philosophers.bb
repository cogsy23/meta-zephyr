inherit deploy pkgconfig

SRCREV="8fe98d628edbfd3cc184dc039168598fede4f971"
SRC_URI = "git://github.com/zephyrproject-rtos/zephyr;protocol=https;branch=v1.6-branch"
SRC_URI += "file://Makefile.toolchain.yocto"
PV = "1.14.0"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=fa818a259cbed7ce8bc2a22d35a464fc"

DEPENDS += " dtc-native gperf-native virtual/libc libgcc"

OECMAKE_SOURCEPATH = "${S}/samples/philosophers"
export ZEPHYR_BASE = "${S}"

#TARGET_OS = "Generic"

#TODO convince zephyr to use supplied toolchain.cmake
export ZEPHYR_TOOLCHAIN_VARIANT = "toolchain"

#These are supplied in toolchain.cmake
unset CFLAGS
unset CXXFLAGS

python () {
    # Translate MACHINE into Zephyr BOARD
    # Zephyr BOARD is basically our MACHINE, except we must use "-" instead of "_"
    board = d.getVar('MACHINE',True)
    board = board.replace('-', '_')
    d.setVar('BOARD',board)
}

export BOARD = "${BOARD}"

inherit cmake
