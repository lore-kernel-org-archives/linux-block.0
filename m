Return-Path: <prvs=541b0d852=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] blk-mq: Add locking annotations to hctx_lock() and hctx_unlock()
Date: Wed, 10 Jan 2018 11:34:27 -0800
Message-Id: <20180110193427.6601-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch avoids that sparse reports the following:

block/blk-mq.c:637:33: warning: context imbalance in 'hctx_unlock' - unexpected unlock
block/blk-mq.c:642:9: warning: context imbalance in 'hctx_lock' - wrong count at exit

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8139d88e78f6..1d705e25852e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -630,6 +630,7 @@ static void __blk_mq_complete_request(struct request *rq)
 }
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
+	__releases(hctx->srcu)
 {
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
 		rcu_read_unlock();
@@ -638,6 +639,7 @@ static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 }
 
 static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
+	__acquires(hctx->srcu)
 {
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		/* shut up gcc false positive */
-- 
2.15.1
