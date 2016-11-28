Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35966 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755588AbcK1Vjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so21231629wma.3
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:49 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 13/23] lightnvm: remove gen_lun abstraction
Date: Mon, 28 Nov 2016 22:39:04 +0100
Message-Id: <20161128213914.12516-14-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

The gen_lun abstraction in the generic media manager was conceived on
the assumption that a single target would instantiated on top of it.
This has complicated target design to implement multi-instances. Remove
this abstraction and move its logic to nvm_lun, which manages physical
lun geometry and operations.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 85 +++++++++++++++++++++++------------------------
 drivers/lightnvm/gennvm.h | 16 +--------
 include/linux/lightnvm.h  | 10 ++++++
 3 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index aee5b72..3572ebb 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -223,13 +223,13 @@ static void gen_put_area(struct nvm_dev *dev, sector_t begin)
 static void gen_blocks_free(struct nvm_dev *dev)
 {
 	struct gen_dev *gn = dev->mp;
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	int i;
 
 	gen_for_each_lun(gn, lun, i) {
-		if (!lun->vlun.blocks)
+		if (!lun->blocks)
 			break;
-		vfree(lun->vlun.blocks);
+		vfree(lun->blocks);
 	}
 }
 
@@ -242,24 +242,24 @@ static void gen_luns_free(struct nvm_dev *dev)
 
 static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	int i;
 
-	gn->luns = kcalloc(dev->nr_luns, sizeof(struct gen_lun), GFP_KERNEL);
+	gn->luns = kcalloc(dev->nr_luns, sizeof(struct nvm_lun), GFP_KERNEL);
 	if (!gn->luns)
 		return -ENOMEM;
 
 	gen_for_each_lun(gn, lun, i) {
-		spin_lock_init(&lun->vlun.lock);
 		INIT_LIST_HEAD(&lun->free_list);
 		INIT_LIST_HEAD(&lun->used_list);
 		INIT_LIST_HEAD(&lun->bb_list);
 
-		lun->reserved_blocks = 2; /* for GC only */
-		lun->vlun.id = i;
-		lun->vlun.lun_id = i % dev->luns_per_chnl;
-		lun->vlun.chnl_id = i / dev->luns_per_chnl;
-		lun->vlun.nr_free_blocks = dev->blks_per_lun;
+		spin_lock_init(&lun->lock);
+
+		lun->id = i;
+		lun->lun_id = i % dev->luns_per_chnl;
+		lun->chnl_id = i / dev->luns_per_chnl;
+		lun->nr_free_blocks = dev->blks_per_lun;
 	}
 	return 0;
 }
@@ -268,7 +268,7 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 							u8 *blks, int nr_blks)
 {
 	struct nvm_dev *dev = gn->dev;
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	struct nvm_block *blk;
 	int i;
 
@@ -282,9 +282,10 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 		if (blks[i] == NVM_BLK_T_FREE)
 			continue;
 
-		blk = &lun->vlun.blocks[i];
+		blk = &lun->blocks[i];
 		list_move_tail(&blk->list, &lun->bb_list);
-		lun->vlun.nr_free_blocks--;
+		blk->state = NVM_BLK_ST_BAD;
+		lun->nr_free_blocks--;
 	}
 
 	return 0;
@@ -295,7 +296,7 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 	struct nvm_dev *dev = private;
 	struct gen_dev *gn = dev->mp;
 	u64 elba = slba + nlb;
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	struct nvm_block *blk;
 	u64 i;
 	int lun_id;
@@ -326,7 +327,7 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 		/* Calculate block offset into lun */
 		pba = pba - (dev->sec_per_lun * lun_id);
-		blk = &lun->vlun.blocks[div_u64(pba, dev->sec_per_blk)];
+		blk = &lun->blocks[div_u64(pba, dev->sec_per_blk)];
 
 		if (!blk->state) {
 			/* at this point, we don't know anything about the
@@ -335,7 +336,7 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 			 */
 			list_move_tail(&blk->list, &lun->used_list);
 			blk->state = NVM_BLK_ST_TGT;
-			lun->vlun.nr_free_blocks--;
+			lun->nr_free_blocks--;
 		}
 	}
 
@@ -344,7 +345,7 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	struct nvm_block *block;
 	sector_t lun_iter, blk_iter, cur_block_id = 0;
 	int ret, nr_blks;
