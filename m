Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35663 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932179AbcKROoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:12 -0500
Received: by mail-wm0-f53.google.com with SMTP id a197so42656273wmd.0
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:12 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 17/20] lightnvm: eliminate nvm_lun abstraction in mm
Date: Fri, 18 Nov 2016 15:43:39 +0100
Message-Id: <1479480222-18790-18-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In order to naturally support multi-target instances on an Open-Channel
SSD, targets should own the LUNs they get blocks from and manage
provisioning internally. This is done in several steps.

Since targets own the LUNs the are instantiated on top of and manage the
free block list internally, there is no need for a LUN abstraction in
the media manager. LUNs are intrinsically managed as in the physical
layout (ch:0,lun:0, ..., ch:0,lun:n, ch:1,lun:0, ch:1,lun:n, ...,
ch:m,lun:0, ch:m,lun:n) and given to the targets based on the target
creation ioctl. This simplifies LUN management and clears the path for a
partition manager to sit directly underneath LightNVM targets.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      |  14 +-
 drivers/lightnvm/gennvm.c    | 336 ++++++++++++++++++++++++++++++++++---------
 drivers/lightnvm/gennvm.h    |  20 ++-
 drivers/lightnvm/rrpc.c      | 142 +++++++++---------
 drivers/lightnvm/rrpc.h      |  32 ++++-
 drivers/nvme/host/lightnvm.c |   3 +
 include/linux/lightnvm.h     |  41 +++---
 7 files changed, 422 insertions(+), 166 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 691b16f..23d582f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -203,15 +203,19 @@ int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
 }
 EXPORT_SYMBOL(nvm_set_bb_tbl);
 
