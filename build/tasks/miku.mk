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

TARGET_FILES_PACKAGE := $(PRODUCT_OUT)/$(PROD_VERSION).zip

.PHONY: diva
diva: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(TARGET_FILES_PACKAGE)
	@echo -e ${CL_CYN}"\033[36m               ..,:cc::c,\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m              ;xO000K0000l.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m             ,k00000000000o.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m            .d000000000xlk0o.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m            c00kxxO000x'.l00o.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m           ,kKk:,cx000kl.,k00o.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m          .d00kxk0000000:.o000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m          c000000000000O; ,O000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m         ,k000000000OkOO; .o0000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m        .x00000000kc.;x0:  ;O0000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m       .o00000000Kk, 'xKl  .d00000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m      .l00000000000xllkKx.  :O00000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m      :O0000000000000000O:  .x000000l.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m     ,k000000000000000000d.  c000000O:\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m    'x0000000000000kox000O;  ,O00000Kx'\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m   ,x00000000kl:d00OxkO000c  .x0000000:\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m  ,k000000000l. .x00Kx:;:,.  .d0000000o.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m 'x0000000000:   ;OKKO;      .x0000000d.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m.l0000000000O,   .o000l.     ;O000000Kx.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m,k0000000000O,    ;O0Kx'    .o00000000l.\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m:000000000000:    .o00O;    ;O0000000x'\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36mc0000000000Ol;.    'cx0d.  .x0000000O;\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m;O00000000k,  .      ,x0o. :0000000O:\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m.l00000000c           'x0l.,dk000Oo'\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m .;xO0Odkk'            .xO: .,xOl'\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m   .,ol:xd.             ,kx.  ''          ███    ███ ██ ██   ██ ██    ██     ██    ██ ██\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m       'xk'             .l0c              ████  ████ ██ ██  ██  ██    ██     ██    ██ ██\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m       .d0l.            .d0x'             ██ ████ ██ ██ █████   ██    ██     ██    ██ ██\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m       .l0k,            ,k0d.             ██  ██  ██ ██ ██  ██  ██    ██     ██    ██ ██\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m        .;,.            .,;.              ██      ██ ██ ██   ██  ██████       ██████  ██\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m-----------------------------------------------------------------------------------------\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m编译完成啦~快来认领你的小Miku吧！\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[36m感谢各位对Miku UI的认可~最后请让我说一声：\033[0m"${CL_RST}
	@echo -e ${CL_CYN}"\033[5;36;30m3 9！\033[0m"${CL_RST}
	@echo "Package Complete: $(TARGET_FILES_PACKAGE)" >&2


