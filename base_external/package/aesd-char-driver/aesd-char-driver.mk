##############################################################
#
# AESD-CHAR-DRIVER
#
##############################################################

#DONE: Fill up the contents below in order to reference your assignment 3 git contents
AESD_CHAR_DRIVER_VERSION = f5ca5eb4af1846c8c36cefbc401d980f96101064
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_CHAR_DRIVER_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-Ahall407.git
AESD_CHAR_DRIVER_SITE_METHOD = git
AESD_CHAR_DRIVER_GIT_SUBMODULES = YES

AESD_CHAR_DRIVER_MODULE_SUBDIRS = aesd-char-driver

define AESD_CHAR_DRIVER_BUILD_CMDS
	$(MAKE) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(LINUX_DIR) M=$(@D)/aesd-char-driver modules
endef

# DONE add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_CHAR_DRIVER_INSTALL_TARGET_CMDS
	$(MAKE) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(LINUX_DIR) M=$(@D)/aesd-char-driver INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
	$(INSTALL) -D -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin/aesdchar_load
	$(INSTALL) -D -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/aesdchar_unload
	$(INSTALL) -D -m 0755 $(@D)/aesd-char-driver/S99load_aesdchar $(TARGET_DIR)/etc/init.d/S99load_aesdchar
	chmod 0755 $(TARGET_DIR)/etc/init.d/S99load_aesdchar
endef

$(eval $(kernel-module))
$(eval $(generic-package))