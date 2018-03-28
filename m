Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: only run mapped hw queues in blk_mq_run_hw_queues()
Date: Wed, 28 Mar 2018 09:20:35 +0800
Message-Id: <20180328012035.17565-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

>From commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule
with each possisble CPU") on, it should be easier to see unmapped hctx
in some CPU topo, such as, hctx may not be mapped to any CPU.

This patch avoids the warning in __blk_mq_delay_run_hw_queue() by
checking if the hctx is mapped in blk_mq_run_hw_queues().

blk_mq_run_hw_queues() is often run in SCSI or some driver's completion
path, so this warning has to be addressed.

Reported-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 16e83e6df404..48f25a63833b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1459,7 +1459,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (blk_mq_hctx_stopped(hctx))
+		if (blk_mq_hctx_stopped(hctx) || !blk_mq_hw_queue_mapped(hctx))
 			continue;
 
 		blk_mq_run_hw_queue(hctx, async);
-- 
2.9.5
