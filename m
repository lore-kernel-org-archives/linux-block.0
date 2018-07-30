Return-Path: <jin.xiao@intel.com>
From: xiao jin <jin.xiao@intel.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yanmin.zhang@intel.com,
	jin.xiao@intel.com
Subject: [PATCH] blk_init_allocated_queue() set q->fq as NULL in the fail case
Date: Mon, 30 Jul 2018 10:03:17 +0800
Message-Id: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
List-ID: <linux-block@vger.kernel.org>

We find the memory use-after-free issue in __blk_drain_queue()
on the kernel 4.14. After read the latest kernel 4.18-rc6 we
think it has the same problem.

Memory is allocated for q->fq in the blk_init_allocated_queue().
If the elevator init function called with error return, it will
run into the fail case to free the q->fq.

Then the __blk_drain_queue() uses the same memory after the free
of the q->fq, it will lead to the unpredictable event.

The patch is to set q->fq as NULL in the fail case of
blk_init_allocated_queue().

Signed-off-by: xiao jin <jin.xiao@intel.com>
---
 block/blk-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index b888175..52635e2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1072,6 +1072,7 @@ int blk_init_allocated_queue(struct request_queue *q)
 		q->exit_rq_fn(q, q->fq->flush_rq);
 out_free_flush_queue:
 	blk_free_flush_queue(q->fq);
+	q->fq = NULL;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(blk_init_allocated_queue);
-- 
1.7.9.5