-int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
+int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
-	return dev->mt->submit_io(dev, rqd);
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	return dev->mt->submit_io(tgt_dev, rqd);
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-int nvm_erase_blk(struct nvm_dev *dev, struct ppa_addr *p, int flags)
+int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p, int flags)
 {
-	return dev->mt->erase_blk(dev, p, flags);
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	return dev->mt->erase_blk(tgt_dev, p, flags);
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
@@ -350,7 +354,7 @@ static int __nvm_submit_ppa(struct nvm_dev *dev, struct nvm_rq *rqd, int opcode,
 
 	nvm_generic_to_addr_mode(dev, rqd);
 
-	rqd->dev = dev;
+	rqd->dev = NULL;
 	rqd->opcode = opcode;
 	rqd->flags = flags;
 	rqd->bio = bio;
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 19c3924..5d7c8c4 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -38,8 +38,6 @@ static const struct block_device_operations gen_fops = {
 static int gen_reserve_luns(struct nvm_dev *dev, struct nvm_target *t,
 			    int lun_begin, int lun_end)
 {
-	struct gen_dev *gn = dev->mp;
-	struct nvm_lun *lun;
 	int i;
 
 	for (i = lun_begin; i <= lun_end; i++) {
@@ -47,35 +45,50 @@ static int gen_reserve_luns(struct nvm_dev *dev, struct nvm_target *t,
 			pr_err("nvm: lun %d already allocated\n", i);
 			goto err;
 		}
-
-		lun = &gn->luns[i];
-		list_add_tail(&lun->list, &t->lun_list);
 	}
 
 	return 0;
 
 err:
-	while (--i > lun_begin) {
-		lun = &gn->luns[i];
+	while (--i > lun_begin)
 		clear_bit(i, dev->lun_map);
-		list_del(&lun->list);
-	}
 
 	return -EBUSY;
 }
 
-static void gen_release_luns(struct nvm_dev *dev, struct nvm_target *t)
+static void gen_release_luns_err(struct nvm_dev *dev, int lun_begin,
+				 int lun_end)
 {
-	struct nvm_lun *lun, *tmp;
+	int i;
 
-	list_for_each_entry_safe(lun, tmp, &t->lun_list, list) {
-		WARN_ON(!test_and_clear_bit(lun->id, dev->lun_map));
-		list_del(&lun->list);
-	}
+	for (i = lun_begin; i <= lun_end; i++)
+		WARN_ON(!test_and_clear_bit(i, dev->lun_map));
 }
 
 static void gen_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct gen_dev_map *dev_map = tgt_dev->map;
+	int i, j;
+
+	for (i = 0; i < dev_map->nr_chnls; i++) {
+		struct gen_ch_map *ch_map = &dev_map->chnls[i];
+		int *lun_offs = ch_map->lun_offs;
+		int ch = i + ch_map->ch_off;
+
+		for (j = 0; j < ch_map->nr_luns; j++) {
+			int lun = j + lun_offs[j];
+			int lunid = (ch * dev->geo.luns_per_chnl) + lun;
+
+			WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
+		}
+
+		kfree(ch_map->lun_offs);
+	}
+
+	kfree(dev_map->chnls);
+	kfree(dev_map);
+	kfree(tgt_dev->luns);
 	kfree(tgt_dev);
 }
 
@@ -83,24 +96,103 @@ static struct nvm_tgt_dev *gen_create_tgt_dev(struct nvm_dev *dev,
 					      int lun_begin, int lun_end)
 {
 	struct nvm_tgt_dev *tgt_dev = NULL;
+	struct gen_dev_map *dev_rmap = dev->rmap;
+	struct gen_dev_map *dev_map;
+	struct ppa_addr *luns;
 	int nr_luns = lun_end - lun_begin + 1;
+	int luns_left = nr_luns;
+	int nr_chnls = nr_luns / dev->geo.luns_per_chnl;
+	int nr_chnls_mod = nr_luns % dev->geo.luns_per_chnl;
+	int bch = lun_begin / dev->geo.luns_per_chnl;
+	int blun = lun_begin % dev->geo.luns_per_chnl;
+	int lunid = 0;
+	int lun_balanced = 1;
+	int prev_nr_luns;
+	int i, j;
+
+	nr_chnls = nr_luns / dev->geo.luns_per_chnl;
+	nr_chnls = (nr_chnls_mod == 0) ? nr_chnls : nr_chnls + 1;
+
+	dev_map = kmalloc(sizeof(struct gen_dev_map), GFP_KERNEL);
+	if (!dev_map)
+		goto err_dev;
+
+	dev_map->chnls = kcalloc(nr_chnls, sizeof(struct gen_ch_map),
+								GFP_KERNEL);
+	if (!dev_map->chnls)
+		goto err_chnls;
+
+	luns = kcalloc(nr_luns, sizeof(struct ppa_addr), GFP_KERNEL);
+	if (!luns)
+		goto err_luns;
+
+	prev_nr_luns = (luns_left > dev->geo.luns_per_chnl) ?
+					dev->geo.luns_per_chnl : luns_left;
+	for (i = 0; i < nr_chnls; i++) {
+		struct gen_ch_map *ch_rmap = &dev_rmap->chnls[i + bch];
+		int *lun_roffs = ch_rmap->lun_offs;
+		struct gen_ch_map *ch_map = &dev_map->chnls[i];
+		int *lun_offs;
+		int luns_in_chnl = (luns_left > dev->geo.luns_per_chnl) ?
+					dev->geo.luns_per_chnl : luns_left;
+
+		if (lun_balanced && prev_nr_luns != luns_in_chnl)
+			lun_balanced = 0;
+
+		ch_map->ch_off = ch_rmap->ch_off = bch;
+		ch_map->nr_luns = luns_in_chnl;
+
+		lun_offs = kcalloc(luns_in_chnl, sizeof(int), GFP_KERNEL);
+		if (!lun_offs)
+			goto err_ch;
+
+		for (j = 0; j < luns_in_chnl; j++) {
+			luns[lunid].ppa = 0;
+			luns[lunid].g.ch = i;
+			luns[lunid++].g.lun = j;
+
+			lun_offs[j] = blun;
+			lun_roffs[j + blun] = blun;
+		}
+
+		ch_map->lun_offs = lun_offs;
+
+		/* when starting a new channel, lun offset is reset */
+		blun = 0;
+		luns_left -= luns_in_chnl;
+	}
+
+	dev_map->nr_chnls = nr_chnls;
 
 	tgt_dev = kmalloc(sizeof(struct nvm_tgt_dev), GFP_KERNEL);
 	if (!tgt_dev)
-		goto out;
+		goto err_ch;
 
 	memcpy(&tgt_dev->geo, &dev->geo, sizeof(struct nvm_geo));
-	tgt_dev->geo.nr_chnls = (nr_luns / (dev->geo.luns_per_chnl + 1)) + 1;
+	/* Target device only owns a portion of the physical device */
+	tgt_dev->geo.nr_chnls = nr_chnls;
 	tgt_dev->geo.nr_luns = nr_luns;
+	tgt_dev->geo.luns_per_chnl = (lun_balanced) ? prev_nr_luns : -1;
 	tgt_dev->total_secs = nr_luns * tgt_dev->geo.sec_per_lun;
 	tgt_dev->q = dev->q;
 	tgt_dev->ops = dev->ops;
 	tgt_dev->mt = dev->mt;
+	tgt_dev->map = dev_map;
+	tgt_dev->luns = luns;
 	memcpy(&tgt_dev->identity, &dev->identity, sizeof(struct nvm_id));
 
 	tgt_dev->parent = dev;
 
-out:
+	return tgt_dev;
+err_ch:
+	while (--i > 0)
+		kfree(dev_map->chnls[i].lun_offs);
+	kfree(luns);
+err_luns:
+	kfree(dev_map->chnls);
+err_chnls:
+	kfree(dev_map);
+err_dev:
 	return tgt_dev;
 }
 
@@ -134,14 +226,14 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	if (!t)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&t->lun_list);
-
 	if (gen_reserve_luns(dev, t, s->lun_begin, s->lun_end))
 		goto err_t;
 
 	tgt_dev = gen_create_tgt_dev(dev, s->lun_begin, s->lun_end);
-	if (!tgt_dev)
+	if (!tgt_dev) {
+		pr_err("nvm: could not create target device\n");
 		goto err_reserve;
+	}
 
 	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
 	if (!tqueue)
@@ -159,7 +251,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 	tdisk->fops = &gen_fops;
 	tdisk->queue = tqueue;
 
-	targetdata = tt->init(tgt_dev, tdisk, &t->lun_list);
+	targetdata = tt->init(tgt_dev, tdisk);
 	if (IS_ERR(targetdata))
 		goto err_init;
 
@@ -187,7 +279,7 @@ static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 err_dev:
 	kfree(tgt_dev);
 err_reserve:
-	gen_release_luns(dev, t);
+	gen_release_luns_err(dev, s->lun_begin, s->lun_end);
 err_t:
 	kfree(t);
 	return -ENOMEM;
@@ -205,7 +297,6 @@ static void __gen_remove_target(struct nvm_target *t)
 	if (tt->exit)
 		tt->exit(tdisk->private_data);
 
-	gen_release_luns(t->dev->parent, t);
 	gen_remove_tgt_dev(t->dev);
 	put_disk(tdisk);
 
@@ -306,51 +397,54 @@ static void gen_put_area(struct nvm_dev *dev, sector_t begin)
 	spin_unlock(&dev->lock);
 }
 
