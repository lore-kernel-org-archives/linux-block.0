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
Subject: [PATCH V4 12/16] block, bfq: boost the throughput on NCQ-capable flash-based devices
Date: Wed, 12 Apr 2017 18:23:18 +0200
Message-Id: <20170412162322.11139-13-paolo.valente@linaro.org>
In-Reply-To: <20170412162322.11139-1-paolo.valente@linaro.org>
References: <20170412162322.11139-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This patch boosts the throughput on NCQ-capable flash-based devices,
while still preserving latency guarantees for interactive and soft
real-time applications. The throughput is boosted by just not idling
the device when the in-service queue remains empty, even if the queue
is sync and has a non-null idle window. This helps to keep the drive's
internal queue full, which is necessary to achieve maximum
performance. This solution to boost the throughput is a port of
commits a68bbdd and f7d7b7a for CFQ.

As already highlighted in a previous patch, allowing the device to
prefetch and internally reorder requests trivially causes loss of
control on the request service order, and hence on service guarantees.
Fortunately, as discussed in detail in the comments on the function
bfq_bfqq_may_idle(), if every process has to receive the same
fraction of the throughput, then the service order enforced by the
internal scheduler of a flash-based device is relatively close to that
enforced by BFQ. In particular, it is close enough to let service
guarantees be substantially preserved.

Things change in an asymmetric scenario, i.e., if not every process
has to receive the same fraction of the throughput. In this case, to
guarantee the desired throughput distribution, the device must be
prevented from prefetching requests. This is exactly what this patch
does in asymmetric scenarios.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/bfq-iosched.c | 154 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 106 insertions(+), 48 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b97801f..2081784 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6442,15 +6442,25 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	 * The value of the variable is computed considering that
 	 * idling is usually beneficial for the throughput if:
 	 * (a) the device is not NCQ-capable, or
-	 * (b) regardless of the presence of NCQ, the request pattern
-	 *     for bfqq is I/O-bound (possible throughput losses
-	 *     caused by granting idling to seeky queues are mitigated
-	 *     by the fact that, in all scenarios where boosting
-	 *     throughput is the best thing to do, i.e., in all
-	 *     symmetric scenarios, only a minimal idle time is
-	 *     allowed to seeky queues).
+	 * (b) regardless of the presence of NCQ, the device is rotational
+	 *     and the request pattern for bfqq is I/O-bound (possible
+	 *     throughput losses caused by granting idling to seeky queues
+	 *     are mitigated by the fact that, in all scenarios where
+	 *     boosting throughput is the best thing to do, i.e., in all
+	 *     symmetric scenarios, only a minimal idle time is allowed to
+	 *     seeky queues).
+	 *
+	 * Secondly, and in contrast to the above item (b), idling an
+	 * NCQ-capable flash-based device would not boost the
+	 * throughput even with intense I/O; rather it would lower
+	 * the throughput in proportion to how fast the device
+	 * is. Accordingly, the next variable is true if any of the
+	 * above conditions (a) and (b) is true, and, in particular,
+	 * happens to be false if bfqd is an NCQ-capable flash-based
+	 * device.
 	 */
