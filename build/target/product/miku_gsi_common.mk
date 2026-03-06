#
# Copyright (C) 2025 Miku UI
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

# Maintainer
MIKU_MASTER := 0xCAFEBABE,AmeChan

PRODUCT_BRAND := Miku-UI

# Disable bits enabled from AOSP GSI product makefiles which we don't support yet
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false
PRODUCT_SOONG_DEFINED_SYSTEM_IMAGE :=
USE_SOONG_DEFINED_SYSTEM_IMAGE := false

# Additional product packages for GSI builds
PRODUCT_PACKAGES += \
    AvatarPicker \
    Calendar \
    Contacts \
    DeskClock \
    Gallery2 \
    Music \
    preinstalled-packages-platform-handheld-product.xml \
    QuickSearchBox \
    SettingsIntelligence \
    frameworks-base-overlays \
    ImsServiceEntitlement \
    preinstalled-packages-platform-telephony-product.xml \
    initial-package-stopped-states-aosp.xml \
    PhotoTable \
    preinstalled-packages-platform-aosp-product.xml

# Additional system_ext packages for GSI builds
PRODUCT_PACKAGES += \
    AccessibilityMenu \
    WallpaperCropper \
    EmergencyInfo
