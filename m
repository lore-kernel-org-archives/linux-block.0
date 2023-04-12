Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAF1C77B75
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDLFdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDLFc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:32:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDBCFD
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F517CBI9TXNeWoNHPXaL1oC+Xlq3s0EWuP7PZJM4uqY=; b=U6FFkZcWf6QY8UQ35n3mowOBl8
        3b6O/Jg57AJ4TASl+favJAl/K85H/TI9YKaPCMoKKphGc168V6dlP2fehmIj+aEl1wOLPZq3/QSC4
        DSuC8736Fja2scpcavbmedAJ+7MBCN9it3EZHJwN7qqbLiTkbvF76Tyf4crPNrM98scmgkh//blmd
        KlOuvl4gEAcoIvSMSH/enyGClAu/6Hlb2jVnafUX+GEozLVEIdNdQarCIyHAklMCgOmVGklfmsLNK
        m9UHAINsaMnddTxPMr4+b2c5/T/KvzvBheLGziwKBmnDkD9hrvPyTnSOa4BiFO3PjZaFke4SOJE16
        Lcx9EtWg==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6G-001rET-2g;
        Wed, 12 Apr 2023 05:32:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 02/18] blk-mq: remove blk-mq-tag.h
Date:   Wed, 12 Apr 2023 07:32:32 +0200
Message-Id: <20230412053248.601961-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq-tag.h is always included by blk-mq.h, and causes recursive
inclusion hell with further changes.  Just merge it into blk-mq.h
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c    |  1 -
 block/blk-flush.c      |  1 -
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq-sched.c   |  1 -
 block/blk-mq-sched.h   |  1 -
 block/blk-mq-sysfs.c   |  1 -
 block/blk-mq-tag.c     |  1 -
 block/blk-mq-tag.h     | 73 ------------------------------------------
 block/blk-mq.c         |  1 -
 block/blk-mq.h         | 61 ++++++++++++++++++++++++++++++++++-
 block/blk-pm.c         |  1 -
 block/kyber-iosched.c  |  1 -
 block/mq-deadline.c    |  1 -
 13 files changed, 60 insertions(+), 85 deletions(-)
 delete mode 100644 block/blk-mq-tag.h

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d9ed3108c17af6..37f68c907ac08c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -129,7 +129,6 @@
 #include "elevator.h"
 #include "blk.h"
 #include "blk-mq.h"
-#include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
 #include "bfq-iosched.h"
 #include "blk-wbt.h"
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53202eff545efb..a13a1d6caa0f3e 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -73,7 +73,6 @@
 
 #include "blk.h"
 #include "blk-mq.h"
