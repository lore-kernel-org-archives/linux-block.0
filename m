Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65264C4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 06:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E3206C2
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 06:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfIQGn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:43:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbfIQGn0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 02:43:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3444CB6FA7B2C93B4FD6;
        Tue, 17 Sep 2019 14:43:25 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 17 Sep 2019 14:43:16 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <sunke32@huawei.com>, <osandov@fb.com>,
        <linux-block@vger.kernel.org>
Subject: [PATCH blktests v2] nbd/003:add mount and clear_sock test for nbd
Date:   Tue, 17 Sep 2019 14:49:51 +0800
Message-ID: <1568702991-69027-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the test case to check nbd devices.This test case catches regressions
fixed by commit 92b5c8f0063e4 "nbd: replace kill_bdev() with
__invalidate_device() again".

Establish the nbd connection.Run two processes.One do mount and umount,
anther one do clear_sock ioctl.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 src/Makefile           |  3 ++-
 src/mount_clear_sock.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/003          | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/003.out      |  1 +
 4 files changed, 137 insertions(+), 1 deletion(-)
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
index 0000000..f6eef5a
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
index 0000000..45093aa
--- /dev/null
+++ b/tests/nbd/003
@@ -0,0 +1,66 @@
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
+run_cnt=1
+
+requires() {
+	_have_nbd && _have_src_program mount_clear_sock
+}
+
+_start_nbd_mount_server() {
+
+	fallocate -l $1 "${TMPDIR}/mnt_$i"
+
+	if [[ "$2"x = "ext4"x ]]; then
+		mkfs.ext4 "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
+	else
+		mkdosfs "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
+	fi
+	nbd-server 800$i "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
+
+	mkdir -p "${TMPDIR}/$i"
+}
+
+_stop_nbd_mount_server() {
+	pkill -9 -f 800$i
+	rm -f "${TMPDIR}/mnt_$i"
+	rm -rf "${TMPDIR}/$i"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	for ((i = 0; i < 15; i++))
+	do
+		_start_nbd_mount_server  $disk_capacity $fs_type
+		nbd-client localhost 800$i /dev/nbd$i >> "$FULL" 2>&1
+		if [[ "$?" -ne "0" ]]; then
+			echo "nbd$i connnect failed" 
+		fi 
+	done
+
+	for ((j = 0; j < $run_cnt; j++))
+	do
+		for ((i = 0; i < 15; i++))
+		do
+			src/mount_clear_sock  "${TMPDIR}/$i" /dev/nbd$i $fs_type
+		done
+	done	
+
+	for ((i = 0; i < 15; i++))
+	do
+		nbd-client -d /dev/nbd$i
+		_stop_nbd_mount_server
+	done
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

