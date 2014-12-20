NDLL="../ndll/iPhone/"
HXCPP="haxelib run hxcpp Build.xml"
HXCPP_IPHONEOS=$HXCPP" -Diphoneos"
DEBUG="-Ddebug -Dfulldebug"
VERSION="-Dmiphoneos-version-min=7.0"
VERBOSE="-verbose"
GCC="-DHXCPP_GCC"
ARC="-DOBJC_ARC"
M64="-DHXCPP_M64"
LIB="downloadmanager"
DELAY="0.5"

cleanup()
{
	rm -rf "obj"
	rm -rf "all_objs"
}

ios_armv6()
{
	echo "\n\n\\033[1;32mCompiling for armv6"
	sleep $DELAY
	rm -rf NDLL"lib"LIB"-debug.iphoneos.a"
	rm -rf NDLL"lib"LIB".iphoneos.a"
	$HXCPP_IPHONEOS $VERBOSE $DEBUG $ARC $GCC
	sleep $DELAY
	$HXCPP_IPHONEOS $VERBOSE $ARC $GCC
	sleep $DELAY
}

ios_armv7()
{
	echo "\n\n\\033[1;32mCompiling for armv7"
	rm -rf NDLL"lib"LIB"-debug.iphoneos-v7.a"
	rm -rf NDLL"lib"LIB".iphoneos-v7.a"

	$HXCPP_IPHONEOS -DHXCPP_ARMV7 $VERBOSE $DEBUG $VERSION $ARC $GCC
	sleep $DELAY
	$HXCPP_IPHONEOS -DHXCPP_ARMV7 $VERBOSE $VERSION $ARC $GCC
	sleep $DELAY
}

ios_simulator()
{
	echo "\n\n\033[1;32mCompiling for simulator"
	rm -rf NDLL"lib"LIB"-debug.iphonesim.a"
	rm -rf NDLL"lib"LIB".iphonesim.a"
	$HXCPP -Diphonesim $VERBOSE $DEBUG $ARC $VERSION $GCC
	sleep $DELAY
	$HXCPP -Diphonesim -DHXCPP_ARMV7 $VERBOSE $VERSION $ARC $GCC
	sleep $DELAY
}

mac()
{
	echo "\n\n\033[1;32mCompiling for OSX"
	rm -rf NDLL"lib"LIB"-debug.iphonesim.a"
	rm -rf NDLL"lib"LIB".iphonesim.a"
	$HXCPP $VERBOSE $DEBUG $VERSION
	sleep $DELAY
	$HXCPP -DM64 $VERBOSE $VERSION
	sleep $DELAY
}

mac64()
{
	echo "\n\n\033[1;32mCompiling for OSX 64bit"
	rm -rf NDLL"lib"LIB"-debug.iphonesim.a"
	rm -rf NDLL"lib"LIB".iphonesim.a"
	$HXCPP $VERBOSE $DEBUG $VERSION
	sleep $DELAY
	$HXCPP -DM64 $VERBOSE $VERSION
	sleep $DELAY
}

case "$1" in
	"v6")
		cleanup
		ios_armv6
	;;
	"v7")
		cleanup
		ios_armv7
	;;
	"simulator")
		cleanup
		ios_simulator
	;;
	"mac")
		cleanup
		mac
	;;
	"mac64")
		cleanup
		mac64
	;;
	*)
		cleanup
		ios_armv6
		ios_armv7
		ios_simulator
		mac
		mac64
	;;
esac

cleanup