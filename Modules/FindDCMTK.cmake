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

# MANUALLY FIND DCMTK INSTALLED FROM GITHUB

SET(DCMTK_INCLUDE_SEARCH_PATH
    $ENV{HOME}/pkg/dcmtk-3.6.0
   )
FIND_PATH(DCMTK_DCMTK_H DCMTK.h ${DCMTK_INCLUDE_SEARCH_PATH})

SET(DCMTK_LIBRARY_SEARCH_PATH
  $ENV{HOME}/pkg/DCMTK
  /usr/lib
  /usr/local/lib)
FIND_LIBRARY(DCMTK_DCMTK NAMES DCMTK PATHS ${DCMTK_LIBRARY_SEARCH_PATH})

SET(DCMTK_FOUND 1)
FOREACH(var DCMTK_DCMTK_H DCMTK_DCMTK)
#FOREACH(var DCMTK_DCMTK_H)
  IF(NOT ${var})
	SET(DCMTK_FOUND 0)
  ENDIF(NOT ${var})
ENDFOREACH(var)

IF(DCMTK_FOUND)
  SET(DCMTK_INCLUDE_DIRS ${DCMTK_DCMTK_H})
#  SET(DCMTK_LIBRARIES    ${DCMTK_DCMTK})
ELSE(DCMTK_FOUND)
ENDIF(DCMTK_FOUND)