-#include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
 
 /* PREFLUSH/FUA sequences */
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 212a7f301e7302..ace2bcf1cf9a6f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -12,7 +12,6 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
-#include "blk-mq-tag.h"
 #include "blk-rq-qos.h"
 
 static int queue_poll_stat_show(void *data, struct seq_file *m)
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 06b312c691143f..1029e8eed5eef6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -15,7 +15,6 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
-#include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
 /*
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0250139724539a..65cab6e475be8e 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -4,7 +4,6 @@
 
 #include "elevator.h"
 #include "blk-mq.h"
-#include "blk-mq-tag.h"
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 1b2b0d258e465f..ba84caa868dd54 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -13,7 +13,6 @@
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
-#include "blk-mq-tag.h"
 
 static void blk_mq_sysfs_release(struct kobject *kobj)
 {
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9eb968e14d31f8..1f8b065d72c5f2 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -14,7 +14,6 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
-#include "blk-mq-tag.h"
 
 /*
  * Recalculate wakeup batch when tag is shared by hctx.
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
deleted file mode 100644
index 91ff37e3b43dff..00000000000000
--- a/block/blk-mq-tag.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef INT_BLK_MQ_TAG_H
-#define INT_BLK_MQ_TAG_H
-
-struct blk_mq_alloc_data;
-
-extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
-					unsigned int reserved_tags,
-					int node, int alloc_policy);
-extern void blk_mq_free_tags(struct blk_mq_tags *tags);
-extern int blk_mq_init_bitmaps(struct sbitmap_queue *bitmap_tags,
-			       struct sbitmap_queue *breserved_tags,
-			       unsigned int queue_depth,
-			       unsigned int reserved,
-			       int node, int alloc_policy);
-
-extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
-unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
-			      unsigned int *offset);
-extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
-			   unsigned int tag);
-void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
-extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
-					struct blk_mq_tags **tags,
-					unsigned int depth, bool can_grow);
-extern void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
-					     unsigned int size);
-extern void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
-
-extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
-		void *priv);
-void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
-		void *priv);
-
-static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
-						 struct blk_mq_hw_ctx *hctx)
-{
-	if (!hctx)
-		return &bt->ws[0];
-	return sbq_wait_ptr(bt, &hctx->wait_index);
-}
-
-enum {
-	BLK_MQ_NO_TAG		= -1U,
-	BLK_MQ_TAG_MIN		= 1,
-	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
-};
-
-extern void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
-extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
-
-static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
-{
-	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-		__blk_mq_tag_busy(hctx);
-}
-
-static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
-{
-	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return;
-
-	__blk_mq_tag_idle(hctx);
-}
-
-static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
-					  unsigned int tag)
-{
-	return tag < tags->nr_reserved_tags;
-}
-
-#endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7908d19f140815..545600be2063ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -37,7 +37,6 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
-#include "blk-mq-tag.h"
 #include "blk-pm.h"
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ef59fee62780d3..7a041fecea02e4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -3,7 +3,6 @@
 #define INT_BLK_MQ_H
 
 #include "blk-stat.h"
-#include "blk-mq-tag.h"
 
 struct blk_mq_tag_set;
 
@@ -30,6 +29,12 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+enum {
+	BLK_MQ_NO_TAG		= -1U,
+	BLK_MQ_TAG_MIN		= 1,
+	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
+};
+
 void blk_mq_submit_bio(struct bio *bio);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
@@ -164,6 +169,60 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
+struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
+		unsigned int reserved_tags, int node, int alloc_policy);
+void blk_mq_free_tags(struct blk_mq_tags *tags);
+int blk_mq_init_bitmaps(struct sbitmap_queue *bitmap_tags,
+		struct sbitmap_queue *breserved_tags, unsigned int queue_depth,
+		unsigned int reserved, int node, int alloc_policy);
+
+unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
+unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
+		unsigned int *offset);
+void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
+		unsigned int tag);
+void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags);
+int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
+		struct blk_mq_tags **tags, unsigned int depth, bool can_grow);
+void blk_mq_tag_resize_shared_tags(struct blk_mq_tag_set *set,
+		unsigned int size);
+void blk_mq_tag_update_sched_shared_tags(struct request_queue *q);
+
+void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
+		void *priv);
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv);
+
+static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
+						 struct blk_mq_hw_ctx *hctx)
+{
+	if (!hctx)
+		return &bt->ws[0];
+	return sbq_wait_ptr(bt, &hctx->wait_index);
+}
+
+void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
+void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
+
+static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_tag_busy(hctx);
+}
+
+static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_tag_idle(hctx);
+}
+
+static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
+					  unsigned int tag)
+{
+	return tag < tags->nr_reserved_tags;
+}
+
 static inline bool blk_mq_is_shared_tags(unsigned int flags)
 {
 	return flags & BLK_MQ_F_TAG_HCTX_SHARED;
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 2dad62cc157272..8af5ee54feb406 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -5,7 +5,6 @@
 #include <linux/blkdev.h>
 #include <linux/pm_runtime.h>
 #include "blk-mq.h"
-#include "blk-mq-tag.h"
 
 /**
  * blk_pm_runtime_init - Block layer runtime PM initialization routine
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 2146969237bfed..d0a4838ce7fc63 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -19,7 +19,6 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
-#include "blk-mq-tag.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kyber.h>
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f10c2a0d18d411..a18526e11194ca 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -23,7 +23,6 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
-#include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
 
 /*
-- 
2.39.2

