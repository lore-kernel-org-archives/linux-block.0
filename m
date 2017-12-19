Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59413 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933857AbdLSKeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 05:34:09 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
To: <osandov@osandov.com>
CC: <eguan@redhat.com>, <fstests@vger.kernel.org>,
        <linux-block@vger.kernel.org>, xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH blktests] block/013: Add test for BLKRRPART ioctl
Date: Tue, 19 Dec 2017 18:30:23 +0800
Message-ID: <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
References: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If the entire block device is formatted with a filesystem and
mounted, running "blockdev --rereadpt" should fail and return
EBUSY instead of pass.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 tests/block/013     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/013.out |  3 +++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/block/013
 create mode 100644 tests/block/013.out

diff --git a/tests/block/013 b/tests/block/013
new file mode 100755
index 0000000..77ae55c
--- /dev/null
+++ b/tests/block/013
@@ -0,0 +1,62 @@
+#!/bin/bash
+#
+# If the entire block device is formatted with a filesystem and
+# mounted, running "blockdev --rereadpt" should fail and return
+# EBUSY.  On buggy kernel, it passes unexpectedly.
+#
+# Regression test for commit 77032ca66f86 ("Return EBUSY from
+# BLKRRPART for mounted whole-dev fs").
+#
+# Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+DESCRIPTION="test return EBUSY from BLKRRPART for mounted whole-dev"
+QUICK=1
+
+requires() {
+	_have_program mkfs.ext3
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	rm -f "$FULL"
+	mkdir "$TMPDIR/mntpoint"
+
+	# Format
+	mkfs.ext3 -F "$TEST_DEV" >> "$FULL" 2>&1
+
+	# Mount
+	mount "$TEST_DEV" "$TMPDIR/mntpoint"
+
+	# Check mounted whole-dev
+	local out=$(blockdev --rereadpt "$TEST_DEV" 2>&1)
+	echo $out | grep -q "Device or resource busy"
+	if [ $? -eq 0 ]; then
+		echo "Return EBUSY for mounted whole-dev"
+	else
+		echo "Don't return EBUSY for mounted whole-dev"
+	fi
+
+	echo $out >> "$FULL"
+
+	# Umount
+	umount "$TMPDIR/mntpoint"
+
+	rm -rf "$TMPDIR/mntpoint"
+
+	echo "Test complete"
+}
diff --git a/tests/block/013.out b/tests/block/013.out
new file mode 100644
index 0000000..74d1d08
--- /dev/null
+++ b/tests/block/013.out
@@ -0,0 +1,3 @@
+Running block/013
+Return EBUSY for mounted whole-dev
+Test complete
-- 
1.8.3.1
