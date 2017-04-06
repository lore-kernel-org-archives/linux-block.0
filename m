Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35863 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933835AbdDFNTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 09:19:22 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 5/6] new: blockdev/004 Check that live fs survives blkdev page truncation
Date: Thu,  6 Apr 2017 17:19:09 +0400
Message-Id: <1491484750-9164-6-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/blockdev/004     | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/blockdev/004.out |  2 ++
 tests/blockdev/group   |  1 +
 3 files changed, 84 insertions(+)
 create mode 100755 tests/blockdev/004
 create mode 100644 tests/blockdev/004.out

diff --git a/tests/blockdev/004 b/tests/blockdev/004
new file mode 100755
index 0000000..decb4ad
--- /dev/null
+++ b/tests/blockdev/004
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test 004
+#
+# Check that live filesystem survives blockdev pagecache truncation.
+# blkdev page cache can be truncated due to various reasons
+# 1)ioctl: BLKDISCARD
+# 2)blkdev: falloc{ FALLOC_FL_ZERO_RANGE, FALLOC_FL_PUNCH_HOLE }
+# 3)nbd: NBD_CLEAR_SOCK
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Dmitry Monakhov <dmonakhov@openvz.org>
+# All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	$UMOUNT_PROG $fs_mnt
+	_destroy_loop_device $loop_dev
+	cd /
+	rm -rf $TEST_DIR/$$
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_loop
+
+# create the fs image and mount point
+
+mkdir -p $TEST_DIR/$$ || _fail "Can not make test dir"
+fs_img=$TEST_DIR/$$/fs.img
+fs_mnt=$TEST_DIR/$$/mnt
+$XFS_IO_PROG -fc "truncate 1g" $fs_img >>$seqres.full 2>&1
+mkdir -p $fs_mnt
+loop_dev=$(_create_loop_device $fs_img)
+_mkfs_dev $loop_dev
+_mount $loop_dev $fs_mnt
+
+# Issue zeroout on block device, this act just a giant hammer for fs,
+# A lot of complains are expected, bug_on/panic is not.
+$XFS_IO_PROG -c "fzero -k 0 1G" -f $loop_dev >>$seqres.full 2>&1
+# Try IO on corrupted fs
+for ((i=0;i<1000;i++));do
+	$XFS_IO_PROG -fc "pwrite -S $i 0 16k" $fs_mnt/test-$i >>$seqres.full 2>&1
+done
+$XFS_IO_PROG -fc "fsync" $fs_mnt/test-0 >>$seqres.full 2>&1
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/blockdev/004.out b/tests/blockdev/004.out
new file mode 100644
index 0000000..af8614a
--- /dev/null
+++ b/tests/blockdev/004.out
@@ -0,0 +1,2 @@
+QA output created by 004
+Silence is golden
diff --git a/tests/blockdev/group b/tests/blockdev/group
index e5ce864..d100c85 100644
--- a/tests/blockdev/group
+++ b/tests/blockdev/group
@@ -6,3 +6,4 @@
 001 rw blockdev
 002 rw blockdev liotarget
 003 rw blockdev liotarget integrity dangerous
+004 rw blockdev dangerous zero
-- 
2.9.3
