Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	lee.tibbert@gmail.com,
	oleksandr@natalenko.name,
	mirkomontanari91@gmail.com,
	angeloruocco90@gmail.com,
	mauro.andreolini@unimore.it,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 3/4] block, bfq: let early-merged queues be weight-raised on split too
Date: Thu, 21 Sep 2017 11:04:02 +0200
Message-Id: <20170921090403.3217-4-paolo.valente@linaro.org>
In-Reply-To: <20170921090403.3217-1-paolo.valente@linaro.org>
References: <20170921090403.3217-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

A just-created bfq_queue, say Q, may happen to be merged with another
bfq_queue on the very first invocation of the function
__bfq_insert_request. In such a case, even if Q would clearly deserve
interactive weight raising (as it has just been created), the function
bfq_add_request does not make it to be invoked for Q, and thus to
activate weight raising for Q. As a consequence, when the state of Q
is saved for a possible future restore, after a split of Q from the
other bfq_queue(s), such a state happens to be (unjustly)
non-weight-raised. Then the bfq_queue will not enjoy any weight
raising on the split, even if should still be in an interactive
weight-raising period when the split occurs.

This commit solves this problem as follows, for a just-created
bfq_queue that is being early-merged: it stores directly, in the saved
state of the bfq_queue, the weight-raising state that would have been
assigned to the bfq_queue if not early-merged.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Tested-by: Angelo Ruocco <angeloruocco90@gmail.com>
Tested-by: Mirko Montanari <mirkomontanari91@gmail.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 block/bfq-iosched.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 33b63bc..115747f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2061,10 +2061,27 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
 	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
 	bic->was_in_burst_list = !hlist_unhashed(&bfqq->burst_list_node);
-	bic->saved_wr_coeff = bfqq->wr_coeff;
-	bic->saved_wr_start_at_switch_to_srt = bfqq->wr_start_at_switch_to_srt;
-	bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
-	bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+	if (unlikely(bfq_bfqq_just_created(bfqq) &&
+		     !bfq_bfqq_in_large_burst(bfqq))) {
+		/*
+		 * bfqq being merged right after being created: bfqq
+		 * would have deserved interactive weight raising, but
+		 * did not make it to be set in a weight-raised state,
+		 * because of this early merge.	Store directly the
+		 * weight-raising state that would have been assigned
+		 * to bfqq, so that to avoid that bfqq unjustly fails
+		 * to enjoy weight raising if split soon.
+		 */
+		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
+		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
+		bic->saved_last_wr_start_finish = jiffies;
+	} else {
+		bic->saved_wr_coeff = bfqq->wr_coeff;
+		bic->saved_wr_start_at_switch_to_srt =
+			bfqq->wr_start_at_switch_to_srt;
+		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
+		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
+	}
 }
 
 static void
@@ -4150,7 +4167,6 @@ static void __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		new_bfqq->allocated++;
 		bfqq->allocated--;
 		new_bfqq->ref++;
-		bfq_clear_bfqq_just_created(bfqq);
 		/*
 		 * If the bic associated with the process
 		 * issuing this request still points to bfqq
@@ -4162,6 +4178,8 @@ static void __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		if (bic_to_bfqq(RQ_BIC(rq), 1) == bfqq)
 			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
 					bfqq, new_bfqq);
+
+		bfq_clear_bfqq_just_created(bfqq);
 		/*
 		 * rq is about to be enqueued into new_bfqq,
 		 * release rq reference on bfqq
-- 
2.10.0
