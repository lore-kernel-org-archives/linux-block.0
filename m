Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33033 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755636AbcK1Vjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so21228104wmu.0
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:54 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 18/23] lightnvm: eliminate nvm_block abstraction on mm
Date: Mon, 28 Nov 2016 22:39:09 +0100
Message-Id: <20161128213914.12516-19-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

In order to naturally support multi-target instances on an Open-Channel
SSD, targets should own the LUNs they get blocks from and manage
provisioning internally. This is done in several steps.

A part of this transformation is that targets manage their blocks
internally. This patch eliminates the nvm_block abstraction and moves
block management to the target logic. The rrpc target is transformed.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   |  10 +-
 drivers/lightnvm/gennvm.c | 205 +---------------------------------------
 drivers/lightnvm/rrpc.c   | 234 +++++++++++++++++++++++++++++++++-------------
 drivers/lightnvm/rrpc.h   |  23 +++--
 include/linux/lightnvm.h  |  48 +---------
 5 files changed, 191 insertions(+), 329 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 493ce03..691b16f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -176,12 +176,6 @@ static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 	return NULL;
 }
 
-void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
-{
-	return dev->mt->mark_blk(dev, ppa, type);
-}
-EXPORT_SYMBOL(nvm_mark_blk);
-
 int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
 								int type)
 {
@@ -215,9 +209,9 @@ int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
+int nvm_erase_blk(struct nvm_dev *dev, struct ppa_addr *p, int flags)
 {
-	return dev->mt->erase_blk(dev, blk, flags);
+	return dev->mt->erase_blk(dev, p, flags);
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index dd9afd7..19c3924 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -306,19 +306,6 @@ static void gen_put_area(struct nvm_dev *dev, sector_t begin)
 	spin_unlock(&dev->lock);
 }
 
-static void gen_blocks_free(struct nvm_dev *dev)
-{
-	struct gen_dev *gn = dev->mp;
-	struct nvm_lun *lun;
-	int i;
-
-	gen_for_each_lun(gn, lun, i) {
-		if (!lun->blocks)
-			break;
-		vfree(lun->blocks);
-	}
-}
-
 static void gen_luns_free(struct nvm_dev *dev)
 {
 	struct gen_dev *gn = dev->mp;
@@ -337,167 +324,17 @@ static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 		return -ENOMEM;
 
 	gen_for_each_lun(gn, lun, i) {
-		INIT_LIST_HEAD(&lun->free_list);
-		INIT_LIST_HEAD(&lun->used_list);
-		INIT_LIST_HEAD(&lun->bb_list);
 		INIT_LIST_HEAD(&lun->list);
 
-		spin_lock_init(&lun->lock);
-
 		lun->id = i;
 		lun->lun_id = i % geo->luns_per_chnl;
 		lun->chnl_id = i / geo->luns_per_chnl;
-		lun->nr_free_blocks = geo->blks_per_lun;
 	}
 	return 0;
 }
 
-static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
-							u8 *blks, int nr_blks)
-{
-	struct nvm_dev *dev = gn->dev;
-	struct nvm_lun *lun;
-	struct nvm_block *blk;
-	int i;
-
-	nr_blks = nvm_bb_tbl_fold(dev, blks, nr_blks);
-	if (nr_blks < 0)
-		return nr_blks;
-
-	lun = &gn->luns[(dev->geo.luns_per_chnl * ppa.g.ch) + ppa.g.lun];
-
-	for (i = 0; i < nr_blks; i++) {
-		if (blks[i] == NVM_BLK_T_FREE)
-			continue;
-
-		blk = &lun->blocks[i];
-		list_move_tail(&blk->list, &lun->bb_list);
-		blk->state = NVM_BLK_ST_BAD;
-		lun->nr_free_blocks--;
-	}
-
-	return 0;
-}
-
-static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
-{
-	struct nvm_dev *dev = private;
-	struct nvm_geo *geo = &dev->geo;
-	struct gen_dev *gn = dev->mp;
-	u64 elba = slba + nlb;
-	struct nvm_lun *lun;
-	struct nvm_block *blk;
-	u64 i;
-	int lun_id;
-
-	if (unlikely(elba > dev->total_secs)) {
-		pr_err("gen: L2P data from device is out of bounds!\n");
-		return -EINVAL;
-	}
-
-	for (i = 0; i < nlb; i++) {
-		u64 pba = le64_to_cpu(entries[i]);
-
-		if (unlikely(pba >= dev->total_secs && pba != U64_MAX)) {
-			pr_err("gen: L2P data entry is out of bounds!\n");
-			return -EINVAL;
-		}
-
-		/* Address zero is a special one. The first page on a disk is
-		 * protected. It often holds internal device boot
-		 * information.
-		 */
-		if (!pba)
-			continue;
-
-		/* resolve block from physical address */
-		lun_id = div_u64(pba, geo->sec_per_lun);
-		lun = &gn->luns[lun_id];
-
-		/* Calculate block offset into lun */
-		pba = pba - (geo->sec_per_lun * lun_id);
-		blk = &lun->blocks[div_u64(pba, geo->sec_per_blk)];
-
-		if (!blk->state) {
-			/* at this point, we don't know anything about the
-			 * block. It's up to the FTL on top to re-etablish the
-			 * block state. The block is assumed to be open.
-			 */
-			list_move_tail(&blk->list, &lun->used_list);
-			blk->state = NVM_BLK_ST_TGT;
-			lun->nr_free_blocks--;
-		}
-	}
-
-	return 0;
-}
-
-static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct nvm_lun *lun;
-	struct nvm_block *block;
-	sector_t lun_iter, blk_iter, cur_block_id = 0;
-	int ret, nr_blks;
-	u8 *blks;
-
-	nr_blks = geo->blks_per_lun * geo->plane_mode;
-	blks = kmalloc(nr_blks, GFP_KERNEL);
-	if (!blks)
-		return -ENOMEM;
-
-	gen_for_each_lun(gn, lun, lun_iter) {
-		lun->blocks = vzalloc(sizeof(struct nvm_block) *
-							geo->blks_per_lun);
-		if (!lun->blocks) {
-			kfree(blks);
-			return -ENOMEM;
-		}
-
-		for (blk_iter = 0; blk_iter < geo->blks_per_lun; blk_iter++) {
-			block = &lun->blocks[blk_iter];
-
-			INIT_LIST_HEAD(&block->list);
-
-			block->lun = lun;
-			block->id = cur_block_id++;
-
-			list_add_tail(&block->list, &lun->free_list);
-		}
-
-		if (dev->ops->get_bb_tbl) {
-			struct ppa_addr ppa;
-
-			ppa.ppa = 0;
-			ppa.g.ch = lun->chnl_id;
-			ppa.g.lun = lun->lun_id;
-
-			ret = nvm_get_bb_tbl(dev, ppa, blks);
-			if (ret)
-				pr_err("gen: could not get BB table\n");
-
-			ret = gen_block_bb(gn, ppa, blks, nr_blks);
-			if (ret)
-				pr_err("gen: BB table map failed\n");
-		}
-	}
-
-	if ((dev->identity.dom & NVM_RSP_L2P) && dev->ops->get_l2p_tbl) {
-		ret = dev->ops->get_l2p_tbl(dev, 0, dev->total_secs,
-							gen_block_map, dev);
-		if (ret) {
-			pr_err("gen: could not read L2P table.\n");
-			pr_warn("gen: default block initialization");
-		}
-	}
-
-	kfree(blks);
-	return 0;
-}
-
 static void gen_free(struct nvm_dev *dev)
 {
-	gen_blocks_free(dev);
 	gen_luns_free(dev);
 	kfree(dev->mp);
 	dev->mp = NULL;
@@ -528,12 +365,6 @@ static int gen_register(struct nvm_dev *dev)
 		goto err;
 	}
 
