Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35660 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936547AbcJ0SBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 14:01:54 -0400
Received: by mail-lf0-f42.google.com with SMTP id f134so33663699lfg.2
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 11:01:53 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/7] lightnvm: manage block list on LUN owner
Date: Thu, 27 Oct 2016 20:01:35 +0200
Message-Id: <1477591299-26504-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
References: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

LUNs can be exclusively owned by a target through the media manager's
reserve_lun function. In this case, the target should implement its own
provisioning and manage internally the free/used/bad block list.

This patch introduces a LUN management structure that can be passed on
to LUN exclusive owners. The media manager is the default owner. On boot
up, it populates the lists with based on the device's bad block table
and sysblk metadata. Then, if the LUN is owned by a target, the
management structured is passed on to it. From this moment, the target
is responsible for list management. Thus, since LUNs are managed
strictly by the target, there is no need for the media manager to
reserve GC blocks.

As a FTL, rrpc owns exclusively its LUNs. Therefore, adapt rrpc to use
the new management interface.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c   |  5 ++--
 drivers/lightnvm/gennvm.c | 76 +++++++++++++++++++++++++++++++----------------
 drivers/lightnvm/gennvm.h | 19 ++++++------
 drivers/lightnvm/rrpc.c   | 74 ++++++++++++++++++++++++++++++++++++++-------
 drivers/lightnvm/rrpc.h   |  4 +++
 include/linux/lightnvm.h  | 21 +++++++++----
 6 files changed, 145 insertions(+), 54 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 1a6a7e6..4c6577e 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -178,10 +178,9 @@ static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 	return NULL;
 }
 
-struct nvm_block *nvm_get_blk(struct nvm_dev *dev, struct nvm_lun *lun,
-							unsigned long flags)
+struct nvm_block *nvm_get_blk(struct nvm_dev *dev, struct nvm_lun *lun)
 {
-	return dev->mt->get_blk(dev, lun, flags);
+	return dev->mt->get_blk(dev, lun);
 }
 EXPORT_SYMBOL(nvm_get_blk);
 
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index a7e17fa..8bff725 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -243,6 +243,7 @@ static void gen_luns_free(struct nvm_dev *dev)
 static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
 	struct gen_lun *lun;
+	struct nvm_lun_mgmt *mgmt;
 	int i;
 
 	gn->luns = kcalloc(dev->nr_luns, sizeof(struct gen_lun), GFP_KERNEL);
@@ -250,18 +251,31 @@ static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 		return -ENOMEM;
 
 	gen_for_each_lun(gn, lun, i) {
+		mgmt = kmalloc(sizeof(struct nvm_lun_mgmt), GFP_KERNEL);
+		if (!mgmt)
+			goto free;
+
+		lun->mgmt = mgmt;
+		lun->tgt = NULL;
+
 		spin_lock_init(&lun->vlun.lock);
-		INIT_LIST_HEAD(&lun->free_list);
-		INIT_LIST_HEAD(&lun->used_list);
-		INIT_LIST_HEAD(&lun->bb_list);
+		INIT_LIST_HEAD(&lun->mgmt->free_list);
+		INIT_LIST_HEAD(&lun->mgmt->used_list);
+		INIT_LIST_HEAD(&lun->mgmt->bb_list);
+		lun->mgmt->nr_free_blocks = dev->blks_per_lun;
 
-		lun->reserved_blocks = 2; /* for GC only */
 		lun->vlun.id = i;
 		lun->vlun.lun_id = i % dev->luns_per_chnl;
 		lun->vlun.chnl_id = i / dev->luns_per_chnl;
-		lun->vlun.nr_free_blocks = dev->blks_per_lun;
+		lun->vlun.priv = NULL;
 	}
 	return 0;
+
+free:
+	gen_for_each_lun(gn, lun, i)
+		kfree(lun->mgmt);
+
+	return -ENOMEM;
 }
 
 static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
@@ -279,12 +293,13 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
 
 	for (i = 0; i < nr_blks; i++) {
-		if (blks[i] == 0)
+		if (blks[i] == NVM_BLK_T_FREE && i > 0)
 			continue;
 
 		blk = &lun->vlun.blocks[i];
-		list_move_tail(&blk->list, &lun->bb_list);
-		lun->vlun.nr_free_blocks--;
+		list_move_tail(&blk->list, &lun->mgmt->bb_list);
+		blk->state = NVM_BLK_ST_BAD;
+		lun->mgmt->nr_free_blocks--;
 	}
 
 	return 0;
@@ -333,9 +348,9 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 			 * block. It's up to the FTL on top to re-etablish the
 			 * block state. The block is assumed to be open.
 			 */
