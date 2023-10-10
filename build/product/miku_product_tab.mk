#
# Copyright (C) 2018 The Android Open Source Project
# Copyright (C) 2021-2022 Miku UI
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from our versioning
$(call inherit-product, vendor/miku/config/versioning.mk)

# Inherit from our overlay
$(call inherit-product, vendor/miku/config/overlay.mk)

# Sign for official build
$(call inherit-product-if-exists, vendor/miku-secret/keys/sign.mk)

ifneq ($(TARGET_DISABLE_EPPE),true)
# Require all requested packages to exist
$(call enforce-product-packages-exist-internal,$(wildcard device/*/$(MIKU_BUILD)/$(TARGET_PRODUCT).mk),product_manifest.xml rild Calendar Launcher3 Launcher3Go Launcher3QuickStep Launcher3QuickStepGo android.hidl.memory@1.0-impl.vendor vndk_apex_snapshot_package)
endif

# 2-Pane layout
PRODUCT_PACKAGES += \
    androidx.window.extensions

# Applications
TARGET_NO_APERTURE = true
ifneq ($(TARGET_NO_APERTURE),true)
    PRODUCT_PACKAGES += Aperture
endif
PRODUCT_PACKAGES += \
    Gboard \
    LiveWallpapersPicker \
    MUBB \
    PartnerBookmarksProvider \
    ThemePicker \
    ThemesStub

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/miku/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip

# Ringtone
PRODUCT_COPY_FILES += \
    vendor/miku/ringtone/miku_secret.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/ringtones/miku_secret.ogg \
    vendor/miku/ringtone/miku_noti_msg.ogg:$(TARGET_COPY_OUT_PRODUCT)/media/audio/notifications/miku_noti_msg.ogg

PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.ringtone=miku_secret.ogg \
    ro.config.notification_sound=miku_noti_msg.ogg

# Performance Mode
PRODUCT_COPY_FILES += \
    vendor/miku/prebuilt/common/etc/init/init.miku.performance_mode.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.miku.performance_mode.rc

# MikuWallpapers
PRODUCT_PACKAGES += \
    MikuWallpapers

# ThemeOverlays
include packages/overlays/Themes/themes.mk

# Compile everything
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything

# Disable extra StrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true

# Boost Framework
ifneq ($(TARGET_MIKU_BOOST_FRAMEWORK_PLATFORM),)
$(call inherit-product, device/qcom/perf/BoostFramework.mk)
endif
