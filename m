Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36391 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdA0U6t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 15:58:49 -0500
Received: by mail-pf0-f182.google.com with SMTP id 189so75808290pfu.3
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 12:58:48 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2] blk-mq: fix debugfs compilation issues
Date: Fri, 27 Jan 2017 12:49:06 -0800
Message-Id: <8ff253c312f1af002b99065b0a1e355af2d3ee9a.1485550075.git.osandov@fb.com>
In-Reply-To: <9980eb1d180dc482953b8e473f607bec7411e2b1.1485548245.git.osandov@fb.com>
References: <9980eb1d180dc482953b8e473f607bec7411e2b1.1485548245.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This fixes a couple of problems:

1. In the !CONFIG_DEBUG_FS case, the stub definitions were bogus.
2. In the !CONFIG_BLOCK case, blk-mq-debugfs.c shouldn't be compiled at
   all.

Fix the stub definitions and add a CONFIG_BLK_DEBUG_FS Kconfig option.

Fixes: 07e4fead45e6 ("blk-mq: create debugfs directory tree")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/Kconfig  |  9 +++++++++
 block/Makefile |  2 +-
 block/blk-mq.h | 11 ++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 8bf114a3858a..0a31ed745258 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -147,6 +147,15 @@ config BLK_WBT_MQ
 	Multiqueue currently doesn't have support for IO scheduling,
 	enabling this option is recommended.
 
+config BLK_DEBUG_FS
+	bool "Block layer debugging information in debugfs"
+	default y
+	depends on DEBUG_FS
+	---help---
+	Include block layer debugging information in debugfs. This information
+	is only useful for kernel developers, but it doesn't incur any cost at
+	runtime.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index 6cabe6bd2882..317165f8708c 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -26,4 +26,4 @@ obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
-obj-$(CONFIG_DEBUG_FS)		+= blk-mq-debugfs.o
+obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 57cdbf6c0cee..b52abd62b1b0 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -84,7 +84,7 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 /*
  * debugfs helpers
  */
-#ifdef CONFIG_DEBUG_FS
+#ifdef CONFIG_BLK_DEBUG_FS
 void blk_mq_debugfs_init(void);
 int blk_mq_debugfs_register(struct request_queue *q, const char *name);
 void blk_mq_debugfs_unregister(struct request_queue *q);
@@ -95,21 +95,22 @@ static inline void blk_mq_debugfs_init(void)
 {
 }
 
-int blk_mq_debugfs_register(struct request_queue *q, const char *name);
+static inline int blk_mq_debugfs_register(struct request_queue *q,
+					  const char *name)
 {
 	return 0;
 }
 
-void blk_mq_debugfs_unregister(struct request_queue *q)
+static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
-int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	return 0;
 }
 
-void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
+static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 #endif
-- 
2.11.0

