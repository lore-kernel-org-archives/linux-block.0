Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH RFC 3/4] blk-mq: prepare for supporting runtime PM
Date: Thu, 12 Jul 2018 00:29:05 +0800
Message-Id: <20180711162906.14271-4-ming.lei@redhat.com>
In-Reply-To: <20180711162906.14271-1-ming.lei@redhat.com>
References: <20180711162906.14271-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch introduces blk_mq_pm_add_request() which is called after
allocating one request. Also blk_mq_pm_put_request() is introduced
and called after one request is freed.

For blk-mq, it can be quite expensive to accounting in-flight IOs,
so this patch calls pm_runtime_mark_last_busy() simply after each IO
is done, instead of doing that only after the last in-flight IO is done.
This way is still workable, since the active non-PM IO will be checked
in blk_pre_runtime_suspend(), and runtime suspend will be prevented
if there is any active non-PM IO.

Also makes blk_post_runtime_resume() to cover blk-mq.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 12 ++++++++++--
 block/blk-mq.c   | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c4b57d8806fe..bf66d561980d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3804,12 +3804,17 @@ EXPORT_SYMBOL(blk_pm_runtime_init);
 int blk_pre_runtime_suspend(struct request_queue *q)
 {
 	int ret = 0;
+	bool active;
 
 	if (!q->dev)
 		return ret;
 
 	spin_lock_irq(q->queue_lock);
-	if (q->nr_pending) {
+	if (!q->mq_ops)
+		active = !!q->nr_pending;
+	else
+		active = !blk_mq_pm_queue_idle(q);
+	if (active) {
 		ret = -EBUSY;
 		pm_runtime_mark_last_busy(q->dev);
 	} else {
@@ -3893,7 +3898,10 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	spin_lock_irq(q->queue_lock);
 	if (!err) {
 		q->rpm_status = RPM_ACTIVE;
-		__blk_run_queue(q);
+		if (!q->mq_ops)
+			__blk_run_queue(q);
+		else
+			blk_mq_run_hw_queues(q, true);
 		pm_runtime_mark_last_busy(q->dev);
 		pm_request_autosuspend(q->dev);
 	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3a78fed87959..50dd259f798f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/pm_runtime.h>
 
 #include <trace/events/block.h>
 
@@ -80,6 +81,25 @@ bool blk_mq_pm_queue_idle(struct request_queue *q)
 	return idle_cnt == 0;
 }
 
+static void blk_mq_pm_add_request(struct request_queue *q, struct request *rq)
+{
+	if (!blk_mq_support_runtime_pm(q))
+		return;
+
+	if (q->dev && !(rq->rq_flags & RQF_PM) &&
+	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
+		pm_request_resume(q->dev);
+}
+
+static void blk_mq_pm_put_request(struct request_queue *q, struct request *rq)
+{
+	if (!blk_mq_support_runtime_pm(q))
+		return;
+
+	if (q->dev && !(rq->rq_flags & RQF_PM))
+		pm_runtime_mark_last_busy(q->dev);
+}
+
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -531,6 +551,8 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
+	blk_mq_pm_put_request(q, rq);
+
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
@@ -1841,6 +1863,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	rq_qos_track(q, rq, bio);
 
+	blk_mq_pm_add_request(q, rq);
+
 	cookie = request_to_qc_t(data.hctx, rq);
 
 	plug = current->plug;
-- 
2.9.5
