Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeAQMfJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 07:35:09 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ming Lei <ming.lei@redhat.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] blk-mq: make sure hctx->next_cpu is set correctly
Date: Wed, 17 Jan 2018 20:34:43 +0800
Message-Id: <20180117123444.18393-2-ming.lei@redhat.com>
In-Reply-To: <20180117123444.18393-1-ming.lei@redhat.com>
References: <20180117123444.18393-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When hctx->next_cpu is set from possible online CPUs, there is one
race in which hctx->next_cpu may be set as >= nr_cpu_ids, and finally
break workqueue.

The race is triggered when one CPU is becoming DEAD, blk_mq_hctx_notify_dead()
is called to dispatch requests from the DEAD cpu context, but at that
time, this DEAD CPU has been cleared from 'cpu_online_mask', so all
CPUs in hctx->cpumask may become offline, and cause hctx->next_cpu set
a bad value.

This patch deals with this issue by re-selecting next CPU, and make
sure it is set correctly.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: "jianchao.wang" <jianchao.w.wang@oracle.com>
Tested-by: "jianchao.wang" <jianchao.w.wang@oracle.com>
Fixes: 20e4d81393 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c376d1b6309a..dc4066d28323 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1416,21 +1416,48 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
  */
 static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 {
+	bool tried = false;
+
 	if (hctx->queue->nr_hw_queues == 1)
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
 		int next_cpu;
-
+select_cpu:
 		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
 				cpu_online_mask);
 		if (next_cpu >= nr_cpu_ids)
 			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
 
-		hctx->next_cpu = next_cpu;
+		/*
+		 * No online CPU is found here, and this may happen when
+		 * running from blk_mq_hctx_notify_dead(), and make sure
+		 * hctx->next_cpu is set correctly for not breaking workqueue.
+		 */
+		if (next_cpu >= nr_cpu_ids)
+			hctx->next_cpu = cpumask_first(hctx->cpumask);
+		else
+			hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
 
+	/*
+	 * Do unbound schedule if we can't find a online CPU for this hctx,
+	 * and it should only happen in the path of handling CPU DEAD.
+	 */
+	if (!cpu_online(hctx->next_cpu)) {
+		if (!tried) {
+			tried = true;
+			goto select_cpu;
+		}
+
+		/*
+		 * Make sure to re-select CPU next time once after CPUs
+		 * in hctx->cpumask become online again.
+		 */
+		hctx->next_cpu_batch = 1;
+		return WORK_CPU_UNBOUND;
+	}
 	return hctx->next_cpu;
 }
 
-- 
2.9.5
