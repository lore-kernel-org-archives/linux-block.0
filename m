Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41000 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeHIWIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:08:34 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 09/12] block: Split blk_pm_add_request() and blk_pm_put_request()
Date: Thu,  9 Aug 2018 12:41:46 -0700
Message-Id: <20180809194149.15285-10-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Move the pm_request_resume() and pm_runtime_mark_last_busy() calls into
two new functions.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
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
index 3770a36e85be..59dd98585eb0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1774,6 +1774,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 
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
index 4c15f0240c99..00c5d8dbce16 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,6 +601,7 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 	trace_block_rq_insert(q, rq);
 
 	blk_pm_add_request(q, rq);
+	blk_pm_request_resume(q);
 
 	rq->q = q;
 
-- 
2.18.0
