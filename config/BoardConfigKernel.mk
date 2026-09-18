# Copyright (C) 2018-2022 The LineageOS Project
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
#
# Kernel build configuration variables
# ====================================
#
# These config vars are usually set in BoardConfig.mk:
#
#   TARGET_KERNEL_SOURCE               = Kernel source dir, optional, defaults
#                                          to kernel/$(TARGET_DEVICE_DIR)
#   TARGET_KERNEL_ARCH                 = Kernel Arch
#
#   TARGET_KERNEL_CLANG_VERSION        = Clang prebuilts version, optional, defaults to clang-stable
#   TARGET_KERNEL_CLANG_PATH           = Clang prebuilts path, optional
#
#   TARGET_KERNEL_LLVM_BINUTILS        = Use LLVM binutils, defaults to true
#   TARGET_KERNEL_VERSION              = Reported kernel version in top level kernel
#                                        makefile. Can be overriden in device trees
#                                        in the event of prebuilt kernel.
#
#   TARGET_KERNEL_DTBO_PREFIX          = Override path prefix of TARGET_KERNEL_DTBO.
#                                        Defaults to empty
#   TARGET_KERNEL_DTBO                 = Name of the kernel Makefile target that
#                                        generates dtbo.img. Defaults to dtbo.img
#   TARGET_KERNEL_DTB                  = Name of the kernel Makefile target that
#                                        generates the *.dtb targets. Defaults to dtbs
#
#   TARGET_KERNEL_EXT_MODULE_ROOT      = Optional, the external modules root directory
#                                          Defaults to empty
#   TARGET_KERNEL_EXT_MODULES          = Optional, the external modules we are
#                                          building. Defaults to empty
#
#   USE_CCACHE                         = Enable ccache (global Android flag)

BUILD_TOP := $(abspath .)

TARGET_AUTO_KDIR := $(shell echo $(TARGET_DEVICE_DIR) | sed -e 's/^device/kernel/g')
TARGET_KERNEL_SOURCE ?= $(TARGET_AUTO_KDIR)

TARGET_KERNEL_ARCH := $(strip $(TARGET_KERNEL_ARCH))
ifeq ($(TARGET_KERNEL_ARCH),)
    KERNEL_ARCH := $(TARGET_ARCH)
else
    KERNEL_ARCH := $(TARGET_KERNEL_ARCH)
endif

KERNEL_VERSION := $(shell grep -s "^VERSION = " $(TARGET_KERNEL_SOURCE)/Makefile | awk '{ print $$3 }')
KERNEL_PATCHLEVEL := $(shell grep -s "^PATCHLEVEL = " $(TARGET_KERNEL_SOURCE)/Makefile | awk '{ print $$3 }')
TARGET_KERNEL_VERSION ?= $(shell echo $(KERNEL_VERSION)"."$(KERNEL_PATCHLEVEL))

ifneq ($(TARGET_KERNEL_CLANG_VERSION),)
    KERNEL_CLANG_VERSION := clang-$(TARGET_KERNEL_CLANG_VERSION)
else ifneq ($(RELEASE_BUILD_CLANG_VERSION),)
    KERNEL_CLANG_VERSION := $(RELEASE_BUILD_CLANG_VERSION)
else
    # Use the default version of clang if TARGET_KERNEL_CLANG_VERSION hasn't been set by the device config
    KERNEL_CLANG_VERSION := clang-r584948b
endif
TARGET_KERNEL_CLANG_PATH ?= $(BUILD_TOP)/prebuilts/clang/host/$(HOST_PREBUILT_TAG)/$(KERNEL_CLANG_VERSION)

ifneq ($(USE_CCACHE),)
    ifneq ($(CCACHE_EXEC),)
        # Android 10+ deprecates use of a build ccache. Only system installed ones are now allowed
        CCACHE_BIN := $(CCACHE_EXEC)
    endif
endif

