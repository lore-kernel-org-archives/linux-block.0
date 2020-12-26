Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5AC433E6
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F0C221EA
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgLZK03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Dec 2020 05:26:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10367 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLZK00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Dec 2020 05:26:26 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D30LC6qGDz7L6g;
        Sat, 26 Dec 2020 18:24:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Sat, 26 Dec 2020
 18:25:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while sharing a tag set
Date:   Sat, 26 Dec 2020 18:28:06 +0800
Message-ID: <20201226102808.2534966-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201226102808.2534966-1-yukuai3@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When sharing a tag set, if most disks are issuing small amount of IO, and
only a few is issuing a large amount of IO. Current approach is to limit
the max amount of tags a disk can get equally to the average of total
tags. Thus the few heavy load disk can't get enough tags while many tags
are still free in the tag set.

We add 'pending_queues' in blk_mq_tag_set to count how many queues can't
get driver tag. Thus if this value is zero, there is no need to limit
the max number of available tags.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  2 ++
 block/blk-mq-tag.c     | 38 +++++++++++++++++++++++++++++++++++++-
 block/blk-mq-tag.h     | 23 +++++++++++++++++++++++
 block/blk-mq.c         |  8 ++++++--
 block/blk-mq.h         |  9 ++++++---
 include/linux/blk-mq.h |  4 ++++
 include/linux/blkdev.h |  1 +
 7 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9336a6f8d6ef..fed193b10406 100644
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
index 9c92053e704d..6dcd6dd9123a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -39,6 +39,22 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
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
@@ -73,6 +89,19 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
+void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->tags;
+	struct request_queue *q = hctx->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	if (blk_mq_is_sbitmap_shared(hctx->flags) &&
+	    test_and_clear_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags))
+		atomic_dec(&set->pending_queues_shared_sbitmap);
+	else if (test_and_clear_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state))
+		atomic_dec(&tags->pending_queues);
+}
+
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
@@ -111,8 +140,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (tag != BLK_MQ_NO_TAG)
 		goto found_tag;
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
+	if (data->flags & BLK_MQ_REQ_NOWAIT) {
+		if (!data->q->elevator)
+			blk_mq_dtag_busy(data->hctx);
 		return BLK_MQ_NO_TAG;
+	}
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -139,6 +171,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		if (!data->q->elevator)
+			blk_mq_dtag_busy(data->hctx);
+
 		bt_prev = bt;
 		io_schedule();
 
@@ -459,6 +494,7 @@ static int blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
 
 	tags->bitmap_tags = &tags->__bitmap_tags;
 	tags->breserved_tags = &tags->__breserved_tags;
+	atomic_set(&tags->pending_queues, 0);
 
 	return 0;
 free_bitmap_tags:
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..52d08a92f683 100644
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
@@ -62,6 +67,8 @@ enum {
 
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
+extern void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *);
+extern void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *);
 
 static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
@@ -79,6 +86,22 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
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
index f285a9123a8b..2b8fa49bccb4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1013,8 +1013,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
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
@@ -2564,8 +2566,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
-	if (blk_mq_hw_queue_mapped(hctx))
+	if (blk_mq_hw_queue_mapped(hctx)) {
 		blk_mq_tag_idle(hctx);
+		blk_mq_dtag_idle(hctx);
+	}
 
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index c1458d9502f1..f7212bacfa56 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -114,7 +114,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 		type = HCTX_TYPE_POLL;
 	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
-	
+
 	return ctx->hctxs[type];
 }
 
@@ -212,8 +212,8 @@ static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 {
 	if (blk_mq_is_sbitmap_shared(hctx->flags))
 		atomic_dec(&hctx->queue->nr_active_requests_shared_sbitmap);
-	else
-		atomic_dec(&hctx->nr_active);
+	else if (!atomic_dec_return(&hctx->nr_active))
+		blk_mq_dtag_idle(hctx);
 }
 
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
@@ -300,6 +300,9 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	if (bt->sb.depth == 1)
 		return true;
 
+	if (!atomic_read(&hctx->tags->pending_queues))
+		return true;
+
 	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 		struct blk_mq_tag_set *set = q->tag_set;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d705b174d346..2a473865ee7f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -260,6 +260,7 @@ struct blk_mq_tag_set {
 	unsigned int		flags;
 	void			*driver_data;
 	atomic_t		active_queues_shared_sbitmap;
+	atomic_t		pending_queues_shared_sbitmap;
 
 	struct sbitmap_queue	__bitmap_tags;
 	struct sbitmap_queue	__breserved_tags;
@@ -410,6 +411,9 @@ enum {
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE	= 3,
 
+	/* hw queue is waiting for driver tag */
+	BLK_MQ_S_DTAG_WAIT	= 4,
+
 	BLK_MQ_MAX_DEPTH	= 10240,
 
 	BLK_MQ_CPU_WORK_BATCH	= 8,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..445249e00b9d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -621,6 +621,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_HCTX_WAIT	30	/* at least one blk-mq hctx can't get driver tag */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
-- 
2.25.4

