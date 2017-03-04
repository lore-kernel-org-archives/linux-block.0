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
Subject: [PATCH RFC 13/14] block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
Date: Sat,  4 Mar 2017 17:01:30 +0100
Message-Id: <20170304160131.57366-14-paolo.valente@linaro.org>
In-Reply-To: <20170304160131.57366-1-paolo.valente@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
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
 block/bfq-iosched.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e509237..10d550b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6372,20 +6372,15 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
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
@@ -6393,7 +6388,8 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	 * device.
 	 */
 	idling_boosts_thr = !bfqd->hw_tag ||
-		(!blk_queue_nonrot(bfqd->queue) && bfq_bfqq_IO_bound(bfqq));
+		(!blk_queue_nonrot(bfqd->queue) && bfq_bfqq_IO_bound(bfqq) &&
+		 bfq_bfqq_idle_window(bfqq));
 
 	/*
 	 * The value of the next variable,
@@ -8301,7 +8297,7 @@ static struct blkcg_policy blkcg_policy_bfq = {
 static int __init bfq_init(void)
 {
 	int ret;
-	char msg[50] = "BFQ I/O-scheduler: v6";
+	char msg[50] = "BFQ I/O-scheduler: v7r3";
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	ret = blkcg_policy_register(&blkcg_policy_bfq);
-- 
2.10.0
