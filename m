Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C12C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DE720989
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SeN5Mrtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1NP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:15:28 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60364 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfA1NP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548681327; x=1580217327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abHhg2wcbdF25eLMhxDmHJ2SklmyEaucqIIwjuf8MIk=;
  b=SeN5Mrtj7/sUeX5bgni6ijoSZ7PB1Tqjxl1rBuF0/obk69DsEqApeONn
   LuvWzZeF8KcSqsvW3TsxBuriFukmqiIV8MA9MMK41SecN2W4fJSYKleX/
   Z76mHWHgHCsFyk/E9JFdfeXa7ywnPPHOcakq7CskZTxtt3I6S6qIF5osY
   YgWxFB+OR4eytrLXP9/byo/Ot6+mbFPMlImh/lo1gE4DO8xbbki/lHTBw
   hm/qK5l14KUlR4xbaq1/4xXWVPgfmaaQuIxYfZD27T1BmNRCogpPcp5Hi
   79/LviCUGtoBF8cP/0oXZF9135z8/rr7bUDBR99LkhFCvT0Kix6HPXNCZ
   w==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="204977732"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 21:15:27 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Jan 2019 04:56:28 -0800
Received: from shin_dev.dhcp.fujisawa.hgst.com (HELO shin_dev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2019 05:15:24 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v4 06/12] src: Introduce zbdioctl program
Date:   Mon, 28 Jan 2019 22:14:49 +0900
Message-Id: <20190128131455.31997-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
References: <20190128131455.31997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zbdioctl implements calls to zoned block devices ioctls that are not
supported currently by sys-utils blkzone utility, namely BLKGETZONESZ
and BLKGETNRZONES.

Reviewed-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 src/.gitignore |  1 +
 src/Makefile   |  3 +-
 src/zbdioctl.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 src/zbdioctl.c

diff --git a/src/.gitignore b/src/.gitignore
index 8c95785..2108f56 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -6,3 +6,4 @@
 /nbdsetsize
 /sg/dxfer-from-dev
 /sg/syzkaller1
+/zbdioctl
diff --git a/src/Makefile b/src/Makefile
index c4094b4..5a0556f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -5,7 +5,8 @@ C_TARGETS := \
 	sg/dxfer-from-dev \
 	sg/syzkaller1 \
 	nbdsetsize \
-	loop_change_fd
+	loop_change_fd \
+	zbdioctl
 
 CXX_TARGETS := \
 	discontiguous-io
diff --git a/src/zbdioctl.c b/src/zbdioctl.c
new file mode 100644
index 0000000..1ea72e8
--- /dev/null
+++ b/src/zbdioctl.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2018 Western Digital Corporation or its affiliates.
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/blkzoned.h>
+#include <linux/types.h>
+
+#if !defined(BLKGETZONESZ) || !defined(BLKGETNRZONES)
+
+int main(int argc, char **argv)
+{
+	return EXIT_FAILURE;
+}
+
+#else
+
+struct request {
+	const char *name;
+	unsigned long code;
+} requests[] = {
+	{ "-s", BLKGETZONESZ},
+	{ "-n", BLKGETNRZONES},
+	{ NULL, 0},
+};
+
+void usage(const char *progname)
+{
+	int i = 0;
+
+	fprintf(stderr, "usage: %s <request> <device file>\n", progname);
+	fprintf(stderr, "<request> can be:\n");
+	while (requests[i].name) {
+		fprintf(stderr, "\t%s\n", requests[i].name);
+		i++;
+	}
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	int i = 0, fd, ret;
+	unsigned int val;
+	unsigned long code = 0;
+
+	if (argc != 3)
+		usage(argv[0]);
+
+	while (requests[i].name) {
+		if (strcmp(argv[1], requests[i].name) == 0) {
+			code = requests[i].code;
+			break;
+		}
+		i++;
+	}
+	if (code == 0)
+		usage(argv[0]);
+
+	fd = open(argv[2], O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	ret = ioctl(fd, code, &val);
+	if (ret < 0) {
+		perror("ioctl");
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
+	printf("%u\n", val);
+
+	close(fd);
+
+	return EXIT_SUCCESS;
+}
+
+#endif
+
-- 
2.20.1

