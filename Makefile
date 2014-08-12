#
# Copyright (C) 2007-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xpdf
PKG_VERSION:=3.04
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=ftp://ftp.foolabs.com/pub/xpdf/
PKG_MD5SUM:=3bc86c69c8ff444db52461270bef3f44
#PKG_BUILD_DIR:= # Wo Compilieren? Das Verzeichnis nach dem Entpacken.
#PKG_CAT:= # Wie entpacken
#PKG_BUILD_DEPENDS:= # Pakete zum bauen aber nicht fuer Laufzeit
#PKG_INSTALL:= #  "1" ruft das original "make install" mit Option PKG_INSTALL_DIR
#PKG_INSTALL_DIR:= # Installationsverzeichniss
#PKG_FIXUP:= # Nicht dokumentiert! Für Crosscompile bugs.

# @SF steht für sourceforge.org
# $(BUILD_DIR) ist das Verzeichniss, wo wget aufgerufen wird.



include $(INCLUDE_DIR)/package.mk


define Package/xpdf
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libpng +libstdcpp
  TITLE:=xpdf
  URL:=http://www.foolabs.com/
endef

define Package/xpdf/description
	xpdf
endef


MAKE_FLAGS += AR="$(TARGET_CROSS)ar rc"


define Build/Configure
	$(call Build/Configure/Default)
endef


define Build/Compile
	$(call Build/Compile/Default)
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" install
endef

define Package/xpdf/install	
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/xpdfrc $(1)/etc/

endef

$(eval $(call BuildPackage,xpdf))