-			list_move_tail(&blk->list, &lun->used_list);
+			list_move_tail(&blk->list, &lun->mgmt->used_list);
 			blk->state = NVM_BLK_ST_TGT;
-			lun->vlun.nr_free_blocks--;
+			lun->mgmt->nr_free_blocks--;
 		}
 	}
 
@@ -371,7 +386,7 @@ static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 			block->lun = &lun->vlun;
 			block->id = cur_block_id++;
 
-			list_add_tail(&block->list, &lun->free_list);
+			list_add_tail(&block->list, &lun->mgmt->free_list);
 		}
 
 		if (dev->ops->get_bb_tbl) {
@@ -467,30 +482,30 @@ static void gen_unregister(struct nvm_dev *dev)
 	module_put(THIS_MODULE);
 }
 
-static struct nvm_block *gen_get_blk(struct nvm_dev *dev,
-				struct nvm_lun *vlun, unsigned long flags)
+static struct nvm_block *gen_get_blk(struct nvm_dev *dev, struct nvm_lun *vlun)
 {
 	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
 	struct nvm_block *blk = NULL;
-	int is_gc = flags & NVM_IOTYPE_GC;
 
 	spin_lock(&vlun->lock);
-	if (list_empty(&lun->free_list)) {
-		pr_err_ratelimited("gen: lun %u have no free pages available",
-								lun->vlun.id);
+	if (test_bit(vlun->id, dev->lun_map)) {
+		pr_err("gen: bad get block - lun:%d not managed by mm\n",
+				vlun->id);
 		goto out;
 	}
 
-	if (!is_gc && lun->vlun.nr_free_blocks < lun->reserved_blocks)
+	if (list_empty(&lun->mgmt->free_list))
 		goto out;
 
-	blk = list_first_entry(&lun->free_list, struct nvm_block, list);
+	blk = list_first_entry(&lun->mgmt->free_list, struct nvm_block, list);
 
-	list_move_tail(&blk->list, &lun->used_list);
+	list_move_tail(&blk->list, &lun->mgmt->used_list);
 	blk->state = NVM_BLK_ST_TGT;
-	lun->vlun.nr_free_blocks--;
+	lun->mgmt->nr_free_blocks--;
+
 out:
 	spin_unlock(&vlun->lock);
+
 	return blk;
 }
 
@@ -500,19 +515,28 @@ static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
 	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
 
 	spin_lock(&vlun->lock);
+
+	if (test_bit(vlun->id, dev->lun_map)) {
+		pr_err("gen: bad put block - lun:%d not managed by mm\n",
+				vlun->id);
+		goto out;
+	}
+
 	if (blk->state & NVM_BLK_ST_TGT) {
-		list_move_tail(&blk->list, &lun->free_list);
-		lun->vlun.nr_free_blocks++;
+		list_move_tail(&blk->list, &lun->mgmt->free_list);
+		lun->mgmt->nr_free_blocks++;
 		blk->state = NVM_BLK_ST_FREE;
 	} else if (blk->state & NVM_BLK_ST_BAD) {
-		list_move_tail(&blk->list, &lun->bb_list);
+		list_move_tail(&blk->list, &lun->mgmt->bb_list);
 		blk->state = NVM_BLK_ST_BAD;
 	} else {
 		WARN_ON_ONCE(1);
 		pr_err("gen: erroneous block type (%lu -> %u)\n",
 							blk->id, blk->state);
-		list_move_tail(&blk->list, &lun->bb_list);
+		list_move_tail(&blk->list, &lun->mgmt->bb_list);
 	}
+
+out:
 	spin_unlock(&vlun->lock);
 }
 