-static void gen_luns_free(struct nvm_dev *dev)
-{
-	struct gen_dev *gn = dev->mp;
-
-	kfree(gn->luns);
-}
-
-static int gen_luns_init(struct nvm_dev *dev, struct gen_dev *gn)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct nvm_lun *lun;
-	int i;
-
-	gn->luns = kcalloc(geo->nr_luns, sizeof(struct nvm_lun), GFP_KERNEL);
-	if (!gn->luns)
-		return -ENOMEM;
-
-	gen_for_each_lun(gn, lun, i) {
-		INIT_LIST_HEAD(&lun->list);
-
-		lun->id = i;
-		lun->lun_id = i % geo->luns_per_chnl;
-		lun->chnl_id = i / geo->luns_per_chnl;
-	}
-	return 0;
-}
-
 static void gen_free(struct nvm_dev *dev)
 {
-	gen_luns_free(dev);
 	kfree(dev->mp);
+	kfree(dev->rmap);
 	dev->mp = NULL;
 }
 
 static int gen_register(struct nvm_dev *dev)
 {
 	struct gen_dev *gn;
-	int ret;
+	struct gen_dev_map *dev_rmap;
+	int i, j;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
 
 	gn = kzalloc(sizeof(struct gen_dev), GFP_KERNEL);
 	if (!gn)
-		return -ENOMEM;
+		goto err_gn;
+
+	dev_rmap = kmalloc(sizeof(struct gen_dev_map), GFP_KERNEL);
+	if (!dev_rmap)
+		goto err_rmap;
+
+	dev_rmap->chnls = kcalloc(dev->geo.nr_chnls, sizeof(struct gen_ch_map),
+								GFP_KERNEL);
+	if (!dev_rmap->chnls)
+		goto err_chnls;
+
+	for (i = 0; i < dev->geo.nr_chnls; i++) {
+		struct gen_ch_map *ch_rmap;
+		int *lun_roffs;
+		int luns_in_chnl = dev->geo.luns_per_chnl;
+
+		ch_rmap = &dev_rmap->chnls[i];
+
+		ch_rmap->ch_off = -1;
+		ch_rmap->nr_luns = luns_in_chnl;
+
+		lun_roffs = kcalloc(luns_in_chnl, sizeof(int), GFP_KERNEL);
+		if (!lun_roffs)
+			goto err_ch;
+
+		for (j = 0; j < luns_in_chnl; j++)
+			lun_roffs[j] = -1;
+
+		ch_rmap->lun_offs = lun_roffs;
+	}
 
 	gn->dev = dev;
 	gn->nr_luns = dev->geo.nr_luns;
@@ -358,18 +452,19 @@ static int gen_register(struct nvm_dev *dev)
 	mutex_init(&gn->lock);
 	INIT_LIST_HEAD(&gn->targets);
 	dev->mp = gn;
-
-	ret = gen_luns_init(dev, gn);
-	if (ret) {
-		pr_err("gen: could not initialize luns\n");
-		goto err;
-	}
+	dev->rmap = dev_rmap;
 
 	return 1;
-err:
+err_ch:
+	while (--i >= 0)
+		kfree(dev_rmap->chnls[i].lun_offs);
+err_chnls:
+	kfree(dev_rmap);
+err_rmap:
 	gen_free(dev);
+err_gn:
 	module_put(THIS_MODULE);
-	return ret;
+	return -ENOMEM;
 }
 
 static void gen_unregister(struct nvm_dev *dev)
@@ -389,29 +484,137 @@ static void gen_unregister(struct nvm_dev *dev)
 	module_put(THIS_MODULE);
 }
 
