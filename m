Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35158 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933785AbdDFNTX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 09:19:23 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 6/6] new: blockdev/005 Check that busy fs survives blkdev page truncation
Date: Thu,  6 Apr 2017 17:19:10 +0400
Message-Id: <1491484750-9164-7-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

same as blockdev/004 but with add more stress on corrupted fs.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/blockdev/005     | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/blockdev/005.out |  2 ++
 tests/blockdev/group   |  1 +
 tests/generic/390      |  1 +
 4 files changed, 96 insertions(+)
 create mode 100755 tests/blockdev/005
 create mode 100644 tests/blockdev/005.out

diff --git a/tests/blockdev/005 b/tests/blockdev/005
new file mode 100755
index 0000000..fa3eadc
--- /dev/null
+++ b/tests/blockdev/005
@@ -0,0 +1,92 @@
+#! /bin/bash
+# FS QA Test 005
+#
+# Check that busy filesystem survives blockdev pagecache truncation.
+# blkdev page cache can be truncated due to various reasons
+# 1)ioctl: BLKDISCARD
+# 2)blkdev: falloc{ FALLOC_FL_ZERO_RANGE, FALLOC_FL_PUNCH_HOLE }
+# 3)nbd: NBD_CLEAR_SOCK
+# test is similar blockdev/004 but push more stress on filesystem.
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
+#_require_xfs_io_command "fzero"
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
+stress_dir="$fs_mnt/stress"
+mkdir "$stress_dir"
+# Disable all sync operations to get higher load
+FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
+fsstress_args=`_scale_fsstress_args -d $stress_dir -p4 -n9999999 $FSSTRESS_AVOID`
+$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
+fsstress_pid=$!
+# Warm-up
+sleep 3
+
+# Issue zeroout on block device, this act just a giant hammer for fs,
+# A lot of complains are expected, bug_on/panic is not.
+$XFS_IO_PROG -c "fzero -k 0 1G" -f $loop_dev >>$seqres.full 2>&1
+# Force sync operation in order to flush data to screwed disk.
+$XFS_IO_PROG -c "pwrite 0 4k" -c "syncfs" -f $fs_mnt/check_ro >>$seqres.full 2>&1
+sleep 3
+$KILLALL_PROG -q $FSSTRESS_PROG
+wait $pid
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/blockdev/005.out b/tests/blockdev/005.out
new file mode 100644
index 0000000..a5027f1
--- /dev/null
+++ b/tests/blockdev/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/blockdev/group b/tests/blockdev/group
index d100c85..445b97c 100644
--- a/tests/blockdev/group
+++ b/tests/blockdev/group
@@ -7,3 +7,4 @@
 002 rw blockdev liotarget
 003 rw blockdev liotarget integrity dangerous
 004 rw blockdev dangerous zero
+005 rw blockdev dangerous zero
diff --git a/tests/generic/390 b/tests/generic/390
index 473015a..a717888 100755
--- a/tests/generic/390
+++ b/tests/generic/390
@@ -55,6 +55,7 @@ _supported_os Linux
 _require_scratch
 _require_freeze
 _require_test_program "feature"
+_require_command "$KILLALL_PROG" killall
 
 _scratch_mkfs >>$seqres.full 2>&1
 # We don't want to freeze/unfreeze root fs if mount scratch dev failed
-- 
2.9.3