-	idling_boosts_thr = !bfqd->hw_tag || bfq_bfqq_IO_bound(bfqq);
+	idling_boosts_thr = !bfqd->hw_tag ||
+		(!blk_queue_nonrot(bfqd->queue) && bfq_bfqq_IO_bound(bfqq));
 
 	/*
 	 * The value of the next variable,
@@ -6491,14 +6501,16 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 		bfqd->wr_busy_queues == 0;
 
 	/*
-	 * There is then a case where idling must be performed not for
-	 * throughput concerns, but to preserve service guarantees. To
-	 * introduce it, we can note that allowing the drive to
-	 * enqueue more than one request at a time, and hence
+	 * There is then a case where idling must be performed not
+	 * for throughput concerns, but to preserve service
+	 * guarantees.
+	 *
+	 * To introduce this case, we can note that allowing the drive
+	 * to enqueue more than one request at a time, and hence
 	 * delegating de facto final scheduling decisions to the
-	 * drive's internal scheduler, causes loss of control on the
+	 * drive's internal scheduler, entails loss of control on the
 	 * actual request service order. In particular, the critical
-	 * situation is when requests from different processes happens
+	 * situation is when requests from different processes happen
 	 * to be present, at the same time, in the internal queue(s)
 	 * of the drive. In such a situation, the drive, by deciding
 	 * the service order of the internally-queued requests, does
@@ -6509,51 +6521,97 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	 * the service distribution enforced by the drive's internal
 	 * scheduler is likely to coincide with the desired
 	 * device-throughput distribution only in a completely
-	 * symmetric scenario where: (i) each of these processes must
-	 * get the same throughput as the others; (ii) all these
-	 * processes have the same I/O pattern (either sequential or
-	 * random).  In fact, in such a scenario, the drive will tend
-	 * to treat the requests of each of these processes in about
-	 * the same way as the requests of the others, and thus to
-	 * provide each of these processes with about the same
-	 * throughput (which is exactly the desired throughput
-	 * distribution). In contrast, in any asymmetric scenario,
-	 * device idling is certainly needed to guarantee that bfqq
-	 * receives its assigned fraction of the device throughput
-	 * (see [1] for details).
+	 * symmetric scenario where:
+	 * (i)  each of these processes must get the same throughput as
+	 *      the others;
+	 * (ii) all these processes have the same I/O pattern
+		(either sequential or random).
+	 * In fact, in such a scenario, the drive will tend to treat
+	 * the requests of each of these processes in about the same
+	 * way as the requests of the others, and thus to provide
+	 * each of these processes with about the same throughput
+	 * (which is exactly the desired throughput distribution). In
+	 * contrast, in any asymmetric scenario, device idling is
+	 * certainly needed to guarantee that bfqq receives its
+	 * assigned fraction of the device throughput (see [1] for
+	 * details).
+	 *
+	 * We address this issue by controlling, actually, only the
+	 * symmetry sub-condition (i), i.e., provided that
+	 * sub-condition (i) holds, idling is not performed,
+	 * regardless of whether sub-condition (ii) holds. In other
+	 * words, only if sub-condition (i) holds, then idling is
+	 * allowed, and the device tends to be prevented from queueing
+	 * many requests, possibly of several processes. The reason
+	 * for not controlling also sub-condition (ii) is that we
+	 * exploit preemption to preserve guarantees in case of
+	 * symmetric scenarios, even if (ii) does not hold, as
+	 * explained in the next two paragraphs.
+	 *
+	 * Even if a queue, say Q, is expired when it remains idle, Q
+	 * can still preempt the new in-service queue if the next
+	 * request of Q arrives soon (see the comments on
+	 * bfq_bfqq_update_budg_for_activation). If all queues and
+	 * groups have the same weight, this form of preemption,
+	 * combined with the hole-recovery heuristic described in the
+	 * comments on function bfq_bfqq_update_budg_for_activation,
+	 * are enough to preserve a correct bandwidth distribution in
+	 * the mid term, even without idling. In fact, even if not
+	 * idling allows the internal queues of the device to contain
+	 * many requests, and thus to reorder requests, we can rather
+	 * safely assume that the internal scheduler still preserves a
+	 * minimum of mid-term fairness. The motivation for using
+	 * preemption instead of idling is that, by not idling,
+	 * service guarantees are preserved without minimally
+	 * sacrificing throughput. In other words, both a high
+	 * throughput and its desired distribution are obtained.
+	 *
+	 * More precisely, this preemption-based, idleless approach
+	 * provides fairness in terms of IOPS, and not sectors per
+	 * second. This can be seen with a simple example. Suppose
+	 * that there are two queues with the same weight, but that
+	 * the first queue receives requests of 8 sectors, while the
+	 * second queue receives requests of 1024 sectors. In
+	 * addition, suppose that each of the two queues contains at
+	 * most one request at a time, which implies that each queue
+	 * always remains idle after it is served. Finally, after
+	 * remaining idle, each queue receives very quickly a new
+	 * request. It follows that the two queues are served
+	 * alternatively, preempting each other if needed. This
+	 * implies that, although both queues have the same weight,
+	 * the queue with large requests receives a service that is
+	 * 1024/8 times as high as the service received by the other
+	 * queue.
 	 *
-	 * As for sub-condition (i), actually we check only whether
-	 * bfqq is being weight-raised. In fact, if bfqq is not being
-	 * weight-raised, we have that:
-	 * - if the process associated with bfqq is not I/O-bound, then
-	 *   it is not either latency- or throughput-critical; therefore
-	 *   idling is not needed for bfqq;
-	 * - if the process asociated with bfqq is I/O-bound, then
-	 *   idling is already granted with bfqq (see the comments on
-	 *   idling_boosts_thr).
+	 * On the other hand, device idling is performed, and thus
+	 * pure sector-domain guarantees are provided, for the
+	 * following queues, which are likely to need stronger
+	 * throughput guarantees: weight-raised queues, and queues
+	 * with a higher weight than other queues. When such queues
+	 * are active, sub-condition (i) is false, which triggers
+	 * device idling.
 	 *
-	 * We do not check sub-condition (ii) at all, i.e., the next
-	 * variable is true if and only if bfqq is being
-	 * weight-raised. We do not need to control sub-condition (ii)
-	 * for the following reason:
-	 * - if bfqq is being weight-raised, then idling is already
-	 *   guaranteed to bfqq by sub-condition (i);
-	 * - if bfqq is not being weight-raised, then idling is
-	 *   already guaranteed to bfqq (only) if it matters, i.e., if
-	 *   bfqq is associated to a currently I/O-bound process (see
-	 *   the above comment on sub-condition (i)).
+	 * According to the above considerations, the next variable is
+	 * true (only) if sub-condition (i) holds. To compute the
+	 * value of this variable, we not only use the return value of
+	 * the function bfq_symmetric_scenario(), but also check
+	 * whether bfqq is being weight-raised, because
+	 * bfq_symmetric_scenario() does not take into account also
+	 * weight-raised queues (see comments on
+	 * bfq_weights_tree_add()).
 	 *
 	 * As a side note, it is worth considering that the above
 	 * device-idling countermeasures may however fail in the
 	 * following unlucky scenario: if idling is (correctly)
-	 * disabled in a time period during which the symmetry
-	 * sub-condition holds, and hence the device is allowed to
+	 * disabled in a time period during which all symmetry
+	 * sub-conditions hold, and hence the device is allowed to
 	 * enqueue many requests, but at some later point in time some
 	 * sub-condition stops to hold, then it may become impossible
 	 * to let requests be served in the desired order until all
 	 * the requests already queued in the device have been served.
 	 */
-	asymmetric_scenario = bfqq->wr_coeff > 1;
+	asymmetric_scenario = bfqq->wr_coeff > 1 ||
+		!bfq_symmetric_scenario(bfqd);
 
 	/*
 	 * We have now all the components we need to compute the return
-- 
2.10.0
