Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753541AbeAQQnM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 11:43:12 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ming Lei <ming.lei@redhat.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 2/2] blk-mq: avoid one WARN_ON in __blk_mq_run_hw_queue to printk
Date: Thu, 18 Jan 2018 00:41:52 +0800
Message-Id: <20180117164152.7066-3-ming.lei@redhat.com>
In-Reply-To: <20180117164152.7066-1-ming.lei@redhat.com>
References: <20180117164152.7066-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We know this WARN_ON is harmless and in reality it may be trigged,
so convert it to printk() and dump_stack() for avoiding to confuse
people.

Also add comment about two releated races here.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 69e73b4e32f3..480fc7623a5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1391,9 +1391,27 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
+	 *
+	 * There are at least two related races now between setting
+	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
+	 * __blk_mq_run_hw_queue():
+	 *
+	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
+	 *   but later it becomes online, then this warning is harmless
+	 *   at all
+	 *
+	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
+	 *   but later it becomes offline, then the warning can't be
+	 *   triggered, and we depend on blk-mq timeout handler to
+	 *   handle dispatched requests to this hctx
 	 */
-	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
-		cpu_online(hctx->next_cpu));
+	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
+		cpu_online(hctx->next_cpu)) {
+		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
+			raw_smp_processor_id(),
+			cpumask_empty(hctx->cpumask) ? "inactive": "active");
+		dump_stack();
+	}
 
 	/*
 	 * We can't run the queue inline with ints disabled. Ensure that
-- 
2.9.5
