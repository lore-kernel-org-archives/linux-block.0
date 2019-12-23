Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3200CC2D0D2
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 03:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FD520709
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 03:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfLWDL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:11:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbfLWDL2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Dec 2019 22:11:28 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF194F06F464B68A80EE;
        Mon, 23 Dec 2019 11:11:25 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Dec 2019
 11:11:14 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <linux-block@vger.kernel.org>, <osandov@fb.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH blktests v4] nbd/003:add mount and clear_sock test for nbd
Date:   Mon, 23 Dec 2019 11:18:29 +0800
Message-ID: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
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
[Omar: simplify]
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
simplified nbd/003 -> v4
1. mkfs.ext4 /dev/nbd0 >> "$FULL" 2>&1.
2. Allow mount and umount to fail. if clear sock do the first, mount and
   umount can not be successful.
3. Add the loops to 5000. So it is very likely to trigger the BUGON.
---
 src/Makefile           |  5 +--
 src/mount_clear_sock.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/003          | 30 +++++++++++++++++
 tests/nbd/003.out      |  1 +
 4 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 src/mount_clear_sock.c
 create mode 100644 tests/nbd/003
 create mode 100644 tests/nbd/003.out

diff --git a/src/Makefile b/src/Makefile
index 917d6f4..3b587f6 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -4,12 +4,13 @@ HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
 
 C_TARGETS := \
 	loblksize \
+	loop_change_fd \
 	loop_get_status_null \
+	mount_clear_sock \
+	nbdsetsize \
 	openclose \
 	sg/dxfer-from-dev \
 	sg/syzkaller1 \
-	nbdsetsize \
-	loop_change_fd \
 	zbdioctl
 
 CXX_TARGETS := \
diff --git a/src/mount_clear_sock.c b/src/mount_clear_sock.c
new file mode 100644
index 0000000..ba9ed71
--- /dev/null
+++ b/src/mount_clear_sock.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2019 Sun Ke
+
+#include <assert.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <linux/fs.h>
+#include <linux/nbd.h>
+
+int main(int argc, char **argv)
+{
+	const char *mountpoint, *dev, *fstype;
+	int loops, fd;
+
+	if (argc != 5) {
+		fprintf(stderr, "usage: %s DEV MOUNTPOINT FSTYPE LOOPS", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	dev = argv[1];
+	mountpoint = argv[2];
+	fstype = argv[3];
+	loops = atoi(argv[4]);
+
+	fd = open(dev, O_RDWR);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	for (int i = 0; i < loops; i++) {
+		pid_t mount_pid, clear_sock_pid;
+		int wstatus;
+
+		mount_pid = fork();
+		if (mount_pid == -1) {
+			perror("fork");
+			return EXIT_FAILURE;
+		}
+		if (mount_pid == 0) {
+			mount(dev, mountpoint, fstype,
+				  MS_NOSUID | MS_SYNCHRONOUS, 0);
+			umount(mountpoint);
+			exit(EXIT_SUCCESS);
+		}
+
+		clear_sock_pid = fork();
+		if (clear_sock_pid == -1) {
+			perror("fork");
+			return EXIT_FAILURE;
+		}
+		if (clear_sock_pid == 0) {
+			if (ioctl(fd, NBD_CLEAR_SOCK, 0) == -1) {
+				perror("ioctl");
+				exit(EXIT_FAILURE);
+			}
+			exit(EXIT_SUCCESS);
+		}
+
+		if (waitpid(mount_pid, &wstatus, 0) == -1) {
+			perror("waitpid");
+			return EXIT_FAILURE;
+		}
+		if (!WIFEXITED(wstatus) ||
+		    WEXITSTATUS(wstatus) != EXIT_SUCCESS) {
+			fprintf(stderr, "mount process failed");
+			return EXIT_FAILURE;
+		}
+
+		if (waitpid(clear_sock_pid, &wstatus, 0) == -1) {
+			perror("waitpid");
+			return EXIT_FAILURE;
+		}
+		if (!WIFEXITED(wstatus) ||
+		    WEXITSTATUS(wstatus) != EXIT_SUCCESS) {
+			fprintf(stderr, "NBD_CLEAR_SOCK process failed");
+			return EXIT_FAILURE;
+		}
+	}
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
diff --git a/tests/nbd/003 b/tests/nbd/003
new file mode 100644
index 0000000..57fb63a
--- /dev/null
+++ b/tests/nbd/003
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Sun Ke
+#
+# Regression test for commit 2b5c8f0063e4 ("nbd: replace kill_bdev() with
+# __invalidate_device() again").
+
+. tests/nbd/rc
+
+DESCRIPTION="mount/unmount concurrently with NBD_CLEAR_SOCK"
+QUICK=1
+
+requires() {
+	_have_nbd && _have_src_program mount_clear_sock
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_start_nbd_server
+	nbd-client -L -N export localhost /dev/nbd0 >> "$FULL" 2>&1
+	mkfs.ext4 /dev/nbd0 >> "$FULL" 2>&1
+
+	mkdir -p "${TMPDIR}/mnt"
+	src/mount_clear_sock /dev/nbd0 "${TMPDIR}/mnt" ext4 5000
+	umount "${TMPDIR}/mnt" > /dev/null 2>&1
+
+	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
+	_stop_nbd_server
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

