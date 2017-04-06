Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33745 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757082AbdDFNTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 09:19:20 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 3/6] new: blockdev/002 check information leak for lio-fileio
Date: Thu,  6 Apr 2017 17:19:07 +0400
Message-Id: <1491484750-9164-4-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/blockdev/002     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/blockdev/002.out | 12 ++++++++
 tests/blockdev/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/blockdev/002
 create mode 100644 tests/blockdev/002.out

diff --git a/tests/blockdev/002 b/tests/blockdev/002
new file mode 100755
index 0000000..71867d1
--- /dev/null
+++ b/tests/blockdev/002
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test 002
+#
+# Regression test for  information leak for lio-fileio target
+# BUG: If image  file is less than virtual blockdev then read() may return
+#      unitilized data.
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
+	_liotgt_cleanup
+	rm -rf $TEST_DIR/$$
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/liotarget
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_liotarget
+
+mkdir -p $TEST_DIR/$$ || _fail "Can not make test dir"
+
+cfg_path=$(_liotgt_create_fileio  002-test.img $TEST_DIR/$$/002-test.img 128M)
+dev=$(_liotgt_attach_target /backstores/fileio/002-test.img)
+
+$XFS_IO_PROG -f -c "truncate 1M" $TEST_DIR/$$/002-test.img >> $seqres.full
+
+$XFS_IO_PROG -c "pwrite -S 0xa0 -b 512 512 1k" -d $dev >>$seqres.full 2>&1 || \
+    _fail "pwrite failed"
+
+$XFS_IO_PROG -c "pwrite -S 0xab -b 512 2M 1k" -d $dev >>$seqres.full 2>&1 || \
+    _fail "pwrite failed"
+
+dd if=$dev bs=4k  2>>$seqres.full | hexdump
+# success, all done
+status=0
+exit
diff --git a/tests/blockdev/002.out b/tests/blockdev/002.out
new file mode 100644
index 0000000..e761c06
--- /dev/null
+++ b/tests/blockdev/002.out
@@ -0,0 +1,12 @@
+QA output created by 002
+0000000 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0000200 a0a0 a0a0 a0a0 a0a0 a0a0 a0a0 a0a0 a0a0
+*
+0000600 0000 0000 0000 0000 0000 0000 0000 0000
+*
+0200000 abab abab abab abab abab abab abab abab
+*
+0200400 0000 0000 0000 0000 0000 0000 0000 0000
+*
+8000000
diff --git a/tests/blockdev/group b/tests/blockdev/group
index bdfdcb9..0b511f3 100644
--- a/tests/blockdev/group
+++ b/tests/blockdev/group
@@ -4,3 +4,4 @@
 # - comment line before each group is "new" description
 #
 001 rw blockdev
+002 rw blockdev liotarget
-- 
2.9.3