+enum {
+	TRANS_TGT_TO_DEV =	0x0,
+	TRANS_DEV_TO_TGT =	0x1,
+};
+
+
+static int gen_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
+{
+	struct gen_dev_map *dev_map = tgt_dev->map;
+	struct gen_ch_map *ch_map = &dev_map->chnls[p->g.ch];
+	int lun_off = ch_map->lun_offs[p->g.lun];
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct gen_dev_map *dev_rmap = dev->rmap;
+	struct gen_ch_map *ch_rmap;
+	int lun_roff;
+
+	p->g.ch += ch_map->ch_off;
+	p->g.lun += lun_off;
+
+	ch_rmap = &dev_rmap->chnls[p->g.ch];
+	lun_roff = ch_rmap->lun_offs[p->g.lun];
+
+	if (unlikely(ch_rmap->ch_off < 0 || lun_roff < 0)) {
+		pr_err("nvm: corrupted device partition table\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gen_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct gen_dev_map *dev_rmap = dev->rmap;
+	struct gen_ch_map *ch_rmap = &dev_rmap->chnls[p->g.ch];
+	int lun_roff = ch_rmap->lun_offs[p->g.lun];
+
+	p->g.ch -= ch_rmap->ch_off;
+	p->g.lun -= lun_roff;
+
+	return 0;
+}
+
+static int gen_trans_rq(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
+			int flag)
+{
+	gen_trans_fn *f;
+	int i;
+	int ret = 0;
+
+	f = (flag == TRANS_TGT_TO_DEV) ? gen_map_to_dev : gen_map_to_tgt;
+
+	if (rqd->nr_ppas == 1)
+		return f(tgt_dev, &rqd->ppa_addr);
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		ret = f(tgt_dev, &rqd->ppa_list[i]);
+		if (ret)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 static void gen_end_io(struct nvm_rq *rqd)
 {
+	struct nvm_tgt_dev *tgt_dev = rqd->dev;
 	struct nvm_tgt_instance *ins = rqd->ins;
 
+	/* Convert address space */
+	if (tgt_dev)
+		gen_trans_rq(tgt_dev, rqd, TRANS_DEV_TO_TGT);
+
 	ins->tt->end_io(rqd);
 }
 
-static int gen_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
+static int gen_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+
 	if (!dev->ops->submit_io)
 		return -ENODEV;
 
 	/* Convert address space */
+	gen_trans_rq(tgt_dev, rqd, TRANS_TGT_TO_DEV);
 	nvm_generic_to_addr_mode(dev, rqd);
 
-	rqd->dev = dev;
+	rqd->dev = tgt_dev;
 	rqd->end_io = gen_end_io;
 	return dev->ops->submit_io(dev, rqd);
 }
 
-static int gen_erase_blk(struct nvm_dev *dev, struct ppa_addr *p, int flags)
+static int gen_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p,
+			 int flags)
 {
-	return nvm_erase_ppa(dev, p, 1, flags);
+	/* Convert address space */
+	gen_map_to_dev(tgt_dev, p);
+
+	return nvm_erase_ppa(tgt_dev->parent, p, 1, flags);
+}
+
+static void gen_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
+			       int len)
+{
+	struct nvm_geo *geo = &dev->geo;
+	struct gen_dev_map *dev_rmap = dev->rmap;
+	u64 i;
+
+	for (i = 0; i < len; i++) {
+		struct gen_ch_map *ch_rmap;
+		int *lun_roffs;
+		struct ppa_addr gaddr;
+		u64 pba = le64_to_cpu(entries[i]);
+		int off;
+		u64 diff;
+
+		if (!pba)
+			continue;
+
+		gaddr = linear_to_generic_addr(geo, pba);
+		ch_rmap = &dev_rmap->chnls[gaddr.g.ch];
+		lun_roffs = ch_rmap->lun_offs;
+
+		off = gaddr.g.ch * geo->luns_per_chnl + gaddr.g.lun;
+
+		diff = ((ch_rmap->ch_off * geo->luns_per_chnl) +
+				(lun_roffs[gaddr.g.lun])) * geo->sec_per_lun;
+
+		entries[i] -= cpu_to_le64(diff);
+	}
 }
 
 static struct nvmm_type gen = {
@@ -430,6 +633,7 @@ static struct nvmm_type gen = {
 	.get_area		= gen_get_area,
 	.put_area		= gen_put_area,
 
+	.part_to_tgt		= gen_part_to_tgt,
 };
 
 static int __init gen_module_init(void)
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
index d167f39..6a4b3f3 100644
--- a/drivers/lightnvm/gennvm.h
+++ b/drivers/lightnvm/gennvm.h
@@ -24,19 +24,37 @@ struct gen_dev {
 	struct nvm_dev *dev;
 
 	int nr_luns;
-	struct nvm_lun *luns;
 	struct list_head area_list;
 
 	struct mutex lock;
 	struct list_head targets;
 };
 
+/* Map between virtual and physical channel and lun */
+struct gen_ch_map {
+	int ch_off;
+	int nr_luns;
+	int *lun_offs;
+};
+
+struct gen_dev_map {
+	struct gen_ch_map *chnls;
+	int nr_chnls;
+};
+
 struct gen_area {
 	struct list_head list;
 	sector_t begin;
 	sector_t end;	/* end is excluded */
 };
 
+static inline void *ch_map_to_lun_offs(struct gen_ch_map *ch_map)
+{
+	return ch_map + 1;
+}
+
+typedef int (gen_trans_fn)(struct nvm_tgt_dev *, struct ppa_addr *);
+
 #define gen_for_each_lun(bm, lun, i) \
 		for ((i) = 0, lun = &(bm)->luns[0]; \
 			(i) < (bm)->nr_luns; (i)++, lun = &(bm)->luns[(i)])
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index fad117b..08a633c 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -45,7 +45,7 @@ static void rrpc_page_invalidate(struct rrpc *rrpc, struct rrpc_addr *a)
 
 	spin_unlock(&rblk->lock);
 
-	rrpc->rev_trans_map[a->addr - rrpc->poffset].addr = ADDR_EMPTY;
+	rrpc->rev_trans_map[a->addr].addr = ADDR_EMPTY;
 }
 
 static void rrpc_invalidate_range(struct rrpc *rrpc, sector_t slba,
@@ -127,28 +127,25 @@ static u64 block_to_rel_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_lun *lun = rlun->parent;
 
-	return lun->id * dev->geo.sec_per_blk;
+	return rlun->id * dev->geo.sec_per_blk;
 }
 
-/* Calculate global addr for the given block */
-static u64 block_to_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
+static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_tgt_dev *dev,
+					 struct rrpc_addr *gp)
 {
-	struct nvm_tgt_dev *dev = rrpc->dev;
-	struct nvm_geo *geo = &dev->geo;
+	struct rrpc_block *rblk = gp->rblk;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_lun *lun = rlun->parent;
-
-	return lun->id * geo->sec_per_lun + rblk->id * geo->sec_per_blk;
-}
-
-static struct ppa_addr rrpc_ppa_to_gaddr(struct nvm_tgt_dev *dev, u64 addr)
-{
+	u64 addr = gp->addr;
 	struct ppa_addr paddr;
 
 	paddr.ppa = addr;
-	return linear_to_generic_addr(&dev->geo, paddr);
+	paddr = rrpc_linear_to_generic_addr(&dev->geo, paddr);
+	paddr.g.ch = rlun->bppa.g.ch;
+	paddr.g.lun = rlun->bppa.g.lun;
+	paddr.g.blk = rblk->id;
+
+	return paddr;
 }
 
 /* requires lun->lock taken */
