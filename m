Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33DC77B73
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 10:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbjD0Kdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243568AbjD0Kdy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 06:33:54 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2C94EDC
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 03:33:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vh7PZyW_1682591628;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vh7PZyW_1682591628)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 18:33:50 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     shinichiro.kawasaki@wdc.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH blktests 2/2] tests: Add ublk tests
Date:   Thu, 27 Apr 2023 18:32:42 +0800
Message-Id: <20230427103242.31361-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230427103242.31361-1-ZiyangZhang@linux.alibaba.com>
References: <20230427103242.31361-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is very important to test ublk crash handling since the userspace
part is not reliable. Especially we should test removing device, killing
ublk daemons and user recovery feature.

Add five new test for ublk to cover these cases.

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 tests/ublk/001     | 39 +++++++++++++++++++++++++++
 tests/ublk/001.out |  2 ++
 tests/ublk/002     | 53 +++++++++++++++++++++++++++++++++++++
 tests/ublk/002.out |  2 ++
 tests/ublk/003     | 43 ++++++++++++++++++++++++++++++
 tests/ublk/003.out |  2 ++
 tests/ublk/004     | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/ublk/004.out |  2 ++
 tests/ublk/005     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ublk/005.out |  2 ++
 10 files changed, 274 insertions(+)
 create mode 100644 tests/ublk/001
 create mode 100644 tests/ublk/001.out
 create mode 100644 tests/ublk/002
 create mode 100644 tests/ublk/002.out
 create mode 100644 tests/ublk/003
 create mode 100644 tests/ublk/003.out
 create mode 100644 tests/ublk/004
 create mode 100644 tests/ublk/004.out
 create mode 100644 tests/ublk/005
 create mode 100644 tests/ublk/005.out

