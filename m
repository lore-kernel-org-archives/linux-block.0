Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36317 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933025AbcGGHyo (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id i4so3077816wmg.3
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:43 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 08/17] lightnvm: remove open/close statistics for gennvm
Date: Thu,  7 Jul 2016 09:54:14 +0200
Message-Id: <1467878063-22919-9-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The responsibility of the media manager is not to keep track of
open/closed blocks. This is better maintained within a target,
that already manages this information on writes.

Remove the statistics and merge the states NVM_BLK_ST_OPEN and
NVM_BLK_ST_CLOSED.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/gennvm.c | 31 ++++++-------------------------
 drivers/lightnvm/rrpc.c   |  5 -----
 include/linux/lightnvm.h  | 15 +++------------
 3 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index ec9fb68..1a3e164 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -122,9 +122,6 @@ static int gennvm_luns_init(struct nvm_dev *dev, struct gen_nvm *gn)
 		lun->vlun.lun_id = i % dev->luns_per_chnl;
 		lun->vlun.chnl_id = i / dev->luns_per_chnl;
 		lun->vlun.nr_free_blocks = dev->blks_per_lun;
-		lun->vlun.nr_open_blocks = 0;
-		lun->vlun.nr_closed_blocks = 0;
-		lun->vlun.nr_bad_blocks = 0;
 	}
 	return 0;
 }
@@ -149,7 +146,6 @@ static int gennvm_block_bb(struct gen_nvm *gn, struct ppa_addr ppa,
 
 		blk = &lun->vlun.blocks[i];
 		list_move_tail(&blk->list, &lun->bb_list);
-		lun->vlun.nr_bad_blocks++;
 		lun->vlun.nr_free_blocks--;
 	}
 
@@ -200,9 +196,8 @@ static int gennvm_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 			 * block state. The block is assumed to be open.
 			 */
 			list_move_tail(&blk->list, &lun->used_list);
-			blk->state = NVM_BLK_ST_OPEN;
+			blk->state = NVM_BLK_ST_TGT;
 			lun->vlun.nr_free_blocks--;
-			lun->vlun.nr_open_blocks++;
 		}
 	}
 
@@ -346,11 +341,10 @@ static struct nvm_block *gennvm_get_blk_unlocked(struct nvm_dev *dev,
 		goto out;
 
 	blk = list_first_entry(&lun->free_list, struct nvm_block, list);
+
 	list_move_tail(&blk->list, &lun->used_list);
-	blk->state = NVM_BLK_ST_OPEN;
-
+	blk->state = NVM_BLK_ST_TGT;
 	lun->vlun.nr_free_blocks--;
-	lun->vlun.nr_open_blocks++;
 
 out:
 	return blk;
@@ -374,27 +368,18 @@ static void gennvm_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
 
 	assert_spin_locked(&vlun->lock);
 
-	if (blk->state & NVM_BLK_ST_OPEN) {
+	if (blk->state & NVM_BLK_ST_TGT) {
 		list_move_tail(&blk->list, &lun->free_list);
-		lun->vlun.nr_open_blocks--;
-		lun->vlun.nr_free_blocks++;
-		blk->state = NVM_BLK_ST_FREE;
-	} else if (blk->state & NVM_BLK_ST_CLOSED) {
-		list_move_tail(&blk->list, &lun->free_list);
-		lun->vlun.nr_closed_blocks--;
 		lun->vlun.nr_free_blocks++;
 		blk->state = NVM_BLK_ST_FREE;
 	} else if (blk->state & NVM_BLK_ST_BAD) {
 		list_move_tail(&blk->list, &lun->bb_list);
-		lun->vlun.nr_bad_blocks++;
 		blk->state = NVM_BLK_ST_BAD;
 	} else {
 		WARN_ON_ONCE(1);
 		pr_err("gennvm: erroneous block type (%lu -> %u)\n",
 							blk->id, blk->state);
 		list_move_tail(&blk->list, &lun->bb_list);
-		lun->vlun.nr_bad_blocks++;
-		blk->state = NVM_BLK_ST_BAD;
 	}
 }
 
@@ -516,12 +501,8 @@ static void gennvm_lun_info_print(struct nvm_dev *dev)
 	gennvm_for_each_lun(gn, lun, i) {
 		spin_lock(&lun->vlun.lock);
 
-		pr_info("%s: lun%8u\t%u\t%u\t%u\t%u\n",
-				dev->name, i,
-				lun->vlun.nr_free_blocks,
-				lun->vlun.nr_open_blocks,
-				lun->vlun.nr_closed_blocks,
-				lun->vlun.nr_bad_blocks);
+		pr_info("%s: lun%8u\t%u\n", dev->name, i,
+						lun->vlun.nr_free_blocks);
 
 		spin_unlock(&lun->vlun.lock);
 	}
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 90c7cb4..c3a6f34 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -512,17 +512,12 @@ static void rrpc_gc_queue(struct work_struct *work)
 	struct rrpc_block *rblk = gcb->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
 	struct nvm_lun *lun = rblk->parent->lun;
-	struct nvm_block *blk = rblk->parent;
 
 	spin_lock(&rlun->lock);
 	list_add_tail(&rblk->prio, &rlun->prio_list);
 	spin_unlock(&rlun->lock);
 
 	spin_lock(&lun->lock);
-	lun->nr_open_blocks--;
-	lun->nr_closed_blocks++;
-	blk->state &= ~NVM_BLK_ST_OPEN;
-	blk->state |= NVM_BLK_ST_CLOSED;
 	list_move_tail(&rblk->list, &rlun->closed_list);
 	spin_unlock(&lun->lock);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index cee4c8d..8b51d57 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -269,24 +269,15 @@ struct nvm_lun {
 	int lun_id;
 	int chnl_id;
 
-	/* It is up to the target to mark blocks as closed. If the target does
-	 * not do it, all blocks are marked as open, and nr_open_blocks
-	 * represents the number of blocks in use
-	 */
-	unsigned int nr_open_blocks;	/* Number of used, writable blocks */
-	unsigned int nr_closed_blocks;	/* Number of used, read-only blocks */
+	spinlock_t lock;
+
 	unsigned int nr_free_blocks;	/* Number of unused blocks */
-	unsigned int nr_bad_blocks;	/* Number of bad blocks */
-
-	spinlock_t lock;
-
 	struct nvm_block *blocks;
 };
 
 enum {
 	NVM_BLK_ST_FREE =	0x1,	/* Free block */
-	NVM_BLK_ST_OPEN =	0x2,	/* Open block - read-write */
-	NVM_BLK_ST_CLOSED =	0x4,	/* Closed block - read-only */
+	NVM_BLK_ST_TGT =	0x2,	/* Block in use by target */
 	NVM_BLK_ST_BAD =	0x8,	/* Bad block */
 };
 
-- 
2.1.4

