Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] blk-wbt: use wq_has_sleeper() for wq active check
Date: Tue, 21 Aug 2018 09:05:16 -0600
Message-Id: <20180821150517.19744-3-axboe@kernel.dk>
In-Reply-To: <20180821150517.19744-1-axboe@kernel.dk>
References: <20180821150517.19744-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We need the memory barrier before checking the list head,
use the appropriate helper for this. The matching queue
side memory barrier is provided by set_current_state().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-wbt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 1dd7edce7a99..853e22492f4e 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -118,7 +118,7 @@ static void rwb_wake_all(struct rq_wb *rwb)
 	for (i = 0; i < WBT_NUM_RWQ; i++) {
 		struct rq_wait *rqw = &rwb->rq_wait[i];
 
-		if (waitqueue_active(&rqw->wait))
+		if (wq_has_sleeper(&rqw->wait))
 			wake_up_all(&rqw->wait);
 	}
 }
@@ -162,7 +162,7 @@ static void __wbt_done(struct rq_qos *rqos, enum wbt_flags wb_acct)
 	if (inflight && inflight >= limit)
 		return;
 
-	if (waitqueue_active(&rqw->wait)) {
+	if (wq_has_sleeper(&rqw->wait)) {
 		int diff = limit - inflight;
 
 		if (!inflight || diff >= rwb->wb_background / 2)
@@ -493,8 +493,8 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
 	DECLARE_WAITQUEUE(wait, current);
 
-	if (!waitqueue_active(&rqw->wait)
-		&& rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+	if (!wq_has_sleeper(&rqw->wait) &&
+	    rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
 	add_wait_queue_exclusive(&rqw->wait, &wait);
-- 
2.17.1
