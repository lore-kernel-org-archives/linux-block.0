Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v7 4/7] block: Split blk_pm_add_request() and blk_pm_put_request()
Date: Mon, 17 Sep 2018 13:11:19 -0700
Message-Id: <20180917201124.26161-7-bvanassche@acm.org>
In-Reply-To: <20180917201124.26161-1-bvanassche@acm.org>
References: <20180917201124.26161-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Move the pm_request_resume() and pm_runtime_mark_last_busy() calls into
two new functions and thereby separate legacy block layer code from code
that works for both the legacy block layer and blk-mq. A later patch will
add calls to the new functions in the blk-mq code.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c |  1 +
 block/blk-pm.h   | 36 +++++++++++++++++++++++++++++++-----
 block/elevator.c |  1 +
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1a691f5269bb..fd91e9bf2893 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1744,6 +1744,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 
 	blk_req_zone_write_unlock(req);
 	blk_pm_put_request(req);
+	blk_pm_mark_last_busy(req);
 
 	elv_completed_request(q, req);
 
diff --git a/block/blk-pm.h b/block/blk-pm.h
index 1ffc8ef203ec..a8564ea72a41 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -6,8 +6,23 @@
 #include <linux/pm_runtime.h>
 
 #ifdef CONFIG_PM
+static inline void blk_pm_request_resume(struct request_queue *q)
+{
+	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
+		       q->rpm_status == RPM_SUSPENDING))
+		pm_request_resume(q->dev);
+}
+
+static inline void blk_pm_mark_last_busy(struct request *rq)
+{
+	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
+		pm_runtime_mark_last_busy(rq->q->dev);
+}
+
 static inline void blk_pm_requeue_request(struct request *rq)
 {
+	lockdep_assert_held(rq->q->queue_lock);
+
 	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
 		rq->q->nr_pending--;
 }
@@ -15,17 +30,28 @@ static inline void blk_pm_requeue_request(struct request *rq)
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
-	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
-	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
-		pm_request_resume(q->dev);
+	lockdep_assert_held(q->queue_lock);
+
+	if (q->dev && !(rq->rq_flags & RQF_PM))
+		q->nr_pending++;
 }
 
 static inline void blk_pm_put_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
-		pm_runtime_mark_last_busy(rq->q->dev);
+	lockdep_assert_held(rq->q->queue_lock);
+
+	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
+		--rq->q->nr_pending;
 }
 #else
+static inline void blk_pm_request_resume(struct request_queue *q)
+{
+}
+
+static inline void blk_pm_mark_last_busy(struct request *rq)
+{
+}
+
 static inline void blk_pm_requeue_request(struct request *rq)
 {
 }
diff --git a/block/elevator.c b/block/elevator.c
index e18ac68626e3..1c992bf6cfb1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,6 +601,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 	trace_block_rq_insert(q, rq);
 
 	blk_pm_add_request(q, rq);
+	blk_pm_request_resume(q);
 
 	rq->q = q;
 
-- 
2.18.0