-	ret = gen_blocks_init(dev, gn);
-	if (ret) {
-		pr_err("gen: could not initialize blocks\n");
-		goto err;
-	}
-
 	return 1;
 err:
 	gen_free(dev);
@@ -558,34 +389,6 @@ static void gen_unregister(struct nvm_dev *dev)
 	module_put(THIS_MODULE);
 }
 
-static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct gen_dev *gn = dev->mp;
-	struct nvm_lun *lun;
-	struct nvm_block *blk;
-
-	pr_debug("gen: ppa  (ch: %u lun: %u blk: %u pg: %u) -> %u\n",
-			ppa.g.ch, ppa.g.lun, ppa.g.blk, ppa.g.pg, type);
-
-	if (unlikely(ppa.g.ch > geo->nr_chnls ||
-					ppa.g.lun > geo->luns_per_chnl ||
-					ppa.g.blk > geo->blks_per_lun)) {
-		WARN_ON_ONCE(1);
-		pr_err("gen: ppa broken (ch: %u > %u lun: %u > %u blk: %u > %u",
-				ppa.g.ch, geo->nr_chnls,
-				ppa.g.lun, geo->luns_per_chnl,
-				ppa.g.blk, geo->blks_per_lun);
-		return;
-	}
-
-	lun = &gn->luns[(geo->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
-	blk = &lun->blocks[ppa.g.blk];
-
-	/* will be moved to bb list on put_blk from target */
-	blk->state = type;
-}
-
 static void gen_end_io(struct nvm_rq *rqd)
 {
 	struct nvm_tgt_instance *ins = rqd->ins;
@@ -606,11 +409,9 @@ static int gen_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	return dev->ops->submit_io(dev, rqd);
 }
 
-static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
+static int gen_erase_blk(struct nvm_dev *dev, struct ppa_addr *p, int flags)
 {
-	struct ppa_addr addr = block_to_ppa(dev, blk);
-
-	return nvm_erase_ppa(dev, &addr, 1, flags);
+	return nvm_erase_ppa(dev, p, 1, flags);
 }
 
 static struct nvmm_type gen = {
@@ -626,8 +427,6 @@ static struct nvmm_type gen = {
 	.submit_io		= gen_submit_io,
 	.erase_blk		= gen_erase_blk,
 
-	.mark_blk		= gen_mark_blk,
-
 	.get_area		= gen_get_area,
 	.put_area		= gen_put_area,
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 165b9d3..a352285d 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -126,19 +126,21 @@ static int block_is_full(struct rrpc *rrpc, struct rrpc_block *rblk)
 static u64 block_to_rel_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvm_block *blk = rblk->parent;
-	int lun_blk = blk->id % (dev->geo.blks_per_lun * rrpc->nr_luns);
+	struct rrpc_lun *rlun = rblk->rlun;
+	struct nvm_lun *lun = rlun->parent;
 
-	return lun_blk * dev->geo.sec_per_blk;
+	return lun->id * dev->geo.sec_per_blk;
 }
 
 /* Calculate global addr for the given block */
 static u64 block_to_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvm_block *blk = rblk->parent;
+	struct nvm_geo *geo = &dev->geo;
+	struct rrpc_lun *rlun = rblk->rlun;
+	struct nvm_lun *lun = rlun->parent;
 
-	return blk->id * dev->geo.sec_per_blk;
+	return lun->id * geo->sec_per_lun + rblk->id * geo->sec_per_blk;
 }
 
 static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_tgt_dev *dev, u64 addr)
