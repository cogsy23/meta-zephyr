#Set relevant variables based on Zephyr kernel version

PREFERRED_VERSION_zephyr-kernel ??= "1.6.0"

SRCREV="8fe98d628edbfd3cc184dc039168598fede4f971"
SRC_URI = "git://github.com/zephyrproject-rtos/zephyr;protocol=https;branch=v1.6-branch"
SRC_URI += "file://Makefile.toolchain.yocto"
PV = "1.6.0"

SRCREV_1.7 = "dcd41fcd85e439ff1999ca74ecf246b78e9afa46"
SRC_URI_1.7 = "git://github.com/zephyrproject-rtos/zephyr;protocol=https;branch=v1.7-branch"
SRC_URI_1.7 += "file://Makefile.toolchain.yocto"
PV_1.7 = "1.7.0"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=fa818a259cbed7ce8bc2a22d35a464fc"

ZEPHYR_TEST_SRCDIR = "tests/legacy/kernel/"

python () {
    src_pn = d.getVar('PREFERRED_VERSION_zephyr-kernel', True)
    if src_pn == '1.6.0':
        return
    elif src_pn == '1.7.0':
        d.setVar('SRC_URI',d.getVar('SRC_URI_1.7', True))
        d.setVar('SRCREV',d.getVar('SRCREV_1.7', True))
        d.setVar('PV',d.getVar('PV_1.7', True))
    else:
        bb.error("Unsupported Zephyr kernel version requested")
}
