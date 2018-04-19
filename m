Return-Path: <jiang.biao2@zte.com.cn>
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: [PATCH 2/2] blkcg: init root blkcg_gq under lock
Date: Thu, 19 Apr 2018 12:06:09 +0800
Message-Id: <1524110769-107033-1-git-send-email-jiang.biao2@zte.com.cn>
List-ID: <linux-block@vger.kernel.org>

The initializing of q->root_blkg is currently outside of queue lock
and rcu, so the blkg may be destroied before the initializing, which
may cause dangling/null references. On the other side, the destroys
of blkg are protected by queue lock or rcu. Put the initializing
inside the queue lock and rcu to make it safer.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 07e3359..ec86837 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1138,18 +1138,16 @@ int blkcg_init_queue(struct request_queue *q)
 	rcu_read_lock();
 	spin_lock_irq(q->queue_lock);
 	blkg = blkg_create(&blkcg_root, q, new_blkg);
+	if (IS_ERR(blkg))
+		goto err_unlock;
+	q->root_blkg = blkg;
+	q->root_rl.blkg = blkg;
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
 
 	if (preloaded)
 		radix_tree_preload_end();
 
-	if (IS_ERR(blkg))
-		return PTR_ERR(blkg);
-
-	q->root_blkg = blkg;
-	q->root_rl.blkg = blkg;
-
 	ret = blk_throtl_init(q);
 	if (ret) {
 		spin_lock_irq(q->queue_lock);
@@ -1157,6 +1155,13 @@ int blkcg_init_queue(struct request_queue *q)
 		spin_unlock_irq(q->queue_lock);
 	}
 	return ret;
+
+err_unlock:
+	spin_unlock_irq(q->queue_lock);
+	rcu_read_unlock();
+	if (preloaded)
+		radix_tree_preload_end();
+	return PTR_ERR(blkg);
 }
 
 /**
-- 
2.7.4
