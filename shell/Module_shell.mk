# -*- Mode: makefile-gmake; tab-width: 4; indent-tabs-mode: t -*-
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

$(eval $(call gb_Module_Module,shell))

$(eval $(call gb_Module_add_targets,shell,\
	$(if $(filter-out MACOSX WNT,$(OS)),Library_desktopbe) \
	Library_localebe \
))

ifneq ($(filter DRAGONFLY FREEBSD LINUX NETBSD OPENBSD,$(OS)),)
ifeq ($(ENABLE_GIO),TRUE)
$(eval $(call gb_Module_add_targets,shell,\
	Library_losessioninstall \
))
endif
endif

ifeq ($(OS),SOLARIS)
ifeq ($(ENABLE_GIO),TRUE)
$(eval $(call gb_Module_add_targets,shell,\
    Library_losessioninstall \
))
endif
endif

ifeq ($(ENABLE_KDE4),TRUE)
$(eval $(call gb_Module_add_targets,shell,\
	Library_kde4be \
))
endif

ifeq ($(ENABLE_KDE5),TRUE)
$(eval $(call gb_Module_add_targets,shell,\
	Library_kde5be \
))
endif

ifeq ($(OS),WNT)

$(eval $(call gb_Module_add_targets,shell,\
	Executable_regsvrex \
	Executable_senddoc \
	Library_smplmail \
	Library_wininetbe \
))

ifeq ($(COM),MSC)
$(eval $(call gb_Module_add_targets,shell,\
	CustomTarget_shlxthdl_res \
	Library_ooofilt \
	Library_propertyhdl \
	Library_shlxthdl \
	StaticLibrary_shlxthandler_common \
	StaticLibrary_xmlparser \
	WinResTarget_shlxthdl \
	CustomTarget_spsupp_idl \
	Library_spsupp \
	WinResTarget_spsupp \
))

$(eval $(call gb_Module_add_check_targets,shell,\
    CppunitTest_shell_zip \
))
endif

ifeq ($(BUILD_X64),TRUE)
$(eval $(call gb_Module_add_targets,shell,\
	CustomTarget_x64 \
	Library_ooofilt_x64 \
	Library_propertyhdl_x64 \
	Library_shlxthdl_x64 \
	StaticLibrary_shlxthandler_common_x64 \
	StaticLibrary_xmlparser_x64 \
	Library_spsupp_x64 \
))
endif

endif

ifeq ($(OS),MACOSX)
$(eval $(call gb_Module_add_targets,shell,\
	Library_macbe \
))
endif

ifeq ($(filter DESKTOP,$(BUILD_TYPE)),DESKTOP)

$(eval $(call gb_Module_add_targets,shell,\
	Executable_lngconvex \
	Library_syssh \
))

ifeq ($(USING_X11),TRUE)
$(eval $(call gb_Module_add_targets,shell,\
	Library_recentfile \
))
endif

ifneq ($(OS),WNT)

$(eval $(call gb_Module_add_targets,shell,\
	StaticLibrary_xmlparser \
	Executable_uri_encode \
	Library_cmdmail \
	$(if $(ENABLE_MACOSX_SANDBOX),,Package_senddoc) \
))

endif

endif

# vim: set shiftwidth=4 tabstop=4 noexpandtab:
