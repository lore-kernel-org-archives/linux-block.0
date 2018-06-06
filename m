Return-Path: <linux-block-owner@vger.kernel.org>
Received: from synology.com ([59.124.61.242]:55916 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932316AbeFFILi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 04:11:38 -0400
From: bingjingc <bingjingc@synology.com>
To: linux-block@vger.kernel.org
Cc: bingjingc@synology.com, cccheng@synology.com
Subject: [PATCH blktests 7/9] blktests: add a regression test for raid10 recovery
Date: Wed,  6 Jun 2018 16:11:32 +0800
Message-Id: <1528272692-21639-1-git-send-email-bingjingc@synology.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/md/006     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/006.out |  4 +++
 2 files changed, 84 insertions(+)
 create mode 100755 tests/md/006
 create mode 100644 tests/md/006.out

diff --git a/tests/md/006 b/tests/md/006
new file mode 100755
index 0000000..c124913
--- /dev/null
+++ b/tests/md/006
@@ -0,0 +1,80 @@
+#!/bin/bash
+#
+# RAID10 recovery test
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
+DESCRIPTION="run raid10 recovery test"
+QUICK=1
+
+requires() {
+	_check_md_devname_available /dev/md/blktests6 && \
+	    _have_program cmp && _have_spares && _meet_raid10_requirement && \
+	    _check_raid_devs_available && _check_raid_spares_available
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local size=${#RAID_DEVS[@]}
+	local devices=( "${RAID_DEVS[@]}" )
+
+	if [ $((size % 2)) -eq 1 ]; then
+		unset "devices[${#devices[@]}-1]"
+		size=$((size - 1))
+	fi
+
+	if [ -n "$LIMIT_DEV_SIZE" ]; then
+		mdadm -C /dev/md/blktests6 -R -l10 "-n$size" -pn2 \
+		    "${devices[@]}" -z "$LIMIT_DEV_SIZE" 2>&1 | grep started
+	else
+		mdadm -C /dev/md/blktests6 -R -l10 "-n$size" -pn2 \
+		    "${devices[@]}" 2>&1 | grep started
+	fi
+	if [ $? -ne 0 ]; then
+		echo "Array is not started."
+		return
+	fi
+
+	local md
+	md=$(basename "$(readlink /dev/md/blktests6)")
+	_wait_sync_completed "$md"
+
+	# blktests doesn't support regex on *.out, so ignore the result.
+	mdadm /dev/md/blktests6 -f "${RAID_DEVS[0]}" 2>/dev/null
+	mdadm /dev/md/blktests6 -r "${RAID_DEVS[0]}" 2>/dev/null
+	mdadm /dev/md/blktests6 -a "${RAID_SPARE_DEVS[0]}" 2>/dev/null
+	_wait_recovery_completed "$md"
+
+	local skip1
+	local skip2
+	local size
+	skip1=$(mdadm -E "${RAID_DEVS[0]}" | grep "Data Offset" | \
+	    grep -o "[0-9]*")
+	skip2=$(mdadm -E "${RAID_SPARE_DEVS[0]}" | grep "Data Offset" | \
+	    grep -o "[0-9]*")
+	size=$(cat /sys/block/"$md"/md/component_size)
+	mdadm -S /dev/md/blktests6
+	skip1=$((skip1 * 512))
+	skip2=$((skip2 * 512))
+	size=$((size * 1024))
+	cmp -i "$skip1:$skip2" -n "$size" "${RAID_DEVS[0]}" \
+	    "${RAID_SPARE_DEVS[0]}"
+
+	echo "Test complete"
+}
diff --git a/tests/md/006.out b/tests/md/006.out
new file mode 100644
index 0000000..2eff0b1
--- /dev/null
+++ b/tests/md/006.out
@@ -0,0 +1,4 @@
+Running md/006
+mdadm: array /dev/md/blktests6 started.
+mdadm: stopped /dev/md/blktests6
+Test complete
-- 
2.7.4
