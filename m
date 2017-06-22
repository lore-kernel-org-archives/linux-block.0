Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 22 Jun 2017 23:06:56 +0800
From: weiping <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq: remove double set queue_num
Message-ID: <20170622150656.GA26913@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

hwctx's queue_num has been set prior call blk_mq_init_hctx, so no need
set it again.

Signed-off-by: weiping <zhangweiping@didichuxing.com>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bb66c96..adcb79c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1900,7 +1900,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
 	hctx->queue = q;
-	hctx->queue_num = hctx_idx;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 
 	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
-- 
1.8.3.1
