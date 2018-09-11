Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] blk-mq: introduce bio retrieve mechanism
Date: Tue, 11 Sep 2018 17:48:11 +0800
Message-Id: <1536659294-2321-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently request requeue mechanism cannot work well with updating
nr_hw_queues. Because the requests are highly bound with specific
hw queue, requests on the dying hw queue have to be failed. And
this could be fatal for filesystem.

In addition, the request_queue need to be frozen and drained before
updating nr_hw_queues, if IO timeout, we have to depend on the LLDD
to do recovery. But the recovery path maybe sleeping to wait the
the request_queue to be drained. IO hang comes up.

To avoid the two case above, we introduce bio retrieve mechanism.
The bio retrieving will do following things:
 - flush requests on hctx->dispatch, sw queue or io scheduler queue
 - take the bios down from the requests and end the requests
 - requeue this bios and submit them through generic_make_request
   again later.

Then we could avoid to fail requests on dying hw queue and depend
on storage device to drain request_queue.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq.c         | 40 ++++++++++++++++++++++++++
 include/linux/blk-mq.h |  4 +++
 include/linux/blkdev.h |  2 ++
 4 files changed, 124 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe80..4881ae1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -422,6 +422,84 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
+static void blk_mq_sched_retrieve_one_req(struct request *rq,
+		struct bio_list *list)
+{
+	blk_steal_bios(list, rq);
+	blk_mq_end_request(rq, BLK_STS_OK);
+}
+
+static void __blk_mq_sched_retrieve_bios(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+	struct bio_list bio_list;
+	LIST_HEAD(rq_list);
+	struct request *rq;
+
+	bio_list_init(&bio_list);
+
+	if (!list_empty_careful(&hctx->dispatch)) {
+		spin_lock(&hctx->lock);
+		if (!list_empty(&hctx->dispatch))
+			list_splice_tail_init(&hctx->dispatch, &rq_list);
+		spin_unlock(&hctx->lock);
+	}
+
+	if (!q->elevator)
+		blk_mq_flush_busy_ctxs(hctx, &rq_list);
+
+	while (!list_empty(&rq_list)) {
+		rq = list_first_entry(&rq_list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		blk_mq_sched_retrieve_one_req(rq, &bio_list);
+	}
+
+	if (q->elevator) {
+		struct elevator_queue *e = hctx->queue->elevator;
+
+		while (e->type->ops.mq.has_work &&
+				e->type->ops.mq.has_work(hctx)) {
+			rq = e->type->ops.mq.dispatch_request(hctx);
+			if (!rq)
+				continue;
+
+			blk_mq_sched_retrieve_one_req(rq, &bio_list);
+		}
+	}
+	/*
+	 * There could still be rqs in flush queue, the caller will check
+	 * q_usage_counter and come back again.
+	 */
+	blk_mq_requeue_bios(q, &bio_list, false);
+}
+
+/*
+ * When blk_mq_sched_retrieve_bios returns:
+ *  - All the rqs are ended, q_usage_counter is zero
+ *  - All the bios are queued to q->requeue_bios
+ */
+void blk_mq_sched_retrieve_bios(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	BUG_ON(!atomic_read(&q->mq_freeze_depth) ||
+			!blk_queue_quiesced(q));
+
+	/*
+	 * Kick the requeue_work to flush the reqs in requeue_list
+	 */
+	blk_mq_kick_requeue_list(q);
+
+	while (!percpu_ref_is_zero(&q->q_usage_counter)) {
+		queue_for_each_hw_ctx(q, hctx, i)
+			__blk_mq_sched_retrieve_bios(hctx);
+	}
+
+	blk_mq_requeue_bios(q, NULL, true);
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_retrieve_bios);
+
 static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 				   struct blk_mq_hw_ctx *hctx,
 				   unsigned int hctx_idx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a..3d59741 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -689,6 +689,44 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
+static void blk_mq_bio_requeue_work(struct work_struct *work)
+{
+	struct request_queue *q =
+		container_of(work, struct request_queue, bio_requeue_work.work);
+	struct bio *bio;
+
+	/* Defects:
+	 *  - Bios from all cpus have to be issued on one.
+	 *  - The requeued older bios have to contend tags with following
+	 *    new bios.
+	 */
+	while (true) {
+		spin_lock_irq(&q->requeue_lock);
+		bio = bio_list_pop(&q->requeue_bios);
+		spin_unlock_irq(&q->requeue_lock);
+		if (!bio)
+			break;
+		/*
+		 * generic_make_request will handle the queue DYING case.
+		 */
+		generic_make_request(bio);
+	}
+}
+
+void blk_mq_requeue_bios(struct request_queue *q,
+		struct bio_list *bio_list, bool kick)
+{
+	if (bio_list) {
+		spin_lock_irq(&q->requeue_lock);
+		bio_list_merge(&q->requeue_bios, bio_list);
+		spin_unlock_irq(&q->requeue_lock);
+	}
+
+	if (kick)
+		kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->bio_requeue_work, 0);
+}
+EXPORT_SYMBOL(blk_mq_requeue_bios);
+
 static void blk_mq_requeue_work(struct work_struct *work)
 {
 	struct request_queue *q =
@@ -2607,7 +2645,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->sg_reserved_size = INT_MAX;
 
 	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
+	INIT_DELAYED_WORK(&q->bio_requeue_work, blk_mq_bio_requeue_work);
 	INIT_LIST_HEAD(&q->requeue_list);
+	bio_list_init(&q->requeue_bios);
 	spin_lock_init(&q->requeue_lock);
 
 	blk_queue_make_request(q, blk_mq_make_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c1..ef6edb4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -256,6 +256,10 @@ void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
 
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
+void blk_mq_requeue_bios(struct request_queue *q,
+		struct bio_list *bio_list, bool kick);
+void blk_mq_sched_retrieve_bios(struct request_queue *q);
+
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..f6ff001 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -627,8 +627,10 @@ struct request_queue {
 	struct blk_flush_queue	*fq;
 
 	struct list_head	requeue_list;
+	struct bio_list 	requeue_bios;
 	spinlock_t		requeue_lock;
 	struct delayed_work	requeue_work;
+	struct delayed_work	bio_requeue_work;
 
 	struct mutex		sysfs_lock;
 
-- 
2.7.4
