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

git clone https://github.com/Se7enMuting/Openwrt-Packages package/Openwrt-Packages

git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd

git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

git clone -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge

# git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata

# git clone https://github.com/sirpdboy/netspeedtest package/netspeedtest

# rm
rm -rf feeds/luci/applications/luci-app-wrtbwmon
rm -rf package/feeds/luci/luci-app-wrtbwmon

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/feeds/luci/luci-theme-argon

rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/feeds/luci/luci-app-openclash

# rm -rf feeds/luci/applications/luci-app-netdata
# rm -rf package/feeds/luci/luci-app-netdata

# Clone openclash 项目
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull --depth 1 origin dev
git branch --set-upstream-to=origin/dev dev

# 编译 po2lmo (如果有po2lmo可跳过)
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# 先回退到SDK主目录
cd ../..

# add poweroff
curl -fsSL https://raw.githubusercontent.com/Se7enMuting/Openwrt-Packages/main/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm
curl -fsSL https://raw.githubusercontent.com/Se7enMuting/Openwrt-Packages/main/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

# files
# chmod -R 755 files
