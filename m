Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36329 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933143AbcGGHyp (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id i4so3077898wmg.3
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:44 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 09/17] lightnvm: rename gennvm and update description
Date: Thu,  7 Jul 2016 09:54:15 +0200
Message-Id: <1467878063-22919-10-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The generic manager should be called the general media manager, and
instead of using the rather long name of "gennvm" in front of each data
structures, use "gen" instead to shorten it. Update the description of
the media manager as well to make the media manager purpose clearer.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/Kconfig  |  10 ++-
 drivers/lightnvm/gennvm.c | 184 +++++++++++++++++++++++-----------------------
 drivers/lightnvm/gennvm.h |   7 +-
 3 files changed, 102 insertions(+), 99 deletions(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 85a3390..61c68a1 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -27,11 +27,13 @@ config NVM_DEBUG
 	It is required to create/remove targets without IOCTLs.
 
 config NVM_GENNVM
-	tristate "Generic NVM manager for Open-Channel SSDs"
+	tristate "General Non-Volatile Memory Manager for Open-Channel SSDs"
 	---help---
-	NVM media manager for Open-Channel SSDs that offload management
-	functionality to device, while keeping data placement and garbage
-	collection decisions on the host.
+	Non-volatile memory media manager for Open-Channel SSDs that implements
+	physical media metadata management and block provisioning API.
+
+	This is the standard media manager for using Open-Channel SSDs, and
+	required for targets to be instantiated.
 
 config NVM_RRPC
 	tristate "Round-robin Hybrid Open-Channel SSD target"
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 1a3e164..3d2762f 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -15,22 +15,22 @@
  * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
  * USA.
  *
- * Implementation of a generic nvm manager for Open-Channel SSDs.
+ * Implementation of a general nvm manager for Open-Channel SSDs.
  */
 
 #include "gennvm.h"
 
-static int gennvm_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
+static int gen_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
 {
-	struct gen_nvm *gn = dev->mp;
-	struct gennvm_area *area, *prev, *next;
+	struct gen_dev *gn = dev->mp;
+	struct gen_area *area, *prev, *next;
 	sector_t begin = 0;
 	sector_t max_sectors = (dev->sec_size * dev->total_secs) >> 9;
 
 	if (len > max_sectors)
 		return -EINVAL;
 
-	area = kmalloc(sizeof(struct gennvm_area), GFP_KERNEL);
+	area = kmalloc(sizeof(struct gen_area), GFP_KERNEL);
 	if (!area)
 		return -ENOMEM;
 
@@ -64,10 +64,10 @@ static int gennvm_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
 	return 0;
 }
 
-static void gennvm_put_area(struct nvm_dev *dev, sector_t begin)
+static void gen_put_area(struct nvm_dev *dev, sector_t begin)
 {
-	struct gen_nvm *gn = dev->mp;
-	struct gennvm_area *area;
+	struct gen_dev *gn = dev->mp;
+	struct gen_area *area;
 
 	spin_lock(&dev->lock);
 	list_for_each_entry(area, &gn->area_list, list) {
@@ -82,27 +82,27 @@ static void gennvm_put_area(struct nvm_dev *dev, sector_t begin)
 	spin_unlock(&dev->lock);
 }
 
-static void gennvm_blocks_free(struct nvm_dev *dev)
+static void gen_blocks_free(struct nvm_dev *dev)
 {
-	struct gen_nvm *gn = dev->mp;
+	struct gen_dev *gn = dev->mp;
 	struct gen_lun *lun;
 	int i;
 
-	gennvm_for_each_lun(gn, lun, i) {
+	gen_for_each_lun(gn, lun, i) {
 		if (!lun->vlun.blocks)
 			break;
 		vfree(lun->vlun.blocks);
 	}
 }
 
-static void gennvm_luns_free(struct nvm_dev *dev)
+static void gen_luns_free(struct nvm_dev *dev)
 {
-	struct gen_nvm *gn = dev->mp;
+	struct gen_dev *gn = dev->mp;
 
 	kfree(gn->luns);
 }
 
-static int gennvm_luns_init(struct nvm_dev *dev, struct gen_nvm *gn)
+static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
 	struct gen_lun *lun;
 	int i;
@@ -111,7 +111,7 @@ static int gennvm_luns_init(struct nvm_dev *dev, struct gen_nvm *gn)
 	if (!gn->luns)
 		return -ENOMEM;
 
-	gennvm_for_each_lun(gn, lun, i) {
+	gen_for_each_lun(gn, lun, i) {
 		spin_lock_init(&lun->vlun.lock);
 		INIT_LIST_HEAD(&lun->free_list);
 		INIT_LIST_HEAD(&lun->used_list);
@@ -126,7 +126,7 @@ static int gennvm_luns_init(struct nvm_dev *dev, struct gen_nvm *gn)
 	return 0;
 }
 
-static int gennvm_block_bb(struct gen_nvm *gn, struct ppa_addr ppa,
+static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 							u8 *blks, int nr_blks)
 {
 	struct nvm_dev *dev = gn->dev;
@@ -152,10 +152,10 @@ static int gennvm_block_bb(struct gen_nvm *gn, struct ppa_addr ppa,
 	return 0;
 }
 
-static int gennvm_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
+static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 {
 	struct nvm_dev *dev = private;
-	struct gen_nvm *gn = dev->mp;
+	struct gen_dev *gn = dev->mp;
 	u64 elba = slba + nlb;
 	struct gen_lun *lun;
 	struct nvm_block *blk;
@@ -163,7 +163,7 @@ static int gennvm_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 	int lun_id;
 
 	if (unlikely(elba > dev->total_secs)) {
-		pr_err("gennvm: L2P data from device is out of bounds!\n");
+		pr_err("gen: L2P data from device is out of bounds!\n");
 		return -EINVAL;
 	}
 
@@ -171,7 +171,7 @@ static int gennvm_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 		u64 pba = le64_to_cpu(entries[i]);
 
 		if (unlikely(pba >= dev->total_secs && pba != U64_MAX)) {
-			pr_err("gennvm: L2P data entry is out of bounds!\n");
+			pr_err("gen: L2P data entry is out of bounds!\n");
 			return -EINVAL;
 		}
 
@@ -204,7 +204,7 @@ static int gennvm_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 	return 0;
 }
 
-static int gennvm_blocks_init(struct nvm_dev *dev, struct gen_nvm *gn)
+static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
 	struct gen_lun *lun;
 	struct nvm_block *block;
@@ -217,7 +217,7 @@ static int gennvm_blocks_init(struct nvm_dev *dev, struct gen_nvm *gn)
 	if (!blks)
 		return -ENOMEM;
 
-	gennvm_for_each_lun(gn, lun, lun_iter) {
+	gen_for_each_lun(gn, lun, lun_iter) {
 		lun->vlun.blocks = vzalloc(sizeof(struct nvm_block) *
 							dev->blks_per_lun);
 		if (!lun->vlun.blocks) {
@@ -251,20 +251,20 @@ static int gennvm_blocks_init(struct nvm_dev *dev, struct gen_nvm *gn)
 
 			ret = nvm_get_bb_tbl(dev, ppa, blks);
 			if (ret)
-				pr_err("gennvm: could not get BB table\n");
+				pr_err("gen: could not get BB table\n");
 
-			ret = gennvm_block_bb(gn, ppa, blks, nr_blks);
+			ret = gen_block_bb(gn, ppa, blks, nr_blks);
 			if (ret)
-				pr_err("gennvm: BB table map failed\n");
+				pr_err("gen: BB table map failed\n");
 		}
 	}
 
 	if ((dev->identity.dom & NVM_RSP_L2P) && dev->ops->get_l2p_tbl) {
 		ret = dev->ops->get_l2p_tbl(dev, 0, dev->total_secs,
-							gennvm_block_map, dev);
+							gen_block_map, dev);
 		if (ret) {
-			pr_err("gennvm: could not read L2P table.\n");
-			pr_warn("gennvm: default block initialization");
+			pr_err("gen: could not read L2P table.\n");
+			pr_warn("gen: default block initialization");
 		}
 	}
 
@@ -272,23 +272,23 @@ static int gennvm_blocks_init(struct nvm_dev *dev, struct gen_nvm *gn)
 	return 0;
 }
 
-static void gennvm_free(struct nvm_dev *dev)
+static void gen_free(struct nvm_dev *dev)
 {
-	gennvm_blocks_free(dev);
-	gennvm_luns_free(dev);
+	gen_blocks_free(dev);
+	gen_luns_free(dev);
 	kfree(dev->mp);
 	dev->mp = NULL;
 }
 
-static int gennvm_register(struct nvm_dev *dev)
+static int gen_register(struct nvm_dev *dev)
 {
-	struct gen_nvm *gn;
+	struct gen_dev *gn;
 	int ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
-	gn = kzalloc(sizeof(struct gen_nvm), GFP_KERNEL);
+	gn = kzalloc(sizeof(struct gen_dev), GFP_KERNEL);
 	if (!gn)
 		return -ENOMEM;
 
@@ -297,32 +297,32 @@ static int gennvm_register(struct nvm_dev *dev)
 	INIT_LIST_HEAD(&gn->area_list);
 	dev->mp = gn;
 
-	ret = gennvm_luns_init(dev, gn);
+	ret = gen_luns_init(dev, gn);
 	if (ret) {
-		pr_err("gennvm: could not initialize luns\n");
+		pr_err("gen: could not initialize luns\n");
 		goto err;
 	}
 
-	ret = gennvm_blocks_init(dev, gn);
+	ret = gen_blocks_init(dev, gn);
 	if (ret) {
-		pr_err("gennvm: could not initialize blocks\n");
+		pr_err("gen: could not initialize blocks\n");
 		goto err;
 	}
 
 	return 1;
 err:
-	gennvm_free(dev);
+	gen_free(dev);
 	module_put(THIS_MODULE);
 	return ret;
 }
 
-static void gennvm_unregister(struct nvm_dev *dev)
+static void gen_unregister(struct nvm_dev *dev)
 {
-	gennvm_free(dev);
+	gen_free(dev);
 	module_put(THIS_MODULE);
 }
 
-static struct nvm_block *gennvm_get_blk_unlocked(struct nvm_dev *dev,
+static struct nvm_block *gen_get_blk_unlocked(struct nvm_dev *dev,
 				struct nvm_lun *vlun, unsigned long flags)
 {
 	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
@@ -332,7 +332,7 @@ static struct nvm_block *gennvm_get_blk_unlocked(struct nvm_dev *dev,
 	assert_spin_locked(&vlun->lock);
 
 	if (list_empty(&lun->free_list)) {
-		pr_err_ratelimited("gennvm: lun %u have no free pages available",
+		pr_err_ratelimited("gen: lun %u have no free pages available",
 								lun->vlun.id);
 		goto out;
 	}
@@ -350,18 +350,18 @@ out:
 	return blk;
 }
 
-static struct nvm_block *gennvm_get_blk(struct nvm_dev *dev,
+static struct nvm_block *gen_get_blk(struct nvm_dev *dev,
 				struct nvm_lun *vlun, unsigned long flags)
 {
 	struct nvm_block *blk;
 
 	spin_lock(&vlun->lock);
-	blk = gennvm_get_blk_unlocked(dev, vlun, flags);
+	blk = gen_get_blk_unlocked(dev, vlun, flags);
 	spin_unlock(&vlun->lock);
 	return blk;
 }
 
-static void gennvm_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
+static void gen_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
 {
 	struct nvm_lun *vlun = blk->lun;
 	struct gen_lun *lun = container_of(vlun, struct gen_lun, vlun);
@@ -377,35 +377,35 @@ static void gennvm_put_blk_unlocked(struct nvm_dev *dev, struct nvm_block *blk)
 		blk->state = NVM_BLK_ST_BAD;
 	} else {
 		WARN_ON_ONCE(1);
-		pr_err("gennvm: erroneous block type (%lu -> %u)\n",
+		pr_err("gen: erroneous block type (%lu -> %u)\n",
 							blk->id, blk->state);
 		list_move_tail(&blk->list, &lun->bb_list);
 	}
 }
 
-static void gennvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
+static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
 {
 	struct nvm_lun *vlun = blk->lun;
 
 	spin_lock(&vlun->lock);
-	gennvm_put_blk_unlocked(dev, blk);
+	gen_put_blk_unlocked(dev, blk);
 	spin_unlock(&vlun->lock);
 }
 
-static void gennvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
+static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 {
-	struct gen_nvm *gn = dev->mp;
+	struct gen_dev *gn = dev->mp;
 	struct gen_lun *lun;
 	struct nvm_block *blk;
 
-	pr_debug("gennvm: ppa  (ch: %u lun: %u blk: %u pg: %u) -> %u\n",
+	pr_debug("gen: ppa  (ch: %u lun: %u blk: %u pg: %u) -> %u\n",
 			ppa.g.ch, ppa.g.lun, ppa.g.blk, ppa.g.pg, type);
 
 	if (unlikely(ppa.g.ch > dev->nr_chnls ||
 					ppa.g.lun > dev->luns_per_chnl ||
 					ppa.g.blk > dev->blks_per_lun)) {
 		WARN_ON_ONCE(1);
-		pr_err("gennvm: ppa broken (ch: %u > %u lun: %u > %u blk: %u > %u",
+		pr_err("gen: ppa broken (ch: %u > %u lun: %u > %u blk: %u > %u",
 				ppa.g.ch, dev->nr_chnls,
 				ppa.g.lun, dev->luns_per_chnl,
 				ppa.g.blk, dev->blks_per_lun);
@@ -420,9 +420,9 @@ static void gennvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 }
 
 /*
- * mark block bad in gennvm. It is expected that the target recovers separately
+ * mark block bad in gen. It is expected that the target recovers separately
  */
-static void gennvm_mark_blk_bad(struct nvm_dev *dev, struct nvm_rq *rqd)
+static void gen_mark_blk_bad(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
 	int bit = -1;
 	int max_secs = dev->ops->max_phys_sect;
@@ -432,25 +432,25 @@ static void gennvm_mark_blk_bad(struct nvm_dev *dev, struct nvm_rq *rqd)
 
 	/* look up blocks and mark them as bad */
 	if (rqd->nr_ppas == 1) {
-		gennvm_mark_blk(dev, rqd->ppa_addr, NVM_BLK_ST_BAD);
+		gen_mark_blk(dev, rqd->ppa_addr, NVM_BLK_ST_BAD);
 		return;
 	}
 
 	while ((bit = find_next_bit(comp_bits, max_secs, bit + 1)) < max_secs)
-		gennvm_mark_blk(dev, rqd->ppa_list[bit], NVM_BLK_ST_BAD);
+		gen_mark_blk(dev, rqd->ppa_list[bit], NVM_BLK_ST_BAD);
 }
 
-static void gennvm_end_io(struct nvm_rq *rqd)
+static void gen_end_io(struct nvm_rq *rqd)
 {
 	struct nvm_tgt_instance *ins = rqd->ins;
 
 	if (rqd->error == NVM_RSP_ERR_FAILWRITE)
-		gennvm_mark_blk_bad(rqd->dev, rqd);
+		gen_mark_blk_bad(rqd->dev, rqd);
 
 	ins->tt->end_io(rqd);
 }
 
-static int gennvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
+static int gen_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
 	if (!dev->ops->submit_io)
 		return -ENODEV;
@@ -459,11 +459,11 @@ static int gennvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	nvm_generic_to_addr_mode(dev, rqd);
 
 	rqd->dev = dev;
-	rqd->end_io = gennvm_end_io;
+	rqd->end_io = gen_end_io;
 	return dev->ops->submit_io(dev, rqd);
 }
 
-static int gennvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk,
+static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk,
 							unsigned long flags)
 {
 	struct ppa_addr addr = block_to_ppa(dev, blk);
@@ -471,19 +471,19 @@ static int gennvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk,
 	return nvm_erase_ppa(dev, &addr, 1);
 }
 
-static int gennvm_reserve_lun(struct nvm_dev *dev, int lunid)
+static int gen_reserve_lun(struct nvm_dev *dev, int lunid)
 {
 	return test_and_set_bit(lunid, dev->lun_map);
 }
 
-static void gennvm_release_lun(struct nvm_dev *dev, int lunid)
+static void gen_release_lun(struct nvm_dev *dev, int lunid)
 {
 	WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
 }
 
-static struct nvm_lun *gennvm_get_lun(struct nvm_dev *dev, int lunid)
+static struct nvm_lun *gen_get_lun(struct nvm_dev *dev, int lunid)
 {
-	struct gen_nvm *gn = dev->mp;
+	struct gen_dev *gn = dev->mp;
 
 	if (unlikely(lunid >= dev->nr_luns))
 		return NULL;
@@ -491,14 +491,14 @@ static struct nvm_lun *gennvm_get_lun(struct nvm_dev *dev, int lunid)
 	return &gn->luns[lunid].vlun;
 }
 
-static void gennvm_lun_info_print(struct nvm_dev *dev)
+static void gen_lun_info_print(struct nvm_dev *dev)
 {
-	struct gen_nvm *gn = dev->mp;
+	struct gen_dev *gn = dev->mp;
 	struct gen_lun *lun;
 	unsigned int i;
 
 
-	gennvm_for_each_lun(gn, lun, i) {
+	gen_for_each_lun(gn, lun, i) {
 		spin_lock(&lun->vlun.lock);
 
 		pr_info("%s: lun%8u\t%u\n", dev->name, i,
@@ -508,45 +508,45 @@ static void gennvm_lun_info_print(struct nvm_dev *dev)
 	}
 }
 
-static struct nvmm_type gennvm = {
+static struct nvmm_type gen = {
 	.name			= "gennvm",
 	.version		= {0, 1, 0},
 
-	.register_mgr		= gennvm_register,
-	.unregister_mgr		= gennvm_unregister,
+	.register_mgr		= gen_register,
+	.unregister_mgr		= gen_unregister,
 
-	.get_blk_unlocked	= gennvm_get_blk_unlocked,
-	.put_blk_unlocked	= gennvm_put_blk_unlocked,
+	.get_blk_unlocked	= gen_get_blk_unlocked,
+	.put_blk_unlocked	= gen_put_blk_unlocked,
 
-	.get_blk		= gennvm_get_blk,
-	.put_blk		= gennvm_put_blk,
+	.get_blk		= gen_get_blk,
+	.put_blk		= gen_put_blk,
 
-	.submit_io		= gennvm_submit_io,
-	.erase_blk		= gennvm_erase_blk,
+	.submit_io		= gen_submit_io,
+	.erase_blk		= gen_erase_blk,
 
-	.mark_blk		= gennvm_mark_blk,
+	.mark_blk		= gen_mark_blk,
 
-	.get_lun		= gennvm_get_lun,
-	.reserve_lun		= gennvm_reserve_lun,
-	.release_lun		= gennvm_release_lun,
-	.lun_info_print		= gennvm_lun_info_print,
+	.get_lun		= gen_get_lun,
+	.reserve_lun		= gen_reserve_lun,
+	.release_lun		= gen_release_lun,
+	.lun_info_print		= gen_lun_info_print,
 
-	.get_area		= gennvm_get_area,
-	.put_area		= gennvm_put_area,
+	.get_area		= gen_get_area,
+	.put_area		= gen_put_area,
 
 };
 
-static int __init gennvm_module_init(void)
+static int __init gen_module_init(void)
 {
-	return nvm_register_mgr(&gennvm);
+	return nvm_register_mgr(&gen);
 }
 
-static void gennvm_module_exit(void)
+static void gen_module_exit(void)
 {
-	nvm_unregister_mgr(&gennvm);
+	nvm_unregister_mgr(&gen);
 }
 
-module_init(gennvm_module_init);
-module_exit(gennvm_module_exit);
+module_init(gen_module_init);
+module_exit(gen_module_exit);
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Generic media manager for Open-Channel SSDs");
+MODULE_DESCRIPTION("General media manager for Open-Channel SSDs");
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
index 04d7c23..bf06219 100644
--- a/drivers/lightnvm/gennvm.h
+++ b/drivers/lightnvm/gennvm.h
@@ -34,7 +34,7 @@ struct gen_lun {
 					 */
 };
 
-struct gen_nvm {
+struct gen_dev {
 	struct nvm_dev *dev;
 
 	int nr_luns;
@@ -42,12 +42,13 @@ struct gen_nvm {
 	struct list_head area_list;
 };
 
-struct gennvm_area {
+struct gen_area {
 	struct list_head list;
 	sector_t begin;
 	sector_t end;	/* end is excluded */
 };
-#define gennvm_for_each_lun(bm, lun, i) \
+
+#define gen_for_each_lun(bm, lun, i) \
 		for ((i) = 0, lun = &(bm)->luns[0]; \
 			(i) < (bm)->nr_luns; (i)++, lun = &(bm)->luns[(i)])
 
-- 
2.1.4

