Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.143.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474898;
	b=gKWtec7xF1VawrYz/VBOZ+hF8wuvpg5qVP75TtN3RRYRrB42d/VmgltymCzPbngvf+vM
	 SNHwr4T+1WRiOBral9xpSCay2u/DadrywHfN44WtA3ktHSN3wvFakhpSTPNeflr9EyOZk
	 Ggf8266cde/WQEk5dF/+0ZjBdP19W7JRGODVVQ2FxtUOud4j/7E0jsSULsrj0pjL6DdW/
	 1+g9zQVIe4gNFySrZ7lOVogU+Ml3Y0ajAa59StXd2xHJt5f9potTKeJK/IByaRGARe711
	 CQt9ArJ/mFidupayv3HJo4JFA7sxfLfqrPzKi5xLSzFur1Hx27u9JXLqGskCfT87ZHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474898;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 IronPort-SDR:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 WDCIronportException:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TFfxpGWfdAbMC9dGcepZWf3nKjA1VGzF5ixEyGtDoks=;
	b=F2z0Bs7u5wHd8JX/8S5vCtrUqhhZB4USzXBf2WMsYJgGDFm3hwjWDg+pze6D5TGhaptZ
	 qNeyAVqUSU+Oq8iPMYBT2mp4MUvJEZBmDx5JG/GLQvGaOpBdgKNSppUa4ozwOEmLsKxun
	 Z0bETgWf0nsVK8MVTweinNw19yfsFZ/NFZhzAPoG3QS4r5mkOjwZqBUSRKUzwXyDnntZX
	 itQrbJ5WhA3mtwrT2EbQO8PTfaoO8AjRhWVKnqWBwBbZ4va27+nEPKjQSpG69/GXrcxWB
	 gBXd3YApCUiM9UmKUw1AwSE2N0n8Zt9WVjsVIALAvDwY1S8yDDpu5eE86xrs5NCuMZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.wdc.com;
	spf=pass smtp.mailfrom=opensource.wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SIu8IDbD;
	arc=none smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D257A606A319
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 05:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D257A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=SIu8IDbD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792474897; x=1824010897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dd6I6JA0J5bCSNDhzixjvTqgSuvQo4ow72ex4SRUO+g=;
  b=SIu8IDbDjOfBhhWS5cPCFHxBgo868XDFZLeucFWWuDdHUDRRvxA/rYuI
   Rb32AqKerNrNL5LHecFT0PezhCy6zwl9shWCBtCqKkYdiqFL2yDOG91V3
   sBsEJiGSSAFsh7NBUXsIXHzi7GrjEBqZBdSbVgEBmKzfq6NAMi4WRf+1u
   MJ3tyV7w2fcD5yez3TXtfB0kYpoM7/m2L4vX/QzMWMu2KfgPmUXL27Hul
   w2P5TCGJ7MvrTJgaYrwbrkgCtTWDHVsfmPir771889X0ZfDY4ycFNG27N
   AQEAfb0Zv0wr7T8NYgqfkSSiUMR/DAAj2+0I2dBRRtzmwWP3datJDRUpu
   Q==;
X-CSE-ConnectionGUID: loCOubBlQper8UVodNwY/g==
X-CSE-MsgGUID: ck0PbxduSpqtZb59myRq8w==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="159470154"
Received: from h199-255-45-14.hgst.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2026 13:41:37 +0800
X-CSE-ConnectionGUID: x9R1Hu26Sqa0nHyclHTqLw==
X-CSE-MsgGUID: hqslDnOtSXmCfFKGvKFzlw==
IronPort-SDR: 6ad6ff11_zDvsKPhj2xMQW4gkfevtrUIvtSIvwAyX8mAqeJBHHXLR1Qn
 mAtWjpWmYZR3G5XnbAO6l5brcKeBSSojmspklTQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2026 22:41:37 -0700
X-CSE-ConnectionGUID: zs6H9uFZRhaNHEtVajE+Zg==
X-CSE-MsgGUID: QAAxqQzZSG2RHcRoqZ/ZHw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 19 Oct 2026 22:41:37 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To: linux-block@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] loop: remove loop/006 which tests swapping loop fds
Date: Tue, 20 Oct 2026 14:41:35 +0900
Message-ID: <20261020054135.2766271-1-shinichiro.kawasaki@opensource.wdc.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

The loop driver is going to drop the support of swapping loop fds. The
commit titled "loop: remove support for swapping loop fds" is going to
be applied to kernel version v7.4-rc1, and LOOP_CHANGE_FD ioctl is going
to be removed.

The test case loop/006 checks the behavior of the swapping loop fds.
Failure of the test case is expected after the kernel commit. The test
case no longer has value. Hence remove it.

