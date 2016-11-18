Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38770 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbcKROoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:09 -0500
Received: by mail-wm0-f44.google.com with SMTP id f82so42004597wmf.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:08 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 13/20] lightnvm: move block provisioning to targets
Date: Fri, 18 Nov 2016 15:43:35 +0100
Message-Id: <1479480222-18790-14-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In order to naturally support multi-target instances on an Open-Channel
SSD, targets should own the LUNs they get blocks from and manage
provisioning internally. This is done in several steps.

This patch moves the block provisioning inside of the target and removes
the get/put block interface from the media manager.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      |  95 ++++++++++-----------
 drivers/lightnvm/gennvm.c    | 145 +++++++++++++++-----------------
 drivers/lightnvm/rrpc.c      | 196 ++++++++++++++++++++++++++++---------------
 drivers/lightnvm/rrpc.h      |  15 +++-
 drivers/lightnvm/sysblk.c    |  65 +++++++-------
 drivers/nvme/host/lightnvm.c |  11 ++-
 include/linux/lightnvm.h     | 133 +++++++++++++++--------------
 7 files changed, 370 insertions(+), 290 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index d4433d3..493ce03 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -176,20 +176,6 @@ static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 	return NULL;
 }
 
-struct nvm_block *nvm_get_blk(struct nvm_dev *dev, struct nvm_lun *lun,
-							unsigned long flags)
-{
-	return dev->mt->get_blk(dev, lun, flags);
-}
-EXPORT_SYMBOL(nvm_get_blk);
-
-/* Assumes that all valid pages have already been moved on release to bm */
-void nvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
-{
-	return dev->mt->put_blk(dev, blk);
-}
-EXPORT_SYMBOL(nvm_put_blk);
-
 void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 {
 	return dev->mt->mark_blk(dev, ppa, type);
@@ -266,10 +252,11 @@ EXPORT_SYMBOL(nvm_generic_to_addr_mode);
 int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
 			const struct ppa_addr *ppas, int nr_ppas, int vblk)
 {
+	struct nvm_geo *geo = &dev->geo;
 	int i, plane_cnt, pl_idx;
 	struct ppa_addr ppa;
 
-	if ((!vblk || dev->plane_mode == NVM_PLANE_SINGLE) && nr_ppas == 1) {
+	if ((!vblk || geo->plane_mode == NVM_PLANE_SINGLE) && nr_ppas == 1) {
 		rqd->nr_ppas = nr_ppas;
 		rqd->ppa_addr = ppas[0];
 
@@ -287,7 +274,7 @@ int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
 		for (i = 0; i < nr_ppas; i++)
 			rqd->ppa_list[i] = ppas[i];
 	} else {
-		plane_cnt = dev->plane_mode;
+		plane_cnt = geo->plane_mode;
 		rqd->nr_ppas *= plane_cnt;
 
 		for (i = 0; i < nr_ppas; i++) {
@@ -465,17 +452,18 @@ EXPORT_SYMBOL(nvm_submit_ppa);
  */
 int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
 {
+	struct nvm_geo *geo = &dev->geo;
 	int blk, offset, pl, blktype;
 
-	if (nr_blks != dev->blks_per_lun * dev->plane_mode)
+	if (nr_blks != geo->blks_per_lun * geo->plane_mode)
 		return -EINVAL;
 
-	for (blk = 0; blk < dev->blks_per_lun; blk++) {
-		offset = blk * dev->plane_mode;
+	for (blk = 0; blk < geo->blks_per_lun; blk++) {
+		offset = blk * geo->plane_mode;
 		blktype = blks[offset];
 
 		/* Bad blocks on any planes take precedence over other types */
-		for (pl = 0; pl < dev->plane_mode; pl++) {
+		for (pl = 0; pl < geo->plane_mode; pl++) {
 			if (blks[offset + pl] &
 					(NVM_BLK_T_BAD|NVM_BLK_T_GRWN_BAD)) {
 				blktype = blks[offset + pl];
@@ -486,7 +474,7 @@ int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
 		blks[blk] = blktype;
 	}
 
-	return dev->blks_per_lun;
+	return geo->blks_per_lun;
 }
 EXPORT_SYMBOL(nvm_bb_tbl_fold);
 
@@ -500,9 +488,10 @@ EXPORT_SYMBOL(nvm_get_bb_tbl);
 
 static int nvm_init_slc_tbl(struct nvm_dev *dev, struct nvm_id_group *grp)
 {
+	struct nvm_geo *geo = &dev->geo;
 	int i;
 
-	dev->lps_per_blk = dev->pgs_per_blk;
+	dev->lps_per_blk = geo->pgs_per_blk;
 	dev->lptbl = kcalloc(dev->lps_per_blk, sizeof(int), GFP_KERNEL);
 	if (!dev->lptbl)
 		return -ENOMEM;
@@ -548,29 +537,32 @@ static int nvm_core_init(struct nvm_dev *dev)
 {
 	struct nvm_id *id = &dev->identity;
 	struct nvm_id_group *grp = &id->groups[0];
+	struct nvm_geo *geo = &dev->geo;
 	int ret;
 
-	/* device values */
-	dev->nr_chnls = grp->num_ch;
-	dev->luns_per_chnl = grp->num_lun;
-	dev->pgs_per_blk = grp->num_pg;
-	dev->blks_per_lun = grp->num_blk;
-	dev->nr_planes = grp->num_pln;
-	dev->fpg_size = grp->fpg_sz;
-	dev->pfpg_size = grp->fpg_sz * grp->num_pln;
-	dev->sec_size = grp->csecs;
-	dev->oob_size = grp->sos;
-	dev->sec_per_pg = grp->fpg_sz / grp->csecs;
-	dev->mccap = grp->mccap;
-	memcpy(&dev->ppaf, &id->ppaf, sizeof(struct nvm_addr_format));
+	/* Whole device values */
+	geo->nr_chnls = grp->num_ch;
+	geo->luns_per_chnl = grp->num_lun;
 
-	dev->plane_mode = NVM_PLANE_SINGLE;
-	dev->max_rq_size = dev->ops->max_phys_sect * dev->sec_size;
+	/* Generic device values */
+	geo->pgs_per_blk = grp->num_pg;
+	geo->blks_per_lun = grp->num_blk;
+	geo->nr_planes = grp->num_pln;
+	geo->fpg_size = grp->fpg_sz;
+	geo->pfpg_size = grp->fpg_sz * grp->num_pln;
+	geo->sec_size = grp->csecs;
+	geo->oob_size = grp->sos;
+	geo->sec_per_pg = grp->fpg_sz / grp->csecs;
+	geo->mccap = grp->mccap;
+	memcpy(&geo->ppaf, &id->ppaf, sizeof(struct nvm_addr_format));
+
+	geo->plane_mode = NVM_PLANE_SINGLE;
+	geo->max_rq_size = dev->ops->max_phys_sect * geo->sec_size;
 
 	if (grp->mpos & 0x020202)
-		dev->plane_mode = NVM_PLANE_DOUBLE;
+		geo->plane_mode = NVM_PLANE_DOUBLE;
 	if (grp->mpos & 0x040404)
-		dev->plane_mode = NVM_PLANE_QUAD;
+		geo->plane_mode = NVM_PLANE_QUAD;
 
 	if (grp->mtype != 0) {
 		pr_err("nvm: memory type not supported\n");
@@ -578,13 +570,13 @@ static int nvm_core_init(struct nvm_dev *dev)
 	}
 
 	/* calculated values */
-	dev->sec_per_pl = dev->sec_per_pg * dev->nr_planes;
-	dev->sec_per_blk = dev->sec_per_pl * dev->pgs_per_blk;
-	dev->sec_per_lun = dev->sec_per_blk * dev->blks_per_lun;
-	dev->nr_luns = dev->luns_per_chnl * dev->nr_chnls;
+	geo->sec_per_pl = geo->sec_per_pg * geo->nr_planes;
+	geo->sec_per_blk = geo->sec_per_pl * geo->pgs_per_blk;
+	geo->sec_per_lun = geo->sec_per_blk * geo->blks_per_lun;
+	geo->nr_luns = geo->luns_per_chnl * geo->nr_chnls;
 
-	dev->total_secs = dev->nr_luns * dev->sec_per_lun;
-	dev->lun_map = kcalloc(BITS_TO_LONGS(dev->nr_luns),
+	dev->total_secs = geo->nr_luns * geo->sec_per_lun;
+	dev->lun_map = kcalloc(BITS_TO_LONGS(geo->nr_luns),
 					sizeof(unsigned long), GFP_KERNEL);
 	if (!dev->lun_map)
 		return -ENOMEM;
@@ -611,7 +603,7 @@ static int nvm_core_init(struct nvm_dev *dev)
 	mutex_init(&dev->mlock);
 	spin_lock_init(&dev->lock);
 
-	blk_queue_logical_block_size(dev->q, dev->sec_size);
+	blk_queue_logical_block_size(dev->q, geo->sec_size);
 
 	return 0;
 err_fmtype:
@@ -645,6 +637,7 @@ void nvm_free(struct nvm_dev *dev)
 
 static int nvm_init(struct nvm_dev *dev)
 {
+	struct nvm_geo *geo = &dev->geo;
 	int ret = -EINVAL;
 
 	if (!dev->q || !dev->ops)
@@ -676,9 +669,9 @@ static int nvm_init(struct nvm_dev *dev)
 	}
 
 	pr_info("nvm: registered %s [%u/%u/%u/%u/%u/%u]\n",
-			dev->name, dev->sec_per_pg, dev->nr_planes,
-			dev->pgs_per_blk, dev->blks_per_lun, dev->nr_luns,
-			dev->nr_chnls);
+			dev->name, geo->sec_per_pg, geo->nr_planes,
+			geo->pgs_per_blk, geo->blks_per_lun,
+			geo->nr_luns, geo->nr_chnls);
 	return 0;
 err:
 	pr_err("nvm: failed to initialize nvm\n");
@@ -771,9 +764,9 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 	}
 	s = &create->conf.s;
 
-	if (s->lun_begin > s->lun_end || s->lun_end > dev->nr_luns) {
+	if (s->lun_begin > s->lun_end || s->lun_end > dev->geo.nr_luns) {
 		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
-			s->lun_begin, s->lun_end, dev->nr_luns);
+			s->lun_begin, s->lun_end, dev->geo.nr_luns);
 		return -EINVAL;
 	}
 
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 9671e11..8791a2a 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -74,6 +74,36 @@ static void gen_release_luns(struct nvm_dev *dev, struct nvm_target *t)
 	}
 }
 
+static void gen_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
+{
+	kfree(tgt_dev);
+}
+
+static struct nvm_tgt_dev *gen_create_tgt_dev(struct nvm_dev *dev,
+					      int lun_begin, int lun_end)
+{
+	struct nvm_tgt_dev *tgt_dev = NULL;
+	int nr_luns = lun_end - lun_begin + 1;
+
+	tgt_dev = kmalloc(sizeof(struct nvm_tgt_dev), GFP_KERNEL);
+	if (!tgt_dev)
+		goto out;
+
+	memcpy(&tgt_dev->geo, &dev->geo, sizeof(struct nvm_geo));
+	tgt_dev->geo.nr_chnls = (nr_luns / (dev->geo.luns_per_chnl + 1)) + 1;
+	tgt_dev->geo.nr_luns = nr_luns;
+	tgt_dev->total_secs = nr_luns * tgt_dev->geo.sec_per_lun;
+	tgt_dev->q = dev->q;
+	tgt_dev->ops = dev->ops;
+	tgt_dev->mt = dev->mt;
+	memcpy(&tgt_dev->identity, &dev->identity, sizeof(struct nvm_id));
+
+	tgt_dev->parent = dev;
+
+out:
+	return tgt_dev;
+}
+
 static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 {
 	struct gen_dev *gn = dev->mp;
@@ -82,6 +112,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	struct gendisk *tdisk;
 	struct nvm_tgt_type *tt;
 	struct nvm_target *t;
+	struct nvm_tgt_dev *tgt_dev;
 	void *targetdata;
 
 	tt = nvm_find_target_type(create->tgttype, 1);
@@ -108,9 +139,13 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	if (gen_reserve_luns(dev, t, s->lun_begin, s->lun_end))
 		goto err_t;
 
+	tgt_dev = gen_create_tgt_dev(dev, s->lun_begin, s->lun_end);
+	if (!tgt_dev)
+		goto err_reserve;
+
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue)
-		goto err_reserve;
+		goto err_dev;
 	blk_queue_make_request(tqueue, tt->make_rq);
 
 	tdisk = alloc_disk(0);
@@ -124,7 +159,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->fops = &gen_fops;
 	tdisk->queue = tqueue;
 
-	targetdata = tt->init(dev, tdisk, s->lun_begin, s->lun_end);
+	targetdata = tt->init(tgt_dev, tdisk, s->lun_begin, s->lun_end);
 	if (IS_ERR(targetdata))
 		goto err_init;
 
@@ -138,7 +173,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 
 	t->type = tt;
 	t->disk = tdisk;
-	t->dev = dev;
+	t->dev = tgt_dev;
 
 	mutex_lock(&gn->lock);
 	list_add_tail(&t->list, &gn->targets);
@@ -149,6 +184,8 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	put_disk(tdisk);
 err_queue:
 	blk_cleanup_queue(tqueue);
+err_dev:
+	kfree(tgt_dev);
 err_reserve:
 	gen_release_luns(dev, t);
 err_t:
@@ -168,7 +205,8 @@ static void __gen_remove_target(struct nvm_target *t)
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
-	gen_release_luns(t->dev, t);
+	gen_release_luns(t->dev->parent, t);
+	gen_remove_tgt_dev(t->dev);
 	put_disk(tdisk);
 
 	list_del(&t->list);
@@ -207,10 +245,11 @@ static int gen_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
 
 static int gen_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct gen_dev *gn = dev->mp;
 	struct gen_area *area, *prev, *next;
 	sector_t begin = 0;
-	sector_t max_sectors = (dev->sec_size * dev->total_secs) >> 9;
+	sector_t max_sectors = (geo->sec_size * dev->total_secs) >> 9;
 
 	if (len > max_sectors)
 		return -EINVAL;
@@ -289,10 +328,11 @@ static void gen_luns_free(struct nvm_dev *dev)
 
 static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct nvm_lun *lun;
 	int i;
 
-	gn->luns = kcalloc(dev->nr_luns, sizeof(struct nvm_lun), GFP_KERNEL);
+	gn->luns = kcalloc(geo->nr_luns, sizeof(struct nvm_lun), GFP_KERNEL);
 	if (!gn->luns)
 		return -ENOMEM;
 
@@ -305,9 +345,9 @@ static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
 		spin_lock_init(&lun->lock);
 
 		lun->id = i;
-		lun->lun_id = i % dev->luns_per_chnl;
-		lun->chnl_id = i / dev->luns_per_chnl;
-		lun->nr_free_blocks = dev->blks_per_lun;
+		lun->lun_id = i % geo->luns_per_chnl;
+		lun->chnl_id = i / geo->luns_per_chnl;
+		lun->nr_free_blocks = geo->blks_per_lun;
 	}
 	return 0;
 }
@@ -324,7 +364,7 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 	if (nr_blks < 0)
 		return nr_blks;
 
-	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
+	lun = &gn->luns[(dev->geo.luns_per_chnl * ppa.g.ch) + ppa.g.lun];
 
 	for (i = 0; i < nr_blks; i++) {
 		if (blks[i] == NVM_BLK_T_FREE)
@@ -342,6 +382,7 @@ static int gen_block_bb(struct gen_dev *gn, struct ppa_addr ppa,
 static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 {
 	struct nvm_dev *dev = private;
+	struct nvm_geo *geo = &dev->geo;
 	struct gen_dev *gn = dev->mp;
 	u64 elba = slba + nlb;
 	struct nvm_lun *lun;
@@ -370,12 +411,12 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 			continue;
 
 		/* resolve block from physical address */
-		lun_id = div_u64(pba, dev->sec_per_lun);
+		lun_id = div_u64(pba, geo->sec_per_lun);
 		lun = &gn->luns[lun_id];
 
 		/* Calculate block offset into lun */
-		pba = pba - (dev->sec_per_lun * lun_id);
-		blk = &lun->blocks[div_u64(pba, dev->sec_per_blk)];
+		pba = pba - (geo->sec_per_lun * lun_id);
+		blk = &lun->blocks[div_u64(pba, geo->sec_per_blk)];
 
 		if (!blk->state) {
 			/* at this point, we don't know anything about the
@@ -393,26 +434,27 @@ static int gen_block_map(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 static int gen_blocks_init(struct nvm_dev *dev, struct gen_dev *gn)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct nvm_lun *lun;
 	struct nvm_block *block;
 	sector_t lun_iter, blk_iter, cur_block_id = 0;
 	int ret, nr_blks;
 	u8 *blks;
 
-	nr_blks = dev->blks_per_lun * dev->plane_mode;
+	nr_blks = geo->blks_per_lun * geo->plane_mode;
 	blks = kmalloc(nr_blks, GFP_KERNEL);
 	if (!blks)
 		return -ENOMEM;
 
 	gen_for_each_lun(gn, lun, lun_iter) {
 		lun->blocks = vzalloc(sizeof(struct nvm_block) *
-							dev->blks_per_lun);
+							geo->blks_per_lun);
 		if (!lun->blocks) {
 			kfree(blks);
 			return -ENOMEM;
 		}
 
-		for (blk_iter = 0; blk_iter < dev->blks_per_lun; blk_iter++) {
+		for (blk_iter = 0; blk_iter < geo->blks_per_lun; blk_iter++) {
 			block = &lun->blocks[blk_iter];
 
 			INIT_LIST_HEAD(&block->list);
@@ -474,7 +516,7 @@ static int gen_register(struct nvm_dev *dev)
 		return -ENOMEM;
 
 	gn->dev = dev;
-	gn->nr_luns = dev->nr_luns;
+	gn->nr_luns = dev->geo.nr_luns;
 	INIT_LIST_HEAD(&gn->area_list);
 	mutex_init(&gn->lock);
 	INIT_LIST_HEAD(&gn->targets);
@@ -506,7 +548,7 @@ static void gen_unregister(struct nvm_dev *dev)
 
 	mutex_lock(&gn->lock);
 	list_for_each_entry_safe(t, tmp, &gn->targets, list) {
-		if (t->dev != dev)
+		if (t->dev->parent != dev)
 			continue;
 		__gen_remove_target(t);
 	}
@@ -516,55 +558,9 @@ static void gen_unregister(struct nvm_dev *dev)
 	module_put(THIS_MODULE);
 }
 
-static struct nvm_block *gen_get_blk(struct nvm_dev *dev,
-				struct nvm_lun *lun, unsigned long flags)
-{
-	struct nvm_block *blk = NULL;
-	int is_gc = flags & NVM_IOTYPE_GC;
-
-	spin_lock(&lun->lock);
-	if (list_empty(&lun->free_list)) {
-		pr_err_ratelimited("gen: lun %u have no free pages available",
-								lun->id);
-		goto out;
-	}
-
-	if (!is_gc && lun->nr_free_blocks < lun->reserved_blocks)
-		goto out;
-
-	blk = list_first_entry(&lun->free_list, struct nvm_block, list);
-
-	list_move_tail(&blk->list, &lun->used_list);
-	blk->state = NVM_BLK_ST_TGT;
-	lun->nr_free_blocks--;
-out:
-	spin_unlock(&lun->lock);
-	return blk;
-}
-
-static void gen_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
-{
-	struct nvm_lun *lun = blk->lun;
-
-	spin_lock(&lun->lock);
-	if (blk->state & NVM_BLK_ST_TGT) {
-		list_move_tail(&blk->list, &lun->free_list);
-		lun->nr_free_blocks++;
-		blk->state = NVM_BLK_ST_FREE;
-	} else if (blk->state & NVM_BLK_ST_BAD) {
-		list_move_tail(&blk->list, &lun->bb_list);
-		blk->state = NVM_BLK_ST_BAD;
-	} else {
-		WARN_ON_ONCE(1);
-		pr_err("gen: erroneous block type (%lu -> %u)\n",
-							blk->id, blk->state);
-		list_move_tail(&blk->list, &lun->bb_list);
-	}
-	spin_unlock(&lun->lock);
-}
-
 static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct gen_dev *gn = dev->mp;
 	struct nvm_lun *lun;
 	struct nvm_block *blk;
@@ -572,18 +568,18 @@ static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 	pr_debug("gen: ppa  (ch: %u lun: %u blk: %u pg: %u) -> %u\n",
 			ppa.g.ch, ppa.g.lun, ppa.g.blk, ppa.g.pg, type);
 
-	if (unlikely(ppa.g.ch > dev->nr_chnls ||
-					ppa.g.lun > dev->luns_per_chnl ||
-					ppa.g.blk > dev->blks_per_lun)) {
+	if (unlikely(ppa.g.ch > geo->nr_chnls ||
+					ppa.g.lun > geo->luns_per_chnl ||
+					ppa.g.blk > geo->blks_per_lun)) {
 		WARN_ON_ONCE(1);
 		pr_err("gen: ppa broken (ch: %u > %u lun: %u > %u blk: %u > %u",
-				ppa.g.ch, dev->nr_chnls,
-				ppa.g.lun, dev->luns_per_chnl,
-				ppa.g.blk, dev->blks_per_lun);
+				ppa.g.ch, geo->nr_chnls,
+				ppa.g.lun, geo->luns_per_chnl,
+				ppa.g.blk, geo->blks_per_lun);
 		return;
 	}
 
-	lun = &gn->luns[(dev->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
+	lun = &gn->luns[(geo->luns_per_chnl * ppa.g.ch) + ppa.g.lun];
 	blk = &lun->blocks[ppa.g.blk];
 
 	/* will be moved to bb list on put_blk from target */
@@ -621,7 +617,7 @@ static struct nvm_lun *gen_get_lun(struct nvm_dev *dev, int lunid)
 {
 	struct gen_dev *gn = dev->mp;
 
-	if (unlikely(lunid >= dev->nr_luns))
+	if (unlikely(lunid >= dev->geo.nr_luns))
 		return NULL;
 
 	return &gn->luns[lunid];
@@ -654,9 +650,6 @@ static struct nvmm_type gen = {
 	.create_tgt		= gen_create_tgt,
 	.remove_tgt		= gen_remove_tgt,
 
-	.get_blk		= gen_get_blk,
-	.put_blk		= gen_put_blk,
-
 	.submit_io		= gen_submit_io,
 	.erase_blk		= gen_erase_blk,
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 88e0d06..5377c7a 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -28,6 +28,7 @@ static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 
 static void rrpc_page_invalidate(struct rrpc *rrpc, struct rrpc_addr *a)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_block *rblk = a->rblk;
 	unsigned int pg_offset;
 
@@ -38,7 +39,7 @@ static void rrpc_page_invalidate(struct rrpc *rrpc, struct rrpc_addr *a)
 
 	spin_lock(&rblk->lock);
 
-	div_u64_rem(a->addr, rrpc->dev->sec_per_blk, &pg_offset);
+	div_u64_rem(a->addr, dev->geo.sec_per_blk, &pg_offset);
 	WARN_ON(test_and_set_bit(pg_offset, rblk->invalid_pages));
 	rblk->nr_invalid_pages++;
 
@@ -116,32 +117,36 @@ static void rrpc_discard(struct rrpc *rrpc, struct bio *bio)
 
 static int block_is_full(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	return (rblk->next_page == rrpc->dev->sec_per_blk);
+	struct nvm_tgt_dev *dev = rrpc->dev;
+
+	return (rblk->next_page == dev->geo.sec_per_blk);
 }
 
 /* Calculate relative addr for the given block, considering instantiated LUNs */
 static u64 block_to_rel_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvm_block *blk = rblk->parent;
-	int lun_blk = blk->id % (rrpc->dev->blks_per_lun * rrpc->nr_luns);
+	int lun_blk = blk->id % (dev->geo.blks_per_lun * rrpc->nr_luns);
 
-	return lun_blk * rrpc->dev->sec_per_blk;
+	return lun_blk * dev->geo.sec_per_blk;
 }
 
 /* Calculate global addr for the given block */
 static u64 block_to_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvm_block *blk = rblk->parent;
 
-	return blk->id * rrpc->dev->sec_per_blk;
+	return blk->id * dev->geo.sec_per_blk;
 }
 
-static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_dev *dev, u64 addr)
+static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_tgt_dev *dev, u64 addr)
 {
 	struct ppa_addr paddr;
 
 	paddr.ppa = addr;
-	return linear_to_generic_addr(dev, paddr);
+	return linear_to_generic_addr(&dev->geo, paddr);
 }
 
 /* requires lun->lock taken */
@@ -158,21 +163,52 @@ static void rrpc_set_lun_cur(struct rrpc_lun *rlun, struct rrpc_block *new_rblk,
 	*cur_rblk = new_rblk;
 }
 
+static struct nvm_block *__rrpc_get_blk(struct rrpc *rrpc,
+							struct rrpc_lun *rlun)
+{
+	struct nvm_lun *lun = rlun->parent;
+	struct nvm_block *blk = NULL;
+
+	if (list_empty(&lun->free_list))
+		goto out;
+
+	blk = list_first_entry(&lun->free_list, struct nvm_block, list);
+
+	list_move_tail(&blk->list, &lun->used_list);
+	blk->state = NVM_BLK_ST_TGT;
+	lun->nr_free_blocks--;
+
+out:
+	return blk;
+}
+
 static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 							unsigned long flags)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
+	struct nvm_lun *lun = rlun->parent;
 	struct nvm_block *blk;
 	struct rrpc_block *rblk;
+	int is_gc = flags & NVM_IOTYPE_GC;
 
-	blk = nvm_get_blk(rrpc->dev, rlun->parent, flags);
+	spin_lock(&rlun->lock);
+	if (!is_gc && lun->nr_free_blocks < rlun->reserved_blocks) {
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
-	bitmap_zero(rblk->invalid_pages, rrpc->dev->sec_per_blk);
+	bitmap_zero(rblk->invalid_pages, dev->geo.sec_per_blk);
 	rblk->next_page = 0;
 	rblk->nr_invalid_pages = 0;
 	atomic_set(&rblk->data_cmnt_size, 0);
@@ -182,7 +218,25 @@ static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 
 static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	nvm_put_blk(rrpc->dev, rblk->parent);
+	struct nvm_block *blk = rblk->parent;
+	struct rrpc_lun *rlun = rblk->rlun;
+	struct nvm_lun *lun = rlun->parent;
+
+	spin_lock(&rlun->lock);
+	if (blk->state & NVM_BLK_ST_TGT) {
+		list_move_tail(&blk->list, &lun->free_list);
+		lun->nr_free_blocks++;
+		blk->state = NVM_BLK_ST_FREE;
+	} else if (blk->state & NVM_BLK_ST_BAD) {
+		list_move_tail(&blk->list, &lun->bb_list);
+		blk->state = NVM_BLK_ST_BAD;
+	} else {
+		WARN_ON_ONCE(1);
+		pr_err("rrpc: erroneous block type (%lu -> %u)\n",
+							blk->id, blk->state);
+		list_move_tail(&blk->list, &lun->bb_list);
+	}
+	spin_unlock(&rlun->lock);
 }
 
 static void rrpc_put_blks(struct rrpc *rrpc)
@@ -250,13 +304,14 @@ static void rrpc_end_sync_bio(struct bio *bio)
  */
 static int rrpc_move_valid_pages(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	struct request_queue *q = rrpc->dev->q;
+	struct nvm_tgt_dev *dev = rrpc->dev;
+	struct request_queue *q = dev->q;
 	struct rrpc_rev_addr *rev;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	struct page *page;
 	int slot;
-	int nr_sec_per_blk = rrpc->dev->sec_per_blk;
+	int nr_sec_per_blk = dev->geo.sec_per_blk;
 	u64 phys_addr;
 	DECLARE_COMPLETION_ONSTACK(wait);
 
@@ -366,7 +421,7 @@ static void rrpc_block_gc(struct work_struct *work)
 	struct rrpc *rrpc = gcb->rrpc;
 	struct rrpc_block *rblk = gcb->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 
 	mempool_free(gcb, rrpc->gcb_pool);
 	pr_debug("nvm: block '%lu' being reclaimed\n", rblk->parent->id);
@@ -374,7 +429,7 @@ static void rrpc_block_gc(struct work_struct *work)
 	if (rrpc_move_valid_pages(rrpc, rblk))
 		goto put_back;
 
-	if (nvm_erase_blk(dev, rblk->parent, 0))
+	if (nvm_erase_blk(dev->parent, rblk->parent, 0))
 		goto put_back;
 
 	rrpc_put_blk(rrpc, rblk);
@@ -420,11 +475,12 @@ static void rrpc_lun_gc(struct work_struct *work)
 {
 	struct rrpc_lun *rlun = container_of(work, struct rrpc_lun, ws_gc);
 	struct rrpc *rrpc = rlun->rrpc;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvm_lun *lun = rlun->parent;
 	struct rrpc_block_gc *gcb;
 	unsigned int nr_blocks_need;
 
-	nr_blocks_need = rrpc->dev->blks_per_lun / GC_LIMIT_INVERSE;
+	nr_blocks_need = dev->geo.blks_per_lun / GC_LIMIT_INVERSE;
 
 	if (nr_blocks_need < rrpc->nr_luns)
 		nr_blocks_need = rrpc->nr_luns;
@@ -645,15 +701,15 @@ static void rrpc_run_gc(struct rrpc *rrpc, struct rrpc_block *rblk)
 	queue_work(rrpc->kgc_wq, &gcb->ws_gc);
 }
 
-static void __rrpc_mark_bad_block(struct nvm_dev *dev, struct ppa_addr *ppa)
+static void __rrpc_mark_bad_block(struct nvm_tgt_dev *dev, struct ppa_addr *ppa)
 {
-		nvm_mark_blk(dev, *ppa, NVM_BLK_ST_BAD);
-		nvm_set_bb_tbl(dev, ppa, 1, NVM_BLK_T_GRWN_BAD);
+		nvm_mark_blk(dev->parent, *ppa, NVM_BLK_ST_BAD);
+		nvm_set_bb_tbl(dev->parent, ppa, 1, NVM_BLK_T_GRWN_BAD);
 }
 
 static void rrpc_mark_bad_block(struct rrpc *rrpc, struct nvm_rq *rqd)
 {
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	void *comp_bits = &rqd->ppa_status;
 	struct ppa_addr ppa, prev_ppa;
 	int nr_ppas = rqd->nr_ppas;
@@ -676,6 +732,7 @@ static void rrpc_mark_bad_block(struct rrpc *rrpc, struct nvm_rq *rqd)
 static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 						sector_t laddr, uint8_t npages)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_addr *p;
 	struct rrpc_block *rblk;
 	struct nvm_lun *lun;
@@ -687,7 +744,7 @@ static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 		lun = rblk->parent->lun;
 
 		cmnt_size = atomic_inc_return(&rblk->data_cmnt_size);
-		if (unlikely(cmnt_size == rrpc->dev->sec_per_blk))
+		if (unlikely(cmnt_size == dev->geo.sec_per_blk))
 			rrpc_run_gc(rrpc, rblk);
 	}
 }
@@ -695,6 +752,7 @@ static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 static void rrpc_end_io(struct nvm_rq *rqd)
 {
 	struct rrpc *rrpc = container_of(rqd->ins, struct rrpc, instance);
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_rq *rrqd = nvm_rq_to_pdu(rqd);
 	uint8_t npages = rqd->nr_ppas;
 	sector_t laddr = rrpc_get_laddr(rqd->bio) - npages;
@@ -714,7 +772,7 @@ static void rrpc_end_io(struct nvm_rq *rqd)
 	rrpc_unlock_rq(rrpc, rqd);
 
 	if (npages > 1)
-		nvm_dev_dma_free(rrpc->dev, rqd->ppa_list, rqd->dma_ppa_list);
+		nvm_dev_dma_free(dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 
 	mempool_free(rqd, rrpc->rq_pool);
 }
@@ -722,6 +780,7 @@ static void rrpc_end_io(struct nvm_rq *rqd)
 static int rrpc_read_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 			struct nvm_rq *rqd, unsigned long flags, int npages)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_inflight_rq *r = rrpc_get_inflight_rq(rqd);
 	struct rrpc_addr *gp;
 	sector_t laddr = rrpc_get_laddr(bio);
@@ -729,7 +788,7 @@ static int rrpc_read_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 	int i;
 
 	if (!is_gc && rrpc_lock_rq(rrpc, bio, rqd)) {
-		nvm_dev_dma_free(rrpc->dev, rqd->ppa_list, rqd->dma_ppa_list);
+		nvm_dev_dma_free(dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 		return NVM_IO_REQUEUE;
 	}
 
@@ -739,12 +798,11 @@ static int rrpc_read_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 		gp = &rrpc->trans_map[laddr + i];
 
 		if (gp->rblk) {
-			rqd->ppa_list[i] = rrpc_ppa_to_gaddr(rrpc->dev,
-								gp->addr);
+			rqd->ppa_list[i] = rrpc_ppa_to_gaddr(dev, gp->addr);
 		} else {
 			BUG_ON(is_gc);
 			rrpc_unlock_laddr(rrpc, r);
-			nvm_dev_dma_free(rrpc->dev, rqd->ppa_list,
+			nvm_dev_dma_free(dev->parent, rqd->ppa_list,
 							rqd->dma_ppa_list);
 			return NVM_IO_DONE;
 		}
@@ -784,6 +842,7 @@ static int rrpc_read_rq(struct rrpc *rrpc, struct bio *bio, struct nvm_rq *rqd,
 static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 			struct nvm_rq *rqd, unsigned long flags, int npages)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_inflight_rq *r = rrpc_get_inflight_rq(rqd);
 	struct rrpc_addr *p;
 	sector_t laddr = rrpc_get_laddr(bio);
@@ -791,7 +850,7 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 	int i;
 
 	if (!is_gc && rrpc_lock_rq(rrpc, bio, rqd)) {
-		nvm_dev_dma_free(rrpc->dev, rqd->ppa_list, rqd->dma_ppa_list);
+		nvm_dev_dma_free(dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
 		return NVM_IO_REQUEUE;
 	}
 
@@ -801,14 +860,13 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 		if (!p) {
 			BUG_ON(is_gc);
 			rrpc_unlock_laddr(rrpc, r);
-			nvm_dev_dma_free(rrpc->dev, rqd->ppa_list,
+			nvm_dev_dma_free(dev->parent, rqd->ppa_list,
 							rqd->dma_ppa_list);
 			rrpc_gc_kick(rrpc);
 			return NVM_IO_REQUEUE;
 		}
 
-		rqd->ppa_list[i] = rrpc_ppa_to_gaddr(rrpc->dev,
-								p->addr);
+		rqd->ppa_list[i] = rrpc_ppa_to_gaddr(dev, p->addr);
 	}
 
 	rqd->opcode = NVM_OP_HBWRITE;
@@ -843,8 +901,10 @@ static int rrpc_write_rq(struct rrpc *rrpc, struct bio *bio,
 static int rrpc_setup_rq(struct rrpc *rrpc, struct bio *bio,
 			struct nvm_rq *rqd, unsigned long flags, uint8_t npages)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
+
 	if (npages > 1) {
-		rqd->ppa_list = nvm_dev_dma_alloc(rrpc->dev, GFP_KERNEL,
+		rqd->ppa_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
 							&rqd->dma_ppa_list);
 		if (!rqd->ppa_list) {
 			pr_err("rrpc: not able to allocate ppa list\n");
@@ -867,14 +927,15 @@ static int rrpc_setup_rq(struct rrpc *rrpc, struct bio *bio,
 static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 				struct nvm_rq *rqd, unsigned long flags)
 {
-	int err;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_rq *rrq = nvm_rq_to_pdu(rqd);
 	uint8_t nr_pages = rrpc_get_pages(bio);
 	int bio_size = bio_sectors(bio) << 9;
+	int err;
 
-	if (bio_size < rrpc->dev->sec_size)
+	if (bio_size < dev->geo.sec_size)
 		return NVM_IO_ERR;
-	else if (bio_size > rrpc->dev->max_rq_size)
+	else if (bio_size > dev->geo.max_rq_size)
 		return NVM_IO_ERR;
 
 	err = rrpc_setup_rq(rrpc, bio, rqd, flags, nr_pages);
@@ -887,15 +948,15 @@ static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 	rqd->nr_ppas = nr_pages;
 	rrq->flags = flags;
 
-	err = nvm_submit_io(rrpc->dev, rqd);
+	err = nvm_submit_io(dev->parent, rqd);
 	if (err) {
 		pr_err("rrpc: I/O submission failed: %d\n", err);
 		bio_put(bio);
 		if (!(flags & NVM_IOTYPE_GC)) {
 			rrpc_unlock_rq(rrpc, rqd);
 			if (rqd->nr_ppas > 1)
-				nvm_dev_dma_free(rrpc->dev,
-			rqd->ppa_list, rqd->dma_ppa_list);
+				nvm_dev_dma_free(dev->parent,
+					rqd->ppa_list, rqd->dma_ppa_list);
 		}
 		return NVM_IO_ERR;
 	}
@@ -997,17 +1058,11 @@ static void rrpc_map_free(struct rrpc *rrpc)
 static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 {
 	struct rrpc *rrpc = (struct rrpc *)private;
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_addr *addr = rrpc->trans_map + slba;
 	struct rrpc_rev_addr *raddr = rrpc->rev_trans_map;
-	u64 elba = slba + nlb;
 	u64 i;
 
-	if (unlikely(elba > dev->total_secs)) {
-		pr_err("nvm: L2P data from device is out of bounds!\n");
-		return -EINVAL;
-	}
-
 	for (i = 0; i < nlb; i++) {
 		u64 pba = le64_to_cpu(entries[i]);
 		unsigned int mod;
@@ -1037,7 +1092,7 @@ static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 static int rrpc_map_init(struct rrpc *rrpc)
 {
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	sector_t i;
 	int ret;
 
@@ -1062,7 +1117,7 @@ static int rrpc_map_init(struct rrpc *rrpc)
 		return 0;
 
 	/* Bring up the mapping table from device */
-	ret = dev->ops->get_l2p_tbl(dev, rrpc->soffset, rrpc->nr_sects,
+	ret = dev->ops->get_l2p_tbl(dev->parent, rrpc->soffset, rrpc->nr_sects,
 					rrpc_l2p_update, rrpc);
 	if (ret) {
 		pr_err("nvm: rrpc: could not read L2P table.\n");
@@ -1102,7 +1157,7 @@ static int rrpc_core_init(struct rrpc *rrpc)
 	if (!rrpc->page_pool)
 		return -ENOMEM;
 
-	rrpc->gcb_pool = mempool_create_slab_pool(rrpc->dev->nr_luns,
+	rrpc->gcb_pool = mempool_create_slab_pool(rrpc->dev->geo.nr_luns,
 								rrpc_gcb_cache);
 	if (!rrpc->gcb_pool)
 		return -ENOMEM;
@@ -1146,11 +1201,12 @@ static void rrpc_luns_free(struct rrpc *rrpc)
 
 static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 {
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct rrpc_lun *rlun;
 	int i, j, ret = -EINVAL;
 
-	if (dev->sec_per_blk > MAX_INVALID_PAGES_STORAGE * BITS_PER_LONG) {
+	if (geo->sec_per_blk > MAX_INVALID_PAGES_STORAGE * BITS_PER_LONG) {
 		pr_err("rrpc: number of pages per block too high.");
 		return -EINVAL;
 	}
@@ -1167,20 +1223,20 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 		int lunid = lun_begin + i;
 		struct nvm_lun *lun;
 
-		lun = dev->mt->get_lun(dev, lunid);
+		lun = dev->mt->get_lun(dev->parent, lunid);
 		if (!lun)
 			goto err;
 
 		rlun = &rrpc->luns[i];
 		rlun->parent = lun;
 		rlun->blocks = vzalloc(sizeof(struct rrpc_block) *
-						rrpc->dev->blks_per_lun);
+							geo->blks_per_lun);
 		if (!rlun->blocks) {
 			ret = -ENOMEM;
 			goto err;
 		}
 
-		for (j = 0; j < rrpc->dev->blks_per_lun; j++) {
+		for (j = 0; j < geo->blks_per_lun; j++) {
 			struct rrpc_block *rblk = &rlun->blocks[j];
 			struct nvm_block *blk = &lun->blocks[j];
 
@@ -1190,6 +1246,8 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 			spin_lock_init(&rblk->lock);
 		}
 
+		rlun->reserved_blocks = 2; /* for GC only */
+
 		rlun->rrpc = rrpc;
 		INIT_LIST_HEAD(&rlun->prio_list);
 		INIT_LIST_HEAD(&rlun->wblk_list);
@@ -1206,27 +1264,27 @@ static int rrpc_luns_init(struct rrpc *rrpc, int lun_begin, int lun_end)
 /* returns 0 on success and stores the beginning address in *begin */
 static int rrpc_area_init(struct rrpc *rrpc, sector_t *begin)
 {
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvmm_type *mt = dev->mt;
-	sector_t size = rrpc->nr_sects * dev->sec_size;
+	sector_t size = rrpc->nr_sects * dev->geo.sec_size;
 	int ret;
 
 	size >>= 9;
 
-	ret = mt->get_area(dev, begin, size);
+	ret = mt->get_area(dev->parent, begin, size);
 	if (!ret)
-		*begin >>= (ilog2(dev->sec_size) - 9);
+		*begin >>= (ilog2(dev->geo.sec_size) - 9);
 
 	return ret;
 }
 
 static void rrpc_area_free(struct rrpc *rrpc)
 {
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvmm_type *mt = dev->mt;
-	sector_t begin = rrpc->soffset << (ilog2(dev->sec_size) - 9);
+	sector_t begin = rrpc->soffset << (ilog2(dev->geo.sec_size) - 9);
 
-	mt->put_area(dev, begin);
+	mt->put_area(dev->parent, begin);
 }
 
 static void rrpc_free(struct rrpc *rrpc)
@@ -1255,11 +1313,11 @@ static void rrpc_exit(void *private)
 static sector_t rrpc_capacity(void *private)
 {
 	struct rrpc *rrpc = private;
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	sector_t reserved, provisioned;
 
 	/* cur, gc, and two emergency blocks for each lun */
-	reserved = rrpc->nr_luns * dev->sec_per_blk * 4;
+	reserved = rrpc->nr_luns * dev->geo.sec_per_blk * 4;
 	provisioned = rrpc->nr_sects - reserved;
 
 	if (reserved > rrpc->nr_sects) {
@@ -1278,13 +1336,13 @@ static sector_t rrpc_capacity(void *private)
  */
 static void rrpc_block_map_update(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
-	struct nvm_dev *dev = rrpc->dev;
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	int offset;
 	struct rrpc_addr *laddr;
 	u64 bpaddr, paddr, pladdr;
 
 	bpaddr = block_to_rel_addr(rrpc, rblk);
-	for (offset = 0; offset < dev->sec_per_blk; offset++) {
+	for (offset = 0; offset < dev->geo.sec_per_blk; offset++) {
 		paddr = bpaddr + offset;
 
 		pladdr = rrpc->rev_trans_map[paddr].addr;
@@ -1304,6 +1362,7 @@ static void rrpc_block_map_update(struct rrpc *rrpc, struct rrpc_block *rblk)
 
 static int rrpc_blocks_init(struct rrpc *rrpc)
 {
+	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_lun *rlun;
 	struct rrpc_block *rblk;
 	int lun_iter, blk_iter;
@@ -1311,7 +1370,7 @@ static int rrpc_blocks_init(struct rrpc *rrpc)
 	for (lun_iter = 0; lun_iter < rrpc->nr_luns; lun_iter++) {
 		rlun = &rrpc->luns[lun_iter];
 
-		for (blk_iter = 0; blk_iter < rrpc->dev->blks_per_lun;
+		for (blk_iter = 0; blk_iter < dev->geo.blks_per_lun;
 								blk_iter++) {
 			rblk = &rlun->blocks[blk_iter];
 			rrpc_block_map_update(rrpc, rblk);
@@ -1350,11 +1409,12 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
 
 static struct nvm_tgt_type tt_rrpc;
 
-static void *rrpc_init(struct nvm_dev *dev, struct gendisk *tdisk,
+static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 						int lun_begin, int lun_end)
 {
 	struct request_queue *bqueue = dev->q;
 	struct request_queue *tqueue = tdisk->queue;
+	struct nvm_geo *geo = &dev->geo;
 	struct rrpc *rrpc;
 	sector_t soffset;
 	int ret;
@@ -1377,8 +1437,8 @@ static void *rrpc_init(struct nvm_dev *dev, struct gendisk *tdisk,
 	spin_lock_init(&rrpc->bio_lock);
 	INIT_WORK(&rrpc->ws_requeue, rrpc_requeue);
 
-	rrpc->nr_luns = lun_end - lun_begin + 1;
-	rrpc->nr_sects = (unsigned long long)dev->sec_per_lun * rrpc->nr_luns;
+	rrpc->nr_luns = geo->nr_luns;
+	rrpc->nr_sects = (unsigned long long)geo->sec_per_lun * rrpc->nr_luns;
 
 	/* simple round-robin strategy */
 	atomic_set(&rrpc->next_lun, -1);
@@ -1396,7 +1456,7 @@ static void *rrpc_init(struct nvm_dev *dev, struct gendisk *tdisk,
 		goto err;
 	}
 
-	rrpc->poffset = dev->sec_per_lun * lun_begin;
+	rrpc->poffset = geo->sec_per_lun * lun_begin;
 
 	ret = rrpc_core_init(rrpc);
 	if (ret) {
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index bed49ba..242d4c1 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -52,9 +52,12 @@ struct rrpc_rq {
 };
 
 struct rrpc_block {
+	unsigned long id;
 	struct nvm_block *parent;
 	struct rrpc_lun *rlun;
-	struct list_head prio;
+
+	struct list_head prio;		/* LUN CG list */
+	struct list_head list;		/* LUN free, used, bb list */
 
 #define MAX_INVALID_PAGES_STORAGE 8
 	/* Bitmap for invalid page intries */
@@ -64,6 +67,8 @@ struct rrpc_block {
 	/* number of pages that are invalid, wrt host page size */
 	unsigned int nr_invalid_pages;
 
+	int state;
+
 	spinlock_t lock;
 	atomic_t data_cmnt_size; /* data pages committed to stable storage */
 };
@@ -71,6 +76,7 @@ struct rrpc_block {
 struct rrpc_lun {
 	struct rrpc *rrpc;
 	struct nvm_lun *parent;
+
 	struct rrpc_block *cur, *gc_cur;
 	struct rrpc_block *blocks;	/* Reference to block allocation */
 
@@ -79,6 +85,8 @@ struct rrpc_lun {
 
 	struct work_struct ws_gc;
 
+	int reserved_blocks;
+
 	spinlock_t lock;
 };
 
@@ -86,7 +94,7 @@ struct rrpc {
 	/* instance must be kept in top to resolve rrpc in unprep */
 	struct nvm_tgt_instance instance;
 
-	struct nvm_dev *dev;
+	struct nvm_tgt_dev *dev;
 	struct gendisk *disk;
 
 	sector_t soffset; /* logical sector offset */
@@ -151,7 +159,8 @@ static inline struct rrpc_block *rrpc_get_rblk(struct rrpc_lun *rlun,
 								int blk_id)
 {
 	struct rrpc *rrpc = rlun->rrpc;
-	int lun_blk = blk_id % rrpc->dev->blks_per_lun;
+	struct nvm_tgt_dev *dev = rrpc->dev;
+	int lun_blk = blk_id % dev->geo.blks_per_lun;
 
 	return &rlun->blocks[lun_blk];
 }
diff --git a/drivers/lightnvm/sysblk.c b/drivers/lightnvm/sysblk.c
index fa644af..12002bf 100644
--- a/drivers/lightnvm/sysblk.c
+++ b/drivers/lightnvm/sysblk.c
@@ -62,7 +62,8 @@ static void nvm_cpu_to_sysblk(struct nvm_system_block *sb,
 
 static int nvm_setup_sysblks(struct nvm_dev *dev, struct ppa_addr *sysblk_ppas)
 {
-	int nr_rows = min_t(int, MAX_SYSBLKS, dev->nr_chnls);
+	struct nvm_geo *geo = &dev->geo;
+	int nr_rows = min_t(int, MAX_SYSBLKS, geo->nr_chnls);
 	int i;
 
 	for (i = 0; i < nr_rows; i++)
@@ -71,7 +72,7 @@ static int nvm_setup_sysblks(struct nvm_dev *dev, struct ppa_addr *sysblk_ppas)
 	/* if possible, place sysblk at first channel, middle channel and last
 	 * channel of the device. If not, create only one or two sys blocks
 	 */
-	switch (dev->nr_chnls) {
+	switch (geo->nr_chnls) {
 	case 2:
 		sysblk_ppas[1].g.ch = 1;
 		/* fall-through */
@@ -80,8 +81,8 @@ static int nvm_setup_sysblks(struct nvm_dev *dev, struct ppa_addr *sysblk_ppas)
 		break;
 	default:
 		sysblk_ppas[0].g.ch = 0;
-		sysblk_ppas[1].g.ch = dev->nr_chnls / 2;
-		sysblk_ppas[2].g.ch = dev->nr_chnls - 1;
+		sysblk_ppas[1].g.ch = geo->nr_chnls / 2;
+		sysblk_ppas[2].g.ch = geo->nr_chnls - 1;
 		break;
 	}
 
@@ -162,11 +163,12 @@ static int sysblk_get_host_blks(struct nvm_dev *dev, struct ppa_addr ppa,
 static int nvm_get_all_sysblks(struct nvm_dev *dev, struct sysblk_scan *s,
 				struct ppa_addr *ppas, int get_free)
 {
+	struct nvm_geo *geo = &dev->geo;
 	int i, nr_blks, ret = 0;
 	u8 *blks;
 
 	s->nr_ppas = 0;
-	nr_blks = dev->blks_per_lun * dev->plane_mode;
+	nr_blks = geo->blks_per_lun * geo->plane_mode;
 
 	blks = kmalloc(nr_blks, GFP_KERNEL);
 	if (!blks)
@@ -210,13 +212,14 @@ static int nvm_get_all_sysblks(struct nvm_dev *dev, struct sysblk_scan *s,
 static int nvm_scan_block(struct nvm_dev *dev, struct ppa_addr *ppa,
 						struct nvm_system_block *sblk)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct nvm_system_block *cur;
 	int pg, ret, found = 0;
 
 	/* the full buffer for a flash page is allocated. Only the first of it
 	 * contains the system block information
 	 */
-	cur = kmalloc(dev->pfpg_size, GFP_KERNEL);
+	cur = kmalloc(geo->pfpg_size, GFP_KERNEL);
 	if (!cur)
 		return -ENOMEM;
 
@@ -225,7 +228,7 @@ static int nvm_scan_block(struct nvm_dev *dev, struct ppa_addr *ppa,
 		ppa->g.pg = ppa_to_slc(dev, pg);
 
 		ret = nvm_submit_ppa(dev, ppa, 1, NVM_OP_PREAD, NVM_IO_SLC_MODE,
-							cur, dev->pfpg_size);
+							cur, geo->pfpg_size);
 		if (ret) {
 			if (ret == NVM_RSP_ERR_EMPTYPAGE) {
 				pr_debug("nvm: sysblk scan empty ppa (%u %u %u %u)\n",
@@ -276,6 +279,7 @@ static int nvm_sysblk_set_bb_tbl(struct nvm_dev *dev, struct sysblk_scan *s,
 static int nvm_write_and_verify(struct nvm_dev *dev, struct nvm_sb_info *info,
 							struct sysblk_scan *s)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct nvm_system_block nvmsb;
 	void *buf;
 	int i, sect, ret = 0;
@@ -283,12 +287,12 @@ static int nvm_write_and_verify(struct nvm_dev *dev, struct nvm_sb_info *info,
 
 	nvm_cpu_to_sysblk(&nvmsb, info);
 
-	buf = kzalloc(dev->pfpg_size, GFP_KERNEL);
+	buf = kzalloc(geo->pfpg_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	memcpy(buf, &nvmsb, sizeof(struct nvm_system_block));
 
-	ppas = kcalloc(dev->sec_per_pg, sizeof(struct ppa_addr), GFP_KERNEL);
+	ppas = kcalloc(geo->sec_per_pg, sizeof(struct ppa_addr), GFP_KERNEL);
 	if (!ppas) {
 		ret = -ENOMEM;
 		goto err;
@@ -305,15 +309,15 @@ static int nvm_write_and_verify(struct nvm_dev *dev, struct nvm_sb_info *info,
 							ppas[0].g.pg);
 
 		/* Expand to all sectors within a flash page */
-		if (dev->sec_per_pg > 1) {
-			for (sect = 1; sect < dev->sec_per_pg; sect++) {
+		if (geo->sec_per_pg > 1) {
+			for (sect = 1; sect < geo->sec_per_pg; sect++) {
 				ppas[sect].ppa = ppas[0].ppa;
 				ppas[sect].g.sec = sect;
 			}
 		}
 
-		ret = nvm_submit_ppa(dev, ppas, dev->sec_per_pg, NVM_OP_PWRITE,
-					NVM_IO_SLC_MODE, buf, dev->pfpg_size);
+		ret = nvm_submit_ppa(dev, ppas, geo->sec_per_pg, NVM_OP_PWRITE,
+					NVM_IO_SLC_MODE, buf, geo->pfpg_size);
 		if (ret) {
 			pr_err("nvm: sysblk failed program (%u %u %u)\n",
 							ppas[0].g.ch,
@@ -322,8 +326,8 @@ static int nvm_write_and_verify(struct nvm_dev *dev, struct nvm_sb_info *info,
 			break;
 		}
 
-		ret = nvm_submit_ppa(dev, ppas, dev->sec_per_pg, NVM_OP_PREAD,
-					NVM_IO_SLC_MODE, buf, dev->pfpg_size);
+		ret = nvm_submit_ppa(dev, ppas, geo->sec_per_pg, NVM_OP_PREAD,
+					NVM_IO_SLC_MODE, buf, geo->pfpg_size);
 		if (ret) {
 			pr_err("nvm: sysblk failed read (%u %u %u)\n",
 							ppas[0].g.ch,
@@ -527,6 +531,7 @@ int nvm_update_sysblock(struct nvm_dev *dev, struct nvm_sb_info *new)
 
 int nvm_init_sysblock(struct nvm_dev *dev, struct nvm_sb_info *info)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
 	struct sysblk_scan s;
 	int ret;
@@ -541,7 +546,7 @@ int nvm_init_sysblock(struct nvm_dev *dev, struct nvm_sb_info *info)
 	if (!dev->ops->get_bb_tbl || !dev->ops->set_bb_tbl)
 		return -EINVAL;
 
-	if (!(dev->mccap & NVM_ID_CAP_SLC) || !dev->lps_per_blk) {
+	if (!(geo->mccap & NVM_ID_CAP_SLC) || !dev->lps_per_blk) {
 		pr_err("nvm: memory does not support SLC access\n");
 		return -EINVAL;
 	}
@@ -571,11 +576,11 @@ static int factory_nblks(int nblks)
 	return (nblks + (BITS_PER_LONG - 1)) & ~(BITS_PER_LONG - 1);
 }
 
-static unsigned int factory_blk_offset(struct nvm_dev *dev, struct ppa_addr ppa)
+static unsigned int factory_blk_offset(struct nvm_geo *geo, struct ppa_addr ppa)
 {
-	int nblks = factory_nblks(dev->blks_per_lun);
+	int nblks = factory_nblks(geo->blks_per_lun);
 
-	return ((ppa.g.ch * dev->luns_per_chnl * nblks) + (ppa.g.lun * nblks)) /
+	return ((ppa.g.ch * geo->luns_per_chnl * nblks) + (ppa.g.lun * nblks)) /
 								BITS_PER_LONG;
 }
 
@@ -589,7 +594,7 @@ static int nvm_factory_blks(struct nvm_dev *dev, struct ppa_addr ppa,
 	if (nr_blks < 0)
 		return nr_blks;
 
-	lunoff = factory_blk_offset(dev, ppa);
+	lunoff = factory_blk_offset(&dev->geo, ppa);
 
 	/* non-set bits correspond to the block must be erased */
 	for (i = 0; i < nr_blks; i++) {
@@ -618,19 +623,19 @@ static int nvm_factory_blks(struct nvm_dev *dev, struct ppa_addr ppa,
 static int nvm_fact_get_blks(struct nvm_dev *dev, struct ppa_addr *erase_list,
 					int max_ppas, unsigned long *blk_bitmap)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr ppa;
 	int ch, lun, blkid, idx, done = 0, ppa_cnt = 0;
 	unsigned long *offset;
 
 	while (!done) {
 		done = 1;
-		nvm_for_each_lun_ppa(dev, ppa, ch, lun) {
-			idx = factory_blk_offset(dev, ppa);
+		nvm_for_each_lun_ppa(geo, ppa, ch, lun) {
+			idx = factory_blk_offset(geo, ppa);
 			offset = &blk_bitmap[idx];
 
-			blkid = find_first_zero_bit(offset,
-						dev->blks_per_lun);
-			if (blkid >= dev->blks_per_lun)
+			blkid = find_first_zero_bit(offset, geo->blks_per_lun);
+			if (blkid >= geo->blks_per_lun)
 				continue;
 			set_bit(blkid, offset);
 
@@ -655,16 +660,17 @@ static int nvm_fact_get_blks(struct nvm_dev *dev, struct ppa_addr *erase_list,
 static int nvm_fact_select_blks(struct nvm_dev *dev, unsigned long *blk_bitmap,
 								int flags)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr ppa;
 	int ch, lun, nr_blks, ret = 0;
 	u8 *blks;
 
-	nr_blks = dev->blks_per_lun * dev->plane_mode;
+	nr_blks = geo->blks_per_lun * geo->plane_mode;
 	blks = kmalloc(nr_blks, GFP_KERNEL);
 	if (!blks)
 		return -ENOMEM;
 
-	nvm_for_each_lun_ppa(dev, ppa, ch, lun) {
+	nvm_for_each_lun_ppa(geo, ppa, ch, lun) {
 		ret = nvm_get_bb_tbl(dev, ppa, blks);
 		if (ret)
 			pr_err("nvm: failed bb tbl for ch%u lun%u\n",
@@ -682,14 +688,15 @@ static int nvm_fact_select_blks(struct nvm_dev *dev, unsigned long *blk_bitmap,
 
 int nvm_dev_factory(struct nvm_dev *dev, int flags)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppas;
 	int ppa_cnt, ret = -ENOMEM;
-	int max_ppas = dev->ops->max_phys_sect / dev->nr_planes;
+	int max_ppas = dev->ops->max_phys_sect / geo->nr_planes;
 	struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
 	struct sysblk_scan s;
 	unsigned long *blk_bitmap;
 
-	blk_bitmap = kzalloc(factory_nblks(dev->blks_per_lun) * dev->nr_luns,
+	blk_bitmap = kzalloc(factory_nblks(geo->blks_per_lun) * geo->nr_luns,
 								GFP_KERNEL);
 	if (!blk_bitmap)
 		return ret;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 037dff5..1cdc812 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -352,6 +352,7 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 
 	while (nlb) {
 		u32 cmd_nlb = min(nlb_pr_rq, nlb);
+		u64 elba = slba + cmd_nlb;
 
 		c.l2p.slba = cpu_to_le64(cmd_slba);
 		c.l2p.nlb = cpu_to_le32(cmd_nlb);
@@ -365,6 +366,11 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 			goto out;
 		}
 
+		if (unlikely(elba > nvmdev->total_secs)) {
+			pr_err("nvm: L2P data from device is out of bounds!\n");
+			return -EINVAL;
+		}
+
 		if (update_l2p(cmd_slba, cmd_nlb, entries, priv)) {
 			ret = -EINTR;
 			goto out;
@@ -383,11 +389,12 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 								u8 *blks)
 {
 	struct request_queue *q = nvmdev->q;
+	struct nvm_geo *geo = &nvmdev->geo;
 	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_nvm_command c = {};
 	struct nvme_nvm_bb_tbl *bb_tbl;
-	int nr_blks = nvmdev->blks_per_lun * nvmdev->plane_mode;
+	int nr_blks = geo->blks_per_lun * geo->plane_mode;
 	int tblsz = sizeof(struct nvme_nvm_bb_tbl) + nr_blks;
 	int ret = 0;
 
@@ -428,7 +435,7 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 		goto out;
 	}
 
-	memcpy(blks, bb_tbl->blk, nvmdev->blks_per_lun * nvmdev->plane_mode);
+	memcpy(blks, bb_tbl->blk, geo->blks_per_lun * geo->plane_mode);
 out:
 	kfree(bb_tbl);
 	return ret;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 89c6954..1f1588c 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -211,7 +211,7 @@ struct nvm_id {
 struct nvm_target {
 	struct list_head list;
 	struct list_head lun_list;
-	struct nvm_dev *dev;
+	struct nvm_tgt_dev *dev;
 	struct nvm_tgt_type *type;
 	struct gendisk *disk;
 };
@@ -286,7 +286,6 @@ struct nvm_lun {
 					 * free_list and used_list
 					 */
 	unsigned int nr_free_blocks;	/* Number of unused blocks */
-	int reserved_blocks;
 
 	struct nvm_block *blocks;
 };
@@ -315,22 +314,12 @@ struct nvm_sb_info {
 	struct ppa_addr		fs_ppa;
 };
 
-struct nvm_dev {
-	struct nvm_dev_ops *ops;
-
-	struct list_head devices;
-
-	/* Media manager */
-	struct nvmm_type *mt;
-	void *mp;
-
-	/* System blocks */
-	struct nvm_sb_info sb;
-
-	/* Device information */
+/* Device generic information */
+struct nvm_geo {
 	int nr_chnls;
+	int nr_luns;
+	int luns_per_chnl; /* -1 if channels are not symmetric */
 	int nr_planes;
-	int luns_per_chnl;
 	int sec_per_pg; /* only sectors for a single page */
 	int pgs_per_blk;
 	int blks_per_lun;
@@ -350,14 +339,43 @@ struct nvm_dev {
 	int sec_per_pl; /* all sectors across planes */
 	int sec_per_blk;
 	int sec_per_lun;
+};
+
+struct nvm_tgt_dev {
+	/* Device information */
+	struct nvm_geo geo;
+
+	sector_t total_secs;
+
+	struct nvm_id identity;
+	struct request_queue *q;
+
+	struct nvmm_type *mt;
+	struct nvm_dev_ops *ops;
+
+	void *parent;
+};
+
+struct nvm_dev {
+	struct nvm_dev_ops *ops;
+
+	struct list_head devices;
+
+	/* Media manager */
+	struct nvmm_type *mt;
+	void *mp;
+
+	/* System blocks */
+	struct nvm_sb_info sb;
+
+	/* Device information */
+	struct nvm_geo geo;
 
 	/* lower page table */
 	int lps_per_blk;
 	int *lptbl;
 
-	unsigned long total_blocks;
 	unsigned long total_secs;
-	int nr_luns;
 
 	unsigned long *lun_map;
 	void *dma_pool;
@@ -373,7 +391,7 @@ struct nvm_dev {
 	spinlock_t lock;
 };
 
-static inline struct ppa_addr linear_to_generic_addr(struct nvm_dev *dev,
+static inline struct ppa_addr linear_to_generic_addr(struct nvm_geo *geo,
 							struct ppa_addr r)
 {
 	struct ppa_addr l;
@@ -382,22 +400,22 @@ static inline struct ppa_addr linear_to_generic_addr(struct nvm_dev *dev,
 
 	l.ppa = 0;
 
-	div_u64_rem(ppa, dev->sec_per_pg, &secs);
+	div_u64_rem(ppa, geo->sec_per_pg, &secs);
 	l.g.sec = secs;
 
-	sector_div(ppa, dev->sec_per_pg);
-	div_u64_rem(ppa, dev->pgs_per_blk, &pgs);
+	sector_div(ppa, geo->sec_per_pg);
+	div_u64_rem(ppa, geo->pgs_per_blk, &pgs);
 	l.g.pg = pgs;
 
-	sector_div(ppa, dev->pgs_per_blk);
-	div_u64_rem(ppa, dev->blks_per_lun, &blks);
+	sector_div(ppa, geo->pgs_per_blk);
+	div_u64_rem(ppa, geo->blks_per_lun, &blks);
 	l.g.blk = blks;
 
-	sector_div(ppa, dev->blks_per_lun);
-	div_u64_rem(ppa, dev->luns_per_chnl, &luns);
+	sector_div(ppa, geo->blks_per_lun);
+	div_u64_rem(ppa, geo->luns_per_chnl, &luns);
 	l.g.lun = luns;
 
-	sector_div(ppa, dev->luns_per_chnl);
+	sector_div(ppa, geo->luns_per_chnl);
 	l.g.ch = ppa;
 
 	return l;
@@ -406,14 +424,15 @@ static inline struct ppa_addr linear_to_generic_addr(struct nvm_dev *dev,
 static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 						struct ppa_addr r)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr l;
 
-	l.ppa = ((u64)r.g.blk) << dev->ppaf.blk_offset;
-	l.ppa |= ((u64)r.g.pg) << dev->ppaf.pg_offset;
-	l.ppa |= ((u64)r.g.sec) << dev->ppaf.sect_offset;
-	l.ppa |= ((u64)r.g.pl) << dev->ppaf.pln_offset;
-	l.ppa |= ((u64)r.g.lun) << dev->ppaf.lun_offset;
-	l.ppa |= ((u64)r.g.ch) << dev->ppaf.ch_offset;
+	l.ppa = ((u64)r.g.blk) << geo->ppaf.blk_offset;
+	l.ppa |= ((u64)r.g.pg) << geo->ppaf.pg_offset;
+	l.ppa |= ((u64)r.g.sec) << geo->ppaf.sect_offset;
+	l.ppa |= ((u64)r.g.pl) << geo->ppaf.pln_offset;
+	l.ppa |= ((u64)r.g.lun) << geo->ppaf.lun_offset;
+	l.ppa |= ((u64)r.g.ch) << geo->ppaf.ch_offset;
 
 	return l;
 }
@@ -421,24 +440,25 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 						struct ppa_addr r)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr l;
 
 	l.ppa = 0;
 	/*
 	 * (r.ppa << X offset) & X len bitmask. X eq. blk, pg, etc.
 	 */
-	l.g.blk = (r.ppa >> dev->ppaf.blk_offset) &
-					(((1 << dev->ppaf.blk_len) - 1));
-	l.g.pg |= (r.ppa >> dev->ppaf.pg_offset) &
-					(((1 << dev->ppaf.pg_len) - 1));
-	l.g.sec |= (r.ppa >> dev->ppaf.sect_offset) &
-					(((1 << dev->ppaf.sect_len) - 1));
-	l.g.pl |= (r.ppa >> dev->ppaf.pln_offset) &
-					(((1 << dev->ppaf.pln_len) - 1));
-	l.g.lun |= (r.ppa >> dev->ppaf.lun_offset) &
-					(((1 << dev->ppaf.lun_len) - 1));
-	l.g.ch |= (r.ppa >> dev->ppaf.ch_offset) &
-					(((1 << dev->ppaf.ch_len) - 1));
+	l.g.blk = (r.ppa >> geo->ppaf.blk_offset) &
+					(((1 << geo->ppaf.blk_len) - 1));
+	l.g.pg |= (r.ppa >> geo->ppaf.pg_offset) &
+					(((1 << geo->ppaf.pg_len) - 1));
+	l.g.sec |= (r.ppa >> geo->ppaf.sect_offset) &
+					(((1 << geo->ppaf.sect_len) - 1));
+	l.g.pl |= (r.ppa >> geo->ppaf.pln_offset) &
+					(((1 << geo->ppaf.pln_len) - 1));
+	l.g.lun |= (r.ppa >> geo->ppaf.lun_offset) &
+					(((1 << geo->ppaf.lun_len) - 1));
+	l.g.ch |= (r.ppa >> geo->ppaf.ch_offset) &
+					(((1 << geo->ppaf.ch_len) - 1));
 
 	return l;
 }
@@ -456,11 +476,12 @@ static inline void ppa_set_empty(struct ppa_addr *ppa_addr)
 static inline struct ppa_addr block_to_ppa(struct nvm_dev *dev,
 							struct nvm_block *blk)
 {
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr ppa;
 	struct nvm_lun *lun = blk->lun;
 
 	ppa.ppa = 0;
-	ppa.g.blk = blk->id % dev->blks_per_lun;
+	ppa.g.blk = blk->id % geo->blks_per_lun;
 	ppa.g.lun = lun->lun_id;
 	ppa.g.ch = lun->chnl_id;
 
@@ -483,7 +504,8 @@ static inline int ppa_to_slc(struct nvm_dev *dev, int slc_pg)
 
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
-typedef void *(nvm_tgt_init_fn)(struct nvm_dev *, struct gendisk *, int, int);
+typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *, int,
+				int);
 typedef void (nvm_tgt_exit_fn)(void *);
 
 struct nvm_tgt_type {
@@ -516,9 +538,6 @@ typedef void (nvmm_unregister_fn)(struct nvm_dev *);
 
 typedef int (nvmm_create_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_create *);
 typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
-typedef struct nvm_block *(nvmm_get_blk_fn)(struct nvm_dev *,
-					      struct nvm_lun *, unsigned long);
-typedef void (nvmm_put_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
@@ -538,10 +557,6 @@ struct nvmm_type {
 	nvmm_create_tgt_fn *create_tgt;
 	nvmm_remove_tgt_fn *remove_tgt;
 
-	/* Block administration callbacks */
-	nvmm_get_blk_fn *get_blk;
-	nvmm_put_blk_fn *put_blk;
-
 	nvmm_submit_io_fn *submit_io;
 	nvmm_erase_blk_fn *erase_blk;
 
@@ -563,10 +578,6 @@ struct nvmm_type {
 extern int nvm_register_mgr(struct nvmm_type *);
 extern void nvm_unregister_mgr(struct nvmm_type *);
 
-extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *,
-								unsigned long);
-extern void nvm_put_blk(struct nvm_dev *, struct nvm_block *);
-
 extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
@@ -611,10 +622,10 @@ extern int nvm_init_sysblock(struct nvm_dev *, struct nvm_sb_info *);
 
 extern int nvm_dev_factory(struct nvm_dev *, int flags);
 
-#define nvm_for_each_lun_ppa(dev, ppa, chid, lunid)			\
-	for ((chid) = 0, (ppa).ppa = 0; (chid) < (dev)->nr_chnls;	\
+#define nvm_for_each_lun_ppa(geo, ppa, chid, lunid)			\
+	for ((chid) = 0, (ppa).ppa = 0; (chid) < (geo)->nr_chnls;	\
 					(chid)++, (ppa).g.ch = (chid))	\
-		for ((lunid) = 0; (lunid) < (dev)->luns_per_chnl;	\
+		for ((lunid) = 0; (lunid) < (geo)->luns_per_chnl;	\
 					(lunid)++, (ppa).g.lun = (lunid))
 
 #else /* CONFIG_NVM */
-- 
2.7.4

