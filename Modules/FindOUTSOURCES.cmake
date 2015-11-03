########################################################################
# Multi-Scale-Simulation - Open Library for Mechanical Systems         #
# Copyright (C) 2015 Huu Duc To, Elliot Carr, Ian Turner               #
#                                                                      #
# This program is free software: you can redistribute it and/or modify #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# any later version.                                                   #
#                                                                      #
# This program is distributed in the hope that it will be useful,      #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the         #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with this program. If not, see <http://www.gnu.org/licenses/>  #
########################################################################

# Flags
OPTION(A_MAKE_VERBOSE       "Show additional messages during compilation/linking?" ON )
OPTION(A_MAKE_ALL_WARNINGS  "Make with all warnings (-Wall)"                       ON )
OPTION(A_MAKE_DEBUG_SYMBOLS "Make with debug symbols (-g)"                         OFF)
OPTION(A_MAKE_PROFILING     "Make with profiling information (-pg)"                OFF)
OPTION(A_MAKE_OPTIMIZED     "Make optimized (-O3)"                                 ON )
OPTION(A_MAKE_WXW_MONO      "Use wxWidgets monolithic libraries ?"                 OFF)
OPTION(A_MAKE_TERM_WHITEBG  "Select colors for terminal with white background ?"   OFF)
OPTION(A_MAKE_TERM_NOCOLORS "Don't use colors when printing to terminal ?"         OFF)
OPTION(A_MAKE_STDVECTOR     "Use std::vector instead of own implemenatation ?"     ON )
OPTION(A_MAKE_CHECK_OVERLAP "Check for maximun overlapping in DEM simulations"     OFF)
                                                                                   
# Options                                                                          
OPTION(A_USE_MECHSYS        "Use MECHSYS"                           		   ON)
OPTION(A_USE_CIMG	    "Use CImg"						   OFF)
OPTION(A_USE_DCMTK	    "Use DCMTK"						   OFF)
OPTION(A_USE_PCL	    "Use Pointcloud"					   OFF)


ADD_DEFINITIONS(-fmessage-length=0) # Each error message will appear on a single line; no line-wrapping will be done.
ADD_DEFINITIONS(-std=c++0x)         # New C++ standard
ADD_DEFINITIONS(-fpermissive)       # New C++ standard

### FLAGS ###############################################################################################

IF(A_MAKE_VERBOSE)
	SET (CMAKE_VERBOSE_MAKEFILE TRUE)
ENDIF(A_MAKE_VERBOSE)

IF(A_MAKE_ALL_WARNINGS)
	ADD_DEFINITIONS (-Wall)
ENDIF(A_MAKE_ALL_WARNINGS)

IF(A_MAKE_DEBUG_SYMBOLS)
	ADD_DEFINITIONS (-g)
ENDIF(A_MAKE_DEBUG_SYMBOLS)

IF(A_MAKE_PROFILING)
	ADD_DEFINITIONS (-pg)
    SET (LFLAGS "${LFLAGS} -pg")
ENDIF(A_MAKE_PROFILING)

IF(A_MAKE_OPTIMIZED)
	ADD_DEFINITIONS (-O3)
ENDIF(A_MAKE_OPTIMIZED)

IF(A_MAKE_WXW_MONO)
    SET (WXW_COMPONENTS base core)
ELSE(A_MAKE_WXW_MONO)
    SET (WXW_COMPONENTS base core aui)
ENDIF(A_MAKE_WXW_MONO)

IF(A_MAKE_TERM_WHITEBG AND NOT A_MAKE_TERM_NOCOLORS)
    ADD_DEFINITIONS (-DTERM_WHITEBG)
ENDIF(A_MAKE_TERM_WHITEBG AND NOT A_MAKE_TERM_NOCOLORS)

IF(A_MAKE_TERM_NOCOLORS)
    ADD_DEFINITIONS (-DTERM_NOCOLORS)
ENDIF(A_MAKE_TERM_NOCOLORS)

IF(A_MAKE_STDVECTOR)
    ADD_DEFINITIONS (-DUSE_STDVECTOR)
ENDIF(A_MAKE_STDVECTOR)

IF(A_MAKE_CHECK_OVERLAP)
    ADD_DEFINITIONS (-DUSE_CHECK_OVERLAP)
ENDIF(A_MAKE_CHECK_OVERLAP)
### FIND DEPENDENCIES AND SET FLAGS AND LIBRARIES #######################################################

SET (FLAGS   "${FLAGS}")
SET (LIBS     ${LIBS})
SET (LFLAGS  "${LFLAGS}")
SET (MISSING "")

IF (A_USE_MECHSYS)
    INCLUDE (${MSS_SOURCE_DIR}/Modules/FindMECHSYS.cmake 		) #  1.00	 	#HAVE TO CONFIGURE MECHSYS IN MECHSYS FOLDER
    if(MECHSYS_FOUND)
    	INCLUDE (${MECHSYS_SOURCE_DIR}/Modules/FindDEPS.cmake)
    	if(NOT DEPS_OK)
#       MESSAGE("Not all dependencies were satisfied")
    	endif(NOT DEPS_OK)
    	INCLUDE_DIRECTORIES (${MECHSYS_INCLUDE_DIRS})						#INCLUDE AS MUCH AS POSSIBLE
    else(MECHSYS_FOUND)
    MESSAGE("This project requires MechSys")
    endif(MECHSYS_FOUND)
ENDIF(A_USE_MECHSYS)

IF(A_USE_CIMG)
#   Manually find CImg installed from git hub
    INCLUDE (${MSS_SOURCE_DIR}/Modules/FindCIMG.cmake 			) #  2.00
    if(CIMG_FOUND)
	FIND_PACKAGE(X11 REQUIRED)
	    if (X11_FOUND)
		INCLUDE_DIRECTORIES( ${X11_INCLUDE_DIRS} )
	    else (X11_FOUND)
		MESSAGE("This project requires CImg which neeeds X11 library")
	    endif(X11_FOUND)
    else(CIMG_FOUND)
    	MESSAGE("This project requires CImg")
    endif(CIMG_FOUND)
    INCLUDE_DIRECTORIES (${CIMG_INCLUDE_DIRS})	

ENDIF(A_USE_CIMG)

IF(A_USE_DCMTK)
    INCLUDE (${MSS_SOURCE_DIR}/Modules/FindDCMTK.cmake 			) #  3.00
    if(DCMTK_FOUND)
    else(DCMTK_FOUND)
    	MESSAGE("This project requires DCMTK")
    endif(DCMTK_FOUND)
    INCLUDE_DIRECTORIES (${DCMTK_INCLUDE_DIRS})	
ENDIF(A_USE_DCMTK)

