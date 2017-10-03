Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix peeking requests during PM
Date: Tue,  3 Oct 2017 10:47:01 +0200
Message-Id: <20171003084701.19346-3-hch@lst.de>
In-Reply-To: <20171003084701.19346-1-hch@lst.de>
References: <20171003084701.19346-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We need to look for an active PM request until the next softbarrier
instead of looking for the first non-PM request.  Otherwise any cause
of request reordering might starve the PM request(s).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14f7674fa0b1..2b704759913a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2464,20 +2464,24 @@ void blk_account_io_done(struct request *req)
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
+	if (!rq->q->dev)
+		return true;
+
+	switch (rq->q->rpm_status) {
+	case RPM_SUSPENDED:
+		return false;
+	case RPM_ACTIVE:
+		return rq->rq_flags & RQF_PM;
+	default:
+		return true;
+	}
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
 
@@ -2525,9 +2529,12 @@ static struct request *elv_next_request(struct request_queue *q)
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
@@ -2578,10 +2585,6 @@ struct request *blk_peek_request(struct request_queue *q)
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
2.14.1
