Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA75C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB35F6056C
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhIGORK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhIGORH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:17:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42200C061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F2abRsF5t0TCGHCBW9h+AnepX2rD6fAfHo3yvJZMFDo=; b=FWLQ5kj+Eb71ihpFk81eEWrH47
        u+eOvj8olYVafOnvEcuAbuLYXzO6RGckcRDGPrfAfkFsKq4QUvaFhwfSHAHotNp+OrCwLt//VBt3p
        LEDMXJPeea8shib1/iKh85E5p0lbo7rL3GRrEMya/AvrzvOrRcxblcRoIIomOkG+dzRxXzJX18giH
        QJBGN/o+CuSxuaX1lkzHTL4dt1Dgu0Yt8ttOA2wYcoYkOBvP3w5cXfa/oDDrVfBiq7yT/yo7IFsVe
        HWUxQLhBK0XhfODikmsjjiLHDBZbnmFSwTzRQjIc/dElK+gOE1PY7dnjqj+fweK7ThQwAKoqj8Zk0
        mo9viMFg==;
Received: from 089144201074.atnat0010.highway.a1.net ([89.144.201.74] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNbsB-007vvR-6n; Tue, 07 Sep 2021 14:15:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: move fs/block_dev.c to block/bdev.c
Date:   Tue,  7 Sep 2021 16:13:03 +0200
Message-Id: <20210907141303.1371844-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907141303.1371844-1-hch@lst.de>
References: <20210907141303.1371844-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move it together with the rest of the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/kernel-api.rst     | 3 +++
 Documentation/filesystems/api-summary.rst | 3 ---
 MAINTAINERS                               | 1 -
 block/Makefile                            | 2 +-
 fs/block_dev.c => block/bdev.c            | 4 ++--
 fs/Makefile                               | 2 +-
 fs/internal.h                             | 2 +-
 7 files changed, 8 insertions(+), 9 deletions(-)
 rename fs/block_dev.c => block/bdev.c (99%)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 2a7444e3a4c21..2e71868051480 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -315,6 +315,9 @@ Block Devices
 .. kernel-doc:: block/genhd.c
    :export:
 
+.. kernel-doc:: block/bdev.c
+   :export:
+
 Char devices
 ============
 
diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
index 7e5c04c986198..98db2ea5fa12c 100644
--- a/Documentation/filesystems/api-summary.rst
+++ b/Documentation/filesystems/api-summary.rst
@@ -71,9 +71,6 @@ Other Functions
 .. kernel-doc:: fs/fs-writeback.c
    :export:
 
-.. kernel-doc:: fs/block_dev.c
-   :export:
-
 .. kernel-doc:: fs/anon_inodes.c
    :export:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2f298429a5e92..46227e43e0b15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3300,7 +3300,6 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	block/
 F:	drivers/block/
-F:	fs/block_dev.c
 F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
diff --git a/block/Makefile b/block/Makefile
index a4d8d149670bf..c03b92d8a4bc5 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel block layer
 #
 
-obj-$(CONFIG_BLOCK) := fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
+obj-$(CONFIG_BLOCK) := bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
diff --git a/fs/block_dev.c b/block/bdev.c
similarity index 99%
rename from fs/block_dev.c
rename to block/bdev.c
index 84c97e2760474..cf2780cb44a74 100644
--- a/fs/block_dev.c
+++ b/block/bdev.c
@@ -26,8 +26,8 @@
 #include <linux/cleancache.h>
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
-#include "internal.h"
-#include "../block/blk.h"
+#include "../fs/internal.h"
+#include "blk.h"
 
 struct bdev_inode {
 	struct block_device bdev;
diff --git a/fs/Makefile b/fs/Makefile
index 354e2ba3ee67d..a1b89b1dc8fcd 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -17,7 +17,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		kernel_read_file.o remap_range.o
 
 ifeq ($(CONFIG_BLOCK),y)
-obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
+obj-y +=	buffer.o direct-io.o mpage.o
 else
 obj-y +=	no-block.o
 endif
diff --git a/fs/internal.h b/fs/internal.h
index 68a2ae029a27f..3cd065c8a66b4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -18,7 +18,7 @@ struct user_namespace;
 struct pipe_inode_info;
 
 /*
- * block_dev.c
+ * block/bdev.c
  */
 #ifdef CONFIG_BLOCK
 extern void __init bdev_cache_init(void);
-- 
2.30.2

