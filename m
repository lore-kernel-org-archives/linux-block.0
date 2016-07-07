Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33946 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933194AbcGGHyu (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so3535178wmz.1
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:49 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 14/17] lightnvm: make rrpc_map_page call nvm_get_blk outside locks
Date: Thu,  7 Jul 2016 09:54:20 +0200
Message-Id: <1467878063-22919-15-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The nvm_get_blk() function is called with rlun->lock held. This is ok
when the media manager implementation doesn't go out of its atomic
context. However, if a media manager persists its metadata, and
guarantees that the block is given to the target, this is no longer
a viable approach. Therefore, clean up the flow of rrpc_map_page,
and make sure that nvm_get_blk() is called without any locks acquired.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c | 108 +++++++++++++++++++++++++++++-------------------
 drivers/lightnvm/rrpc.h |   1 +
 2 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index fa8d5be..fa1ab04 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -175,18 +175,17 @@ static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_dev *dev, u64 addr)
 }
 
 /* requires lun->lock taken */
-static void rrpc_set_lun_cur(struct rrpc_lun *rlun, struct rrpc_block *rblk)
+static void rrpc_set_lun_cur(struct rrpc_lun *rlun, struct rrpc_block *new_rblk,
+						struct rrpc_block **cur_rblk)
 {
 	struct rrpc *rrpc = rlun->rrpc;
 
-	BUG_ON(!rblk);
-
-	if (rlun->cur) {
-		spin_lock(&rlun->cur->lock);
-		WARN_ON(!block_is_full(rrpc, rlun->cur));
-		spin_unlock(&rlun->cur->lock);
+	if (*cur_rblk) {
+		spin_lock(&(*cur_rblk)->lock);
+		WARN_ON(!block_is_full(rrpc, *cur_rblk));
+		spin_unlock(&(*cur_rblk)->lock);
 	}
-	rlun->cur = rblk;
+	*cur_rblk = new_rblk;
 }
 
 static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
@@ -577,21 +576,20 @@ out:
 	return addr;
 }
 
