Return-Path: <linux-block-owner@vger.kernel.org>
Received: from synology.com ([59.124.61.242]:46596 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932283AbeFFIGt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 04:06:49 -0400
From: bingjingc <bingjingc@synology.com>
To: linux-block@vger.kernel.org
Cc: bingjingc@synology.com, cccheng@synology.com
Subject: [PATCH blktests 1/9] blktests: add hepler functions for new md tests
Date: Wed,  6 Jun 2018 16:06:40 +0800
Message-Id: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We'd like to leverage this test framework for testing linux raid
software. There are several resync tasks in md/raid. For this commit,
we are trying to add creation resync and basic recovery tests for
every raid type.

RAID is different from other block devices. It requires several
raid devices and hotspare devices for being assembled, disambled,
expended or recovered in the runtime. So we don't test devices
iteratively in TEST_DEVS list. We define RAID_DEVS and
RAID_SPARE_DEVS lists for providing block devices instead.

We want to test the software not devices. We also provide a
LIMIT_DEV_SIZE option for limiting the tested array size by limiting
used space for each block device.

[Getting Started]

Additional dependencies are also minimal:
- mdadm
- cmp

And please provide a file named config:
RAID_DEVS=(/dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3 /dev/loop4)
RAID_SPARE_DEVS=(/dev/loop100 /dev/loop101)
LIMIT_DEV_SIZE=20480 # optional

And as root, you can run the md set of tests by typing
./check md

For someone who don't want to run md tests, they just keep RAID_DEVS
and RAID_SPARE_DEVS not assigned, all md tests will be skipped.

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 common/md      | 198 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/group |  24 +++++++
 2 files changed, 222 insertions(+)
 create mode 100644 common/md
 create mode 100644 tests/md/group

diff --git a/common/md b/common/md
new file mode 100644
index 0000000..38c2554
--- /dev/null
+++ b/common/md
@@ -0,0 +1,198 @@
+#!/bin/bash
+#
+# Default helper functions for MD devices.
+#
+# Copyright (C) 2018 Synology Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+
+_check_md_devname_available() {
+	local dev="$1"
+
+	if [ -b "$dev" ]; then
+		SKIP_REASON="Detect that $1 exists. Stop it before this test."
+		return 1
+	fi
+
+	return 0;
+}
+
+_dev_is_available() {
+	local dev="$1"
+
+	if grep -qw "$dev" /proc/mounts; then
+		SKIP_REASON="Detect that $1 is mounted. (see mount)"
+		return 1
+	fi
+
+	dev=$(basename "$dev")
+	if grep -qw "$dev" /proc/mdstat; then
+		SKIP_REASON="Detect that $1 is used. (see cat /proc/mdstat)"
+		return 1
+	fi
+
+	return 0
+}
+
+_check_raid_devs_available() {
+	for dev in "${RAID_DEVS[@]}"
+	do
+		if ! _dev_is_available "$dev"; then
+			return 1
+		fi
+	done
+	return 0
+}
+
+_check_raid_spares_available() {
+	for spare in "${RAID_SPARE_DEVS[@]}"
+	do
+		if ! _dev_is_available "$spare"; then
+			return 1
+		fi
+	done
+	return 0
+}
+
+_have_spares() {
+	local size=${#RAID_SPARE_DEVS[@]}
+
+	if [ -z "$RAID_SPARE_DEVS" ] || [ "$size" -eq 0 ]; then
+		SKIP_REASON="There are no spare devices."
+		SKIP_REASON+=" (RAID_SPARE_DEVS=$RAID_SPARE_DEVS)"
+		return 1
+	fi
+	return 0
+}
+
+_meet_raid1_requirement() {
+	local size=${#RAID_DEVS[@]}
+
+	if ! grep -qw raid1 /proc/mdstat; then
+		SKIP_REASON="RAID1 is not available in /proc/mdstat."
+		return 1
+	fi
+
+	if [ "$size" -lt 2 ]; then
+		SKIP_REASON="RAID1 requires at least 2 devices."
+		SKIP_REASON+=" (RAID_DEVS=$RAID_DEVS)"
+		return 1
+	fi
+	return 0
+}
+
+_meet_raid10_requirement() {
+	local size=${#RAID_DEVS[@]}
+
+	if ! grep -qw raid10 /proc/mdstat; then
+		SKIP_REASON="RAID10 is not available in /proc/mdstat."
+		return 1
+	fi
+
+	if [ "$size" -lt 4 ]; then
+		SKIP_REASON="RAID10 requires at least 4 devices."
+		SKIP_REASON+=" (RAID_DEVS=$RAID_DEVS)"
+		return 1
+	fi
+	return 0
+}
+
+_meet_raid5_requirement() {
+	local size=${#RAID_DEVS[@]}
+
+	if ! grep -qw raid5 /proc/mdstat; then
+		SKIP_REASON="RAID5 is not available in /proc/mdstat."
+		return 1
+	fi
+
+	if [ "$size" -lt 3 ]; then
+		SKIP_REASON="RAID5 requires at least 3 devices."
+		SKIP_REASON+=" (RAID_DEVS=$RAID_DEVS)"
+		return 1
+	fi
+	return 0
+}
+
+_meet_raid6_requirement() {
+	local size=${#RAID_DEVS[@]}
+
+	if ! grep -qw raid6 /proc/mdstat; then
+		SKIP_REASON="RAID6 is not available in /proc/mdstat."
+		return 1
+	fi
+
+	if [ "$size" -lt 4 ]; then
+		SKIP_REASON="RAID6 requires at least 4 devices."
+		SKIP_REASON+=" (RAID_DEVS=$RAID_DEVS)"
+		return 1
+	fi
+	return 0
+}
+
+_start_sync_action() {
+	local dev="$1"
+	local sync_type="$2"
+
+	echo "$sync_type" > /sys/block/"$dev"/md/sync_action
+}
+
+_check_sync_action() {
+	local dev="$1"
+	local sync_type="$2"
+
+	if grep -qw "$sync_type" /sys/block/"$dev"/md/sync_action; then
+		return 0
+	fi
+
+	return 1
+}
+
+_check_last_sync_action() {
+	local dev="$1"
+	local sync_type="$2"
+
+	if grep -qw "$sync_type" /sys/block/"$dev"/md/last_sync_action; then
+		return 0
+	fi
+
+	return 1
+}
+
+_wait_action_completed() {
+	local dev="$1"
+	local sync_type="$2"
+
+	while ! _check_sync_action "$dev" idle || \
+	      ! _check_last_sync_action "$dev" "$sync_type"
+	do
+		sleep 1
+	done
+}
+
+_wait_sync_completed() {
+	local dev="$1"
+	_wait_action_completed "$dev" resync
+}
+
+_wait_recovery_completed() {
+	local dev="$1"
+	_wait_action_completed "$dev" recovery
+}
+
+_check_integrity() {
+	local dev="$1"
+	_start_sync_action "$dev" check
+	_wait_action_completed "$dev" check
+}
diff --git a/tests/md/group b/tests/md/group
new file mode 100644
index 0000000..8f15aae
--- /dev/null
+++ b/tests/md/group
@@ -0,0 +1,24 @@
+#!/bin/bash
+#
+# md raid tests
+#
+# Copyright (C) 2018 Synology Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+. common/md
+
+group_requires() {
+	_have_root && [ -f /proc/mdstat ] && _have_program mdadm
+}
-- 
2.7.4
