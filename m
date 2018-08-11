Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [RFC PATCH V2 17/17] block: enable runtime PM for blk-mq
Date: Sat, 11 Aug 2018 15:12:20 +0800
Message-Id: <20180811071220.357-18-ming.lei@redhat.com>
In-Reply-To: <20180811071220.357-1-ming.lei@redhat.com>
References: <20180811071220.357-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now blk-mq can borrow the runtime PM approach from legacy path, so
enable it simply. The only difference with legacy is that:

1) blk_mq_queue_sched_tag_busy_iter() is introduced for checking if queue
is idle, instead of maintaining one counter.

2) we have to iterate over scheduler tags for counting how many requests
entering queue because requests in hw tags don't cover these allocated
and not dispatched.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c   | 29 ++++++++++++++++++++++++-----
 block/blk-mq-tag.c | 21 +++++++++++++++++++--
 block/blk-mq-tag.h |  2 ++
 block/blk-mq.c     |  4 ++++
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 939e1dae4ea8..f42197c9f7af 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3751,11 +3751,8 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* Don't enable runtime PM for blk-mq until it is ready */
-	if (q->mq_ops) {
-		pm_runtime_disable(dev);
+	if (WARN_ON_ONCE(blk_queue_admin(q)))
 		return;
-	}
 
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
@@ -3764,6 +3761,23 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 }
 EXPORT_SYMBOL(blk_pm_runtime_init);
 
+static void blk_mq_pm_count_req(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	unsigned long *cnt = priv;
+
+	(*cnt)++;
+}
+
+static bool blk_mq_pm_queue_busy(struct request_queue *q)
+{
+	unsigned long cnt = 0;
+
+	blk_mq_queue_sched_tag_busy_iter(q, blk_mq_pm_count_req, &cnt);
+
+	return cnt > 0;
+}
+
 /**
  * blk_pre_runtime_suspend - Pre runtime suspend check
  * @q: the queue of the device
@@ -3788,12 +3802,17 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
 int blk_pre_runtime_suspend(struct request_queue *q)
 {
 	int ret = 0;
+	bool busy = true;
 
 	if (!q->dev)
 		return ret;
 
+	if (q->mq_ops)
+		busy = blk_mq_pm_queue_busy(q);
+
 	spin_lock_irq(q->queue_lock);
-	if (q->nr_pending) {
+	busy = q->mq_ops ? busy : !!q->nr_pending;
+	if (busy) {
 		ret = -EBUSY;
 		pm_runtime_mark_last_busy(q->dev);
 	} else {
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 7cd09fd16f5a..0580f80fa350 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -316,8 +316,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv)
+static void __blk_mq_queue_tag_busy_iter(struct request_queue *q,
+		busy_iter_fn *fn, void *priv, bool sched_tag)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
@@ -326,6 +326,9 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		struct blk_mq_tags *tags = hctx->tags;
 
+		if (sched_tag && hctx->sched_tags)
+			tags = hctx->sched_tags;
+
 		/*
 		 * If not software queues are currently mapped to this
 		 * hardware queue, there's nothing to check
@@ -340,6 +343,20 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 
 }
 
+void blk_mq_queue_tag_busy_iter(struct request_queue *q,
+		busy_iter_fn *fn, void *priv)
+{
+
+	__blk_mq_queue_tag_busy_iter(q, fn, priv, false);
+}
+
+void blk_mq_queue_sched_tag_busy_iter(struct request_queue *q,
+		busy_iter_fn *fn, void *priv)
+{
+
+	__blk_mq_queue_tag_busy_iter(q, fn, priv, true);
+}
+
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..5513c3eeab00 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -35,6 +35,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_queue_sched_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aea121c41a30..b42a2c9ba00e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/pm_runtime.h>
 
 #include <trace/events/block.h>
 
@@ -503,6 +504,9 @@ static void __blk_mq_free_request(struct request *rq)
 		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
+
+	if (q->dev)
+		pm_runtime_mark_last_busy(q->dev);
 }
 
 void blk_mq_free_request(struct request *rq)
-- 
2.9.5
