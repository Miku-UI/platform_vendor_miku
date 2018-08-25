# Kernel
include vendor/miku/config/BoardConfigKernel.mk

# Qcom-specific bits
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/miku/config/BoardConfigQcom.mk
endif

# Soong
include vendor/miku/config/BoardConfigSoong.mk
