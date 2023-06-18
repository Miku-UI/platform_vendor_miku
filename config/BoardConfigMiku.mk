#
# Copyright (C) 2021-2023 Miku UI
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
include vendor/miku/config/BoardConfigKernel.mk

# Qcom-specific bits
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/miku/config/BoardConfigQcom.mk
endif

# Boost Framework detection
ifneq ($(TARGET_MIKU_BOOST_FRAMEWORK_PLATFORM),)
ifneq ($(TARGET_MIKU_BOOST_FRAMEWORK_PLATFORM),$(TARGET_BOARD_PLATFORM))
$(error Current platform is $(TARGET_BOARD_PLATFORM), but you're using $(TARGET_MIKU_BOOST_FRAMEWORK_PLATFORM) as Miku UI Boost Framework platform, that's incorrect, please fix it. )
endif
ifeq (,$(filter lahaina sm6150 sdm660, $(TARGET_BOARD_PLATFORM)))
$(error Current platform: $(TARGET_BOARD_PLATFORM) is not officially supported by Miku UI Boost Framework, please unset TARGET_MIKU_BOOST_FRAMEWORK_PLATFORM. )
else
$(warning Miku UI Boost Framework is enabled, if you faced any issue, please unset TARGET_MIKU_BOOST_FRAMEWORK_PLATFORM and make an issue in https://github.com/Miku-UI/manifesto/issues. )
endif
endif

# Soong
include vendor/miku/config/BoardConfigSoong.mk
