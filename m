Return-Path: <linux-block-owner@vger.kernel.org>
Received: from synology.com ([59.124.61.242]:50279 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932262AbeFFIIF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 04:08:05 -0400
From: bingjingc <bingjingc@synology.com>
To: linux-block@vger.kernel.org
Cc: bingjingc@synology.com, cccheng@synology.com
Subject: [PATCH blktests 2/9] blktests: add a regression test for raid1 creation resync
Date: Wed,  6 Jun 2018 16:07:57 +0800
Message-Id: <1528272477-10861-1-git-send-email-bingjingc@synology.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/md/001     | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/001.out |  4 ++++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/md/001
 create mode 100644 tests/md/001.out

diff --git a/tests/md/001 b/tests/md/001
new file mode 100755
index 0000000..8b3070d
--- /dev/null
+++ b/tests/md/001
@@ -0,0 +1,60 @@
+#!/bin/bash
+#
+# Create a raid1 device of all given devices, and check theirs are
+# all in-sync afterwards.
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
+DESCRIPTION="run raid1 creation resync test"
+QUICK=1
+
+requires() {
+	_check_md_devname_available /dev/md/blktests1 && \
+	    _check_raid_devs_available && _meet_raid1_requirement
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if [ -n "$LIMIT_DEV_SIZE" ]; then
+		mdadm -C /dev/md/blktests1 -R -l1 "-n${#RAID_DEVS[@]}" \
+		    "${RAID_DEVS[@]}" -z "$LIMIT_DEV_SIZE" 2>&1 | grep started
+	else
+		mdadm -C /dev/md/blktests1 -R -l1 "-n${#RAID_DEVS[@]}" \
+		    "${RAID_DEVS[@]}" 2>&1 | grep started
+	fi
+	if [ $? -ne 0 ]; then
+		echo "Array is not started."
+		return
+	fi
+
+	local md
+	md=$(basename "$(readlink /dev/md/blktests1)")
+	_wait_sync_completed "$md"
+
+	local mismatched
+	_check_integrity "$md"
+	mismatched=$(cat /sys/block/"$md"/md/mismatch_cnt)
+	mdadm -S /dev/md/blktests1
+
+	if [ "$mismatched" -ne 0 ]; then
+		echo "Array is not synced."
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/md/001.out b/tests/md/001.out
new file mode 100644
index 0000000..0dd94d8
--- /dev/null
+++ b/tests/md/001.out
@@ -0,0 +1,4 @@
+Running md/001
+mdadm: array /dev/md/blktests1 started.
+mdadm: stopped /dev/md/blktests1
+Test complete
-- 
2.7.4
