Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Arianna Avanzini <avanzini.arianna@gmail.com>
Subject: [PATCH V2 17/22] block, bfq: reduce latency during request-pool saturation
Date: Mon,  8 Aug 2016 13:15:12 +0200
Message-Id: <1470654917-4280-18-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This patch introduces an heuristic that reduces latency when the
I/O-request pool is saturated. This goal is achieved by disabling
device idling, for non-weight-raised queues, when there are weight-
raised queues with pending or in-flight requests. In fact, as
explained in more detail in the comment on the function
bfq_bfqq_may_idle(), this reduces the rate at which processes
associated with non-weight-raised queues grab requests from the pool,
thereby increasing the probability that processes associated with
weight-raised queues get a request immediately (or at least soon) when
they need one. Along the same line, if there are weight-raised queues,
then this patch halves the service rate of async (write) requests for
non-weight-raised queues.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/cfq-iosched.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index d3cda1a..d137ed2 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -375,6 +375,8 @@ struct bfq_data {
 	 * queue in service, even if it is idling).
 	 */
 	int busy_queues;
+	/* number of weight-raised busy @bfq_queues */
+	int wr_busy_queues;
 	/* number of queued requests */
 	int queued;
 	/* number of requests dispatched and waiting for completion */
@@ -1993,6 +1995,9 @@ static void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqd->busy_queues--;
 
+	if (bfqq->wr_coeff > 1)
+		bfqd->wr_busy_queues--;
+
 	bfqg_stats_update_dequeue(bfqq_group(bfqq));
 
 	bfq_deactivate_bfqq(bfqd, bfqq, requeue);
@@ -2009,6 +2014,9 @@ static void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_mark_bfqq_busy(bfqq);
 	bfqd->busy_queues++;
+
+	if (bfqq->wr_coeff > 1)
+		bfqd->wr_busy_queues++;
 }
 
 #if defined(CONFIG_CFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
@@ -3305,7 +3313,16 @@ static unsigned long bfq_serv_to_charge(struct request *rq,
 	if (bfq_bfqq_sync(bfqq) || bfqq->wr_coeff > 1)
 		return blk_rq_sectors(rq);
 
-	return blk_rq_sectors(rq) * bfq_async_charge_factor;
+	/*
+	 * If there are no weight-raised queues, then amplify service
+	 * by just the async charge factor; otherwise amplify service
+	 * by twice the async charge factor, to further reduce latency
+	 * for weight-raised queues.
+	 */
+	if (bfqq->bfqd->wr_busy_queues == 0)
+		return blk_rq_sectors(rq) * bfq_async_charge_factor;
+
+	return blk_rq_sectors(rq) * 2 * bfq_async_charge_factor;
 }
 
 /**
@@ -3773,6 +3790,7 @@ static void bfq_add_request(struct request *rq)
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
 
+			bfqd->wr_busy_queues++;
 			bfqq->entity.prio_changed = 1;
 		}
 		if (prev != bfqq->next_rq)
@@ -3974,6 +3992,8 @@ static void bfq_merged_requests(struct request_queue *q, struct request *rq,
 /* Must be called with bfqq != NULL */
 static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 {
+	if (bfq_bfqq_busy(bfqq))
+		bfqq->bfqd->wr_busy_queues--;
 	bfqq->wr_coeff = 1;
 	bfqq->wr_cur_max_time = 0;
 	/*
@@ -4839,7 +4859,8 @@ static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
 static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 {
 	struct bfq_data *bfqd = bfqq->bfqd;
-	bool idling_boosts_thr, asymmetric_scenario;
+	bool idling_boosts_thr, idling_boosts_thr_without_issues,
+		asymmetric_scenario;
 
 	if (bfqd->strict_guarantees)
 		return true;
@@ -4862,6 +4883,44 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	idling_boosts_thr = !bfqd->hw_tag || bfq_bfqq_IO_bound(bfqq);
 
 	/*
+	 * The value of the next variable,
+	 * idling_boosts_thr_without_issues, is equal to that of
+	 * idling_boosts_thr, unless a special case holds. In this
+	 * special case, described below, idling may cause problems to
+	 * weight-raised queues.
+	 *
+	 * When the request pool is saturated (e.g., in the presence
+	 * of write hogs), if the processes associated with
+	 * non-weight-raised queues ask for requests at a lower rate,
+	 * then processes associated with weight-raised queues have a
+	 * higher probability to get a request from the pool
+	 * immediately (or at least soon) when they need one. Thus
+	 * they have a higher probability to actually get a fraction
+	 * of the device throughput proportional to their high
+	 * weight. This is especially true with NCQ-capable drives,
+	 * which enqueue several requests in advance, and further
+	 * reorder internally-queued requests.
+	 *
+	 * For this reason, we force to false the value of
+	 * idling_boosts_thr_without_issues if there are weight-raised
+	 * busy queues. In this case, and if bfqq is not weight-raised,
+	 * this guarantees that the device is not idled for bfqq (if,
+	 * instead, bfqq is weight-raised, then idling will be
+	 * guaranteed by another variable, see below). Combined with
+	 * the timestamping rules of BFQ (see [1] for details), this
+	 * behavior causes bfqq, and hence any sync non-weight-raised
+	 * queue, to get a lower number of requests served, and thus
+	 * to ask for a lower number of requests from the request
+	 * pool, before the busy weight-raised queues get served
+	 * again. This often mitigates starvation problems in the
+	 * presence of heavy write workloads and NCQ, thereby
+	 * guaranteeing a higher application and system responsiveness
+	 * in these hostile scenarios.
+	 */
+	idling_boosts_thr_without_issues = idling_boosts_thr &&
+		bfqd->wr_busy_queues == 0;
+
+	/*
 	 * There is then a case where idling must be performed not for
 	 * throughput concerns, but to preserve service guarantees. To
 	 * introduce it, we can note that allowing the drive to
@@ -4935,7 +4994,7 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	 *    is necessary to preserve service guarantees.
 	 */
 	return bfq_bfqq_sync(bfqq) &&
-		(idling_boosts_thr || asymmetric_scenario);
+		(idling_boosts_thr_without_issues || asymmetric_scenario);
 }
 
 /*
@@ -6059,6 +6118,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 					      * high-definition compressed
 					      * video.
 					      */
+	bfqd->wr_busy_queues = 0;
 
 	/*
 	 * Begin by assuming, optimistically, that the device is a
-- 
1.9.1
