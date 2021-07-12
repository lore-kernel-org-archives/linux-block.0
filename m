Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBAFC07E96
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 03:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99986101C
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 03:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhGLDMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jul 2021 23:12:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6912 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhGLDMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jul 2021 23:12:47 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GNTDy4wVNz72FR;
        Mon, 12 Jul 2021 11:06:26 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 11:09:58 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 12
 Jul 2021 11:09:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] blk-mq: allow hardware queue to get more tag while sharing a tag set
Date:   Mon, 12 Jul 2021 11:18:18 +0800
Message-ID: <20210712031818.31918-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If there are multiple active queues while sharing a tag set, it's not
necessary to limit the available tags as same share for each active queue
if no one ever failed to get driver tag. And fall back to same share if
someone do failed to get driver tag.

This modification will be beneficial if total queue_depth of disks
on the same host is less than total tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  2 ++
 block/blk-mq-tag.c     | 43 +++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq-tag.h     | 27 ++++++++++++++++++++++++--
 block/blk-mq.c         | 13 ++++++++++---
 block/blk-mq.h         |  8 ++++++++
 include/linux/blk-mq.h |  4 ++++
 include/linux/blkdev.h |  1 +
 7 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b66d2776eda..35f1f01d93ae 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -450,6 +450,8 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
 		   atomic_read(&tags->active_queues));
+	seq_printf(m, "pending_queues=%d\n",
+		   atomic_read(&tags->pending_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 86f87346232a..618624b359d6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -40,6 +40,22 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	return true;
 }
 
+void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
+		struct request_queue *q = hctx->queue;
+		struct blk_mq_tag_set *set = q->tag_set;
+
+		if (!test_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags) &&
+		    !test_and_set_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags))
+			atomic_inc(&set->pending_queues_shared_sbitmap);
+	} else {
+		if (!test_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state) &&
+		    !test_and_set_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state))
+			atomic_inc(&hctx->tags->pending_queues);
+	}
+}
+
 /*
  * Wakeup all potentially sleeping on tags
  */
@@ -74,6 +90,24 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
+void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->tags;
+	struct request_queue *q = hctx->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
+		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_WAIT,
+					&q->queue_flags))
+			return;
+		atomic_dec(&set->pending_queues_shared_sbitmap);
+	} else {
+		if (!test_and_clear_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state))
+			return;
+		atomic_dec(&tags->pending_queues);
+	}
+}
+
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
@@ -112,8 +146,12 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (tag != BLK_MQ_NO_TAG)
 		goto found_tag;
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
+	if (data->flags & BLK_MQ_REQ_NOWAIT) {
+		if (!data->q->elevator)
+			blk_mq_dtag_busy(data->hctx);
+
 		return BLK_MQ_NO_TAG;
+	}
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -140,6 +178,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		if (!data->q->elevator)
+			blk_mq_dtag_busy(data->hctx);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 8ed55af08427..badcf3693749 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -10,6 +10,11 @@ struct blk_mq_tags {
 	unsigned int nr_reserved_tags;
 
 	atomic_t active_queues;
+	/*
+	 * if multiple queues share a tag set, pending_queues record the
+	 * number of queues that can't get driver tag.
+	 */
+	atomic_t pending_queues;
 
 	struct sbitmap_queue *bitmap_tags;
 	struct sbitmap_queue *breserved_tags;
@@ -69,8 +74,10 @@ enum {
 	BLK_MQ_TAG_MAX		= BLK_MQ_NO_TAG - 1,
 };
 
-extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
-extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
+extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx);
+extern void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx);
 
 static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
@@ -88,6 +95,22 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	__blk_mq_tag_idle(hctx);
 }
 
+static inline void blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+		return;
+
+	__blk_mq_dtag_busy(hctx);
+}
+
+static inline void blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+		return;
+
+	__blk_mq_dtag_idle(hctx);
+}
+
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 					  unsigned int tag)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..1bb52bd71da8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -991,8 +991,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
-			if (blk_mq_hw_queue_mapped(hctx))
+			if (blk_mq_hw_queue_mapped(hctx)) {
 				blk_mq_tag_idle(hctx);
+				blk_mq_dtag_idle(hctx);
+			}
 		}
 	}
 	blk_queue_exit(q);
@@ -1097,8 +1099,10 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	}
 
 	tag = __sbitmap_queue_get(bt);
-	if (tag == BLK_MQ_NO_TAG)
+	if (tag == BLK_MQ_NO_TAG) {
+		blk_mq_dtag_busy(rq->mq_hctx);
 		return false;
+	}
 
 	rq->tag = tag + tag_offset;
 	return true;
@@ -2676,8 +2680,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 {
 	struct request *flush_rq = hctx->fq->flush_rq;
 
-	if (blk_mq_hw_queue_mapped(hctx))
+	if (blk_mq_hw_queue_mapped(hctx)) {
 		blk_mq_tag_idle(hctx);
+		blk_mq_dtag_idle(hctx);
+	}
 
 	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
 			set->queue_depth, flush_rq);
@@ -3536,6 +3542,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 
 	if (blk_mq_is_sbitmap_shared(set->flags)) {
 		atomic_set(&set->active_queues_shared_sbitmap, 0);
+		atomic_set(&set->pending_queues_shared_sbitmap, 0);
 
 		if (blk_mq_init_shared_sbitmap(set)) {
 			ret = -ENOMEM;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d08779f77a26..9e646ade81a8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -337,10 +337,18 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return true;
+
+		if (!atomic_read(&set->pending_queues_shared_sbitmap))
+			return true;
+
 		users = atomic_read(&set->active_queues_shared_sbitmap);
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return true;
+
+		if (!atomic_read(&hctx->tags->pending_queues))
+			return true;
+
 		users = atomic_read(&hctx->tags->active_queues);
 	}
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1d18447ebebc..3bc0faf0e2cf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -256,6 +256,7 @@ struct blk_mq_tag_set {
 	unsigned int		flags;
 	void			*driver_data;
 	atomic_t		active_queues_shared_sbitmap;
+	atomic_t		pending_queues_shared_sbitmap;
 
 	struct sbitmap_queue	__bitmap_tags;
 	struct sbitmap_queue	__breserved_tags;
@@ -415,6 +416,9 @@ enum {
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE	= 3,
 
+	/* hw queue is waiting for driver tag */
+	BLK_MQ_S_DTAG_WAIT	= 1,
+
 	BLK_MQ_MAX_DEPTH	= 10240,
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3177181c4326..55e0965c9c3c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -603,6 +603,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_HCTX_WAIT	30	/* at least one blk-mq hctx can't get driver tag */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.31.1

