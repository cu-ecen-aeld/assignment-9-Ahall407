
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#DONE: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 1a509e4899662f8fa77b8a07fffbf6619de4b706
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-Ahall407.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
# $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server CFLAGS="-I$(@D)/aesd-char-driver" all
endef

define AESD_ASSIGNMENTS_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/aesd-char-driver/aesd_ioctl.h $(STAGING_DIR)/usr/include/aesd_ioctl.h
endef

# DONE add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0644 $(@D)/aesd-char-driver/aesd_ioctl.h $(TARGET_DIR)/usr/include/aesd_ioctl.h
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S20aesdsocket
endef

$(eval $(generic-package))
