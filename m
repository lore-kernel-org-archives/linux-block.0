Return-Path: <jiang.biao2@zte.com.cn>
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: [PATCH 1/2] blkcg: small fix on comment in blkcg_init_queue
Date: Thu, 19 Apr 2018 12:04:26 +0800
Message-Id: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
List-ID: <linux-block@vger.kernel.org>

The comment before blkg_create() in blkcg_init_queue() was moved
from blkcg_activate_policy() by commit ec13b1d6f0a0457312e615, but
it does not suit for the new context.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2b7f8d0..07e3359 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1134,11 +1134,7 @@ int blkcg_init_queue(struct request_queue *q)
 
 	preloaded = !radix_tree_preload(GFP_KERNEL);
 
-	/*
-	 * Make sure the root blkg exists and count the existing blkgs.  As
-	 * @q is bypassing at this point, blkg_lookup_create() can't be
-	 * used.  Open code insertion.
-	 */
+	/* Make sure the root blkg exists. */
 	rcu_read_lock();
 	spin_lock_irq(q->queue_lock);
 	blkg = blkg_create(&blkcg_root, q, new_blkg);
-- 
2.7.4
