Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] blk-wbt: fix has-sleeper queueing check
Date: Tue, 21 Aug 2018 09:05:17 -0600
Message-Id: <20180821150517.19744-4-axboe@kernel.dk>
In-Reply-To: <20180821150517.19744-1-axboe@kernel.dk>
References: <20180821150517.19744-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We need to do this inside the loop as well, or we can allow new
IO to supersede previous IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-wbt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 853e22492f4e..c9358f1981fb 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -492,16 +492,17 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
 	DECLARE_WAITQUEUE(wait, current);
+	bool has_sleeper;
 
-	if (!wq_has_sleeper(&rqw->wait) &&
-	    rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+	has_sleeper = wq_has_sleeper(&rqw->wait);
+	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 		return;
 
 	add_wait_queue_exclusive(&rqw->wait, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
-		if (rq_wait_inc_below(rqw, get_limit(rwb, rw)))
+		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
 			break;
 
 		if (lock) {
@@ -510,6 +511,7 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 			spin_lock_irq(lock);
 		} else
 			io_schedule();
+		has_sleeper = false;
 	} while (1);
 
 	__set_current_state(TASK_RUNNING);
-- 
2.17.1
