Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 04/22] block, cfq: remove SSD-related logic
Date: Mon,  8 Aug 2016 13:14:59 +0200
Message-Id: <1470654917-4280-5-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

CFQ disables idling for SSD devices to achieve a higher throughput. As
for seeky queues (see the previous commit), BFQ makes idling decisions
for SSD devices in a more complex way, according to a unified strategy
for boosting the throughput while at the same preserving strong
throughput-distribution and latency guarantees. This commit then
removes the CFQ mechanism.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 04d2298..ef6b491 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -51,7 +51,6 @@ static const int cfq_hist_divisor = 4;
 
 #define CFQQ_SEEK_THR		(sector_t)(8 * 100)
 #define CFQQ_CLOSE_THR		(sector_t)(8 * 1024)
-#define CFQQ_SECT_THR_NONROT	(sector_t)(2 * 32)
 #define CFQQ_SEEKY(cfqq)	(hweight32(cfqq->seek_history) > 32/8)
 
 #define RQ_CIC(rq)		icq_to_cic((rq)->elv.icq)
@@ -2714,8 +2713,7 @@ static bool cfq_should_idle(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 		return false;
 
 	/* We do for queues that were marked with idle window flag. */
-	if (cfq_cfqq_idle_window(cfqq) &&
-	   !(blk_queue_nonrot(cfqd->queue) && cfqd->hw_tag))
+	if (cfq_cfqq_idle_window(cfqq))
 		return true;
 
 	/*
@@ -2737,14 +2735,6 @@ static void cfq_arm_slice_timer(struct cfq_data *cfqd)
 	u64 sl, group_idle = 0;
 	u64 now = ktime_get_ns();
 
-	/*
-	 * SSD device without seek penalty, disable idling. But only do so
-	 * for devices that support queuing, otherwise we still have a problem
-	 * with sync vs async workloads.
-	 */
-	if (blk_queue_nonrot(cfqd->queue) && cfqd->hw_tag)
-		return;
-
 	WARN_ON(!RB_EMPTY_ROOT(&cfqq->sort_list));
 	WARN_ON(cfq_cfqq_slice_new(cfqq));
 
@@ -3611,7 +3601,6 @@ cfq_update_io_seektime(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 		       struct request *rq)
 {
 	sector_t sdist = 0;
-	sector_t n_sec = blk_rq_sectors(rq);
 	if (cfqq->last_request_pos) {
 		if (cfqq->last_request_pos < blk_rq_pos(rq))
 			sdist = blk_rq_pos(rq) - cfqq->last_request_pos;
@@ -3620,10 +3609,7 @@ cfq_update_io_seektime(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	}
 
 	cfqq->seek_history <<= 1;
-	if (blk_queue_nonrot(cfqd->queue))
-		cfqq->seek_history |= (n_sec < CFQQ_SECT_THR_NONROT);
-	else
-		cfqq->seek_history |= (sdist > CFQQ_SEEK_THR);
+	cfqq->seek_history |= (sdist > CFQQ_SEEK_THR);
 }
 
 /*
-- 
1.9.1
