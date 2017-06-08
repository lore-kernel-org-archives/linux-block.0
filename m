Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39007 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdFHM3J (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 8 Jun 2017 08:29:09 -0400
From: James Wang <jnwang@suse.com>
To: osandov@fb.com, hch@infradead.org
Cc: axboe@fb.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com,
        James Wang <jnwang@suse.com>
Subject: [PATCH blktests] loop/002: Regression testing for loop device flush
Date: Thu,  8 Jun 2017 20:28:12 +0800
Message-Id: <20170608122812.24225-1-jnwang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a regression testing for loop device. when an unbound device
be close that take too long time. kernel will consume serveral orders
of magnitude more wall time than it does for a mounted device.

Signed-off-by: James Wang <jnwang@suse.com>
---
 tests/loop/002     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/002.out |  2 ++
 2 files changed, 79 insertions(+)

diff --git a/tests/loop/002 b/tests/loop/002
new file mode 100755
index 0000000..fd607d1
--- /dev/null
+++ b/tests/loop/002
@@ -0,0 +1,77 @@
+#!/bin/bash
+#
+# Test if close()ing a unbound loop device is too slow
+# Copyright (C) 2017 James Wang
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
+DESCRIPTION="Test if close()ing a unbound loop device is too slow"
+
+QUICK=1
+
+function run_test() {
+	TIMEFORMAT='%5R'
+	time {
+		for f in `ls /dev/loop[0-9]*|sort`; do dd if=$f of=/dev/null  bs=512 count=1 >/dev/null 2>&1; done
+	}
+}
+function clean_up() {
+	if lsmod | grep loop >/dev/null 2>&1; then
+		umount /dev/loop* >/dev/null 2>&1
+		losetup -D
+		sleep 5
+		
+		if ! rmmod loop;then
+			return 2;
+		fi
+	fi
+}
+
+function prepare() {
+	modprobe loop max_loop=64
+	dd if=/dev/zero of=${TMPDIR}/disk bs=512 count=200K >/dev/null 2>&1
+	for((i=0;i<4;i++))
+	do
+	        losetup -f ${TMPDIR}/disk;
+	done
+	mkfs.ext4 -F /dev/loop0 >/dev/null 2>&1
+	for((i=0;i<4;i++))
+	do
+	        mkdir -p t$i;
+	        mount /dev/loop$i t$i;
+	done
+
+}
+
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	prepare
+	SECONDS=0
+	run_test >/dev/null 2>&1
+	DURATION=${SECONDS}
+
+	clean_up
+	if ! clean_up; then
+		echo "Test complete"
+		return 2
+	fi
+	echo "Test complete"
+	if [[ "${DURATION}" -gt 1 ]]; then
+		return 1
+	else
+		return 0
+	fi
+}
diff --git a/tests/loop/002.out b/tests/loop/002.out
new file mode 100644
index 0000000..5c34a37
--- /dev/null
+++ b/tests/loop/002.out
@@ -0,0 +1,2 @@
+Running loop/002
+Test complete
-- 
2.12.3