@@ -216,7 +213,6 @@ static struct rrpc_block *rrpc_get_blk(struct rrpc *rrpc, struct rrpc_lun *rlun,
 static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_lun *lun = rlun->parent;
 
 	spin_lock(&rlun->lock);
 	if (rblk->state & NVM_BLK_ST_TGT) {
@@ -229,8 +225,8 @@ static void rrpc_put_blk(struct rrpc *rrpc, struct rrpc_block *rblk)
 	} else {
 		WARN_ON_ONCE(1);
 		pr_err("rrpc: erroneous type (ch:%d,lun:%d,blk%d-> %u)\n",
-						lun->chnl_id, lun->lun_id,
-						rblk->id, rblk->state);
+					rlun->bppa.g.ch, rlun->bppa.g.lun,
+					rblk->id, rblk->state);
 		list_move_tail(&rblk->list, &rlun->bb_list);
 	}
 	spin_unlock(&rlun->lock);
@@ -336,7 +332,7 @@ static int rrpc_move_valid_pages(struct rrpc *rrpc, struct rrpc_block *rblk)
 try:
 		spin_lock(&rrpc->rev_lock);
 		/* Get logical address from physical to logical table */
-		rev = &rrpc->rev_trans_map[phys_addr - rrpc->poffset];
+		rev = &rrpc->rev_trans_map[phys_addr];
 		/* already updated by previous regular write */
 		if (rev->addr == ADDR_EMPTY) {
 			spin_unlock(&rrpc->rev_lock);
@@ -423,18 +419,18 @@ static void rrpc_block_gc(struct work_struct *work)
 
 	mempool_free(gcb, rrpc->gcb_pool);
 	pr_debug("nvm: block 'ch:%d,lun:%d,blk:%d' being reclaimed\n",
-			rlun->parent->chnl_id, rlun->parent->lun_id,
+			rlun->bppa.g.ch, rlun->bppa.g.lun,
 			rblk->id);
 
 	if (rrpc_move_valid_pages(rrpc, rblk))
 		goto put_back;
 
 	ppa.ppa = 0;
-	ppa.g.ch = rlun->parent->chnl_id;
-	ppa.g.lun = rlun->parent->lun_id;
+	ppa.g.ch = rlun->bppa.g.ch;
+	ppa.g.lun = rlun->bppa.g.lun;
 	ppa.g.blk = rblk->id;
 
-	if (nvm_erase_blk(dev->parent, &ppa, 0))
+	if (nvm_erase_blk(dev, &ppa, 0))
 		goto put_back;
 
 	rrpc_put_blk(rrpc, rblk);
@@ -506,8 +502,7 @@ static void rrpc_lun_gc(struct work_struct *work)
 		WARN_ON(!block_is_full(rrpc, rblk));
 
 		pr_debug("rrpc: selected block 'ch:%d,lun:%d,blk:%d' for GC\n",
-					rlun->parent->chnl_id,
-					rlun->parent->lun_id,
+					rlun->bppa.g.ch, rlun->bppa.g.lun,
 					rblk->id);
 
 		gcb->rrpc = rrpc;
@@ -537,8 +532,7 @@ static void rrpc_gc_queue(struct work_struct *work)
 
 	mempool_free(gcb, rrpc->gcb_pool);
 	pr_debug("nvm: block 'ch:%d,lun:%d,blk:%d' full, allow GC (sched)\n",
-					rlun->parent->chnl_id,
-					rlun->parent->lun_id,
+					rlun->bppa.g.ch, rlun->bppa.g.lun,
 					rblk->id);
 }
 
@@ -586,7 +580,7 @@ static struct rrpc_addr *rrpc_update_map(struct rrpc *rrpc, sector_t laddr,
 	gp->addr = paddr;
 	gp->rblk = rblk;
 
-	rev = &rrpc->rev_trans_map[gp->addr - rrpc->poffset];
+	rev = &rrpc->rev_trans_map[gp->addr];
 	rev->addr = laddr;
 	spin_unlock(&rrpc->rev_lock);
 
@@ -601,7 +595,7 @@ static u64 rrpc_alloc_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
 	if (block_is_full(rrpc, rblk))
 		goto out;
 
-	addr = block_to_addr(rrpc, rblk) + rblk->next_page;
+	addr = rblk->next_page;
 
 	rblk->next_page++;
 out:
@@ -615,18 +609,22 @@ static u64 rrpc_alloc_addr(struct rrpc *rrpc, struct rrpc_block *rblk)
  * Returns rrpc_addr with the physical address and block. Returns NULL if no
  * blocks in the next rlun are available.
  */
-static struct rrpc_addr *rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
+static struct ppa_addr rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
 								int is_gc)
 {
+	struct nvm_tgt_dev *tgt_dev = rrpc->dev;
 	struct rrpc_lun *rlun;
 	struct rrpc_block *rblk, **cur_rblk;
+	struct rrpc_addr *p;
+	struct ppa_addr ppa;
 	u64 paddr;
 	int gc_force = 0;
 
+	ppa.ppa = ADDR_EMPTY;
 	rlun = rrpc_get_lun_rr(rrpc, is_gc);
 
 	if (!is_gc && rlun->nr_free_blocks < rrpc->nr_luns * 4)
-		return NULL;
+		return ppa;
 
 	/*
 	 * page allocation steps:
@@ -683,10 +681,15 @@ static struct rrpc_addr *rrpc_map_page(struct rrpc *rrpc, sector_t laddr,
 	}
 
 	pr_err("rrpc: failed to allocate new block\n");
-	return NULL;
+	return ppa;
 done:
 	spin_unlock(&rlun->lock);
-	return rrpc_update_map(rrpc, laddr, rblk, paddr);
+	p = rrpc_update_map(rrpc, laddr, rblk, paddr);
+	if (!p)
+		return ppa;
+
+	/* return global address */
+	return rrpc_ppa_to_gaddr(tgt_dev, p);
 }
 
 static void rrpc_run_gc(struct rrpc *rrpc, struct rrpc_block *rblk)