Link: https://lore.kernel.org/linux-block/as8-8rDJmUb1FxbP@shinmob/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 src/.gitignore       |  1 -
 src/Makefile         |  1 -
 src/loop_change_fd.c | 48 ---------------------------
 tests/loop/006       | 78 --------------------------------------------
 tests/loop/006.out   |  2 --
 5 files changed, 130 deletions(-)
 delete mode 100644 src/loop_change_fd.c
 delete mode 100755 tests/loop/006
 delete mode 100644 tests/loop/006.out

diff --git a/src/.gitignore b/src/.gitignore
index f9a3916..54413a7 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -3,7 +3,6 @@
 /dio-offsets
 /discontiguous-io
 /loblksize
-/loop_change_fd
 /loop_get_status_null
 /metadata
 /metadata-iopoll
diff --git a/src/Makefile b/src/Makefile
index 1e571c6..07a5791 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,7 +18,6 @@ C_TARGETS := \
 	bio-full-trim \
 	dio-offsets \
 	loblksize \
-	loop_change_fd \
 	loop_get_status_null \
 	mmap-loss \
 	mount_clear_sock \
diff --git a/src/loop_change_fd.c b/src/loop_change_fd.c
deleted file mode 100644
index b124d82..0000000
--- a/src/loop_change_fd.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/ioctl.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <linux/loop.h>
-
-void usage(const char *progname)
-{
-	fprintf(stderr, "usage: %s LOOPDEV PATH\n", progname);
-	exit(EXIT_FAILURE);
-}
-
-int main(int argc, char **argv)
-{
-	int ret;
-	int fd, filefd;
-
-	if (argc != 3)
-		usage(argv[0]);
-
-	fd = open(argv[1], O_RDWR);
-	if (fd == -1) {
-		perror("open");
-		return EXIT_FAILURE;
-	}
-
-	filefd = open(argv[2], O_RDWR);
-	if (filefd == -1) {
-		perror("open");
-		return EXIT_FAILURE;
-	}
-
-	ret = ioctl(fd, LOOP_CHANGE_FD, filefd);
-	if (ret == -1) {
-		perror("ioctl");
-		close(fd);
-		close(filefd);
-		return EXIT_FAILURE;
-	}
-	close(fd);
-	close(filefd);
-	return EXIT_SUCCESS;
-}
diff --git a/tests/loop/006 b/tests/loop/006
deleted file mode 100755
index 701d44c..0000000
--- a/tests/loop/006
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-3.0+
-# Copyright (C) 2018 Jan Kara
-#
-# Regression test for patch "block/loop: Use global lock for ioctl() operation."
-# We swap file (through LOOP_CHANGE_FD) under one loopback device while
-# creating and deleting another loopback device pointing to the first one.
-# This checks for races in validation of backing fd.
-
-. tests/loop/rc
-
-DESCRIPTION="change loop backing file while creating/removing another loop device"
-# Try for some time to trigger the race
-TIMED=1
-
-requires() {
-	_have_src_program loop_change_fd
-}
-
-# Setup and tear down loop device pointing to loop_dev
-run_setter() {
-	loop_dev="$1"
-
-	while top_dev=$(losetup -f --show "$loop_dev"); do
-		losetup -d "$top_dev"
-	done
-}
-
-# Switch backing file of loop_dev continuously
-run_switcher() {
-	loop_dev="$1"
-
-	i=1
-	while src/loop_change_fd "$loop_dev" "$TMPDIR/file$i"; do
-		i=$(((i+1)%2))
-	done
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	truncate -s 1M "$TMPDIR/file0"
-	truncate -s 1M "$TMPDIR/file1"
-
-	if ! loop_dev="$(losetup -r -f --show "$TMPDIR/file0")"; then
-		return 1
-	fi
-
-	run_switcher "$loop_dev" &
-	switch_pid=$!
-	run_setter "$loop_dev" &
-	set_pid=$!
-
-	sleep "${TIMEOUT:-30}"
-
-	# Discard KILLED messages from bash...
-	{
-		kill -9 $switch_pid
-		wait $switch_pid
-		kill -9 $set_pid
-		wait $set_pid
-		sleep 1
-	} 2>/dev/null
-
-	# Clean up devices
-	top_dev=$(losetup -j "$loop_dev" | sed -e 's/\([^:]*\): .*/\1/')
-	if [[ -n "$top_dev" ]]; then
-		losetup -d "$top_dev"
-	fi
-	losetup -d "$loop_dev"
-
-	# Let udev catch up on the attach/detach/change-fd before
-	# handing control back, so it doesn't leave a backlog for
-	# whatever test runs next.
-	udevadm settle
-
-	echo "Test complete"
-}
diff --git a/tests/loop/006.out b/tests/loop/006.out
deleted file mode 100644
index 50bf833..0000000
--- a/tests/loop/006.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Running loop/006
-Test complete
-- 
2.54.0

