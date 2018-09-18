Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v8 2/8] blk-mq: Introduce blk_mq_queue_rq_iter()
Date: Tue, 18 Sep 2018 13:58:57 -0700
Message-Id: <20180918205903.15516-3-bvanassche@acm.org>
In-Reply-To: <20180918205903.15516-1-bvanassche@acm.org>
References: <20180918205903.15516-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

This function will be used in the patch "Make blk_get_request() block for
non-PM requests while suspended".

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-mq-tag.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-tag.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index ef3acb4a80e0..cf8537017f78 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -374,6 +374,50 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	rcu_read_unlock();
 }
 
+/*
+ * Call @fn(rq, @priv, reserved) for each request associated with request
+ * queue @q or any queue that it shares tags with and that has been assigned a
+ * tag. 'reserved' indicates whether or not 'rq' is a reserved request. In
+ * contrast to blk_mq_queue_tag_busy_iter(), if an I/O scheduler has been
+ * associated with @q, this function also iterates over requests that have
+ * been assigned a scheduler tag but that have not yet been assigned a driver
+ * tag.
+ */
+void blk_mq_queue_rq_iter(struct request_queue *q, busy_iter_fn *fn, void *priv)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	/*
+	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
+	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
+	 * to avoid race with it. __blk_mq_update_nr_hw_queues will users
+	 * synchronize_rcu to ensure all of the users go out of the critical
+	 * section below and see zeroed q_usage_counter.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		struct blk_mq_tags *tags = hctx->sched_tags ? : hctx->tags;
+
+		/*
+		 * If no software queues are currently mapped to this
+		 * hardware queue, there's nothing to check
+		 */
+		if (!blk_mq_hw_queue_mapped(hctx))
+			continue;
+
+		if (tags->nr_reserved_tags)
+			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
+		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+	}
+	rcu_read_unlock();
+}
+
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..25e62997ed6c 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -35,6 +35,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_queue_rq_iter(struct request_queue *q, busy_iter_fn *fn,
+			  void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
-- 
2.18.0
