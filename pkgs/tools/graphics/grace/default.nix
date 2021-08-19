{ lib
, stdenv
, fetchurl
, coreutils
, motif
, fftw
, netcdf
, libpng
, libjpeg_original
, libX11
, libSM
, libXext
, libXmu
, libXp
, libXpm
, libXt
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "grace";
  version = "5.1.25";
  src = fetchurl {
    url = "ftp://ftp.fu-berlin.de/unix/graphics/grace/src/grace5/grace-${version}.tar.gz";
    sha256 = "751ab9917ed0f6232073c193aba74046037e185d73b77bab0f5af3e3ff1da2ac";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    coreutils
    motif
    fftw
    netcdf
    libpng
    libjpeg_original
    libX11
    libSM
    libXext
    libXmu
    libXp
    libXpm
    libXt
  ];

  enableParallelBuilding = true;

  NIX_CFLAGS_COMPILE = [ "-Wno-format-security" ]
    ++ lib.optionals stdenv.cc.isClang [ "-Wno-implicit-function-declaration" "-O1" ];

  configureFlags = [
    "--disable-debug"
    "--with-bundled-t1lib=yes"
  ];

  meta = with lib; {
    homepage = "https://plasma-gate.weizmann.ac.il/Grace/";
    description = "Grace is a WYSIWYG 2D plotting tool.";
    longDescription = "Grace is a WYSIWYG 2D plotting tool for the X Window System and M*tif. Grace is a descendant of ACE/gr, also known as Xmgr, and runs on practically any version of Unix-like OS.";
    platforms = platforms.linux ++ platforms.darwin;
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ netforceexplorer ];
  };
}
