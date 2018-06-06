Return-Path: <linux-block-owner@vger.kernel.org>
Received: from synology.com ([59.124.61.242]:53441 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932316AbeFFIKR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 04:10:17 -0400
From: bingjingc <bingjingc@synology.com>
To: linux-block@vger.kernel.org
Cc: bingjingc@synology.com, cccheng@synology.com
Subject: [PATCH blktests 5/9] blktests: add a regression test for raid6 creation resync
Date: Wed,  6 Jun 2018 16:10:10 +0800
Message-Id: <1528272610-17338-1-git-send-email-bingjingc@synology.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/md/004     | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/004.out |  4 ++++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/md/004
 create mode 100644 tests/md/004.out

diff --git a/tests/md/004 b/tests/md/004
new file mode 100755
index 0000000..591e096
--- /dev/null
+++ b/tests/md/004
@@ -0,0 +1,60 @@
+#!/bin/bash
+#
+# Create a raid6 device of all given devices, and check theirs are
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
+DESCRIPTION="run raid6 creation resync test"
+QUICK=1
+
+requires() {
+	_check_md_devname_available /dev/md/blktests4 && \
+	    _check_raid_devs_available && _meet_raid6_requirement
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if [ -n "$LIMIT_DEV_SIZE" ]; then
+		mdadm -C /dev/md/blktests4 -R -l6 "-n${#RAID_DEVS[@]}"\
+		    "${RAID_DEVS[@]}" -z "$LIMIT_DEV_SIZE" 2>&1 | grep started
+	else
+		mdadm -C /dev/md/blktests4 -R -l6 "-n${#RAID_DEVS[@]}"\
+		    "${RAID_DEVS[@]}" 2>&1 | grep started
+	fi
+	if [ $? -ne 0 ]; then
+		echo "Array is not started."
+		return
+	fi
+
+	local md
+	md=$(basename "$(readlink /dev/md/blktests4)")
+	_wait_sync_completed "$md"
+
+	local mismatched
+	_check_integrity "$md"
+	mismatched=$(cat /sys/block/"$md"/md/mismatch_cnt)
+	mdadm -S /dev/md/blktests4
+
+	if [ "$mismatched" -ne 0 ]; then
+		echo "Array is not synced."
+	fi
+
+	echo "Test complete"
+}
\ No newline at end of file
diff --git a/tests/md/004.out b/tests/md/004.out
new file mode 100644
index 0000000..1c9b7a8
--- /dev/null
+++ b/tests/md/004.out
@@ -0,0 +1,4 @@
+Running md/004
+mdadm: array /dev/md/blktests4 started.
+mdadm: stopped /dev/md/blktests4
+Test complete
-- 
2.7.4
