################################################################################
#
# webbridge
#
################################################################################

WEBBRIDGE_VERSION = c54cea9a54485577ca10759810a1080119abf6cb
WEBBRIDGE_SITE_METHOD = git
WEBBRIDGE_SITE = git@github.com:Metrological/webbridge.git
WEBBRIDGE_INSTALL_STAGING = YES
WEBBRIDGE_DEPENDENCIES += cppsdk

ifeq ($(BR2_ENABLE_DEBUG),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_DEBUG=ON
else ifeq ($(BR2_PACKAGE_CPPSDK_DEBUG),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_DEBUG=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_FANCONTROL),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_FANCONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TRACECONTROL),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_TRACECONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DICTIONARY),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_DICTIONARY=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_BACKOFFICE),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_BACKOFFICE=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DELAYEDRESPONSE),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_DELAYEDRESPONSE=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_PROVISIONING),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_PROVISIONING=ON
WEBBRIDGE_DEPENDENCIES += dxdrm
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBPROXY),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_WEBPROXY=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_REMOTECONTROL),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_REMOTECONTROL=ON
ifeq ($(BR2_PACKAGE_GREENPEAK_GP501)$(BR2_PACKAGE_GREENPEAK_GP711),y)
WEBBRIDGE_DEPENDENCIES += greenpeak
WEBBRIDGE_CONF_OPTS += -DGREENPEAK_REMOTE=ON
endif
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DEVICEINFO),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_DEVICEINFO=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_BROWSER),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_BROWSER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_WEBKITBROWSER),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_WEBKITBROWSER=ON
WEBBRIDGE_DEPENDENCIES += wpe 
endif

ifeq ($(BR2_PACKAGE_PLUGIN_DIALSERVER),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_DIALSERVER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_I2CCONTROL),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_I2CCONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_SPICONTROL),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_SPICONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_TEMPCONTROL),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_TEMPCONTROL=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_FILESERVER),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_FILESERVER=ON
endif

ifeq ($(BR2_PACKAGE_PLUGIN_SURFACECOMPOSITOR),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_SURFACECOMPOSITOR=ON
WEBBRIDGE_DEPENDENCIES += bcm-refsw
endif

ifeq ($(BR2_PACKAGE_PLUGIN_NXRESOURCECENTER),y)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_PLUGIN_NXRESOURCECENTER=ON
WEBBRIDGE_DEPENDENCIES += bcm-refsw
endif

ifeq ($(BR2_PACKAGE_PLUGIN_MINIMIZED),)
WEBBRIDGE_CONF_OPTS += -DWEBBRIDGE_WEB_UI=ON
endif

define WEBBRIDGE_POST_TARGET_INITD
    $(INSTALL) -D -m 0755 package/webbridge/S80webbridge $(TARGET_DIR)/etc/init.d
endef

WEBBRIDGE_POST_INSTALL_TARGET_HOOKS += WEBBRIDGE_POST_TARGET_INITD

$(eval $(cmake-package))
