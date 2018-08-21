Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] blk-wbt: move disable check into get_limit()
Date: Tue, 21 Aug 2018 09:05:15 -0600
Message-Id: <20180821150517.19744-2-axboe@kernel.dk>
In-Reply-To: <20180821150517.19744-1-axboe@kernel.dk>
References: <20180821150517.19744-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Check it in one place, instead of in multiple places.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-wbt.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index bb93c7c2b182..1dd7edce7a99 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -449,6 +449,13 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 {
 	unsigned int limit;
 
+	/*
+	 * If we got disabled, just return UINT_MAX. This ensures that
+	 * we'll properly inc a new IO, and dec+wakeup at the end.
+	 */
+	if (!rwb_enabled(rwb))
+		return UINT_MAX;
+
 	if ((rw & REQ_OP_MASK) == REQ_OP_DISCARD)
 		return rwb->wb_background;
 
@@ -486,16 +493,6 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
 	DECLARE_WAITQUEUE(wait, current);
 
-	/*
-	* inc it here even if disabled, since we'll dec it at completion.
-	* this only happens if the task was sleeping in __wbt_wait(),
-	* and someone turned it off at the same time.
-	*/
-	if (!rwb_enabled(rwb)) {
-		atomic_inc(&rqw->inflight);
-		return;
-	}
-
 	if (!waitqueue_active(&rqw->wait)
 		&& rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
@@ -504,11 +501,6 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (!rwb_enabled(rwb)) {
-			atomic_inc(&rqw->inflight);
-			break;
-		}
-
 		if (rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 			break;
 
-- 
2.17.1
