# Gboard
PRODUCT_PACKAGES += \
    Gboard

# Telephony

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Inherit full common MikuUI stuff
$(call inherit-product, vendor/miku/config/common.mk)
