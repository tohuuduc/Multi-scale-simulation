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

# MANUALLY FIND CIMG INSTALLED FROM CLONE

SET(CIMG_INCLUDE_SEARCH_PATH
  $ENV{HOME}/pkg/CImg
  /usr/include
  /usr/local/include)
FIND_PATH(CIMG_CIMG_H CImg.h ${CIMG_INCLUDE_SEARCH_PATH})

#SET(CIMG_LIBRARY_SEARCH_PATH
#  $ENV{HOME}/pkg/CImg
#  /usr/lib
#  /usr/local/lib)
#FIND_LIBRARY(CIMG_CIMG NAMES CImg PATHS ${CIMG_LIBRARY_SEARCH_PATH})

SET(CIMG_FOUND 1)
#FOREACH(var CIMG_CIMG_H CIMG_CIMG)
FOREACH(var CIMG_CIMG_H)
  IF(NOT ${var})
	SET(CIMG_FOUND 0)
  ENDIF(NOT ${var})
ENDFOREACH(var)

IF(CIMG_FOUND)
  SET(CIMG_INCLUDE_DIRS ${CIMG_CIMG_H})
#  SET(CIMG_LIBRARIES    ${CIMG_CIMG})
ELSE(CIMG_FOUND)
  
ENDIF(CIMG_FOUND)


