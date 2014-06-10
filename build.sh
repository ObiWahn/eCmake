#!/bin/bash

install_path="/opt/e18"

#used by camke
export E18_PRE=$install_path

export PATH="$install_path/bin:$PATH"
echo "PATH=$PATH"
export ACLOCAL_FLAGS="-I $install_path/share/aclocal $ACLOCAL_FLAGS"
echo "ACLOCAL_FLAGS=$ACLOCAL_FLAGS"
export LD_LIBRARY_PATH="$install_path/lib:$LD_LIBRARY_PATH"
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$install_path/lib/pkgconfig:$PKG_CONFIG_PATH"
echo "PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
export CPPFLAGS="$CPPFLAGS -I$install_path/include"
echo "CPPFLAGS=$CPPFLAGS"
export LDFLAGS="$LDFLAGS -L$install_path/lib" #${conf[ldflags]}"
echo "LDFLAGS=$LDFLAGS"
export LD_RUN_PATH="$install_path/lib"
echo "LD_RUN_PATH=$LD_RUN_PATH"
#export CFLAGS="$CFLAGS ${conf[cflags]}"
#echo "CFLAGS=$CFLAGS"
export PYTHONPATH="$($pythoncmd -c "import distutils.sysconfig; print distutils.sysconfig.get_python_lib(prefix='$install_path')" 2>/dev/null)"
echo "PYTHONPATH=$PYTHONPATH"
export PYTHONINCLUDE="$($pythoncmd -c "import distutils.sysconfig; print distutils.sysconfig.get_python_inc(prefix='$install_path')" 2>/dev/null)"
echo "PYTHONINCLUDE=$PYTHONINCLUDE"
export NOCONFIGURE="true"
echo "NOCONFIGURE=$NOCONFIGURE"
export V
echo "V=$V"
echo


mkdir -p ./build
cd build
cmake ../eCmake

make -j 1
