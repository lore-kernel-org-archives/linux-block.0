Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH RFC V8 02/22] block, cfq: remove close-based preemption
Date: Wed, 27 Jul 2016 18:13:18 +0200
Message-Id: <1469636018-31247-3-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
References: <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
 <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

CFQ may preempt the queue currently in service if a new request, for a
different queue, happens to be close to the last-dispatched
request. This boosts the throughput with processes that issue close
requests, but whose I/O patterns are not regularly interleaved enough
to trigger the activation of the queue-merging heuristic removed in
the previous commit. BFQ does not need to perform any such preemption,
because the queue-merging mechanism of BFQ (EQM) is reactive enough to
merge queues also in the presence of irregularly interleaved I/O.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 18a7291..1b9fa10 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2677,12 +2677,6 @@ static inline sector_t cfq_dist_from_last(struct cfq_data *cfqd,
 		return cfqd->last_position - blk_rq_pos(rq);
 }
 
-static inline int cfq_rq_close(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-			       struct request *rq)
-{
-	return cfq_dist_from_last(cfqd, rq) <= CFQQ_CLOSE_THR;
-}
-
 /*
  * Determine whether we should enforce idle window for this queue.
  */
@@ -3724,13 +3718,6 @@ cfq_should_preempt(struct cfq_data *cfqd, struct cfq_queue *new_cfqq,
 	if (!cfqd->active_cic || !cfq_cfqq_wait_request(cfqq))
 		return false;
 
-	/*
-	 * if this request is as-good as one we would expect from the
-	 * current cfqq, let it preempt
-	 */
-	if (cfq_rq_close(cfqd, cfqq, rq))
-		return true;
-
 	return false;
 }
 
-- 
1.9.1
