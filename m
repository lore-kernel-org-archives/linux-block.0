Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbeJRScT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Oct 2018 14:32:19 -0400
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] loop/006: Add test for setting partscan flag
Date: Thu, 18 Oct 2018 12:31:46 +0200
Message-Id: <20181018103147.3567-2-jack@suse.cz>
In-Reply-To: <20181018103147.3567-1-jack@suse.cz>
References: <20181018103147.3567-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add test for setting partscan flag.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/Makefile                   |  3 ++-
 src/loop_set_status_partscan.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 tests/loop/006                 | 33 +++++++++++++++++++++++++++++++
 tests/loop/006.out             |  2 ++
 4 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 src/loop_set_status_partscan.c
 create mode 100755 tests/loop/006
 create mode 100644 tests/loop/006.out

diff --git a/src/Makefile b/src/Makefile
index f89f61701179..6dadcbec8beb 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -4,7 +4,8 @@ C_TARGETS := \
 	openclose \
 	sg/dxfer-from-dev \
 	sg/syzkaller1 \
-	nbdsetsize
+	nbdsetsize \
+	loop_set_status_partscan
 
 CXX_TARGETS := \
 	discontiguous-io
diff --git a/src/loop_set_status_partscan.c b/src/loop_set_status_partscan.c
new file mode 100644
index 000000000000..8873a12e4334
--- /dev/null
+++ b/src/loop_set_status_partscan.c
@@ -0,0 +1,45 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <linux/loop.h>
+
+void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s PATH\n", progname);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int ret;
+	int fd;
+	struct loop_info64 info;
+
+	if (argc != 2)
+		usage(argv[0]);
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.lo_flags = LO_FLAGS_PARTSCAN;
+	memcpy(info.lo_file_name, "part", 5);
+
+	ret = ioctl(fd, LOOP_SET_STATUS64, &info);
+	if (ret == -1) {
+		perror("ioctl");
+		close(fd);
+		return EXIT_FAILURE;
+	}
+	close(fd);
+	return EXIT_SUCCESS;
+}
diff --git a/tests/loop/006 b/tests/loop/006
new file mode 100755
index 000000000000..e468d3a20210
--- /dev/null
+++ b/tests/loop/006
@@ -0,0 +1,33 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Jan Kara
+#
+# Regression test for patch "loop: Fix deadlock when calling
+# blkdev_reread_part()". We check whether setting partscan flag
+# and thus forcing partition reread won't trigger lockdep warning.
+#
+
+. tests/loop/rc
+
+DESCRIPTION="check for partition rereading deadlock"
+
+QUICK=1
+
+requires() {
+	_have_src_program loop_set_status_partscan
+}
+
+test() {
+	local loop_dev
+	echo "Running ${TEST_NAME}"
+
+	truncate -s 1M "$TMPDIR/file"
+	if ! loop_dev="$(losetup -f --show "$TMPDIR/file")"; then
+		return 1
+	fi
+
+	src/loop_set_status_partscan "$loop_dev"
+	losetup -d "$loop_dev"
+
+	echo "Test complete"
+}
diff --git a/tests/loop/006.out b/tests/loop/006.out
new file mode 100644
index 000000000000..50bf833f77b0
--- /dev/null
+++ b/tests/loop/006.out
@@ -0,0 +1,2 @@
+Running loop/006
+Test complete
-- 
2.16.4
