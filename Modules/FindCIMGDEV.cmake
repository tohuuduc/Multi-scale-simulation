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

# AUTOMATICALLY FIND CIMG INSTALLED BY SUDO APT

FIND_PACKAGE (cimg-dev)

IF(cimg-dev_FOUND)
  SET(CIMG_INCLUDE_DIRS ${CIMG_CIMG_H})
  SET(CIMG_LIBRARIES    ${CIMG_CIMG})
ELSE(CIMG_FOUND)
  MESSAGE("This project requires cimg-dev which can be installed by sudo apt")
ENDIF(CIMG_FOUND)


