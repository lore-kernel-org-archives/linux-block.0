Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C77CC7EE2A
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 03:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjEED2j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 23:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjEED2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 23:28:38 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A2869A
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 20:28:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VhnGAf0_1683257310;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VhnGAf0_1683257310)
          by smtp.aliyun-inc.com;
          Fri, 05 May 2023 11:28:33 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     shinichiro.kawasaki@wdc.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V2 blktests 2/2] tests: Add ublk tests
Date:   Fri,  5 May 2023 11:28:08 +0800
Message-Id: <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is very important to test ublk crash handling since the userspace
part is not reliable. Especially we should test removing device, killing
ublk daemons and user recovery feature.

Add five new tests for ublk to cover these cases.

Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
---
 common/ublk        | 10 +++++-
 tests/ublk/001     | 48 +++++++++++++++++++++++++++
 tests/ublk/001.out |  2 ++
 tests/ublk/002     | 63 +++++++++++++++++++++++++++++++++++
 tests/ublk/002.out |  2 ++
 tests/ublk/003     | 48 +++++++++++++++++++++++++++
 tests/ublk/003.out |  2 ++
 tests/ublk/004     | 50 ++++++++++++++++++++++++++++
 tests/ublk/004.out |  2 ++
 tests/ublk/005     | 79 +++++++++++++++++++++++++++++++++++++++++++
 tests/ublk/005.out |  2 ++
 tests/ublk/006     | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ublk/006.out |  2 ++
 tests/ublk/rc      | 15 +++++++++
 14 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100755 tests/ublk/001
 create mode 100644 tests/ublk/001.out
 create mode 100755 tests/ublk/002
 create mode 100644 tests/ublk/002.out
 create mode 100755 tests/ublk/003
 create mode 100644 tests/ublk/003.out
 create mode 100755 tests/ublk/004
 create mode 100644 tests/ublk/004.out
 create mode 100755 tests/ublk/005
 create mode 100644 tests/ublk/005.out
 create mode 100755 tests/ublk/006
 create mode 100644 tests/ublk/006.out
 create mode 100644 tests/ublk/rc

diff --git a/common/ublk b/common/ublk
index 932c534..7a951eb 100644
--- a/common/ublk
+++ b/common/ublk
@@ -15,8 +15,16 @@ _remove_ublk_devices() {
 	src/miniublk del -a
 }
 