@@ -163,51 +165,46 @@ static void rrpc_set_lun_cur(struct rrpc_lun *rlun, struct rrpc_block *new_rblk,
 	*cur_rblk = new_rblk;
 }
 
-static struct nvm_block *__rrpc_get_blk(struct rrpc *rrpc,
+static struct rrpc_block *__rrpc_get_blk(struct rrpc *rrpc,
 							struct rrpc_lun *rlun)
 {
-	struct nvm_lun *lun = rlun->parent;
-	struct nvm_block *blk = NULL;
+	struct rrpc_block *rblk = NULL;
 
-	if (list_empty(&lun->free_list))
+	if (list_empty(&rlun->free_list))
 		goto out;
 
-	blk = list_first_entry(&lun->free_list, struct nvm_block, list);
+	rblk = list_first_entry(&rlun->free_list, struct rrpc_block, list);
 
-	list_move_tail(&blk->list, &lun->used_list);
-	blk->state = NVM_BLK_ST_TGT;
-	lun->nr_free_blocks--;
+	list_move_tail(&rblk->list, &rlun->used_list);
+	rblk->state = NVM_BLK_ST_TGT;
+	rlun->nr_free_blocks--;
 
 out:
-	return blk;
+	return rblk;
 }
 
 static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 							unsigned long flags)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvm_lun *lun = rlun->parent;
-	struct nvm_block *blk;
 	struct rrpc_block *rblk;
 	int is_gc = flags & NVM_IOTYPE_GC;
 
 	spin_lock(&rlun->lock);
