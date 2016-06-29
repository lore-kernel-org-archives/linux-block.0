Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34114 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcF2OmX (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 29 Jun 2016 10:42:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so14890744wmz.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2016 07:42:16 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [RFC PATCH 08/11] lightnvm: remove _unlocked variant of [get/put]_blk
Date: Wed, 29 Jun 2016 16:41:53 +0200
Message-Id: <1467211316-22373-9-git-send-email-m@bjorling.me>
In-Reply-To: <1467211316-22373-1-git-send-email-m@bjorling.me>
References: <1467211316-22373-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The [get/put]_blk API enables targets to get ownership of blocks at
runtime. This information is currently not recorded on disk, and the
information is therefore lost on power failure. To restore the
metadata, the [get/put]_blk must persist its metadata. In that case,
we need to control the outer lock, so that we can disable them while
updating the on-disk metadata. Fortunately, the _unlocked versions can
be removed, which allows us to move the lock into the [get/put]_blk
functions.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   | 14 --------------
 drivers/lightnvm/gennvm.c | 32 ++++----------------------------
 drivers/lightnvm/rrpc.c   | 14 ++------------
 include/linux/lightnvm.h  |  6 ------
 4 files changed, 6 insertions(+), 60 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 04469e0..ddc8098 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -176,20 +176,6 @@ static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 	return NULL;
 }
 
-struct nvm_block *nvm_get_blk_unlocked(struct nvm_dev *dev, struct nvm_lun *lun,
-							unsigned long flags)
-{
-	return dev->mt->get_blk_unlocked(dev, lun, flags);
-}
-EXPORT_SYMBOL(nvm_get_blk_unlocked);
-
-/* Assumes that all valid pages have already been moved on release to bm */
-void nvm_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
-{
-	return dev->mt->put_blk_unlocked(dev, blk);
-}
-EXPORT_SYMBOL(nvm_put_blk_unlocked);
-
 struct nvm_block *nvm_get_blk(struct nvm_dev *dev, struct nvm_lun *lun,
 							unsigned long flags)
 {
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 41760b2..c65fb67 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -473,15 +473,14 @@ static void gen_unregister(struct nvm_dev *dev)
 	module_put(THIS_MODULE);
 }
 
-static struct nvm_block *gen_get_blk_unlocked(struct nvm_dev *dev,
+static struct nvm_block *gen_get_blk(struct nvm_dev *dev,
 				struct nvm_lun *vlun, unsigned long flags)
 {
 	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
 	struct nvm_block *blk = NULL;
 	int is_gc = flags & NVM_IOTYPE_GC;
 
-	assert_spin_locked(&vlun->lock);
-
+	spin_lock(&vlun->lock);
 	if (list_empty(&lun->free_list)) {
 		pr_err_ratelimited("gen: lun %u have no free pages available",
 								lun->vlun.id);
@@ -496,29 +495,17 @@ static struct nvm_block *gen_get_blk_unlocked(struct nvm_dev *dev,
 	list_move_tail(&blk->list, &lun->used_list);
 	blk->state = NVM_BLK_ST_TGT;
 	lun->vlun.nr_free_blocks--;
-
 out:
-	return blk;
-}
-
-static struct nvm_block *gen_get_blk(struct nvm_dev *dev,
-				struct nvm_lun *vlun, unsigned long flags)
-{
-	struct nvm_block *blk;
-
-	spin_lock(&vlun->lock);
-	blk = gen_get_blk_unlocked(dev, vlun, flags);
 	spin_unlock(&vlun->lock);
 	return blk;
 }
 
-static void gen_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
+static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
 {
 	struct nvm_lun *vlun = blk->lun;
 	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
 
-	assert_spin_locked(&vlun->lock);
-
+	spin_lock(&vlun->lock);
 	if (blk->state & NVM_BLK_ST_TGT) {
 		list_move_tail(&blk->list, &lun->free_list);
 		lun->vlun.nr_free_blocks++;
@@ -532,14 +519,6 @@ static void gen_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
 							blk->id, blk->state);
 		list_move_tail(&blk->list, &lun->bb_list);
 	}
-}
-
-static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
-{
-	struct nvm_lun *vlun = blk->lun;
-
-	spin_lock(&vlun->lock);
-	gen_put_blk_unlocked(dev, blk);
 	spin_unlock(&vlun->lock);
 }
 
@@ -669,9 +648,6 @@ static struct nvmm_type gen = {
 	.create_tgt		= gen_create_tgt,
 	.remove_tgt		= gen_remove_tgt,
 
-	.get_blk_unlocked	= gen_get_blk_unlocked,
-	.put_blk_unlocked	= gen_put_blk_unlocked,
-
 	.get_blk		= gen_get_blk,
 	.put_blk		= gen_put_blk,
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 10ed22b..fa8d5be 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -192,21 +192,16 @@ static void rrpc_set_lun_cur(struct rrpc_lun *rlun, struct rrpc_block *rblk)
 static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 							unsigned long flags)
 {
-	struct nvm_lun *lun = rlun->parent;
 	struct nvm_block *blk;
 	struct rrpc_block *rblk;
 
-	spin_lock(&lun->lock);
-	blk = nvm_get_blk_unlocked(rrpc->dev, rlun->parent, flags);
+	blk = nvm_get_blk(rrpc->dev, rlun->parent, flags);
 	if (!blk) {
 		pr_err("nvm: rrpc: cannot get new block from media manager\n");
-		spin_unlock(&lun->lock);
 		return NULL;
 	}
 
 	rblk = rrpc_get_rblk(rlun, blk->id);
-	spin_unlock(&lun->lock);
-
 	blk->priv = rblk;
 	bitmap_zero(rblk->invalid_pages, rrpc->dev->sec_per_blk);
 	rblk->next_page = 0;
@@ -218,12 +213,7 @@ static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 
 static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_lun *lun = rlun->parent;
-
-	spin_lock(&lun->lock);
-	nvm_put_blk_unlocked(rrpc->dev, rblk->parent);
-	spin_unlock(&lun->lock);
+	nvm_put_blk(rrpc->dev, rblk->parent);
 }
 
 static void rrpc_put_blks(struct rrpc *rrpc)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d619f6d..e9836cf 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -491,8 +491,6 @@ struct nvmm_type {
 	nvmm_remove_tgt_fn *remove_tgt;
 
 	/* Block administration callbacks */
-	nvmm_get_blk_fn *get_blk_unlocked;
-	nvmm_put_blk_fn *put_blk_unlocked;
 	nvmm_get_blk_fn *get_blk;
 	nvmm_put_blk_fn *put_blk;
 	nvmm_open_blk_fn *open_blk;
@@ -522,10 +520,6 @@ struct nvmm_type {
 extern int nvm_register_mgr(struct nvmm_type *);
 extern void nvm_unregister_mgr(struct nvmm_type *);
 
-extern struct nvm_block *nvm_get_blk_unlocked(struct nvm_dev *,
-					struct nvm_lun *, unsigned long);
-extern void nvm_put_blk_unlocked(struct nvm_dev *, struct nvm_block *);
-
 extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *,
 								unsigned long);
 extern void nvm_put_blk(struct nvm_dev *, struct nvm_block *);
-- 
2.1.4

