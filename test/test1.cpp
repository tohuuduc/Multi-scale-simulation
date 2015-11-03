// Std Lib
#include <iostream>
#include <stdlib.h>

//MechSys
//#include <mechsys/lbm/Domain.h>

// CImg
//#include "CImg.h"
//#include <pkg/CImg/CImg.h>
#include "CImg.h"
#include "/usr/include/X11/Xlib.h"

using namespace std;
//using namespace DEM;
using namespace cimg_library;

int main()
{
	CImg<unsigned char> image("lena.pgm");
	CImgDisplay main_disp(image,"Image",0);
}

//int main(int argc, char **argv)try
//{
//	CImg<unsigned char> image("lena.pgm");
//	CImgDisplay main_disp(image,"Image",0);
//}
//MECHSYS_CATCH