diff --git a/tests/ublk/001 b/tests/ublk/001
new file mode 100644
index 0000000..fe158ba
--- /dev/null
+++ b/tests/ublk/001
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk by deleting ublk device while running fio
+
+. tests/block/rc
+. common/ublk
+
+DESCRIPTION="test ublk deletion"
+QUICK=1
+
+requires() {
+	_have_ublk
+}
+
+test() {
+	local ublk_prog="src/miniublk"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 > "$FULL"
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
+
+        ${ublk_prog} del -n 0 >> "$FULL"
+
+	_exit_ublk
+
+	echo "Test complete"
+}
diff --git a/tests/ublk/001.out b/tests/ublk/001.out
new file mode 100644
index 0000000..0d070b3
--- /dev/null
+++ b/tests/ublk/001.out
@@ -0,0 +1,2 @@
+Running ublk/001
+Test complete
diff --git a/tests/ublk/002 b/tests/ublk/002
new file mode 100644
index 0000000..25cad13
--- /dev/null
+++ b/tests/ublk/002
@@ -0,0 +1,53 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk by killing ublk daemon while running fio
+# Delete the device after it is dead
+
+. tests/block/rc
+. common/ublk
+
+DESCRIPTION="test ublk crash(1)"
+QUICK=1
+
+requires() {
+	_have_ublk
+}
+
+test() {
+	local ublk_prog="src/miniublk"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 > "$FULL"
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
+
+        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
+        kill -9 $pid
+
+        sleep 2
+        secs=0
+        while [ $secs -lt 10 ]; do
+                state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
+                [ "$state" == "DEAD" ] && break
+		sleep 1
+		let secs++
+        done
+        [ "$state" != "DEAD" ] && echo "device isn't dead after killing queue daemon"
+
+        ${ublk_prog} del -n 0 >> "$FULL"
+
+	_exit_ublk
+
+	echo "Test complete"
+}
diff --git a/tests/ublk/002.out b/tests/ublk/002.out
new file mode 100644
index 0000000..93039b7
--- /dev/null
+++ b/tests/ublk/002.out
@@ -0,0 +1,2 @@
+Running ublk/002
+Test complete
diff --git a/tests/ublk/003 b/tests/ublk/003
new file mode 100644
index 0000000..34bce74
--- /dev/null
+++ b/tests/ublk/003
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk by killing ublk daemon while running fio
+# Delete the device immediately
+
+. tests/block/rc
+. common/ublk
+
+DESCRIPTION="test ublk crash(2)"
+QUICK=1
+
+requires() {
+	_have_ublk
+}
+
+test() {
+	local ublk_prog="src/miniublk"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 > "$FULL"
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
+
+        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
+        kill -9 $pid
+
+        ${ublk_prog} del -n 0 >> "$FULL"
+
+	_exit_ublk
+
+	echo "Test complete"
+}
diff --git a/tests/ublk/003.out b/tests/ublk/003.out
new file mode 100644
index 0000000..90a3bfa
--- /dev/null
+++ b/tests/ublk/003.out
@@ -0,0 +1,2 @@
+Running ublk/003
+Test complete
diff --git a/tests/ublk/004 b/tests/ublk/004
new file mode 100644
index 0000000..c5d0694
--- /dev/null
+++ b/tests/ublk/004
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk user recovery by run fio with dev recovery:
+# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
+# (3)delete dev
+
+. tests/block/rc
+. common/ublk
+
+DESCRIPTION="test ublk recovery(1)"
+QUICK=1
+
+requires() {
+	_have_ublk
+}
+
+test() {
+	local ublk_prog="src/miniublk"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 -r 1 > "$FULL"
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
+        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
+        kill -9 $pid
+
+        sleep 2
+        secs=0
+        while [ $secs -lt 10 ]; do
+                state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
+                [ "$state" == "QUIESCED" ] && break
+		sleep 1
+		let secs++
+        done
+        [ "$state" != "QUIESCED" ] && echo "device isn't quiesced after killing queue daemon"
+ 
+        secs=0
+        while [ $secs -lt 10 ]; do
+                ${ublk_prog} recover -t null -n 0 >> "$FULL"
+                [ $? -eq 0 ] && break 
+                sleep 1
+                let secs++
+        done
+        state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
+        [ "$state" == "QUIESCED" ] && echo "failed to recover dev"
+
+        ${ublk_prog} del -n 0 >> "$FULL"
+
+	_exit_ublk
+
+	echo "Test complete"
+}
diff --git a/tests/ublk/004.out b/tests/ublk/004.out
new file mode 100644
index 0000000..a92cd50
--- /dev/null
+++ b/tests/ublk/004.out
@@ -0,0 +1,2 @@
+Running ublk/004
+Test complete
diff --git a/tests/ublk/005 b/tests/ublk/005
new file mode 100644
index 0000000..23c0555
--- /dev/null
+++ b/tests/ublk/005
@@ -0,0 +1,66 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk user recovery by run fio with dev recovery:
+# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
+# (3)kill all ubq_deamon, (4)delete dev
+
+. tests/block/rc
+. common/ublk
+
+DESCRIPTION="test ublk recovery(2)"
+QUICK=1
+
+requires() {
+	_have_ublk
+}
+
+test() {
+	local ublk_prog="src/miniublk"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	${ublk_prog} add -t null -n 0 -r 1 > "$FULL"
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 > /dev/null 2>&1 &
+        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
+        kill -9 $pid
+
+        sleep 2
+        secs=0
+        while [ $secs -lt 10 ]; do
+                state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
+                [ "$state" == "QUIESCED" ] && break
+		sleep 1
+		let secs++
+        done
+        [ "$state" != "QUIESCED" ] && echo "device isn't quiesced after killing queue daemon"
+
+        secs=0
+        while [ $secs -lt 10 ]; do
+                ${ublk_prog} recover -t null -n 0 >> "$FULL"
+                [ $? -eq 0 ] && break 
+                sleep 1
+                let secs++
+        done
+        state=`${ublk_prog} list -n 0 | grep "state" | awk '{print $11}'`
+        [ "$state" == "QUIESCED" ] && echo "failed to recover dev"
+
+        pid=`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
+        kill -9 $pid
+
+        ${ublk_prog} del -n 0 >> "$FULL"
+
+	_exit_ublk
+
+	echo "Test complete"
+}
diff --git a/tests/ublk/005.out b/tests/ublk/005.out
new file mode 100644
index 0000000..20d7b38
--- /dev/null
+++ b/tests/ublk/005.out
@@ -0,0 +1,2 @@
+Running ublk/005
+Test complete
-- 
2.31.1

