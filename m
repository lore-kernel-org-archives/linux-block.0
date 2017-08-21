Return-Path: <lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] blk-mq: don't use WORK_CPU_UNBOUND
Date: Mon, 21 Aug 2017 15:49:51 +0200
Message-Id: <20170821134951.18848-2-lvivier@redhat.com>
In-Reply-To: <20170821134951.18848-1-lvivier@redhat.com>
References: <20170821134951.18848-1-lvivier@redhat.com>
List-ID: <linux-block@vger.kernel.org>

cpumask is the list of CPUs present when the queue is built.
If a new CPU is hotplugged, this list is not updated,
and when the scheduler asks for a CPU id, blk_mq_hctx_next_cpu()
can return WORK_CPU_UNBOUND.
And in this case _blk_mq_run_hw_queue() can be executed by the new CPU
(that is not present in cpumask) and raises the following warning:

    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
            cpu_online(hctx->next_cpu));

To fix this problem, this patch modifies blk_mq_hctx_next_cpu()
to only return a CPU id present in cpumask.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4603b115e234..bdac1e654814 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1126,9 +1126,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
  */
 static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 {
-	if (hctx->queue->nr_hw_queues == 1)
-		return WORK_CPU_UNBOUND;
-
 	if (--hctx->next_cpu_batch <= 0) {
 		int next_cpu;
 
-- 
2.13.5
