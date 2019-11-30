Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A39C43215
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD802075A
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 11:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfK3L6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 06:58:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfK3L6z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 06:58:55 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF9DD5F9970F59D50E44;
        Sat, 30 Nov 2019 19:58:51 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 19:58:44 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <linux-block@vger.kernel.org>,
        <osandov@fb.com>
Subject: [PATCH blktests v3] nbd/003:add mount and clear_sock test for nbd
Date:   Sat, 30 Nov 2019 20:05:40 +0800
Message-ID: <1575115540-69845-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the test case to check nbd device. This test case catches regressions
fixed by commit 92b5c8f0063e4 "nbd: replace kill_bdev() with
__invalidate_device() again".

Establish the nbd connection. Run two processes. The first one do mount
and umount, and the other one do clear_sock ioctl.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
v2 -> v3
1. Now only build nbd0 connection, not 15 connections.
2. Add the run_cnt to 225.
3. Modify some variable names.
---
 src/Makefile           |  3 ++-
 src/mount_clear_sock.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/003          | 55 ++++++++++++++++++++++++++++++++++++++++
 tests/nbd/003.out      |  1 +
 4 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 src/mount_clear_sock.c
 create mode 100644 tests/nbd/003
 create mode 100644 tests/nbd/003.out

diff --git a/src/Makefile b/src/Makefile
index 917d6f4..acd7327 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -10,7 +10,8 @@ C_TARGETS := \
 	sg/syzkaller1 \
 	nbdsetsize \
 	loop_change_fd \
-	zbdioctl
+	zbdioctl \
+	mount_clear_sock
 
 CXX_TARGETS := \
 	discontiguous-io
diff --git a/src/mount_clear_sock.c b/src/mount_clear_sock.c
new file mode 100644
index 0000000..c76cbfe
--- /dev/null
+++ b/src/mount_clear_sock.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2019 Sun Ke
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <linux/nbd.h>
+#include <assert.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <linux/fs.h>
+
+void clear_sock(int fd)
+{
+	int err;
+
+	err = ioctl(fd, NBD_CLEAR_SOCK, 0);
+	if (err) {
+		perror("ioctl");
+	}
+}
+
+void mount_nbd(char *dev, char *mp, char *fs)
+{
+	mount(dev, mp, fs, MS_NOSUID | MS_SYNCHRONOUS, 0);
+	umount(mp);
+}
+
+int main(int argc, char **argv)
+{
+	if (argc != 4) {
+		fprintf(stderr, "usage: $0 MOUNTPOINT DEV FS");
+		return EXIT_FAILURE;
+	}
+
+	char *mp = argv[1];
+	char *dev = argv[2];
+	char *fs = argv[3];
+
+	static int fd = -1;
+
+	fd = open(dev, O_RDWR);
+	if (fd < 0 ) {
+		perror("open");
+	}
+
+	if (fork() == 0) {
+		mount_nbd(dev, mp, fs);
+		exit(0);
+	}
+	if (fork() == 0) {
+		clear_sock(fd);
+		exit(0);
+	}
+	while(wait(NULL) > 0)
+		continue;
+
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/nbd/003 b/tests/nbd/003
new file mode 100644
index 0000000..738928e
--- /dev/null
+++ b/tests/nbd/003
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Sun Ke
+#
+# Test nbd device resizing. Regression test for patch
+#
+# 2b5c8f0063e4 ("nbd: replace kill_bdev() with __invalidate_device() again")
+
+
+DESCRIPTION="resize a connected nbd device"
+QUICK=1
+
+fs_type=ext4
+disk_capacity=256M
+run_cnt=225
+
+requires() {
+	_have_nbd && _have_src_program mount_clear_sock
+}
+
+_start_nbd_mount_server() {
+
+	fallocate -l $1 "${TMPDIR}/disk"
+
+	if [[ "$2"x = "ext4"x ]]; then
+		mkfs.ext4 "${TMPDIR}/disk" >> "$FULL" 2>&1
+	else
+		mkdosfs "${TMPDIR}/disk" >> "$FULL" 2>&1
+	fi
+	nbd-server 8000 "${TMPDIR}/disk" >> "$FULL" 2>&1
+
+	mkdir -p "${TMPDIR}/mount_point"
+}
+
+_stop_nbd_mount_server() {
+	pkill -9 -f 8000
+	rm -f "${TMPDIR}/disk"
+	rm -rf "${TMPDIR}/mount_point"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_start_nbd_mount_server  $disk_capacity $fs_type
+	nbd-client localhost 8000 /dev/nbd0 >> "$FULL" 2>&1
+
+	for ((i = 0; i < $run_cnt; i++))
+	do
+		src/mount_clear_sock  "${TMPDIR}/mount_point" /dev/nbd0 $fs_type
+	done
+
+	nbd-client -d /dev/nbd0
+	_stop_nbd_mount_server
+}
diff --git a/tests/nbd/003.out b/tests/nbd/003.out
new file mode 100644
index 0000000..aa340db
--- /dev/null
+++ b/tests/nbd/003.out
@@ -0,0 +1 @@
+Running nbd/003
-- 
2.13.6

