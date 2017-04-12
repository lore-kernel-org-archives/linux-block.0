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
Subject: [PATCH V4 08/16] block, bfq: preserve a low latency also with NCQ-capable drives
Date: Wed, 12 Apr 2017 18:23:14 +0200
Message-Id: <20170412162322.11139-9-paolo.valente@linaro.org>
In-Reply-To: <20170412162322.11139-1-paolo.valente@linaro.org>
References: <20170412162322.11139-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

I/O schedulers typically allow NCQ-capable drives to prefetch I/O
requests, as NCQ boosts the throughput exactly by prefetching and
internally reordering requests.

Unfortunately, as discussed in detail and shown experimentally in [1],
this may cause fairness and latency guarantees to be violated. The
main problem is that the internal scheduler of an NCQ-capable drive
may postpone the service of some unlucky (prefetched) requests as long
as it deems serving other requests more appropriate to boost the
throughput.

This patch addresses this issue by not disabling device idling for
weight-raised queues, even if the device supports NCQ. This allows BFQ
to start serving a new queue, and therefore allows the drive to
prefetch new requests, only after the idling timeout expires. At that
time, all the outstanding requests of the expired queue have been most
certainly served.

[1] P. Valente and M. Andreolini, "Improving Application
    Responsiveness with the BFQ Disk I/O Scheduler", Proceedings of
    the 5th Annual International Systems and Storage Conference
    (SYSTOR '12), June 2012.
    Slightly extended version:
    http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-
							results.pdf

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7f94ad3..574a5f6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6233,7 +6233,8 @@ static void bfq_update_idle_window(struct bfq_data *bfqd,
 
 	if (atomic_read(&bic->icq.ioc->active_ref) == 0 ||
 	    bfqd->bfq_slice_idle == 0 ||
-		(bfqd->hw_tag && BFQQ_SEEKY(bfqq)))
+		(bfqd->hw_tag && BFQQ_SEEKY(bfqq) &&
+			bfqq->wr_coeff == 1))
 		enable_idle = 0;
 	else if (bfq_sample_valid(bfqq->ttime.ttime_samples)) {
 		if (bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle &&
-- 
2.10.0