@@ -625,7 +649,7 @@ static void gen_lun_info_print(struct nvm_dev *dev)
 		spin_lock(&lun->vlun.lock);
 
 		pr_info("%s: lun%8u\t%u\n", dev->name, i,
-						lun->vlun.nr_free_blocks);
+						lun->mgmt->nr_free_blocks);
 
 		spin_unlock(&lun->vlun.lock);
 	}
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
index 8ecfa81..f19d25a 100644
--- a/drivers/lightnvm/gennvm.h
+++ b/drivers/lightnvm/gennvm.h
@@ -23,15 +23,16 @@
 struct gen_lun {
 	struct nvm_lun vlun;
 
-	int reserved_blocks;
-	/* lun block lists */
-	struct list_head used_list;	/* In-use blocks */
-	struct list_head free_list;	/* Not used blocks i.e. released
-					 * and ready for use
-					 */
-	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
-					 * free_list and used_list
-					 */
+	/* A LUN can either be managed by the media manager if it is shared
+	 * among several used through the generic get/put block interface or
+	 * exclusively owned by a target. In this case, the target manages
+	 * the LUN. gen_lun always maintains a reference to the LUN management.
+	 *
+	 * Exclusive access is managed by the dev->lun_map bitmask. 0:
+	 * non-exclusive, 1: exclusive.
+	 */
+	struct nvm_lun_mgmt *mgmt;
+	struct nvm_target *tgt;
 };
 
 struct gen_dev {
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 067e890..f293d00 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -188,17 +188,45 @@ static void rrpc_set_lun_cur(struct rrpc_lun *rlun, struct rrpc_block *new_rblk,
 	*cur_rblk = new_rblk;
 }
 
+static struct nvm_block *__rrpc_get_blk(struct rrpc *rrpc,
+							struct rrpc_lun *rlun)
+{
+	struct nvm_block *blk = NULL;
+
+	if (list_empty(&rlun->mgmt->free_list))
+		goto out;
+
+	blk = list_first_entry(&rlun->mgmt->free_list, struct nvm_block, list);
+
+	list_move_tail(&blk->list, &rlun->mgmt->used_list);
+	blk->state = NVM_BLK_ST_TGT;
+	rlun->mgmt->nr_free_blocks--;
+
+out:
+	return blk;
+}
+
 static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 							unsigned long flags)
 {
 	struct nvm_block *blk;
 	struct rrpc_block *rblk;
+	int is_gc = flags & NVM_IOTYPE_GC;
 
-	blk = nvm_get_blk(rrpc->dev, rlun->parent, flags);
+	spin_lock(&rlun->lock);
+	if (!is_gc && rlun->mgmt->nr_free_blocks < rlun->reserved_blocks) {
+		pr_err("nvm: rrpc: cannot give block to non GC request\n");
+		spin_unlock(&rlun->lock);
+		return NULL;
+	}
+
+	blk = __rrpc_get_blk(rrpc, rlun);
 	if (!blk) {
-		pr_err("nvm: rrpc: cannot get new block from media manager\n");
+		pr_err("nvm: rrpc: cannot get new block\n");
+		spin_unlock(&rlun->lock);
 		return NULL;
 	}
+	spin_unlock(&rlun->lock);
 
 	rblk = rrpc_get_rblk(rlun, blk->id);
 	blk->priv = rblk;
@@ -212,7 +240,24 @@ static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 
 static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	nvm_put_blk(rrpc->dev, rblk->parent);
+	struct nvm_block *blk = rblk->parent;
+	struct rrpc_lun *rlun = rblk->rlun;
+
+	spin_lock(&rlun->lock);
+	if (blk->state & NVM_BLK_ST_TGT) {
+		list_move_tail(&blk->list, &rlun->mgmt->free_list);
+		rlun->mgmt->nr_free_blocks++;
+		blk->state = NVM_BLK_ST_FREE;
+	} else if (blk->state & NVM_BLK_ST_BAD) {
+		list_move_tail(&blk->list, &rlun->mgmt->bb_list);
+		blk->state = NVM_BLK_ST_BAD;
+	} else {
+		WARN_ON_ONCE(1);
+		pr_err("rrpc: erroneous block type (%lu -> %u)\n",
+							blk->id, blk->state);
+		list_move_tail(&blk->list, &rlun->mgmt->bb_list);
+	}
+	spin_unlock(&rlun->lock);
 }
 
 static void rrpc_put_blks(struct rrpc *rrpc)