-/* Simple round-robin Logical to physical address translation.
+/* Map logical address to a physical page. The mapping implements a round robin
+ * approach and allocates a page from the next lun available.
  *
- * Retrieve the mapping using the active append point. Then update the ap for
- * the next write to the disk.
- *
- * Returns rrpc_addr with the physical address and block. Remember to return to
- * rrpc->addr_cache when request is finished.
+ * Returns rrpc_addr with the physical address and block. Returns NULL if no
+ * blocks in the next rlun are available.
  */
 static struct rrpc_addr *rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
 								int is_gc)
 {
 	struct rrpc_lun *rlun;
-	struct rrpc_block *rblk;
+	struct rrpc_block *rblk, **cur_rblk;
 	struct nvm_lun *lun;
 	u64 paddr;
+	int gc_force = 0;
 
 	rlun = rrpc_get_lun_rr(rrpc, is_gc);
 	lun = rlun->parent;
@@ -599,41 +597,65 @@ static struct rrpc_addr *rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
 	if (!is_gc && lun->nr_free_blocks < rrpc->nr_luns * 4)
 		return NULL;
 
-	spin_lock(&rlun->lock);
+	/*
+	 * page allocation steps:
+	 * 1. Try to allocate new page from current rblk
+	 * 2a. If succeed, proceed to map it in and return
+	 * 2b. If fail, first try to allocate a new block from media manger,
+	 *     and then retry step 1. Retry until the normal block pool is
+	 *     exhausted.
+	 * 3. If exhausted, and garbage collector is requesting the block,
+	 *    go to the reserved block and retry step 1.
+	 *    In the case that this fails as well, or it is not GC
+	 *    requesting, report not able to retrieve a block and let the
+	 *    caller handle further processing.
+	 */
 
+	spin_lock(&rlun->lock);
+	cur_rblk = &rlun->cur;
 	rblk = rlun->cur;
 retry:
 	paddr = rrpc_alloc_addr(rrpc, rblk);
 
-	if (paddr == ADDR_EMPTY) {
-		rblk = rrpc_get_blk(rrpc, rlun, 0);
-		if (rblk) {
-			rrpc_set_lun_cur(rlun, rblk);
-			goto retry;
-		}
+	if (paddr != ADDR_EMPTY)
+		goto done;
 
-		if (is_gc) {
-			/* retry from emergency gc block */
-			paddr = rrpc_alloc_addr(rrpc, rlun->gc_cur);
-			if (paddr == ADDR_EMPTY) {
-				rblk = rrpc_get_blk(rrpc, rlun, 1);
-				if (!rblk) {
-					pr_err("rrpc: no more blocks");
-					goto err;
-				}
+	if (!list_empty(&rlun->wblk_list)) {
+new_blk:
+		rblk = list_first_entry(&rlun->wblk_list, struct rrpc_block,
+									prio);
+		rrpc_set_lun_cur(rlun, rblk, cur_rblk);
+		list_del(&rblk->prio);
+		goto retry;
+	}
+	spin_unlock(&rlun->lock);
 
-				rlun->gc_cur = rblk;
-				paddr = rrpc_alloc_addr(rrpc, rlun->gc_cur);
-			}
-			rblk = rlun->gc_cur;
-		}
+	rblk = rrpc_get_blk(rrpc, rlun, gc_force);
+	if (rblk) {
+		spin_lock(&rlun->lock);
+		list_add_tail(&rblk->prio, &rlun->wblk_list);
+		/*
+		 * another thread might already have added a new block,
+		 * Therefore, make sure that one is used, instead of the
+		 * one just added.
+		 */
+		goto new_blk;
 	}
 
-	spin_unlock(&rlun->lock);
-	return rrpc_update_map(rrpc, laddr, rblk, paddr);
-err:
-	spin_unlock(&rlun->lock);
+	if (unlikely(is_gc) && !gc_force) {
+		/* retry from emergency gc block */
+		cur_rblk = &rlun->gc_cur;
+		rblk = rlun->gc_cur;
+		gc_force = 1;
+		spin_lock(&rlun->lock);
+		goto retry;
+	}
+
+	pr_err("rrpc: failed to allocate new block\n");
 	return NULL;
+done:
+	spin_unlock(&rlun->lock);
+	return rrpc_update_map(rrpc, laddr, rblk, paddr);
 }
 
 static void rrpc_run_gc(struct rrpc *rrpc, struct rrpc_block *rblk)
@@ -1177,6 +1199,7 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 
 		rlun->rrpc = rrpc;
 		INIT_LIST_HEAD(&rlun->prio_list);
+		INIT_LIST_HEAD(&rlun->wblk_list);
 
 		INIT_WORK(&rlun->ws_gc, rrpc_lun_gc);
 		spin_lock_init(&rlun->lock);
@@ -1317,14 +1340,13 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
 		rblk = rrpc_get_blk(rrpc, rlun, 0);
 		if (!rblk)
 			goto err;
-
-		rrpc_set_lun_cur(rlun, rblk);
+		rrpc_set_lun_cur(rlun, rblk, &rlun->cur);
 
 		/* Emergency gc block */
 		rblk = rrpc_get_blk(rrpc, rlun, 1);
 		if (!rblk)
 			goto err;
-		rlun->gc_cur = rblk;
+		rrpc_set_lun_cur(rlun, rblk, &rlun->gc_cur);
 	}
 
 	return 0;
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 448e39a..5e87d52 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -76,6 +76,7 @@ struct rrpc_lun {
 	struct rrpc_block *blocks;	/* Reference to block allocation */
 
 	struct list_head prio_list;	/* Blocks that may be GC'ed */
+	struct list_head wblk_list;	/* Queued blocks to be written to */
 
 	struct work_struct ws_gc;
 
-- 
2.1.4

