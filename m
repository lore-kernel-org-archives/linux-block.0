Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727516AbeJRScT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Oct 2018 14:32:19 -0400
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] loop/007: Add test for oops during backing file verification
Date: Thu, 18 Oct 2018 12:31:47 +0200
Message-Id: <20181018103147.3567-3-jack@suse.cz>
In-Reply-To: <20181018103147.3567-1-jack@suse.cz>
References: <20181018103147.3567-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add regression test for patch "block/loop: Use global lock for ioctl()
operation." where we can oops while traversing list of loop devices
backing newly created device.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/Makefile         |  3 ++-
 src/loop_change_fd.c | 48 +++++++++++++++++++++++++++++++++
 tests/loop/007       | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/loop/007.out   |  2 ++
 4 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 src/loop_change_fd.c
 create mode 100755 tests/loop/007
 create mode 100644 tests/loop/007.out

diff --git a/src/Makefile b/src/Makefile
index 6dadcbec8beb..acd169718b7d 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -5,7 +5,8 @@ C_TARGETS := \
 	sg/dxfer-from-dev \
 	sg/syzkaller1 \
 	nbdsetsize \
-	loop_set_status_partscan
+	loop_set_status_partscan \
+	loop_change_fd
 
 CXX_TARGETS := \
 	discontiguous-io
diff --git a/src/loop_change_fd.c b/src/loop_change_fd.c
new file mode 100644
index 000000000000..b124d829f380
--- /dev/null
+++ b/src/loop_change_fd.c
@@ -0,0 +1,48 @@
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
+	fprintf(stderr, "usage: %s LOOPDEV PATH\n", progname);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int ret;
+	int fd, filefd;
+
+	if (argc != 3)
+		usage(argv[0]);
+
+	fd = open(argv[1], O_RDWR);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	filefd = open(argv[2], O_RDWR);
+	if (filefd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	ret = ioctl(fd, LOOP_CHANGE_FD, filefd);
+	if (ret == -1) {
+		perror("ioctl");
+		close(fd);
+		close(filefd);
+		return EXIT_FAILURE;
+	}
+	close(fd);
+	close(filefd);
+	return EXIT_SUCCESS;
+}
diff --git a/tests/loop/007 b/tests/loop/007
new file mode 100755
index 000000000000..98e4edbe7afa
--- /dev/null
+++ b/tests/loop/007
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Jan Kara
+#
+# Regression test for patch "block/loop: Use global lock for ioctl() operation."
+# We swap file (through LOOP_CHANGE_FD) under one loopback device while
+# creating and deleting another loopback device pointing to the first one.
+# This checks for races in validation of backing fd.
+
+. tests/loop/rc
+
+DESCRIPTION="check for crash when validating new loop file"
+
+# Try for some time to trigger the race
+TIMED=1
+
+requires() {
+	_have_src_program loop_change_fd
+}
+
+# Setup and tear down loop device pointing to loop_dev
+run_setter() {
+	loop_dev="$1"
+
+	while top_dev=$(losetup -f --show "$loop_dev"); do
+		losetup -d "$top_dev"
+	done
+}
+
+# Switch backing file of loop_dev continuously
+run_switcher() {
+	loop_dev="$1"
+
+	i=1
+	while src/loop_change_fd "$loop_dev" "$TMPDIR/file$i"; do
+		i=$(((i+1)%2))
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	timeout=${TIMEOUT:-30}
+
+	truncate -s 1M "$TMPDIR/file0"
+	truncate -s 1M "$TMPDIR/file1"
+
+	if ! loop_dev="$(losetup -r -f --show "$TMPDIR/file0")"; then
+		return 1
+	fi
+
+	run_switcher "$loop_dev" &
+	switch_pid=$!
+	run_setter "$loop_dev" &
+	set_pid=$!
+
+	sleep $timeout
+
+	# Discard KILLED messages from bash...
+	{
+		kill -9 $switch_pid
+		kill -9 $set_pid
+		wait
+		sleep 1
+	} 2>/dev/null
+
+	# Clean up devices
+	top_dev=$(losetup -j "$loop_dev" | sed -e 's/\([^:]*\): .*/\1/')
+	if [[ -n "$top_dev" ]]; then
+		losetup -d "$top_dev"
+	fi
+	losetup -d "$loop_dev"
+
+	echo "Test complete"
+}
diff --git a/tests/loop/007.out b/tests/loop/007.out
new file mode 100644
index 000000000000..32752934d48a
--- /dev/null
+++ b/tests/loop/007.out
@@ -0,0 +1,2 @@
+Running loop/007
+Test complete
-- 
2.16.4