# Clear this first to prevent accidental poisoning from env
KERNEL_MAKE_FLAGS :=

# Add back threads, ninja cuts this to $(getconf _NPROCESSORS_ONLN)/2
KERNEL_MAKE_FLAGS += -j$(shell getconf _NPROCESSORS_ONLN)

TOOLS_PATH_OVERRIDE := \
    PERL5LIB=$(BUILD_TOP)/prebuilts/tools-miku/common/perl-base

KERNEL_MAKE_FLAGS += HOSTCFLAGS='--sysroot=$(BUILD_TOP)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/sysroot -I$(BUILD_TOP)/prebuilts/kernel-build-tools/linux-x86/include'
KERNEL_MAKE_FLAGS += HOSTLDFLAGS='--sysroot=$(BUILD_TOP)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/sysroot -Wl,-rpath,$(BUILD_TOP)/prebuilts/kernel-build-tools/linux-x86/lib64 -L $(BUILD_TOP)/prebuilts/kernel-build-tools/linux-x86/lib64 -fuse-ld=lld --rtlib=compiler-rt'

TOOLS_PATH_OVERRIDE += PATH=$(BUILD_TOP)/prebuilts/tools-miku/$(HOST_PREBUILT_TAG)/bin:$(TARGET_KERNEL_CLANG_PATH)/bin:$$PATH

# Set DTBO image locations so the build system knows to build them
ifeq (true,$(filter true, $(TARGET_NEEDS_DTBOIMAGE) $(BOARD_KERNEL_SEPARATED_DTBO)))
    TARGET_KERNEL_DTBO_PREFIX ?=
    TARGET_KERNEL_DTBO ?= dtbo.img
    BOARD_PREBUILT_DTBOIMAGE ?= $(TARGET_OUT_INTERMEDIATES)/DTBO_OBJ/arch/$(KERNEL_ARCH)/boot/$(TARGET_KERNEL_DTBO_PREFIX)$(TARGET_KERNEL_DTBO)
endif

# Set the default dtb target
TARGET_KERNEL_DTB ?= dtbs

# Set no external modules by default
TARGET_KERNEL_EXT_MODULE_ROOT ?=
TARGET_KERNEL_EXT_MODULES ?=

# Set use the full path to the make command
KERNEL_MAKE_CMD := $(BUILD_TOP)/prebuilts/build-tools/$(HOST_PREBUILT_TAG)/bin/make

# Use LLVM's substitutes for GNU binutils
KERNEL_MAKE_FLAGS += LLVM=1 LLVM_IAS=1

# Since Linux 4.16, flex and bison are required
KERNEL_MAKE_FLAGS += LEX=$(BUILD_TOP)/prebuilts/build-tools/$(HOST_PREBUILT_TAG)/bin/flex
KERNEL_MAKE_FLAGS += YACC=$(BUILD_TOP)/prebuilts/build-tools/$(HOST_PREBUILT_TAG)/bin/bison
KERNEL_MAKE_FLAGS += M4=$(BUILD_TOP)/prebuilts/build-tools/$(HOST_PREBUILT_TAG)/bin/m4
TOOLS_PATH_OVERRIDE += BISON_PKGDATADIR=$(BUILD_TOP)/prebuilts/build-tools/common/bison

# Since Linux 5.10, pahole is required
KERNEL_MAKE_FLAGS += PAHOLE=$(BUILD_TOP)/prebuilts/kernel-build-tools/linux-x86/bin/pahole

# Set the out dir for the kernel's O= arg
# This needs to be an absolute path, so only set this if the standard out dir isn't used
OUT_DIR_PREFIX := $(shell echo $(OUT_DIR) | sed -e 's|/target/.*$$||g')
KERNEL_BUILD_OUT_PREFIX :=
ifeq ($(OUT_DIR_PREFIX),out)
    KERNEL_BUILD_OUT_PREFIX := $(BUILD_TOP)/
endif
