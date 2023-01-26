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

# Soong
include vendor/miku/config/BoardConfigSoong.mk
