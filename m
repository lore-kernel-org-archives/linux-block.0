Return-Path: <BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH v2] block: fix peeking requests during PM
Date: Fri, 20 Oct 2017 16:45:23 +0200
Message-Id: <20171020144523.4585-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We need to look for an active PM request until the next softbarrier
instead of looking for the first non-PM request.  Otherwise any cause
of request reordering might starve the PM request(s).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14f7674fa0b1..480029e4fb54 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2464,20 +2464,22 @@ void blk_account_io_done(struct request *req)
  * Don't process normal requests when queue is suspended
  * or in the process of suspending/resuming
  */
-static struct request *blk_pm_peek_request(struct request_queue *q,
-					   struct request *rq)
+static bool blk_pm_allow_request(struct request *rq)
 {
-	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-	    (q->rpm_status != RPM_ACTIVE && !(rq->rq_flags & RQF_PM))))
-		return NULL;
-	else
-		return rq;
+	switch (rq->q->rpm_status) {
+	case RPM_RESUMING:
+	case RPM_SUSPENDING:
+		return rq->rq_flags & RQF_PM;
+	case RPM_SUSPENDED:
+		return false;
+	}
+
+	return true;
 }
 #else
-static inline struct request *blk_pm_peek_request(struct request_queue *q,
-						  struct request *rq)
+static bool blk_pm_allow_request(struct request *rq)
 {
-	return rq;
+	return true;
 }
 #endif
 
@@ -2525,9 +2527,12 @@ static struct request *elv_next_request(struct request_queue *q)
 	WARN_ON_ONCE(q->mq_ops);
 
 	while (1) {
-		if (!list_empty(&q->queue_head)) {
-			rq = list_entry_rq(q->queue_head.next);
-			return rq;
+		list_for_each_entry(rq, &q->queue_head, queuelist) {
+			if (blk_pm_allow_request(rq))
+				return rq;
+
+			if (rq->rq_flags & RQF_SOFTBARRIER)
+				break;
 		}
 
 		/*
@@ -2578,10 +2583,6 @@ struct request *blk_peek_request(struct request_queue *q)
 	WARN_ON_ONCE(q->mq_ops);
 
 	while ((rq = elv_next_request(q)) != NULL) {
-		rq = blk_pm_peek_request(q, rq);
-		if (!rq)
-			break;
-
 		if (!(rq->rq_flags & RQF_STARTED)) {
 			/*
 			 * This is the first time the device driver
-- 
2.14.2
