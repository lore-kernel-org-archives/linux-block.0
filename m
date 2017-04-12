Return-Path: <paolo.valente@linaro.org>
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
Subject: [PATCH V4 13/16] block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
Date: Wed, 12 Apr 2017 18:23:19 +0200
Message-Id: <20170412162322.11139-14-paolo.valente@linaro.org>
In-Reply-To: <20170412162322.11139-1-paolo.valente@linaro.org>
References: <20170412162322.11139-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This patch is basically the counterpart, for NCQ-capable rotational
devices, of the previous patch. Exactly as the previous patch does on
flash-based devices and for any workload, this patch disables device
idling on rotational devices, but only for random I/O. In fact, only
with these queues disabling idling boosts the throughput on
NCQ-capable rotational devices. To not break service guarantees,
idling is disabled for NCQ-enabled rotational devices only when the
same symmetry conditions considered in the previous patches hold.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/bfq-iosched.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2081784..549f030 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6439,20 +6439,15 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	 * The next variable takes into account the cases where idling
 	 * boosts the throughput.
 	 *
-	 * The value of the variable is computed considering that
-	 * idling is usually beneficial for the throughput if:
+	 * The value of the variable is computed considering, first, that
+	 * idling is virtually always beneficial for the throughput if:
 	 * (a) the device is not NCQ-capable, or
 	 * (b) regardless of the presence of NCQ, the device is rotational
-	 *     and the request pattern for bfqq is I/O-bound (possible
-	 *     throughput losses caused by granting idling to seeky queues
-	 *     are mitigated by the fact that, in all scenarios where
-	 *     boosting throughput is the best thing to do, i.e., in all
-	 *     symmetric scenarios, only a minimal idle time is allowed to
-	 *     seeky queues).
+	 *     and the request pattern for bfqq is I/O-bound and sequential.
 	 *
 	 * Secondly, and in contrast to the above item (b), idling an
 	 * NCQ-capable flash-based device would not boost the
-	 * throughput even with intense I/O; rather it would lower
+	 * throughput even with sequential I/O; rather it would lower
 	 * the throughput in proportion to how fast the device
 	 * is. Accordingly, the next variable is true if any of the
 	 * above conditions (a) and (b) is true, and, in particular,
@@ -6460,7 +6455,8 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	 * device.
 	 */
 	idling_boosts_thr = !bfqd->hw_tag ||
-		(!blk_queue_nonrot(bfqd->queue) && bfq_bfqq_IO_bound(bfqq));
+		(!blk_queue_nonrot(bfqd->queue) && bfq_bfqq_IO_bound(bfqq) &&
+		 bfq_bfqq_idle_window(bfqq));
 
 	/*
 	 * The value of the next variable,
-- 
2.10.0