@@ -450,7 +495,6 @@ static void rrpc_lun_gc(struct work_struct *work)
 {
 	struct rrpc_lun *rlun = container_of(work, struct rrpc_lun, ws_gc);
 	struct rrpc *rrpc = rlun->rrpc;
-	struct nvm_lun *lun = rlun->parent;
 	struct rrpc_block_gc *gcb;
 	unsigned int nr_blocks_need;
 
@@ -460,7 +504,7 @@ static void rrpc_lun_gc(struct work_struct *work)
 		nr_blocks_need = rrpc->nr_luns;
 
 	spin_lock(&rlun->lock);
-	while (nr_blocks_need > lun->nr_free_blocks &&
+	while (nr_blocks_need > rlun->mgmt->nr_free_blocks &&
 					!list_empty(&rlun->prio_list)) {
 		struct rrpc_block *rblock = block_prio_find_max(rlun);
 		struct nvm_block *block = rblock->parent;
@@ -529,8 +573,7 @@ static struct rrpc_lun *rrpc_get_lun_rr(struct rrpc *rrpc, int is_gc)
 	 * estimate.
 	 */
 	rrpc_for_each_lun(rrpc, rlun, i) {
-		if (rlun->parent->nr_free_blocks >
-					max_free->parent->nr_free_blocks)
+		if (rlun->mgmt->nr_free_blocks > max_free->mgmt->nr_free_blocks)
 			max_free = rlun;
 	}
 
@@ -587,14 +630,12 @@ static struct rrpc_addr *rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
 {
 	struct rrpc_lun *rlun;
 	struct rrpc_block *rblk, **cur_rblk;
-	struct nvm_lun *lun;
 	u64 paddr;
 	int gc_force = 0;
 
 	rlun = rrpc_get_lun_rr(rrpc, is_gc);
-	lun = rlun->parent;
 
-	if (!is_gc && lun->nr_free_blocks < rrpc->nr_luns * 4)
+	if (!is_gc && rlun->mgmt->nr_free_blocks < rrpc->nr_luns * 4)
 		return NULL;
 
 	/*
@@ -1175,11 +1216,20 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 		}
 
 		lun = dev->mt->get_lun(dev, lunid);
-		if (!lun)
+		if (!lun) {
+			pr_err("rrpc: cannot get lun %d\n", lun->id);
 			goto err;
+		}
+
+		if (!lun->priv) {
+			pr_err("rrpc: lun %d not allocated exclusively\n",
+								lun->id);
+			goto err;
+		}
 
 		rlun = &rrpc->luns[i];
 		rlun->parent = lun;
+		rlun->mgmt = lun->priv;
 		rlun->blocks = vzalloc(sizeof(struct rrpc_block) *
 						rrpc->dev->blks_per_lun);
 		if (!rlun->blocks) {
@@ -1197,6 +1247,8 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 			spin_lock_init(&rblk->lock);
 		}
 
+		rlun->reserved_blocks = 2; /* for GC only */
+
 		rlun->rrpc = rrpc;
 		INIT_LIST_HEAD(&rlun->prio_list);
 		INIT_LIST_HEAD(&rlun->wblk_list);
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 5e87d52..b8b3ad0 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -75,11 +75,15 @@ struct rrpc_lun {
 	struct rrpc_block *cur, *gc_cur;
 	struct rrpc_block *blocks;	/* Reference to block allocation */
 
+	struct nvm_lun_mgmt *mgmt;
+
 	struct list_head prio_list;	/* Blocks that may be GC'ed */
 	struct list_head wblk_list;	/* Queued blocks to be written to */
 
 	struct work_struct ws_gc;
 
+	int reserved_blocks;
+
 	spinlock_t lock;
 };
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d7da953..14c6fa5 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -273,8 +273,8 @@ struct nvm_lun {
 
 	spinlock_t lock;
 
-	unsigned int nr_free_blocks;	/* Number of unused blocks */
 	struct nvm_block *blocks;
+	void *priv;
 };
 
 enum {
@@ -452,6 +452,19 @@ struct nvm_tgt_type {
 	struct list_head list;
 };
 
+struct nvm_lun_mgmt {
+	/* lun block lists */
+	struct list_head used_list;	/* In-use blocks */
+	struct list_head free_list;	/* Not used blocks i.e. released
+					 * and ready for use
+					 */
+	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
+					 * free_list and used_list
+					 */
+
+	unsigned int nr_free_blocks;	/* Number of unused blocks */
+};
+
 extern struct nvm_tgt_type *nvm_find_target_type(const char *, int);
 
 extern int nvm_register_tgt_type(struct nvm_tgt_type *);
@@ -465,8 +478,7 @@ typedef void (nvmm_unregister_fn)(struct nvm_dev *);
 
 typedef int (nvmm_create_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_create *);
 typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
-typedef struct nvm_block *(nvmm_get_blk_fn)(struct nvm_dev *,
-					      struct nvm_lun *, unsigned long);
+typedef struct nvm_block *(nvmm_get_blk_fn)(struct nvm_dev *, struct nvm_lun *);
 typedef void (nvmm_put_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef int (nvmm_open_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef int (nvmm_close_blk_fn)(struct nvm_dev *, struct nvm_block *);
@@ -522,8 +534,7 @@ struct nvmm_type {
 extern int nvm_register_mgr(struct nvmm_type *);
 extern void nvm_unregister_mgr(struct nvmm_type *);
 
-extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *,
-								unsigned long);
+extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *);
 extern void nvm_put_blk(struct nvm_dev *, struct nvm_block *);
 
 extern struct nvm_dev *nvm_alloc_dev(int);
-- 
2.7.4