-	if (!is_gc && lun->nr_free_blocks < rlun->reserved_blocks) {
+	if (!is_gc && rlun->nr_free_blocks < rlun->reserved_blocks) {
 		pr_err("nvm: rrpc: cannot give block to non GC request\n");
 		spin_unlock(&rlun->lock);
 		return NULL;
 	}
 
-	blk = __rrpc_get_blk(rrpc, rlun);
-	if (!blk) {
+	rblk = __rrpc_get_blk(rrpc, rlun);
+	if (!rblk) {
 		pr_err("nvm: rrpc: cannot get new block\n");
 		spin_unlock(&rlun->lock);
 		return NULL;
 	}
 	spin_unlock(&rlun->lock);
 
-	rblk = rrpc_get_rblk(rlun, blk->id);
-	blk->priv = rblk;
 	bitmap_zero(rblk->invalid_pages, dev->geo.sec_per_blk);
 	rblk->next_page = 0;
 	rblk->nr_invalid_pages = 0;
@@ -218,23 +215,23 @@ static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 
 static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	struct nvm_block *blk = rblk->parent;
 	struct rrpc_lun *rlun = rblk->rlun;
 	struct nvm_lun *lun = rlun->parent;
 
 	spin_lock(&rlun->lock);
-	if (blk->state & NVM_BLK_ST_TGT) {
-		list_move_tail(&blk->list, &lun->free_list);
-		lun->nr_free_blocks++;
-		blk->state = NVM_BLK_ST_FREE;
-	} else if (blk->state & NVM_BLK_ST_BAD) {
-		list_move_tail(&blk->list, &lun->bb_list);
-		blk->state = NVM_BLK_ST_BAD;
+	if (rblk->state & NVM_BLK_ST_TGT) {
+		list_move_tail(&rblk->list, &rlun->free_list);
+		rlun->nr_free_blocks++;
+		rblk->state = NVM_BLK_ST_FREE;
+	} else if (rblk->state & NVM_BLK_ST_BAD) {
+		list_move_tail(&rblk->list, &rlun->bb_list);
+		rblk->state = NVM_BLK_ST_BAD;
 	} else {
 		WARN_ON_ONCE(1);
-		pr_err("rrpc: erroneous block type (%lu -> %u)\n",
-							blk->id, blk->state);
-		list_move_tail(&blk->list, &lun->bb_list);
+		pr_err("rrpc: erroneous type (ch:%d,lun:%d,blk%d-> %u)\n",
+						lun->chnl_id, lun->lun_id,
+						rblk->id, rblk->state);
+		list_move_tail(&rblk->list, &rlun->bb_list);
 	}
 	spin_unlock(&rlun->lock);
 }
@@ -334,7 +331,7 @@ static int rrpc_move_valid_pages(struct rrpc *rrpc, struct rrpc_block *rblk)
 					    nr_sec_per_blk)) < nr_sec_per_blk) {
 
 		/* Lock laddr */
-		phys_addr = rblk->parent->id * nr_sec_per_blk + slot;
+		phys_addr = rrpc_blk_to_ppa(rrpc, rblk) + slot;
 
 try:
 		spin_lock(&rrpc->rev_lock);
@@ -422,14 +419,22 @@ static void rrpc_block_gc(struct work_struct *work)
 	struct rrpc_block *rblk = gcb->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
 	struct nvm_tgt_dev *dev = rrpc->dev;
+	struct ppa_addr ppa;
 
 	mempool_free(gcb, rrpc->gcb_pool);
-	pr_debug("nvm: block '%lu' being reclaimed\n", rblk->parent->id);
+	pr_debug("nvm: block 'ch:%d,lun:%d,blk:%d' being reclaimed\n",
+			rlun->parent->chnl_id, rlun->parent->lun_id,
+			rblk->id);
 
 	if (rrpc_move_valid_pages(rrpc, rblk))
 		goto put_back;
 
-	if (nvm_erase_blk(dev->parent, rblk->parent, 0))
+	ppa.ppa = 0;
+	ppa.g.ch = rlun->parent->chnl_id;
+	ppa.g.lun = rlun->parent->lun_id;
+	ppa.g.blk = rblk->id;
+
+	if (nvm_erase_blk(dev->parent, &ppa, 0))
 		goto put_back;
 
 	rrpc_put_blk(rrpc, rblk);
@@ -445,7 +450,7 @@ static void rrpc_block_gc(struct work_struct *work)
 /* the block with highest number of invalid pages, will be in the beginning
  * of the list
  */
-static struct rrpc_block *rblock_max_invalid(struct rrpc_block *ra,
+static struct rrpc_block *rblk_max_invalid(struct rrpc_block *ra,
 							struct rrpc_block *rb)
 {
 	if (ra->nr_invalid_pages == rb->nr_invalid_pages)
@@ -460,13 +465,13 @@ static struct rrpc_block *rblock_max_invalid(struct rrpc_block *ra,
 static struct rrpc_block *block_prio_find_max(struct rrpc_lun *rlun)
 {
 	struct list_head *prio_list = &rlun->prio_list;
-	struct rrpc_block *rblock, *max;
+	struct rrpc_block *rblk, *max;
 
 	BUG_ON(list_empty(prio_list));
 
 	max = list_first_entry(prio_list, struct rrpc_block, prio);
-	list_for_each_entry(rblock, prio_list, prio)
-		max = rblock_max_invalid(max, rblock);
+	list_for_each_entry(rblk, prio_list, prio)
+		max = rblk_max_invalid(max, rblk);
 
 	return max;
 }
@@ -476,7 +481,6 @@ static void rrpc_lun_gc(struct work_struct *work)
 	struct rrpc_lun *rlun = container_of(work, struct rrpc_lun, ws_gc);
 	struct rrpc *rrpc = rlun->rrpc;
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvm_lun *lun = rlun->parent;
 	struct rrpc_block_gc *gcb;
 	unsigned int nr_blocks_need;
 
@@ -486,26 +490,28 @@ static void rrpc_lun_gc(struct work_struct *work)
 		nr_blocks_need = rrpc->nr_luns;
 
 	spin_lock(&rlun->lock);
-	while (nr_blocks_need > lun->nr_free_blocks &&
+	while (nr_blocks_need > rlun->nr_free_blocks &&
 					!list_empty(&rlun->prio_list)) {
-		struct rrpc_block *rblock = block_prio_find_max(rlun);
-		struct nvm_block *block = rblock->parent;
+		struct rrpc_block *rblk = block_prio_find_max(rlun);
 
-		if (!rblock->nr_invalid_pages)
+		if (!rblk->nr_invalid_pages)
 			break;
 
 		gcb = mempool_alloc(rrpc->gcb_pool, GFP_ATOMIC);
 		if (!gcb)
 			break;
 
-		list_del_init(&rblock->prio);
+		list_del_init(&rblk->prio);
 
-		BUG_ON(!block_is_full(rrpc, rblock));
+		WARN_ON(!block_is_full(rrpc, rblk));
 
-		pr_debug("rrpc: selected block '%lu' for GC\n", block->id);
+		pr_debug("rrpc: selected block 'ch:%d,lun:%d,blk:%d' for GC\n",
+					rlun->parent->chnl_id,
+					rlun->parent->lun_id,
+					rblk->id);
 
 		gcb->rrpc = rrpc;
-		gcb->rblk = rblock;
+		gcb->rblk = rblk;
 		INIT_WORK(&gcb->ws_gc, rrpc_block_gc);
 
 		queue_work(rrpc->kgc_wq, &gcb->ws_gc);
@@ -530,8 +536,10 @@ static void rrpc_gc_queue(struct work_struct *work)
 	spin_unlock(&rlun->lock);
 
 	mempool_free(gcb, rrpc->gcb_pool);
-	pr_debug("nvm: block '%lu' is full, allow GC (sched)\n",
-							rblk->parent->id);
+	pr_debug("nvm: block 'ch:%d,lun:%d,blk:%d' full, allow GC (sched)\n",
+					rlun->parent->chnl_id,
+					rlun->parent->lun_id,
+					rblk->id);
 }
 
 static const struct block_device_operations rrpc_fops = {
@@ -555,8 +563,7 @@ static struct rrpc_lun *rrpc_get_lun_rr(struct rrpc *rrpc, int is_gc)
 	 * estimate.
 	 */
 	rrpc_for_each_lun(rrpc, rlun, i) {
-		if (rlun->parent->nr_free_blocks >
-					max_free->parent->nr_free_blocks)
+		if (rlun->nr_free_blocks > max_free->nr_free_blocks)
 			max_free = rlun;
 	}
 
@@ -613,14 +620,12 @@ static struct rrpc_addr *rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
 {
 	struct rrpc_lun *rlun;
 	struct rrpc_block *rblk, **cur_rblk;
-	struct nvm_lun *lun;
 	u64 paddr;
 	int gc_force = 0;
 
 	rlun = rrpc_get_lun_rr(rrpc, is_gc);
-	lun = rlun->parent;
 
-	if (!is_gc && lun->nr_free_blocks < rrpc->nr_luns * 4)
+	if (!is_gc && rlun->nr_free_blocks < rrpc->nr_luns * 4)
 		return NULL;
 
 	/*
@@ -701,22 +706,44 @@ static void rrpc_run_gc(struct rrpc *rrpc, struct rrpc_block *rblk)
 	queue_work(rrpc->kgc_wq, &gcb->ws_gc);
 }
 
-static void __rrpc_mark_bad_block(struct nvm_tgt_dev *dev, struct ppa_addr *ppa)
+static struct rrpc_lun *rrpc_ppa_to_lun(struct rrpc *rrpc, struct ppa_addr p)
 {
-		nvm_mark_blk(dev->parent, *ppa, NVM_BLK_ST_BAD);
-		nvm_set_bb_tbl(dev->parent, ppa, 1, NVM_BLK_T_GRWN_BAD);
+	struct rrpc_lun *rlun = NULL;
+	int i;
+
+	for (i = 0; i < rrpc->nr_luns; i++) {
+		if (rrpc->luns[i].parent->chnl_id == p.g.ch &&
+				rrpc->luns[i].parent->lun_id == p.g.lun) {
+			rlun = &rrpc->luns[i];
+			break;
+		}
+	}
+
+	return rlun;
+}
+
+static void __rrpc_mark_bad_block(struct rrpc *rrpc, struct ppa_addr ppa)
+{
+	struct nvm_tgt_dev *dev = rrpc->dev;
+	struct rrpc_lun *rlun;
+	struct rrpc_block *rblk;
+
+	rlun = rrpc_ppa_to_lun(rrpc, ppa);
+	rblk = &rlun->blocks[ppa.g.blk];
+	rblk->state = NVM_BLK_ST_BAD;
+
+	nvm_set_bb_tbl(dev->parent, &ppa, 1, NVM_BLK_T_GRWN_BAD);
 }
 
 static void rrpc_mark_bad_block(struct rrpc *rrpc, struct nvm_rq *rqd)
 {
-	struct nvm_tgt_dev *dev = rrpc->dev;
 	void *comp_bits = &rqd->ppa_status;
 	struct ppa_addr ppa, prev_ppa;
 	int nr_ppas = rqd->nr_ppas;
 	int bit;
 
 	if (rqd->nr_ppas == 1)
-		__rrpc_mark_bad_block(dev, &rqd->ppa_addr);
+		__rrpc_mark_bad_block(rrpc, rqd->ppa_addr);
 
 	ppa_set_empty(&prev_ppa);
 	bit = -1;
@@ -725,7 +752,7 @@ static void rrpc_mark_bad_block(struct rrpc *rrpc, struct nvm_rq *rqd)
 		if (ppa_cmp_blk(ppa, prev_ppa))
 			continue;
 
-		__rrpc_mark_bad_block(dev, &ppa);
+		__rrpc_mark_bad_block(rrpc, ppa);
 	}
 }
 
@@ -735,13 +762,11 @@ static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_addr *p;
 	struct rrpc_block *rblk;
-	struct nvm_lun *lun;
 	int cmnt_size, i;
 
 	for (i = 0; i < npages; i++) {
 		p = &rrpc->trans_map[laddr + i];
 		rblk = p->rblk;
-		lun = rblk->parent->lun;
 
 		cmnt_size = atomic_inc_return(&rblk->data_cmnt_size);
 		if (unlikely(cmnt_size == dev->geo.sec_per_blk))
@@ -1061,16 +1086,21 @@ static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_addr *addr = rrpc->trans_map + slba;
 	struct rrpc_rev_addr *raddr = rrpc->rev_trans_map;
+	struct rrpc_lun *rlun;
+	struct rrpc_block *rblk;
 	u64 i;
 
 	for (i = 0; i < nlb; i++) {
+		struct ppa_addr gaddr;
 		u64 pba = le64_to_cpu(entries[i]);
 		unsigned int mod;
+
 		/* LNVM treats address-spaces as silos, LBA and PBA are
 		 * equally large and zero-indexed.
 		 */
 		if (unlikely(pba >= dev->total_secs && pba != U64_MAX)) {
 			pr_err("nvm: L2P data entry is out of bounds!\n");
+			pr_err("nvm: Maybe loaded an old target L2P\n");
 			return -EINVAL;
 		}
 
@@ -1085,6 +1115,25 @@ static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 		addr[i].addr = pba;
 		raddr[mod].addr = slba + i;
+
+		gaddr = rrpc_ppa_to_gaddr(dev, pba);
+		rlun = rrpc_ppa_to_lun(rrpc, gaddr);
+		if (!rlun) {
+			pr_err("rrpc: l2p corruption on lba %llu\n",
+							slba + i);
+			return -EINVAL;
+		}
+
+		rblk = &rlun->blocks[gaddr.g.blk];
+		if (!rblk->state) {
+			/* at this point, we don't know anything about the
+			 * block. It's up to the FTL on top to re-etablish the
+			 * block state. The block is assumed to be open.
+			 */
+			list_move_tail(&rblk->list, &rlun->used_list);
+			rblk->state = NVM_BLK_ST_TGT;
+			rlun->nr_free_blocks--;
+		}
 	}
 
 	return 0;
@@ -1199,6 +1248,51 @@ static void rrpc_luns_free(struct rrpc *rrpc)
 	kfree(rrpc->luns);
 }
 
+static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
+{
+	struct nvm_geo *geo = &dev->geo;
+	struct rrpc_block *rblk;
+	struct ppa_addr ppa;
+	u8 *blks;
+	int nr_blks;
+	int i;
+	int ret;
+
+	nr_blks = geo->blks_per_lun * geo->plane_mode;
+	blks = kmalloc(nr_blks, GFP_KERNEL);
+	if (!blks)
+		return -ENOMEM;
+
+	ppa.ppa = 0;
+	ppa.g.ch = rlun->parent->chnl_id;
+	ppa.g.lun = rlun->parent->lun_id;
+
+	ret = nvm_get_bb_tbl(dev->parent, ppa, blks);
+	if (ret) {
+		pr_err("rrpc: could not get BB table\n");
+		goto out;
+	}
+
+	nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
+	if (nr_blks < 0)
+		return nr_blks;
+
+	rlun->nr_free_blocks = geo->blks_per_lun;
+	for (i = 0; i < nr_blks; i++) {
+		if (blks[i] == NVM_BLK_T_FREE)
+			continue;
+
+		rblk = &rlun->blocks[i];
+		list_move_tail(&rblk->list, &rlun->bb_list);
+		rblk->state = NVM_BLK_ST_BAD;
+		rlun->nr_free_blocks--;
+	}
+
+out:
+	kfree(blks);
+	return ret;
+}
+
 static int rrpc_luns_init(struct rrpc *rrpc, struct list_head *lun_list)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
@@ -1232,16 +1326,26 @@ static int rrpc_luns_init(struct rrpc *rrpc, struct list_head *lun_list)
 			goto err;
 		}
 
+		INIT_LIST_HEAD(&rlun->free_list);
+		INIT_LIST_HEAD(&rlun->used_list);
+		INIT_LIST_HEAD(&rlun->bb_list);
+
 		for (j = 0; j < geo->blks_per_lun; j++) {
 			struct rrpc_block *rblk = &rlun->blocks[j];
-			struct nvm_block *blk = &lun->blocks[j];
 
-			rblk->parent = blk;
+			rblk->id = j;
 			rblk->rlun = rlun;
+			rblk->state = NVM_BLK_T_FREE;
 			INIT_LIST_HEAD(&rblk->prio);
+			INIT_LIST_HEAD(&rblk->list);
 			spin_lock_init(&rblk->lock);
+
+			list_add_tail(&rblk->list, &rlun->free_list);
 		}
 
+		if (rrpc_bb_discovery(dev, rlun))
+			goto err;
+
 		rlun->reserved_blocks = 2; /* for GC only */
 
 		rlun->rrpc = rrpc;
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index 242d4c1..c55cec9 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -52,8 +52,7 @@ struct rrpc_rq {
 };
 
 struct rrpc_block {
-	unsigned long id;
-	struct nvm_block *parent;
+	int id;				/* id inside of LUN */
 	struct rrpc_lun *rlun;
 
 	struct list_head prio;		/* LUN CG list */
@@ -83,6 +82,16 @@ struct rrpc_lun {
 	struct list_head prio_list;	/* Blocks that may be GC'ed */
 	struct list_head wblk_list;	/* Queued blocks to be written to */
 
+	/* lun block lists */
+	struct list_head used_list;	/* In-use blocks */
+	struct list_head free_list;	/* Not used blocks i.e. released
+					 * and ready for use
+					 */
+	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
+					 * free_list and used_list
+					 */
+	unsigned int nr_free_blocks;	/* Number of unused blocks */
+
 	struct work_struct ws_gc;
 
 	int reserved_blocks;
@@ -155,14 +164,14 @@ struct rrpc_rev_addr {
 	u64 addr;
 };
 
-static inline struct rrpc_block *rrpc_get_rblk(struct rrpc_lun *rlun,
-								int blk_id)
+static inline u64 rrpc_blk_to_ppa(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	struct rrpc *rrpc = rlun->rrpc;
 	struct nvm_tgt_dev *dev = rrpc->dev;
-	int lun_blk = blk_id % dev->geo.blks_per_lun;
+	struct nvm_geo *geo = &dev->geo;
+	struct rrpc_lun *rlun = rblk->rlun;
+	struct nvm_lun *lun = rlun->parent;
 
-	return &rlun->blocks[lun_blk];
+	return (lun->id * geo->sec_per_lun) + (rblk->id * geo->sec_per_blk);
 }
 
 static inline sector_t rrpc_get_laddr(struct bio *bio)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ed04fa6..cc210cc 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -266,8 +266,6 @@ static inline void *nvm_rq_to_pdu(struct nvm_rq *rqdata)
 	return rqdata + 1;
 }
 
-struct nvm_block;
-
 struct nvm_lun {
 	int id;
 
@@ -275,19 +273,6 @@ struct nvm_lun {
 	int chnl_id;
 
 	struct list_head list;
-	spinlock_t lock;
-
-	/* lun block lists */
-	struct list_head used_list;	/* In-use blocks */
-	struct list_head free_list;	/* Not used blocks i.e. released
-					 * and ready for use
-					 */
-	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
-					 * free_list and used_list
-					 */
-	unsigned int nr_free_blocks;	/* Number of unused blocks */
-
-	struct nvm_block *blocks;
 };
 
 enum {
@@ -296,15 +281,6 @@ enum {
 	NVM_BLK_ST_BAD =	0x8,	/* Bad block */
 };
 
-struct nvm_block {
-	struct list_head list;
-	struct nvm_lun *lun;
-	unsigned long id;
-
-	void *priv;
-	int state;
-};
-
 /* system block cpu representation */
 struct nvm_sb_info {
 	unsigned long		seqnr;
@@ -473,21 +449,6 @@ static inline void ppa_set_empty(struct ppa_addr *ppa_addr)
 	ppa_addr->ppa = ADDR_EMPTY;
 }
 
-static inline struct ppa_addr block_to_ppa(struct nvm_dev *dev,
-							struct nvm_block *blk)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr ppa;
-	struct nvm_lun *lun = blk->lun;
-
-	ppa.ppa = 0;
-	ppa.g.blk = blk->id % geo->blks_per_lun;
-	ppa.g.lun = lun->lun_id;
-	ppa.g.ch = lun->chnl_id;
-
-	return ppa;
-}
-
 static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
 {
 	if (ppa_empty(ppa1) || ppa_empty(ppa2))
@@ -539,8 +500,7 @@ typedef void (nvmm_unregister_fn)(struct nvm_dev *);
 typedef int (nvmm_create_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_create *);
 typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
 typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
-typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
+typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct ppa_addr *, int);
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
 typedef void (nvmm_put_area_fn)(struct nvm_dev *, sector_t);
 
@@ -557,9 +517,6 @@ struct nvmm_type {
 	nvmm_submit_io_fn *submit_io;
 	nvmm_erase_blk_fn *erase_blk;
 
-	/* Bad block mgmt */
-	nvmm_mark_blk_fn *mark_blk;
-
 	nvmm_get_area_fn *get_area;
 	nvmm_put_area_fn *put_area;
 
@@ -573,7 +530,6 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-extern void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type);
 extern int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas,
 							int nr_ppas, int type);
 
@@ -584,7 +540,7 @@ extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int, int);
-extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *, int);
+extern int nvm_erase_blk(struct nvm_dev *, struct ppa_addr *, int);
 extern void nvm_end_io(struct nvm_rq *, int);
 extern int nvm_submit_ppa(struct nvm_dev *, struct ppa_addr *, int, int, int,
 								void *, int);
-- 
2.9.3

