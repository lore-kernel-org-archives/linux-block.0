Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35844 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbdDFNTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 09:19:18 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 2/6] add: blockdev/001 check page-cache coherency after BLKDISCARD
Date: Thu,  6 Apr 2017 17:19:06 +0400
Message-Id: <1491484750-9164-3-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Regression test for fix https://lkml.org/lkml/2017/3/22/789
Page cache should be dropped after successful discard

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/config          |  1 +
 tests/blockdev/001     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/blockdev/001.out |  7 +++++
 tests/blockdev/group   |  6 ++++
 4 files changed, 88 insertions(+)
 create mode 100755 tests/blockdev/001
 create mode 100644 tests/blockdev/001.out
 create mode 100644 tests/blockdev/group

diff --git a/common/config b/common/config
index cfe7913..aef842c 100644
--- a/common/config
+++ b/common/config
@@ -199,6 +199,7 @@ export LOGGER_PROG="`set_prog_path logger`"
 export DBENCH_PROG="`set_prog_path dbench`"
 export DMSETUP_PROG="`set_prog_path dmsetup`"
 export WIPEFS_PROG="`set_prog_path wipefs`"
+export BLKDISCARD_PROG="`set_prog_path blkdiscard`"
 export DUMP_PROG="`set_prog_path dump`"
 export RESTORE_PROG="`set_prog_path restore`"
 export LVM_PROG="`set_prog_path lvm`"
diff --git a/tests/blockdev/001 b/tests/blockdev/001
new file mode 100755
index 0000000..53b0664
--- /dev/null
+++ b/tests/blockdev/001
@@ -0,0 +1,74 @@
+#! /bin/bash
+# FS QA Test 001
+#
+# Regression test for fix https://lkml.org/lkml/2017/3/22/789
+# Page cache should be dropped after successful discard
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
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/scsi_debug
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scsi_debug
+_require_command $BLKDISCARD_PROG blkdiscard
+
+
+# Create virtual device with unmap_zeroes_data support
+dev=$(_get_scsi_debug_dev 512 512 0 32 "lbpws=1 lbpws10=1")
+
+# Initialize data with known pattern
+$XFS_IO_PROG -c "pwrite -S 0xaa -b 2M 0 32M -w" -d $dev >>$seqres.full 2>&1 || \
+    _fail "pwrite failed"
+
+# Fill page cache with dirty data
+$XFS_IO_PROG -c "pwrite -S 0xbb -b 2M 2M 10M" -f $dev >>$seqres.full 2>&1 || \
+    _fail "pwrite failed"
+
+$BLKDISCARD_PROG $dev
+# After device was fully discarded, read sould return all zeroes
+dd if=$dev bs=4k  2>>$seqres.full | hexdump
+dd if=$dev bs=4M iflag=direct 2>>$seqres.full | hexdump
+# success, all done
+status=0
+exit
diff --git a/tests/blockdev/001.out b/tests/blockdev/001.out
new file mode 100644
index 0000000..0f81a92
--- /dev/null
+++ b/tests/blockdev/001.out
@@ -0,0 +1,7 @@
+QA output created by 001
+0000000 0000 0000 0000 0000 0000 0000 0000 0000
+*
+2000000
+0000000 0000 0000 0000 0000 0000 0000 0000 0000
+*
+2000000
diff --git a/tests/blockdev/group b/tests/blockdev/group
new file mode 100644
index 0000000..bdfdcb9
--- /dev/null
+++ b/tests/blockdev/group
@@ -0,0 +1,6 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 rw blockdev
-- 
2.9.3
