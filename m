Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932867AbeALCyH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jan 2018 21:54:07 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each possisble CPU
Date: Fri, 12 Jan 2018 10:53:06 +0800
Message-Id: <20180112025306.28004-3-ming.lei@redhat.com>
In-Reply-To: <20180112025306.28004-1-ming.lei@redhat.com>
References: <20180112025306.28004-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The previous patch assigns interrupt vectors to all possible CPUs, so
now hctx can be mapped to possible CPUs, this patch applies this fact
to simplify queue mapping & schedule so that we don't need to handle
CPU hotplug for dealing with physical CPU plug & unplug. With this
simplication, we can work well on physical CPU plug & unplug, which
is a normal use case for VM at least.

Make sure we allocate blk_mq_ctx structures for all possible CPUs, and
set hctx->numa_node for possible CPUs which are mapped to this hctx. And
only choose the online CPUs for schedule.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
(merged the three into one because any single one may not work, and fix
selecting online CPUs for scheduler)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8000ba6db07d..ef9beca2d117 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -440,7 +440,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		blk_queue_exit(q);
 		return ERR_PTR(-EXDEV);
 	}
-	cpu = cpumask_first(alloc_data.hctx->cpumask);
+	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	rq = blk_mq_get_request(q, NULL, op, &alloc_data);
@@ -1323,9 +1323,10 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	if (--hctx->next_cpu_batch <= 0) {
 		int next_cpu;
 
-		next_cpu = cpumask_next(hctx->next_cpu, hctx->cpumask);
+		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
+				cpu_online_mask);
 		if (next_cpu >= nr_cpu_ids)
-			next_cpu = cpumask_first(hctx->cpumask);
+			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
 
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
@@ -2219,16 +2220,11 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
 
-		/* If the cpu isn't present, the cpu is mapped to first hctx */
-		if (!cpu_present(i))
-			continue;
-
-		hctx = blk_mq_map_queue(q, i);
-
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
 		 * not, we remain on the home node of the device
 		 */
+		hctx = blk_mq_map_queue(q, i);
 		if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
 			hctx->numa_node = local_memory_node(cpu_to_node(i));
 	}
@@ -2285,7 +2281,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	 *
 	 * If the cpu isn't present, the cpu is mapped to first hctx.
 	 */
-	for_each_present_cpu(i) {
+	for_each_possible_cpu(i) {
 		hctx_idx = q->mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
@@ -2339,7 +2335,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		/*
 		 * Initialize batch roundrobin counts
 		 */
-		hctx->next_cpu = cpumask_first(hctx->cpumask);
+		hctx->next_cpu = cpumask_first_and(hctx->cpumask,
+				cpu_online_mask);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
 }
-- 
2.9.5
