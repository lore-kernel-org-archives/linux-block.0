Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854D2C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDMGmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDMGmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:42:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B693EB
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ak7zZWSpHRGXJJKqCfFj6tZq2quid1vAh2h+7sjDj+o=; b=z+n6IiofTvzcY9Ms/UJ0VK3bxI
        rDWsgeevU3lULI4GQONbm17KIe+QueEilPc10+HK8LwHwfoHyOz5RjFOdm/Vydd3otoqoFrGFqGqo
        8OS+lwjwvq2PmOetlWvZqNWbavT0x9iAgMyiKi/3vlW0GrU/8kEpZiSBWTISEMHwuqRJ3po96w1f8
        BGkjCUgjNhM20jYomThC8xaFNNZ04l3j7sPtLLt9D88m0k/AKHxgAUkThGcxXxgDZV2NnupCEmLC6
        71DBbTMj2hMWDUQhMJhaHVZWWAmlJjNSRT6YKAv2/mgFpgg5K04Qvk4i/CLEiPRHGlQnM9NW7xjkj
        HM5bKiQQ==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmqeS-005BYc-1G;
        Thu, 13 Apr 2023 06:41:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 19/20] blk-mq: pass a flags argument to elevator_type->insert_requests
Date:   Thu, 13 Apr 2023 08:40:56 +0200
Message-Id: <20230413064057.707578-20-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413064057.707578-1-hch@lst.de>
References: <20230413064057.707578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of passing a bool at_head, pass down the full flags from the
blk_mq_insert_request interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/bfq-iosched.c   | 16 ++++++++--------
 block/blk-mq.c        |  5 ++---
 block/elevator.h      |  4 +++-
 block/kyber-iosched.c |  5 +++--
 block/mq-deadline.c   |  9 +++++----
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 37f68c907ac08c..b4c4b4808c6c4c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6231,7 +6231,7 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 static struct bfq_queue *bfq_init_rq(struct request *rq);
 
 static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			       bool at_head)
+			       blk_insert_t flags)
 {
 	struct request_queue *q = hctx->queue;
 	struct bfq_data *bfqd = q->elevator->elevator_data;
@@ -6254,11 +6254,10 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (!bfqq || at_head) {
-		if (at_head)
-			list_add(&rq->queuelist, &bfqd->dispatch);
-		else
-			list_add_tail(&rq->queuelist, &bfqd->dispatch);
+	if (flags & BLK_MQ_INSERT_AT_HEAD) {
+		list_add(&rq->queuelist, &bfqd->dispatch);
+	} else if (!bfqq) {
+		list_add_tail(&rq->queuelist, &bfqd->dispatch);
 	} else {
 		idle_timer_disabled = __bfq_insert_request(bfqd, rq);
 		/*
@@ -6288,14 +6287,15 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 }
 
 static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
-				struct list_head *list, bool at_head)
+				struct list_head *list,
+				blk_insert_t flags)
 {
 	while (!list_empty(list)) {
 		struct request *rq;
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		bfq_insert_request(hctx, rq, at_head);
+		bfq_insert_request(hctx, rq, flags);
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ff74559d7da1fc..6c3db1a15dadc9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2556,8 +2556,7 @@ static void blk_mq_insert_request(struct request *rq, blk_insert_t flags)
 		WARN_ON_ONCE(rq->tag != BLK_MQ_NO_TAG);
 
 		list_add(&rq->queuelist, &list);
-		q->elevator->type->ops.insert_requests(hctx, &list,
-				flags & BLK_MQ_INSERT_AT_HEAD);
+		q->elevator->type->ops.insert_requests(hctx, &list, flags);
 	} else {
 		trace_block_rq_insert(rq);
 
@@ -2768,7 +2767,7 @@ static void blk_mq_dispatch_plug_list(struct blk_plug *plug, bool from_sched)
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
 	if (this_hctx->queue->elevator) {
 		this_hctx->queue->elevator->type->ops.insert_requests(this_hctx,
-				&list, false);
+				&list, 0);
 		blk_mq_run_hw_queue(this_hctx, from_sched);
 	} else {
 		blk_mq_insert_requests(this_hctx, this_ctx, &list, from_sched);
diff --git a/block/elevator.h b/block/elevator.h
index 774a8f6b99e69e..7ca3d7b6ed8289 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -4,6 +4,7 @@
 
 #include <linux/percpu.h>
 #include <linux/hashtable.h>
+#include "blk-mq.h"
 
 struct io_cq;
 struct elevator_type;
@@ -37,7 +38,8 @@ struct elevator_mq_ops {
 	void (*limit_depth)(blk_opf_t, struct blk_mq_alloc_data *);
 	void (*prepare_request)(struct request *);
 	void (*finish_request)(struct request *);
-	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
+	void (*insert_requests)(struct blk_mq_hw_ctx *hctx, struct list_head *list,
+			blk_insert_t flags);
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 3f9fb2090c9158..4155594aefc657 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -588,7 +588,8 @@ static void kyber_prepare_request(struct request *rq)
 }
 
 static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
-				  struct list_head *rq_list, bool at_head)
+				  struct list_head *rq_list,
+				  blk_insert_t flags)
 {
 	struct kyber_hctx_data *khd = hctx->sched_data;
 	struct request *rq, *next;
@@ -600,7 +601,7 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		spin_lock(&kcq->lock);
 		trace_block_rq_insert(rq);
-		if (at_head)
+		if (flags & BLK_MQ_INSERT_AT_HEAD)
 			list_move(&rq->queuelist, head);
 		else
 			list_move_tail(&rq->queuelist, head);
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index ceae477c3571a3..5839a027e0f051 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -766,7 +766,7 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
  * add rq to rbtree and fifo
  */
 static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			      bool at_head)
+			      blk_insert_t flags)
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
@@ -799,7 +799,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head) {
+	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
@@ -823,7 +823,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  * Called from blk_mq_insert_request() or blk_mq_dispatch_plug_list().
  */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
-			       struct list_head *list, bool at_head)
+			       struct list_head *list,
+			       blk_insert_t flags)
 {
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
@@ -834,7 +835,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, at_head);
+		dd_insert_request(hctx, rq, flags);
 	}
 	spin_unlock(&dd->lock);
 }
-- 
2.39.2

