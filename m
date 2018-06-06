Return-Path: <linux-block-owner@vger.kernel.org>
Received: from synology.com ([59.124.61.242]:51948 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932262AbeFFII5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 04:08:57 -0400
From: bingjingc <bingjingc@synology.com>
To: linux-block@vger.kernel.org
Cc: bingjingc@synology.com, cccheng@synology.com
Subject: [PATCH blktests 3/9] blktests: add a regression test for raid10 creation resync
Date: Wed,  6 Jun 2018 16:08:50 +0800
Message-Id: <1528272530-13534-1-git-send-email-bingjingc@synology.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/md/002     | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/002.out |  4 ++++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/md/002
 create mode 100644 tests/md/002.out

diff --git a/tests/md/002 b/tests/md/002
new file mode 100755
index 0000000..9da322a
--- /dev/null
+++ b/tests/md/002
@@ -0,0 +1,68 @@
+#!/bin/bash
+#
+# Create a raid10 (nearcopy=2) device of all given devices, and check
+# theirs are all in-sync afterwards.
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
+DESCRIPTION="run raid10 (nearcopy=2) creation resync test"
+QUICK=1
+
+requires() {
+	_check_md_devname_available /dev/md/blktests2 && \
+	    _check_raid_devs_available && _meet_raid10_requirement
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
+		mdadm -C /dev/md/blktests2 -R -l10 "-n$size" -pn2 \
+		    "${devices[@]}" -z "$LIMIT_DEV_SIZE" 2>&1 | grep started
+	else
+		mdadm -C /dev/md/blktests2 -R -l10 "-n$size" -pn2 \
+		    "${devices[@]}" 2>&1 | grep started
+	fi
+	if [ $? -ne 0 ]; then
+		echo "Array is not started."
+		return
+	fi
+
+	local md
+	md=$(basename "$(readlink /dev/md/blktests2)")
+	_wait_sync_completed "$md"
+
+	local mismatched
+	_check_integrity "$md"
+	mismatched=$(cat /sys/block/"$md"/md/mismatch_cnt)
+	mdadm -S /dev/md/blktests2
+
+	if [ "$mismatched" -ne 0 ]; then
+		echo "Array is not synced."
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/md/002.out b/tests/md/002.out
new file mode 100644
index 0000000..356f3fe
--- /dev/null
+++ b/tests/md/002.out
@@ -0,0 +1,4 @@
+Running md/002
+mdadm: array /dev/md/blktests2 started.
+mdadm: stopped /dev/md/blktests2
+Test complete
-- 
2.7.4