@@ -356,19 +357,19 @@ static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 		return -ENOMEM;
 
 	gen_for_each_lun(gn, lun, lun_iter) {
-		lun->vlun.blocks = vzalloc(sizeof(struct nvm_block) *
+		lun->blocks = vzalloc(sizeof(struct nvm_block) *
 							dev->blks_per_lun);
-		if (!lun->vlun.blocks) {
+		if (!lun->blocks) {
 			kfree(blks);
 			return -ENOMEM;
 		}
 
 		for (blk_iter = 0; blk_iter < dev->blks_per_lun; blk_iter++) {
-			block = &lun->vlun.blocks[blk_iter];
+			block = &lun->blocks[blk_iter];
 
 			INIT_LIST_HEAD(&block->list);
 
-			block->lun = &lun->vlun;
+			block->lun = lun;
 			block->id = cur_block_id++;
 
 			list_add_tail(&block->list, &lun->free_list);
@@ -378,8 +379,8 @@ static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 			struct ppa_addr ppa;
 
 			ppa.ppa = 0;
-			ppa.g.ch = lun->vlun.chnl_id;
-			ppa.g.lun = lun->vlun.lun_id;
+			ppa.g.ch = lun->chnl_id;
+			ppa.g.lun = lun->lun_id;
 
 			ret = nvm_get_bb_tbl(dev, ppa, blks);
 			if (ret)
@@ -468,41 +469,39 @@ static void gen_unregister(struct nvm_dev *dev)
 }
 
 static struct nvm_block *gen_get_blk(struct nvm_dev *dev,
-				struct nvm_lun *vlun, unsigned long flags)
+				struct nvm_lun *lun, unsigned long flags)
 {
-	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
 	struct nvm_block *blk = NULL;
 	int is_gc = flags & NVM_IOTYPE_GC;
 
-	spin_lock(&vlun->lock);
+	spin_lock(&lun->lock);
 	if (list_empty(&lun->free_list)) {
 		pr_err_ratelimited("gen: lun %u have no free pages available",
-								lun->vlun.id);
+								lun->id);
 		goto out;
 	}
 
-	if (!is_gc && lun->vlun.nr_free_blocks < lun->reserved_blocks)
+	if (!is_gc && lun->nr_free_blocks < lun->reserved_blocks)
 		goto out;
 
 	blk = list_first_entry(&lun->free_list, struct nvm_block, list);
 
 	list_move_tail(&blk->list, &lun->used_list);
 	blk->state = NVM_BLK_ST_TGT;
-	lun->vlun.nr_free_blocks--;
+	lun->nr_free_blocks--;
 out:
-	spin_unlock(&vlun->lock);
+	spin_unlock(&lun->lock);
 	return blk;
 }
 
 static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
 {
-	struct nvm_lun *vlun = blk->lun;
-	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
+	struct nvm_lun *lun = blk->lun;
 
-	spin_lock(&vlun->lock);
+	spin_lock(&lun->lock);
 	if (blk->state & NVM_BLK_ST_TGT) {
 		list_move_tail(&blk->list, &lun->free_list);
-		lun->vlun.nr_free_blocks++;
+		lun->nr_free_blocks++;
 		blk->state = NVM_BLK_ST_FREE;
 	} else if (blk->state & NVM_BLK_ST_BAD) {
 		list_move_tail(&blk->list, &lun->bb_list);
@@ -513,13 +512,13 @@ static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
 							blk->id, blk->state);
 		list_move_tail(&blk->list, &lun->bb_list);
 	}
-	spin_unlock(&vlun->lock);
+	spin_unlock(&lun->lock);
 }
 
 static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 {
 	struct gen_dev *gn = dev->mp;
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	struct nvm_block *blk;
 
 	pr_debug("gen: ppa  (ch: %u lun: %u blk: %u pg: %u) -> %u\n",
@@ -537,7 +536,7 @@ static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 	}
 
 	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
-	blk = &lun->vlun.blocks[ppa.g.blk];
+	blk = &lun->blocks[ppa.g.blk];
 
 	/* will be moved to bb list on put_blk from target */
 	blk->state = type;
@@ -587,23 +586,23 @@ static struct nvm_lun *gen_get_lun(struct nvm_dev *dev, int lunid)
 	if (unlikely(lunid >= dev->nr_luns))
 		return NULL;
 
-	return &gn->luns[lunid].vlun;
+	return &gn->luns[lunid];
 }
 
 static void gen_lun_info_print(struct nvm_dev *dev)
 {
 	struct gen_dev *gn = dev->mp;
-	struct gen_lun *lun;
+	struct nvm_lun *lun;
 	unsigned int i;
 
 
 	gen_for_each_lun(gn, lun, i) {
-		spin_lock(&lun->vlun.lock);
+		spin_lock(&lun->lock);
 
 		pr_info("%s: lun%8u\t%u\n", dev->name, i,
-						lun->vlun.nr_free_blocks);
+						lun->nr_free_blocks);
 
-		spin_unlock(&lun->vlun.lock);
+		spin_unlock(&lun->lock);
 	}
 }
 
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
index 8ecfa81..d167f39 100644
--- a/drivers/lightnvm/gennvm.h
+++ b/drivers/lightnvm/gennvm.h
@@ -20,25 +20,11 @@
 
 #include <linux/lightnvm.h>
 
-struct gen_lun {
-	struct nvm_lun vlun;
-
-	int reserved_blocks;
-	/* lun block lists */
-	struct list_head used_list;	/* In-use blocks */
-	struct list_head free_list;	/* Not used blocks i.e. released
-					 * and ready for use
-					 */
-	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
-					 * free_list and used_list
-					 */
-};
-
 struct gen_dev {
 	struct nvm_dev *dev;
 
 	int nr_luns;
-	struct gen_lun *luns;
+	struct nvm_lun *luns;
 	struct list_head area_list;
 
 	struct mutex lock;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 98278a9..33940bd 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -275,7 +275,17 @@ struct nvm_lun {
 
 	spinlock_t lock;
 
+	/* lun block lists */
+	struct list_head used_list;	/* In-use blocks */
+	struct list_head free_list;	/* Not used blocks i.e. released
+					 * and ready for use
+					 */
+	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
+					 * free_list and used_list
+					 */
 	unsigned int nr_free_blocks;	/* Number of unused blocks */
+	int reserved_blocks;
+
 	struct nvm_block *blocks;
 };
 
-- 
2.9.3