@@ -712,8 +715,8 @@ static struct rrpc_lun *rrpc_ppa_to_lun(struct rrpc *rrpc, struct ppa_addr p)
 	int i;
 
 	for (i = 0; i < rrpc->nr_luns; i++) {
-		if (rrpc->luns[i].parent->chnl_id == p.g.ch &&
-				rrpc->luns[i].parent->lun_id == p.g.lun) {
+		if (rrpc->luns[i].bppa.g.ch == p.g.ch &&
+				rrpc->luns[i].bppa.g.lun == p.g.lun) {
 			rlun = &rrpc->luns[i];
 			break;
 		}
@@ -823,7 +826,7 @@ static int rrpc_read_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 		gp = &rrpc->trans_map[laddr + i];
 
 		if (gp->rblk) {
-			rqd->ppa_list[i] = rrpc_ppa_to_gaddr(dev, gp->addr);
+			rqd->ppa_list[i] = rrpc_ppa_to_gaddr(dev, gp);
 		} else {
 			BUG_ON(is_gc);
 			rrpc_unlock_laddr(rrpc, r);
@@ -852,7 +855,7 @@ static int rrpc_read_rq(struct rrpc *rrpc, struct bio *bio, struct nvm_rq *rqd,
 	gp = &rrpc->trans_map[laddr];
 
 	if (gp->rblk) {
-		rqd->ppa_addr = rrpc_ppa_to_gaddr(rrpc->dev, gp->addr);
+		rqd->ppa_addr = rrpc_ppa_to_gaddr(rrpc->dev, gp);
 	} else {
 		BUG_ON(is_gc);
 		rrpc_unlock_rq(rrpc, rqd);
@@ -869,7 +872,7 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct rrpc_inflight_rq *r = rrpc_get_inflight_rq(rqd);
-	struct rrpc_addr *p;
+	struct ppa_addr p;
 	sector_t laddr = rrpc_get_laddr(bio);
 	int is_gc = flags & NVM_IOTYPE_GC;
 	int i;
@@ -882,7 +885,7 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 	for (i = 0; i < npages; i++) {
 		/* We assume that mapping occurs at 4KB granularity */
 		p = rrpc_map_page(rrpc, laddr + i, is_gc);
-		if (!p) {
+		if (p.ppa == ADDR_EMPTY) {
 			BUG_ON(is_gc);
 			rrpc_unlock_laddr(rrpc, r);
 			nvm_dev_dma_free(dev->parent, rqd->ppa_list,
@@ -891,7 +894,7 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 			return NVM_IO_REQUEUE;
 		}
 
-		rqd->ppa_list[i] = rrpc_ppa_to_gaddr(dev, p->addr);
+		rqd->ppa_list[i] = p;
 	}
 
 	rqd->opcode = NVM_OP_HBWRITE;
@@ -902,7 +905,7 @@ static int rrpc_write_ppalist_rq(struct rrpc *rrpc, struct bio *bio,
 static int rrpc_write_rq(struct rrpc *rrpc, struct bio *bio,
 				struct nvm_rq *rqd, unsigned long flags)
 {
-	struct rrpc_addr *p;
+	struct ppa_addr p;
 	int is_gc = flags & NVM_IOTYPE_GC;
 	sector_t laddr = rrpc_get_laddr(bio);
 
@@ -910,14 +913,14 @@ static int rrpc_write_rq(struct rrpc *rrpc, struct bio *bio,
 		return NVM_IO_REQUEUE;
 
 	p = rrpc_map_page(rrpc, laddr, is_gc);
-	if (!p) {
+	if (p.ppa == ADDR_EMPTY) {
 		BUG_ON(is_gc);
 		rrpc_unlock_rq(rrpc, rqd);
 		rrpc_gc_kick(rrpc);
 		return NVM_IO_REQUEUE;
 	}
 
-	rqd->ppa_addr = rrpc_ppa_to_gaddr(rrpc->dev, p->addr);
+	rqd->ppa_addr = p;
 	rqd->opcode = NVM_OP_HBWRITE;
 
 	return NVM_IO_OK;
@@ -973,7 +976,7 @@ static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 	rqd->nr_ppas = nr_pages;
 	rrq->flags = flags;
 
-	err = nvm_submit_io(dev->parent, rqd);
+	err = nvm_submit_io(dev, rqd);
 	if (err) {
 		pr_err("rrpc: I/O submission failed: %d\n", err);
 		bio_put(bio);
@@ -1113,14 +1116,12 @@ static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 		div_u64_rem(pba, rrpc->nr_sects, &mod);
 
-		addr[i].addr = pba;
-		raddr[mod].addr = slba + i;
-
-		gaddr = rrpc_ppa_to_gaddr(dev, pba);
+		gaddr = rrpc_recov_addr(dev->parent, pba);
 		rlun = rrpc_ppa_to_lun(rrpc, gaddr);
 		if (!rlun) {
-			pr_err("rrpc: unmapped lun %d l2p corruption\n",
-							rlun->parent->id);
+			pr_err("rrpc: unmapped 'ch:%d,lun:%d' l2p corruption\n",
+							rlun->bppa.g.ch,
+							rlun->bppa.g.lun);
 			return -EINVAL;
 		}
 
@@ -1134,6 +1135,10 @@ static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 			rblk->state = NVM_BLK_ST_TGT;
 			rlun->nr_free_blocks--;
 		}
+
+		addr[i].addr = pba;
+		addr[i].rblk = rblk;
+		raddr[mod].addr = slba + i;
 	}
 
 	return 0;
@@ -1230,7 +1235,6 @@ static void rrpc_core_free(struct rrpc *rrpc)
 
 static void rrpc_luns_free(struct rrpc *rrpc)
 {
-	struct nvm_lun *lun;
 	struct rrpc_lun *rlun;
 	int i;
 
@@ -1239,9 +1243,6 @@ static void rrpc_luns_free(struct rrpc *rrpc)
 
 	for (i = 0; i < rrpc->nr_luns; i++) {
 		rlun = &rrpc->luns[i];
-		lun = rlun->parent;
-		if (!lun)
-			break;
 		vfree(rlun->blocks);
 	}
 
@@ -1264,8 +1265,8 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
 		return -ENOMEM;
 
 	ppa.ppa = 0;
-	ppa.g.ch = rlun->parent->chnl_id;
-	ppa.g.lun = rlun->parent->lun_id;
+	ppa.g.ch = rlun->bppa.g.ch;
+	ppa.g.lun = rlun->bppa.g.lun;
 
 	ret = nvm_get_bb_tbl(dev->parent, ppa, blks);
 	if (ret) {
@@ -1294,11 +1295,17 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
 	return ret;
 }
 
-static int rrpc_luns_init(struct rrpc *rrpc, struct list_head *lun_list)
+static void rrpc_set_lun_ppa(struct rrpc_lun *rlun, struct ppa_addr ppa)
+{
+	rlun->bppa.ppa = 0;
+	rlun->bppa.g.ch = ppa.g.ch;
+	rlun->bppa.g.lun = ppa.g.lun;
+}
+
+static int rrpc_luns_init(struct rrpc *rrpc, struct ppa_addr *luns)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct nvm_lun *lun;
 	struct rrpc_lun *rlun;
 	int i, j, ret = -EINVAL;
 
@@ -1314,12 +1321,11 @@ static int rrpc_luns_init(struct rrpc *rrpc, struct list_head *lun_list)
 	if (!rrpc->luns)
 		return -ENOMEM;
 
-	i = 0;
-
 	/* 1:1 mapping */
-	list_for_each_entry(lun, lun_list, list) {
-		rlun = &rrpc->luns[i++];
-		rlun->parent = lun;
+	for (i = 0; i < rrpc->nr_luns; i++) {
+		rlun = &rrpc->luns[i];
+		rlun->id = i;
+		rrpc_set_lun_ppa(rlun, luns[i]);
 		rlun->blocks = vzalloc(sizeof(struct rrpc_block) *
 							geo->blks_per_lun);
 		if (!rlun->blocks) {
@@ -1357,8 +1363,6 @@ static int rrpc_luns_init(struct rrpc *rrpc, struct list_head *lun_list)
 		spin_lock_init(&rlun->lock);
 	}
 
-	WARN_ON(i != rrpc->nr_luns);
-
 	return 0;
 err:
 	return ret;
@@ -1512,14 +1516,12 @@ static int rrpc_luns_configure(struct rrpc *rrpc)
 
 static struct nvm_tgt_type tt_rrpc;
 
-static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
-						struct list_head *lun_list)
+static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk)
 {
 	struct request_queue *bqueue = dev->q;
 	struct request_queue *tqueue = tdisk->queue;
 	struct nvm_geo *geo = &dev->geo;
 	struct rrpc *rrpc;
-	int lun_begin = (list_first_entry(lun_list, struct nvm_lun, list))->id;
 	sector_t soffset;
 	int ret;
 
@@ -1554,14 +1556,12 @@ static void *rrpc_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	}
 	rrpc->soffset = soffset;
 
-	ret = rrpc_luns_init(rrpc, lun_list);
+	ret = rrpc_luns_init(rrpc, dev->luns);
 	if (ret) {
 		pr_err("nvm: rrpc: could not initialize luns\n");
 		goto err;
 	}
 
-	rrpc->poffset = geo->sec_per_lun * lun_begin;
-
 	ret = rrpc_core_init(rrpc);
 	if (ret) {
 		pr_err("nvm: rrpc: could not initialize core\n");
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index c55cec9..bc8adba 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -74,7 +74,9 @@ struct rrpc_block {
 
 struct rrpc_lun {
 	struct rrpc *rrpc;
-	struct nvm_lun *parent;
+
+	int id;
+	struct ppa_addr bppa;
 
 	struct rrpc_block *cur, *gc_cur;
 	struct rrpc_block *blocks;	/* Reference to block allocation */
@@ -107,7 +109,6 @@ struct rrpc {
 	struct gendisk *disk;
 
 	sector_t soffset; /* logical sector offset */
-	u64 poffset; /* physical page offset */
 
 	int nr_luns;
 	struct rrpc_lun *luns;
@@ -164,14 +165,37 @@ struct rrpc_rev_addr {
 	u64 addr;
 };
 
+static inline struct ppa_addr rrpc_linear_to_generic_addr(struct nvm_geo *geo,
+							  struct ppa_addr r)
+{
+	struct ppa_addr l;
+	int secs, pgs;
+	sector_t ppa = r.ppa;
+
+	l.ppa = 0;
+
+	div_u64_rem(ppa, geo->sec_per_pg, &secs);
+	l.g.sec = secs;
+
+	sector_div(ppa, geo->sec_per_pg);
+	div_u64_rem(ppa, geo->pgs_per_blk, &pgs);
+	l.g.pg = pgs;
+
+	return l;
+}
+
+static inline struct ppa_addr rrpc_recov_addr(struct nvm_dev *dev, u64 pba)
+{
+	return linear_to_generic_addr(&dev->geo, pba);
+}
+
 static inline u64 rrpc_blk_to_ppa(struct rrpc *rrpc, struct rrpc_block *rblk)
 {
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct rrpc_lun *rlun = rblk->rlun;
-	struct nvm_lun *lun = rlun->parent;
 
-	return (lun->id * geo->sec_per_lun) + (rblk->id * geo->sec_per_blk);
+	return (rlun->id * geo->sec_per_lun) + (rblk->id * geo->sec_per_blk);
 }
 
 static inline sector_t rrpc_get_laddr(struct bio *bio)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 1cdc812..588d4a3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -371,6 +371,9 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 			return -EINVAL;
 		}
 
+		/* Transform physical address to target address space */
+		nvmdev->mt->part_to_tgt(nvmdev, entries, cmd_nlb);
+
 		if (update_l2p(cmd_slba, cmd_nlb, entries, priv)) {
 			ret = -EINTR;
 			goto out;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index cc210cc..2222853 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -47,6 +47,7 @@ struct ppa_addr {
 struct nvm_rq;
 struct nvm_id;
 struct nvm_dev;
+struct nvm_tgt_dev;
 
 typedef int (nvm_l2p_update_fn)(u64, u32, __le64 *, void *);
 typedef int (nvm_id_fn)(struct nvm_dev *, struct nvm_id *);
@@ -210,7 +211,6 @@ struct nvm_id {
 
 struct nvm_target {
 	struct list_head list;
-	struct list_head lun_list;
 	struct nvm_tgt_dev *dev;
 	struct nvm_tgt_type *type;
 	struct gendisk *disk;
@@ -231,7 +231,7 @@ typedef void (nvm_end_io_fn)(struct nvm_rq *);
 
 struct nvm_rq {
 	struct nvm_tgt_instance *ins;
-	struct nvm_dev *dev;
+	struct nvm_tgt_dev *dev;
 
 	struct bio *bio;
 
@@ -266,15 +266,6 @@ static inline void *nvm_rq_to_pdu(struct nvm_rq *rqdata)
 	return rqdata + 1;
 }
 
-struct nvm_lun {
-	int id;
-
-	int lun_id;
-	int chnl_id;
-
-	struct list_head list;
-};
-
 enum {
 	NVM_BLK_ST_FREE =	0x1,	/* Free block */
 	NVM_BLK_ST_TGT =	0x2,	/* Block in use by target */
@@ -321,6 +312,9 @@ struct nvm_tgt_dev {
 	/* Device information */
 	struct nvm_geo geo;
 
+	/* Base ppas for target LUNs */
+	struct ppa_addr *luns;
+
 	sector_t total_secs;
 
 	struct nvm_id identity;
@@ -330,6 +324,7 @@ struct nvm_tgt_dev {
 	struct nvm_dev_ops *ops;
 
 	void *parent;
+	void *map;
 };
 
 struct nvm_dev {
@@ -363,16 +358,18 @@ struct nvm_dev {
 	char name[DISK_NAME_LEN];
 	void *private_data;
 
+	void *rmap;
+
 	struct mutex mlock;
 	spinlock_t lock;
 };
 
 static inline struct ppa_addr linear_to_generic_addr(struct nvm_geo *geo,
-							struct ppa_addr r)
+						     u64 pba)
 {
 	struct ppa_addr l;
 	int secs, pgs, blks, luns;
-	sector_t ppa = r.ppa;
+	sector_t ppa = pba;
 
 	l.ppa = 0;
 
@@ -465,8 +462,7 @@ static inline int ppa_to_slc(struct nvm_dev *dev, int slc_pg)
 
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
-typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-				struct list_head *lun_list);
+typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *);
 typedef void (nvm_tgt_exit_fn)(void *);
 
 struct nvm_tgt_type {
@@ -499,10 +495,11 @@ typedef void (nvmm_unregister_fn)(struct nvm_dev *);
 
 typedef int (nvmm_create_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_create *);
 typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
-typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct ppa_addr *, int);
+typedef int (nvmm_submit_io_fn)(struct nvm_tgt_dev *, struct nvm_rq *);
+typedef int (nvmm_erase_blk_fn)(struct nvm_tgt_dev *, struct ppa_addr *, int);
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
 typedef void (nvmm_put_area_fn)(struct nvm_dev *, sector_t);
+typedef void (nvmm_part_to_tgt_fn)(struct nvm_dev *, sector_t*, int);
 
 struct nvmm_type {
 	const char *name;
@@ -520,6 +517,8 @@ struct nvmm_type {
 	nvmm_get_area_fn *get_area;
 	nvmm_put_area_fn *put_area;
 
+	nvmm_part_to_tgt_fn *part_to_tgt;
+
 	struct list_head list;
 };
 
@@ -533,14 +532,18 @@ extern void nvm_unregister(struct nvm_dev *);
 extern int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas,
 							int nr_ppas, int type);
 
-extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
+extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
 extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int, int);
-extern int nvm_erase_blk(struct nvm_dev *, struct ppa_addr *, int);
+extern int nvm_erase_blk(struct nvm_tgt_dev *, struct ppa_addr *, int);
+extern int nvm_get_l2p_tbl(struct nvm_dev *, u64, u32, nvm_l2p_update_fn *,
+			   void *);
+extern int nvm_get_area(struct nvm_dev *, sector_t *, sector_t);
+extern void nvm_put_area(struct nvm_dev *, sector_t);
 extern void nvm_end_io(struct nvm_rq *, int);
 extern int nvm_submit_ppa(struct nvm_dev *, struct ppa_addr *, int, int, int,
 								void *, int);
-- 
2.7.4

