Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdGNXSS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 19:18:18 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/6] blk-mq: introduce auto restart
Date: Sat, 15 Jul 2017 07:15:59 +0800
Message-Id: <20170714231601.14444-5-ming.lei@redhat.com>
In-Reply-To: <20170714231601.14444-1-ming.lei@redhat.com>
References: <20170714231601.14444-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Both xen-blkfront and virito-blk stops queue when
the queue becomes busy, and restarts the queue after
one request is completed.

This patch implements this function in blk-mq core
by introducing BLK_MQ_F_AUTO_RESTART, then we can
remove stop/start queue related APIs and make 'stopped'
state invisible to drivers. It has caused lots of trouble
to expose this state to driver and let driver control
the state.

Given we can't get exact queue depth for one request queue
in case of TAG_SHARED, we only support this function on
non-TAG_SHARED devices/drivers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 041f7b7fa0d6..f3b582eb492f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -416,6 +416,39 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+static void blk_mq_handle_auto_stop(struct blk_mq_hw_ctx *hctx)
+{
+	struct sbitmap_queue *sbq;
+
+	if (!(hctx->flags & BLK_MQ_F_AUTO_RESTART))
+		return;
+
+	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	sbq = &hctx->tags->bitmap_tags;
+
+	/* order setting 'stopped' and reading queue depth */
+	smp_mb();
+
+	/*
+	 * all requests may be completed just before setting
+	 * 'stopped', so we have to check queue depth to see
+	 * if there is pending requests
+	 */
+	if (unlikely(!sbitmap_weight(&sbq->sb)))
+		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+}
+
+static void blk_mq_handle_auto_restart(struct blk_mq_hw_ctx *hctx)
+{
+	if (!(hctx->flags & BLK_MQ_F_AUTO_RESTART))
+		return;
+	/*
+	 * blk_mq_put_tag() implies one barrier, which is the pair of
+	 * smp_mb() in blk_mq_handle_auto_stop()
+	 */
+	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+}
+
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -446,6 +479,7 @@ void blk_mq_free_request(struct request *rq)
 	if (sched_tag != -1)
 		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
+	blk_mq_handle_auto_restart(hctx);
 	blk_queue_exit(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
@@ -1066,6 +1100,8 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
 
+		blk_mq_handle_auto_stop(hctx);
+
 		/*
 		 * If SCHED_RESTART was set by the caller of this function and
 		 * it is no longer set that means that it was cleared by another
@@ -1502,6 +1538,7 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		return;
 	case BLK_STS_RESOURCE:
 		__blk_mq_requeue_request(rq);
+		blk_mq_handle_auto_stop(hctx);
 		goto insert;
 	default:
 		*cookie = BLK_QC_T_NONE;
@@ -2112,16 +2149,20 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (shared) {
 			if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 				atomic_inc(&q->shared_hctx_restart);
 			hctx->flags |= BLK_MQ_F_TAG_SHARED;
+			hctx->flags &= ~BLK_MQ_F_AUTO_RESTART;
 		} else {
 			if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 				atomic_dec(&q->shared_hctx_restart);
 			hctx->flags &= ~BLK_MQ_F_TAG_SHARED;
+			if (set->flags & BLK_MQ_F_AUTO_RESTART)
+				hctx->flags |= BLK_MQ_F_AUTO_RESTART;
 		}
 	}
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 14542308d25b..251af99e9ba8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -162,6 +162,7 @@ enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
+	BLK_MQ_F_AUTO_RESTART	= 1 << 3,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.9.4
