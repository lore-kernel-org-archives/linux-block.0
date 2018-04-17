Return-Path: <jiang.biao2@zte.com.cn>
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: [PATCH] blkcg: not hold blkcg lock when deactivating policy.
Date: Tue, 17 Apr 2018 15:10:33 +0800
Message-Id: <1523949033-91148-1-git-send-email-jiang.biao2@zte.com.cn>
List-ID: <linux-block@vger.kernel.org>

As described in the comment of blkcg_activate_policy(),
*Update of each blkg is protected by both queue and blkcg locks so
that holding either lock and testing blkcg_policy_enabled() is
always enough for dereferencing policy data.*
with queue lock held, there is no need to hold blkcg lock in
blkcg_deactivate_policy(). Similar case is in
blkcg_activate_policy(), which has removed holding of blkcg lock in
commit 4c55f4f9ad3001ac1fefdd8d8ca7641d18558e23.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c2033a2..2b7f8d0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1367,17 +1367,12 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	__clear_bit(pol->plid, q->blkcg_pols);
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
-		/* grab blkcg lock too while removing @pd from @blkg */
-		spin_lock(&blkg->blkcg->lock);
-
 		if (blkg->pd[pol->plid]) {
 			if (pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
-
-		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	spin_unlock_irq(q->queue_lock);
-- 
2.7.4
