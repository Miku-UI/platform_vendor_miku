#
# Copyright (C) 2018-2019 The Pixel3ROM Project
# Copyright (C) 2020 Raphielscape LLC. and Haruka LLC.
# Copyright (C) 2020 StormbreakerOSS
# Copyright (C) 2021 Miku UI
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

PLATFORM_MIKU_RELEASE := SNOW
PLATFORM_MIKU_VERSION := $(PLATFORM_MIKU_RELEASE).$(shell date +%m%d%H%M)

MIKU_ROM_VERSION := v0.8

TARGET_PRODUCT_SHORT := $(subst miku_,,$(TARGET_DEVICE))

ifdef MIKU_GAPPS
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
    MIKU_TYPE = GAPPS
endif

ifeq ($(TARGET_MIKU_BUILD_VARIANT),OFFICIAL)
    PLATFORM_MIKU_VERSION := $(PLATFORM_MIKU_RELEASE)
    PROD_VERSION += MikuUI-$(PLATFORM_MIKU_VERSION)-$(TARGET_DEVICE)-$(shell date +%m%d%H%M)-$(MIKU_TYPE)-OFFICIAL
else ifeq ($(TARGET_MIKU_BUILD_VARIANT),COMMUNITY)
    PLATFORM_MIKU_VERSION := $(PLATFORM_MIKU_RELEASE)
    PROD_VERSION += MikuUI-$(PLATFORM_MIKU_VERSION)-$(TARGET_DEVICE)-$(shell date +%m%d%H%M)-$(MIKU_TYPE)-COMMUNITY
else
    PLATFORM_MIKU_VERSION := $(PLATFORM_MIKU_RELEASE)
    TARGET_MIKU_BUILD_VARIANT := UNOFFICIAL
    PROD_VERSION += MikuUI-$(PLATFORM_MIKU_VERSION)-$(TARGET_DEVICE)-$(shell date +%m%d%H%M)-$(MIKU_TYPE)-UNOFFICIAL
endif

ifeq ($(MIKU_MASTER),)
    TARGET_MIKU_MASTER := BuildBot
else
    TARGET_MIKU_MASTER := $(MIKU_MASTER)
endif

PRODUCT_PRODUCT_PROPERTIES += \
    ro.system.miku.version=$(PLATFORM_MIKU_VERSION)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.miku.version=$(MIKU_ROM_VERSION) \
    ro.miku.buildtype=$(TARGET_MIKU_BUILD_VARIANT) \
    ro.miku.maintainer=$(TARGET_MIKU_MASTER)

