Return-Path: <krisman@linux.vnet.ibm.com>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Subject: [PATCH] blk-mq: Always schedule hctx->next_cpu
Date: Wed, 28 Sep 2016 00:24:24 -0300
Message-Id: <1475033064-31848-1-git-send-email-krisman@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

Commit 0e87e58bf60e ("blk-mq: improve warning for running a queue on the
wrong CPU") attempts to avoid triggering the WARN_ON in
__blk_mq_run_hw_queue when the expected CPU is dead.  Problem is, in the
last batch execution before round robin, blk_mq_hctx_next_cpu can
schedule a dead CPU and also update next_cpu to the next alive CPU in
the mask, which will trigger the WARN_ON despite the previous
workaround.

The following patch fixes this scenario by always scheduling the value
in hctx->next_cpu.  This changes the moment when we round-robin the CPU
running the hctx, but it really doesn't matter, since it still executes
BLK_MQ_CPU_WORK_BATCH times in a row before switching to another CPU.

Fixes: 0e87e58bf60e ("blk-mq: improve warning for running a queue on the wrong CPU")
Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
---
 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0be5577b0d56..367d21215345 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -883,7 +883,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
-		int cpu = hctx->next_cpu, next_cpu;
+		int next_cpu;
 
 		next_cpu = cpumask_next(hctx->next_cpu, hctx->cpumask);
 		if (next_cpu >= nr_cpu_ids)
@@ -891,8 +891,6 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
-
-		return cpu;
 	}
 
 	return hctx->next_cpu;
-- 
2.7.4
