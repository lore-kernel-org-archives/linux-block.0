Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36359 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbcGGHys (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id i4so3078148wmg.3
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:47 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 12/17] lightnvm: remove unused lists from struct rrpc_block
Date: Thu,  7 Jul 2016 09:54:18 +0200
Message-Id: <1467878063-22919-13-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The ->list, ->open_list, and ->closed_list lists were previously used
for statistics. However, their usage have been removed, and thus these
can safely be removed.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c | 9 ---------
 drivers/lightnvm/rrpc.h | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index c3a6f34..10ed22b 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -205,7 +205,6 @@ static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 	}
 
 	rblk = rrpc_get_rblk(rlun, blk->id);
-	list_add_tail(&rblk->list, &rlun->open_list);
 	spin_unlock(&lun->lock);
 
 	blk->priv = rblk;
@@ -224,7 +223,6 @@ static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 
 	spin_lock(&lun->lock);
 	nvm_put_blk_unlocked(rrpc->dev, rblk->parent);
-	list_del(&rblk->list);
 	spin_unlock(&lun->lock);
 }
 
@@ -511,16 +509,11 @@ static void rrpc_gc_queue(struct work_struct *work)
 	struct rrpc *rrpc = gcb->rrpc;
 	struct rrpc_block *rblk = gcb->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_lun *lun = rblk->parent->lun;
 
 	spin_lock(&rlun->lock);
 	list_add_tail(&rblk->prio, &rlun->prio_list);
 	spin_unlock(&rlun->lock);
 
-	spin_lock(&lun->lock);
-	list_move_tail(&rblk->list, &rlun->closed_list);
-	spin_unlock(&lun->lock);
-
 	mempool_free(gcb, rrpc->gcb_pool);
 	pr_debug("nvm: block '%lu' is full, allow GC (sched)\n",
 							rblk->parent->id);
@@ -1194,8 +1187,6 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 
 		rlun->rrpc = rrpc;
 		INIT_LIST_HEAD(&rlun->prio_list);
-		INIT_LIST_HEAD(&rlun->open_list);
-		INIT_LIST_HEAD(&rlun->closed_list);
 
 		INIT_WORK(&rlun->ws_gc, rrpc_lun_gc);
 		spin_lock_init(&rlun->lock);
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 5797343..448e39a 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -56,7 +56,6 @@ struct rrpc_block {
 	struct nvm_block *parent;
 	struct rrpc_lun *rlun;
 	struct list_head prio;
-	struct list_head list;
 
 #define MAX_INVALID_PAGES_STORAGE 8
 	/* Bitmap for invalid page intries */
@@ -77,13 +76,6 @@ struct rrpc_lun {
 	struct rrpc_block *blocks;	/* Reference to block allocation */
 
 	struct list_head prio_list;	/* Blocks that may be GC'ed */
-	struct list_head open_list;	/* In-use open blocks. These are blocks
-					 * that can be both written to and read
-					 * from
-					 */
-	struct list_head closed_list;	/* In-use closed blocks. These are
-					 * blocks that can _only_ be read from
-					 */
 
 	struct work_struct ws_gc;
 
-- 
2.1.4

