Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFEQCO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 12:02:14 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 07/11] blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue
Date: Mon,  5 Jun 2017 23:59:21 +0800
Message-Id: <20170605155925.7896-8-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-1-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It is required that no dispatch can happen any more once
blk_mq_quiesce_queue() returns, and we don't have such requirement
on APIs of stopping queue.

But blk_mq_quiesce_queue() still may not block/drain dispatch in the
the case of BLK_MQ_S_START_ON_RUN, so use the new introduced flag of
QUEUE_FLAG_QUIESCED and evaluate it inside RCU read-side critical
sections for fixing this issue.

Also blk_mq_quiesce_queue() is implemented via stopping queue, which
limits its uses, and easy to cause race, because any queue restart in
other paths may break blk_mq_quiesce_queue(). With the introduced
flag of QUEUE_FLAG_QUIESCED, we don't need to depend on stopping queue
for quiescing any more.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c   |  3 ++-
 block/blk-mq.c         | 11 ++++++++++-
 include/linux/blk-mq.h |  4 ++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c4e2afb9d12d..ec9885df324c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -141,7 +141,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	bool did_work = false;
 	LIST_HEAD(rq_list);
 
-	if (unlikely(blk_mq_hctx_stopped(hctx)))
+	/* RCU or SRCU read lock is needed before checking quiesced flag */
+	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
 		return;
 
 	hctx->run++;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 068962789dc4..be0b76408a73 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -170,6 +170,10 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 
 	__blk_mq_stop_hw_queues(q, true);
 
+	spin_lock_irq(q->queue_lock);
+	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irq(q->queue_lock);
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
 			synchronize_srcu(&hctx->queue_rq_srcu);
@@ -190,6 +194,10 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
+	spin_lock_irq(q->queue_lock);
+	queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irq(q->queue_lock);
+
 	blk_mq_start_stopped_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
@@ -1426,7 +1434,8 @@ static void __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	int ret;
 	bool run_queue = true;
 
-	if (blk_mq_hctx_stopped(hctx)) {
+	/* RCU or SRCU read lock is needed before checking quiesced flag */
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
 		goto insert;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fc0fc45fc658..dc96ce3f5425 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -271,6 +271,10 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
  */
 static inline void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
+	spin_lock_irq(q->queue_lock);
+	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irq(q->queue_lock);
+
 	blk_mq_stop_hw_queues(q);
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7178ad6805e3..7da799a88244 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -619,6 +619,7 @@ struct request_queue {
 #define QUEUE_FLAG_POLL_STATS  28	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED  29	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 30	/* queue supports SCSI commands */
+#define QUEUE_FLAG_QUIESCED    31	/* queue has been quiesced */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -715,6 +716,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
+#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
 
 static inline bool blk_account_rq(struct request *rq)
 {
-- 
2.9.4