+__get_ublk_dev_state() {
+	src/miniublk list -n "$1" | grep "state" | awk '{print $11}'
+}
+
+__get_ublk_daemon_pid() {
+	src/miniublk list -n "$1" | grep "pid" | awk '{print $7}'
+}
+
 _init_ublk() {
-	_remove_ublk_devices
+	_remove_ublk_devices > /dev/null 2>&1
 
 	modprobe -rq ublk_drv
 	if ! modprobe ublk_drv; then
diff --git a/tests/ublk/001 b/tests/ublk/001
new file mode 100755
index 0000000..36a43d7
--- /dev/null
+++ b/tests/ublk/001
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk delete
+
+. tests/ublk/rc
+
+DESCRIPTION="test ublk delete"
+
+__run() {
+	local type=$1
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
+	else
+		truncate -s 1G "$TMPDIR/img"
+		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
+	fi
+
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
+	sleep 2
+
+	${ublk_prog} del -n 0 >> "$FULL" 2>&1
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
+	for type in "null" "loop"; do
+		__run "$type"
+	done
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
new file mode 100755
index 0000000..e36589e
--- /dev/null
+++ b/tests/ublk/002
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk crash with delete after dead confirmation
+
+. tests/ublk/rc
+
+DESCRIPTION="test ublk crash with delete after dead confirmation"
+
+__run() {
+	local type=$1
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
+	else
+		truncate -s 1G "$TMPDIR/img"
+		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
+	fi
+
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
+	sleep 2
+
+	kill -9 "$(__get_ublk_daemon_pid 0)"
+	sleep 2
+
+	local secs=0
+	local state=""
+	while [ $secs -lt 20 ]; do
+		state="$(__get_ublk_dev_state 0)"
+		[  "$state" == "DEAD" ] && break
+		sleep 1
+		(( secs++ ))
+	done
+
+	state="$(__get_ublk_dev_state 0)"
+	[  "$state" != "DEAD" ] && echo "device is $state after killing queue daemon"
+
+	${ublk_prog} del -n 0 >> "$FULL" 2>&1
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
+	for type in "null" "loop"; do
+		__run "$type"
+	done
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
new file mode 100755
index 0000000..b256b09
--- /dev/null
+++ b/tests/ublk/003
@@ -0,0 +1,48 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test mounting block device exported by ublk
+
+. tests/ublk/rc
+
+DESCRIPTION="test mounting block device exported by ublk"
+
+test() {
+	local ublk_prog="src/miniublk"
+	local ROOT_FSTYPE="$(findmnt -l -o FSTYPE -n /)"
+	local mnt="$TMPDIR/mnt"
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_ublk; then
+		return 1
+	fi
+
+	truncate -s 1G "$TMPDIR/img"
+	${ublk_prog} add -t loop -f  "$TMPDIR/img" -n 0 > "$FULL" 2>&1
+
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
+		echo "fail to list dev"
+	fi
+
+	wipefs -a /dev/ublkb0 >> "$FULL" 2>&1
+	mkfs.${ROOT_FSTYPE} /dev/ublkb0 >> "$FULL" 2>&1
+	mkdir -p "$mnt"
+	mount /dev/ublkb0 "$mnt" >> "$FULL" 2>&1
+
+	local UBLK_FSTYPE="$(findmnt -l -o FSTYPE -n $mnt)"
+	if [ "$UBLK_FSTYPE" != "$ROOT_FSTYPE" ]; then
+		echo "got $UBLK_FSTYPE, should be $ROOT_FSTYPE"
+	fi
+	umount "$mnt" > /dev/null 2>&1
+
+	${ublk_prog} del -n 0 >> "$FULL" 2>&1
+
+	_exit_ublk
+
+	echo "Test complete"
+}
+
+
diff --git a/tests/ublk/003.out b/tests/ublk/003.out
new file mode 100644
index 0000000..90a3bfa
--- /dev/null
+++ b/tests/ublk/003.out
@@ -0,0 +1,2 @@
+Running ublk/003
+Test complete
diff --git a/tests/ublk/004 b/tests/ublk/004
new file mode 100755
index 0000000..84e01d1
--- /dev/null
+++ b/tests/ublk/004
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk crash with delete just after daemon kill
+
+. tests/ublk/rc
+
+DESCRIPTION="test ublk crash with delete just after daemon kill"
+
+__run() {
+	local type=$1
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} add -t null -n 0 > "$FULL" 2>&1
+	else
+		truncate -s 1G "$TMPDIR/img"
+		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 > "$FULL" 2>&1
+	fi
+
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
+	sleep 2
+
+	kill -9 "$(__get_ublk_daemon_pid 0)"
+
+	${ublk_prog} del -n 0 >> "$FULL" 2>&1
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
+	for type in "null" "loop"; do
+		__run "$type"
+	done
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
new file mode 100755
index 0000000..f365fd6
--- /dev/null
+++ b/tests/ublk/005
@@ -0,0 +1,79 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk recovery with one time daemon kill:
+# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
+# (3)delete dev
+
+. tests/ublk/rc
+
+DESCRIPTION="test ublk recovery with one time daemon kill"
+
+__run() {
+	local type=$1
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} add -t null -n 0 -r > "$FULL" 2>&1
+	else
+		truncate -s 1G "$TMPDIR/img"
+		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 -r > "$FULL" 2>&1
+	fi
+
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
+	sleep 2
+
+	kill -9 "$(__get_ublk_daemon_pid 0)"
+	sleep 2
+
+	local secs=0
+	local state=""
+	while [ $secs -lt 20 ]; do
+		state="$(__get_ublk_dev_state 0)"
+		[ "$state" == "QUIESCED" ] && break
+		sleep 1
+		(( secs++ ))
+	done
+
+	state="$(__get_ublk_dev_state 0)"
+	[ "$state" != "QUIESCED" ] && echo "device is $state after killing queue daemon"
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} recover -t null -n 0 >> "$FULL" 2>&1
+	else
+		${ublk_prog} recover -t loop -f "$TMPDIR/img" -n 0 >> "$FULL" 2>&1
+	fi
+
+	while [ $secs -lt 20 ]; do
+		state="$(__get_ublk_dev_state 0)"
+		[ "$state" == "LIVE" ] && break
+		sleep 1
+		(( secs++ ))
+	done
+	[ "$state" != "LIVE" ] && echo "device is $state after recovery"
+
+	${ublk_prog} del -n 0 >> "$FULL" 2>&1
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
+	for type in "null" "loop"; do
+		__run "$type"
+	done
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
diff --git a/tests/ublk/006 b/tests/ublk/006
new file mode 100755
index 0000000..0848939
--- /dev/null
+++ b/tests/ublk/006
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# Test ublk recovery with two times daemon kill:
+# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
+# (3)kill all ubq_deamon, (4)delete dev
+
+. tests/ublk/rc
+
+DESCRIPTION="test ublk recovery with two times daemon kill"
+
+__run() {
+	local type=$1
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} add -t null -n 0 -r > "$FULL" 2>&1
+	else
+		truncate -s 1G "$TMPDIR/img"
+		${ublk_prog} add -t loop -f "$TMPDIR/img" -n 0 -r > "$FULL" 2>&1
+	fi
+
+	udevadm settle
+	if ! ${ublk_prog} list -n 0 >> "$FULL" 2>&1; then
+		echo "fail to list dev"
+	fi
+
+	_run_fio_rand_io --filename=/dev/ublkb0 --time_based --runtime=30 >> "$FULL" 2>&1 &
+	sleep 2
+
+	kill -9 "$(__get_ublk_daemon_pid 0)"
+	sleep 2
+
+	local secs=0
+	local state=""
+	while [ $secs -lt 20 ]; do
+		state="$(__get_ublk_dev_state 0)"
+		[ "$state" == "QUIESCED" ] && break
+		sleep 1
+		(( secs++ ))
+	done
+
+	state="$(__get_ublk_dev_state 0)"
+	[ "$state" != "QUIESCED" ] && echo "device is $state after killing queue daemon"
+
+	if [ "$type" == "null" ]; then
+		${ublk_prog} recover -t null -n 0 >> "$FULL" 2>&1
+	else
+		${ublk_prog} recover -t loop -f "$TMPDIR/img" -n 0 >> "$FULL" 2>&1
+	fi
+
+	secs=0
+	while [ $secs -lt 20 ]; do
+		state="$(__get_ublk_dev_state 0)"
+		[ "$state" == "LIVE" ] && break
+		sleep 1
+		(( secs++ ))
+	done
+	[ "$state" != "LIVE" ] && echo "device is $state after recovery"
+
+	kill -9 "$(__get_ublk_daemon_pid 0)"
+
+	${ublk_prog} del -n 0 >> "$FULL" 2>&1
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
+	for type in "null" "loop"; do
+		__run "$type"
+	done
+
+	_exit_ublk
+
+	echo "Test complete"
+}
+
diff --git a/tests/ublk/006.out b/tests/ublk/006.out
new file mode 100644
index 0000000..6d2a530
--- /dev/null
+++ b/tests/ublk/006.out
@@ -0,0 +1,2 @@
+Running ublk/006
+Test complete
diff --git a/tests/ublk/rc b/tests/ublk/rc
new file mode 100644
index 0000000..8cbc757
--- /dev/null
+++ b/tests/ublk/rc
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Ziyang Zhang
+#
+# ublk tests.
+
+. common/rc
+. common/ublk
+. common/fio
+
+group_requires() {
+	_have_root
+	_have_ublk
+	_have_fio
+}
-- 
2.31.1

