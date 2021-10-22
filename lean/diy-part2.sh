#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.95/g' package/base-files/files/bin/config_generate

git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd

git clone https://github.com/Se7enMuting/Openwrt-Packages package/Openwrt-Packages

# clone openclash
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull --depth 1 origin master
git branch --set-upstream-to=origin/master master
# 编译 po2lmo (如果有po2lmo可跳过)
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd
# 回退到主项目目录
cd ../..

# 添加poweroff按钮
curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm
curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

# files大法
# chmod -R 755 files
