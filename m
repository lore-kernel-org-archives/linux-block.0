Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35320 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdAWMAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 07:00:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id d140so25934228wmd.2
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 03:59:45 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 1/8] lightnvm: merge gennvm with core
Date: Mon, 23 Jan 2017 12:59:12 +0100
Message-Id: <20170123115919.14339-2-matias@cnexlabs.com>
In-Reply-To: <20170123115919.14339-1-matias@cnexlabs.com>
References: <20170123115919.14339-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For the first iteration of Open-Channel SSDs, it was anticipated that
there could be various media managers on top of an open-channel SSD,
such to allow vendors to plug in their own host-side FTLs, without the
media manager in between.

Now that an Open-Channel SSD is exposed as a traditional block device,
there is no longer a need for this. Therefore lets merge the gennvm code
with core and simplify the stack.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/Kconfig     |   9 -
 drivers/lightnvm/Makefile    |   3 +-
 drivers/lightnvm/core.c      | 786 ++++++++++++++++++++++++++++++++-----------
 drivers/lightnvm/gennvm.c    | 657 ------------------------------------
 drivers/lightnvm/gennvm.h    |  62 ----
 drivers/lightnvm/sysblk.c    | 733 ----------------------------------------
 drivers/nvme/host/lightnvm.c |   7 +-
 include/linux/lightnvm.h     |  97 +-----
 8 files changed, 606 insertions(+), 1748 deletions(-)
 delete mode 100644 drivers/lightnvm/gennvm.c
 delete mode 100644 drivers/lightnvm/gennvm.h
 delete mode 100644 drivers/lightnvm/sysblk.c

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 2f5d5f4..0527141 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -26,15 +26,6 @@ config NVM_DEBUG
 
 	It is required to create/remove targets without IOCTLs.
 
-config NVM_GENNVM
-	tristate "General Non-Volatile Memory Manager for Open-Channel SSDs"
-	---help---
-	Non-volatile memory media manager for Open-Channel SSDs that implements
-	physical media metadata management and block provisioning API.
-
-	This is the standard media manager for using Open-Channel SSDs, and
-	required for targets to be instantiated.
-
 config NVM_RRPC
 	tristate "Round-robin Hybrid Open-Channel SSD target"
 	---help---
diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
index a7a0a22..b2a39e2 100644
--- a/drivers/lightnvm/Makefile
+++ b/drivers/lightnvm/Makefile
@@ -2,6 +2,5 @@
 # Makefile for Open-Channel SSDs.
 #
 
-obj-$(CONFIG_NVM)		:= core.o sysblk.o
-obj-$(CONFIG_NVM_GENNVM) 	+= gennvm.o
+obj-$(CONFIG_NVM)		:= core.o
 obj-$(CONFIG_NVM_RRPC)		+= rrpc.o
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 02240a0..e9a4956 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -29,10 +29,492 @@
 
 static LIST_HEAD(nvm_tgt_types);
 static DECLARE_RWSEM(nvm_tgtt_lock);
-static LIST_HEAD(nvm_mgrs);
 static LIST_HEAD(nvm_devices);
 static DECLARE_RWSEM(nvm_lock);
 
+/* Map between virtual and physical channel and lun */
+struct nvm_ch_map {
+	int ch_off;
+	int nr_luns;
+	int *lun_offs;
+};
+
+struct nvm_dev_map {
+	struct nvm_ch_map *chnls;
+	int nr_chnls;
+};
+
+struct nvm_area {
+	struct list_head list;
+	sector_t begin;
+	sector_t end;	/* end is excluded */
+};
+
+enum {
+	TRANS_TGT_TO_DEV =	0x0,
+	TRANS_DEV_TO_TGT =	0x1,
+};
+
+static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
+{
+	struct nvm_target *tgt;
+
+	list_for_each_entry(tgt, &dev->targets, list)
+		if (!strcmp(name, tgt->disk->disk_name))
+			return tgt;
+
+	return NULL;
+}
+
+static int nvm_reserve_luns(struct nvm_dev *dev, int lun_begin, int lun_end)
+{
+	int i;
+
+	for (i = lun_begin; i <= lun_end; i++) {
+		if (test_and_set_bit(i, dev->lun_map)) {
+			pr_err("nvm: lun %d already allocated\n", i);
+			goto err;
+		}
+	}
+
+	return 0;
+err:
+	while (--i > lun_begin)
+		clear_bit(i, dev->lun_map);
+
+	return -EBUSY;
+}
+
+static void nvm_release_luns_err(struct nvm_dev *dev, int lun_begin,
+				 int lun_end)
+{
+	int i;
+
+	for (i = lun_begin; i <= lun_end; i++)
+		WARN_ON(!test_and_clear_bit(i, dev->lun_map));
+}
+
+static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_dev_map *dev_map = tgt_dev->map;
+	int i, j;
+
+	for (i = 0; i < dev_map->nr_chnls; i++) {
+		struct nvm_ch_map *ch_map = &dev_map->chnls[i];
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
+
+	kfree(tgt_dev->luns);
+	kfree(tgt_dev);
+}
+
+static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
+					      int lun_begin, int lun_end)
+{
+	struct nvm_tgt_dev *tgt_dev = NULL;
+	struct nvm_dev_map *dev_rmap = dev->rmap;
+	struct nvm_dev_map *dev_map;
+	struct ppa_addr *luns;
+	int nr_luns = lun_end - lun_begin + 1;
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
+	dev_map = kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
+	if (!dev_map)
+		goto err_dev;
+
+	dev_map->chnls = kcalloc(nr_chnls, sizeof(struct nvm_ch_map),
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
+		struct nvm_ch_map *ch_rmap = &dev_rmap->chnls[i + bch];
+		int *lun_roffs = ch_rmap->lun_offs;
+		struct nvm_ch_map *ch_map = &dev_map->chnls[i];
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
+
+	tgt_dev = kmalloc(sizeof(struct nvm_tgt_dev), GFP_KERNEL);
+	if (!tgt_dev)
+		goto err_ch;
+
+	memcpy(&tgt_dev->geo, &dev->geo, sizeof(struct nvm_geo));
+	/* Target device only owns a portion of the physical device */
+	tgt_dev->geo.nr_chnls = nr_chnls;
+	tgt_dev->geo.nr_luns = nr_luns;
+	tgt_dev->geo.luns_per_chnl = (lun_balanced) ? prev_nr_luns : -1;
+	tgt_dev->total_secs = nr_luns * tgt_dev->geo.sec_per_lun;
+	tgt_dev->q = dev->q;
+	tgt_dev->map = dev_map;
+	tgt_dev->luns = luns;
+	memcpy(&tgt_dev->identity, &dev->identity, sizeof(struct nvm_id));
+
+	tgt_dev->parent = dev;
+
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
+	return tgt_dev;
+}
+
+static const struct block_device_operations nvm_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
+{
+	struct nvm_ioctl_create_simple *s = &create->conf.s;
+	struct request_queue *tqueue;
+	struct gendisk *tdisk;
+	struct nvm_tgt_type *tt;
+	struct nvm_target *t;
+	struct nvm_tgt_dev *tgt_dev;
+	void *targetdata;
+
+	tt = nvm_find_target_type(create->tgttype, 1);
+	if (!tt) {
+		pr_err("nvm: target type %s not found\n", create->tgttype);
+		return -EINVAL;
+	}
+
+	mutex_lock(&dev->mlock);
+	t = nvm_find_target(dev, create->tgtname);
+	if (t) {
+		pr_err("nvm: target name already exists.\n");
+		mutex_unlock(&dev->mlock);
+		return -EINVAL;
+	}
+	mutex_unlock(&dev->mlock);
+
+	if (nvm_reserve_luns(dev, s->lun_begin, s->lun_end))
+		return -ENOMEM;
+
+	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
+	if (!t)
+		goto err_reserve;
+
+	tgt_dev = nvm_create_tgt_dev(dev, s->lun_begin, s->lun_end);
+	if (!tgt_dev) {
+		pr_err("nvm: could not create target device\n");
+		goto err_t;
+	}
+
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
+	if (!tqueue)
+		goto err_dev;
+	blk_queue_make_request(tqueue, tt->make_rq);
+
+	tdisk = alloc_disk(0);
+	if (!tdisk)
+		goto err_queue;
+
+	sprintf(tdisk->disk_name, "%s", create->tgtname);
+	tdisk->flags = GENHD_FL_EXT_DEVT;
+	tdisk->major = 0;
+	tdisk->first_minor = 0;
+	tdisk->fops = &nvm_fops;
+	tdisk->queue = tqueue;
+
+	targetdata = tt->init(tgt_dev, tdisk);
+	if (IS_ERR(targetdata))
+		goto err_init;
+
+	tdisk->private_data = targetdata;
+	tqueue->queuedata = targetdata;
+
+	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
+
+	set_capacity(tdisk, tt->capacity(targetdata));
+	add_disk(tdisk);
+
+	t->type = tt;
+	t->disk = tdisk;
+	t->dev = tgt_dev;
+
+	mutex_lock(&dev->mlock);
+	list_add_tail(&t->list, &dev->targets);
+	mutex_unlock(&dev->mlock);
+
+	return 0;
+err_init:
+	put_disk(tdisk);
+err_queue:
+	blk_cleanup_queue(tqueue);
+err_dev:
+	kfree(tgt_dev);
+err_t:
+	kfree(t);
+err_reserve:
+	nvm_release_luns_err(dev, s->lun_begin, s->lun_end);
+	return -ENOMEM;
+}
+
+static void __nvm_remove_target(struct nvm_target *t)
+{
+	struct nvm_tgt_type *tt = t->type;
+	struct gendisk *tdisk = t->disk;
+	struct request_queue *q = tdisk->queue;
+
+	del_gendisk(tdisk);
+	blk_cleanup_queue(q);
+
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
+
+	nvm_remove_tgt_dev(t->dev);
+	put_disk(tdisk);
+
+	list_del(&t->list);
+	kfree(t);
+}
+
+/**
+ * nvm_remove_tgt - Removes a target from the media manager
+ * @dev:	device
+ * @remove:	ioctl structure with target name to remove.
+ *
+ * Returns:
+ * 0: on success
+ * 1: on not found
+ * <0: on error
+ */
+static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
+{
+	struct nvm_target *t;
+
+	mutex_lock(&dev->mlock);
+	t = nvm_find_target(dev, remove->tgtname);
+	if (!t) {
+		mutex_unlock(&dev->mlock);
+		return 1;
+	}
+	__nvm_remove_target(t);
+	mutex_unlock(&dev->mlock);
+
+	return 0;
+}
+
+static int nvm_register_map(struct nvm_dev *dev)
+{
+	struct nvm_dev_map *rmap;
+	int i, j;
+
+	rmap = kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
+	if (!rmap)
+		goto err_rmap;
+
+	rmap->chnls = kcalloc(dev->geo.nr_chnls, sizeof(struct nvm_ch_map),
+								GFP_KERNEL);
+	if (!rmap->chnls)
+		goto err_chnls;
+
+	for (i = 0; i < dev->geo.nr_chnls; i++) {
+		struct nvm_ch_map *ch_rmap;
+		int *lun_roffs;
+		int luns_in_chnl = dev->geo.luns_per_chnl;
+
+		ch_rmap = &rmap->chnls[i];
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
+
+	dev->rmap = rmap;
+
+	return 0;
+err_ch:
+	while (--i >= 0)
+		kfree(rmap->chnls[i].lun_offs);
+err_chnls:
+	kfree(rmap);
+err_rmap:
+	return -ENOMEM;
+}
+
+static int nvm_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
+{
+	struct nvm_dev_map *dev_map = tgt_dev->map;
+	struct nvm_ch_map *ch_map = &dev_map->chnls[p->g.ch];
+	int lun_off = ch_map->lun_offs[p->g.lun];
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_dev_map *dev_rmap = dev->rmap;
+	struct nvm_ch_map *ch_rmap;
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
+static int nvm_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_dev_map *dev_rmap = dev->rmap;
+	struct nvm_ch_map *ch_rmap = &dev_rmap->chnls[p->g.ch];
+	int lun_roff = ch_rmap->lun_offs[p->g.lun];
+
+	p->g.ch -= ch_rmap->ch_off;
+	p->g.lun -= lun_roff;
+
+	return 0;
+}
+
+static int nvm_trans_rq(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
+			int flag)
+{
+	int i;
+	int ret;
+
+	if (rqd->nr_ppas == 1) {
+		if (flag == TRANS_TGT_TO_DEV)
+			return nvm_map_to_dev(tgt_dev, &rqd->ppa_addr);
+		else
+			return nvm_map_to_tgt(tgt_dev, &rqd->ppa_addr);
+	}
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		if (flag == TRANS_TGT_TO_DEV)
+			ret = nvm_map_to_dev(tgt_dev, &rqd->ppa_list[i]);
+		else
+			ret = nvm_map_to_tgt(tgt_dev, &rqd->ppa_list[i]);
+
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static struct ppa_addr nvm_trans_ppa(struct nvm_tgt_dev *tgt_dev,
+				     struct ppa_addr p, int dir)
+{
+	struct ppa_addr ppa = p;
+
+	if (dir == TRANS_TGT_TO_DEV)
+		nvm_map_to_dev(tgt_dev, &ppa);
+	else
+		nvm_map_to_tgt(tgt_dev, &ppa);
+
+	return ppa;
+}
+
+void nvm_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
+		     int len)
+{
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_dev_map *dev_rmap = dev->rmap;
+	u64 i;
+
+	for (i = 0; i < len; i++) {
+		struct nvm_ch_map *ch_rmap;
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
+}
+EXPORT_SYMBOL(nvm_part_to_tgt);
+
 struct nvm_tgt_type *nvm_find_target_type(const char *name, int lock)
 {
 	struct nvm_tgt_type *tmp, *tt = NULL;
@@ -92,78 +574,6 @@ void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
 }
 EXPORT_SYMBOL(nvm_dev_dma_free);
 
-static struct nvmm_type *nvm_find_mgr_type(const char *name)
-{
-	struct nvmm_type *mt;
-
-	list_for_each_entry(mt, &nvm_mgrs, list)
-		if (!strcmp(name, mt->name))
-			return mt;
-
-	return NULL;
-}
-
-static struct nvmm_type *nvm_init_mgr(struct nvm_dev *dev)
-{
-	struct nvmm_type *mt;
-	int ret;
-
-	lockdep_assert_held(&nvm_lock);
-
-	list_for_each_entry(mt, &nvm_mgrs, list) {
-		if (strncmp(dev->sb.mmtype, mt->name, NVM_MMTYPE_LEN))
-			continue;
-
-		ret = mt->register_mgr(dev);
-		if (ret < 0) {
-			pr_err("nvm: media mgr failed to init (%d) on dev %s\n",
-								ret, dev->name);
-			return NULL; /* initialization failed */
-		} else if (ret > 0)
-			return mt;
-	}
-
-	return NULL;
-}
-
-int nvm_register_mgr(struct nvmm_type *mt)
-{
-	struct nvm_dev *dev;
-	int ret = 0;
-
-	down_write(&nvm_lock);
-	if (nvm_find_mgr_type(mt->name)) {
-		ret = -EEXIST;
-		goto finish;
-	} else {
-		list_add(&mt->list, &nvm_mgrs);
-	}
-
-	/* try to register media mgr if any device have none configured */
-	list_for_each_entry(dev, &nvm_devices, devices) {
-		if (dev->mt)
-			continue;
-
-		dev->mt = nvm_init_mgr(dev);
-	}
-finish:
-	up_write(&nvm_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(nvm_register_mgr);
-
-void nvm_unregister_mgr(struct nvmm_type *mt)
-{
-	if (!mt)
-		return;
-
-	down_write(&nvm_lock);
-	list_del(&mt->list);
-	up_write(&nvm_lock);
-}
-EXPORT_SYMBOL(nvm_unregister_mgr);
-
 static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 {
 	struct nvm_dev *dev;
@@ -183,13 +593,13 @@ static void nvm_tgt_generic_to_addr_mode(struct nvm_tgt_dev *tgt_dev,
 
 	if (rqd->nr_ppas > 1) {
 		for (i = 0; i < rqd->nr_ppas; i++) {
-			rqd->ppa_list[i] = dev->mt->trans_ppa(tgt_dev,
+			rqd->ppa_list[i] = nvm_trans_ppa(tgt_dev,
 					rqd->ppa_list[i], TRANS_TGT_TO_DEV);
 			rqd->ppa_list[i] = generic_to_dev_addr(dev,
 							rqd->ppa_list[i]);
 		}
 	} else {
-		rqd->ppa_addr = dev->mt->trans_ppa(tgt_dev, rqd->ppa_addr,
+		rqd->ppa_addr = nvm_trans_ppa(tgt_dev, rqd->ppa_addr,
 						TRANS_TGT_TO_DEV);
 		rqd->ppa_addr = generic_to_dev_addr(dev, rqd->ppa_addr);
 	}
@@ -242,7 +652,7 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
 	nvm_free_rqd_ppalist(dev, &rqd);
 	if (ret) {
-		pr_err("nvm: sysblk failed bb mark\n");
+		pr_err("nvm: failed bb mark\n");
 		return -EINVAL;
 	}
 
@@ -262,15 +672,23 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 
-	return dev->mt->submit_io(tgt_dev, rqd);
+	if (!dev->ops->submit_io)
+		return -ENODEV;
+
+	/* Convert address space */
+	nvm_generic_to_addr_mode(dev, rqd);
+
+	rqd->dev = tgt_dev;
+	return dev->ops->submit_io(dev, rqd);
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
 int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p, int flags)
 {
-	struct nvm_dev *dev = tgt_dev->parent;
+	/* Convert address space */
+	nvm_map_to_dev(tgt_dev, p);
 
-	return dev->mt->erase_blk(tgt_dev, p, flags);
+	return nvm_erase_ppa(tgt_dev->parent, p, 1, flags);
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
@@ -289,16 +707,65 @@ EXPORT_SYMBOL(nvm_get_l2p_tbl);
 int nvm_get_area(struct nvm_tgt_dev *tgt_dev, sector_t *lba, sector_t len)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_area *area, *prev, *next;
+	sector_t begin = 0;
+	sector_t max_sectors = (geo->sec_size * dev->total_secs) >> 9;
 
-	return dev->mt->get_area(dev, lba, len);
+	if (len > max_sectors)
+		return -EINVAL;
+
+	area = kmalloc(sizeof(struct nvm_area), GFP_KERNEL);
+	if (!area)
+		return -ENOMEM;
+
+	prev = NULL;
+
+	spin_lock(&dev->lock);
+	list_for_each_entry(next, &dev->area_list, list) {
+		if (begin + len > next->begin) {
+			begin = next->end;
+			prev = next;
+			continue;
+		}
+		break;
+	}
+
+	if ((begin + len) > max_sectors) {
+		spin_unlock(&dev->lock);
+		kfree(area);
+		return -EINVAL;
+	}
+
+	area->begin = *lba = begin;
+	area->end = begin + len;
+
+	if (prev) /* insert into sorted order */
+		list_add(&area->list, &prev->list);
+	else
+		list_add(&area->list, &dev->area_list);
+	spin_unlock(&dev->lock);
+
+	return 0;
 }
 EXPORT_SYMBOL(nvm_get_area);
 
-void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t lba)
+void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t begin)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_area *area;
 
-	dev->mt->put_area(dev, lba);
+	spin_lock(&dev->lock);
+	list_for_each_entry(area, &dev->area_list, list) {
+		if (area->begin != begin)
+			continue;
+
+		list_del(&area->list);
+		spin_unlock(&dev->lock);
+		kfree(area);
+		return;
+	}
+	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL(nvm_put_area);
 
@@ -409,8 +876,15 @@ EXPORT_SYMBOL(nvm_erase_ppa);
 
 void nvm_end_io(struct nvm_rq *rqd, int error)
 {
+	struct nvm_tgt_dev *tgt_dev = rqd->dev;
+	struct nvm_tgt_instance *ins = rqd->ins;
+
+	/* Convert address space */
+	if (tgt_dev)
+		nvm_trans_rq(tgt_dev, rqd, TRANS_DEV_TO_TGT);
+
 	rqd->error = error;
-	rqd->end_io(rqd);
+	ins->tt->end_io(rqd);
 }
 EXPORT_SYMBOL(nvm_end_io);
 
@@ -570,10 +1044,9 @@ EXPORT_SYMBOL(nvm_get_bb_tbl);
 int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
 		       u8 *blks)
 {
-	struct nvm_dev *dev = tgt_dev->parent;
+	ppa = nvm_trans_ppa(tgt_dev, ppa, TRANS_TGT_TO_DEV);
 
-	ppa = dev->mt->trans_ppa(tgt_dev, ppa, TRANS_TGT_TO_DEV);
-	return nvm_get_bb_tbl(dev, ppa, blks);
+	return nvm_get_bb_tbl(tgt_dev->parent, ppa, blks);
 }
 EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);
 
@@ -691,36 +1164,31 @@ static int nvm_core_init(struct nvm_dev *dev)
 		goto err_fmtype;
 	}
 
+	INIT_LIST_HEAD(&dev->area_list);
+	INIT_LIST_HEAD(&dev->targets);
 	mutex_init(&dev->mlock);
 	spin_lock_init(&dev->lock);
 
+	ret = nvm_register_map(dev);
+	if (ret)
+		goto err_fmtype;
+
 	blk_queue_logical_block_size(dev->q, geo->sec_size);
-
 	return 0;
 err_fmtype:
 	kfree(dev->lun_map);
 	return ret;
 }
 
-static void nvm_free_mgr(struct nvm_dev *dev)
-{
-	if (!dev->mt)
-		return;
-
-	dev->mt->unregister_mgr(dev);
-	dev->mt = NULL;
-}
-
 void nvm_free(struct nvm_dev *dev)
 {
 	if (!dev)
 		return;
 
-	nvm_free_mgr(dev);
-
 	if (dev->dma_pool)
 		dev->ops->destroy_dma_pool(dev->dma_pool);
 
+	kfree(dev->rmap);
 	kfree(dev->lptbl);
 	kfree(dev->lun_map);
 	kfree(dev);
@@ -731,9 +1199,6 @@ static int nvm_init(struct nvm_dev *dev)
 	struct nvm_geo *geo = &dev->geo;
 	int ret = -EINVAL;
 
-	if (!dev->q || !dev->ops)
-		return ret;
-
 	if (dev->ops->identity(dev, &dev->identity)) {
 		pr_err("nvm: device could not be identified\n");
 		goto err;
@@ -779,49 +1244,50 @@ int nvm_register(struct nvm_dev *dev)
 {
 	int ret;
 
-	ret = nvm_init(dev);
-	if (ret)
-		goto err_init;
+	if (!dev->q || !dev->ops)
+		return -EINVAL;
 
 	if (dev->ops->max_phys_sect > 256) {
 		pr_info("nvm: max sectors supported is 256.\n");
-		ret = -EINVAL;
-		goto err_init;
+		return -EINVAL;
 	}
 
 	if (dev->ops->max_phys_sect > 1) {
 		dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
 		if (!dev->dma_pool) {
 			pr_err("nvm: could not create dma pool\n");
-			ret = -ENOMEM;
-			goto err_init;
+			return -ENOMEM;
 		}
 	}
 
-	if (dev->identity.cap & NVM_ID_DCAP_BBLKMGMT) {
-		ret = nvm_get_sysblock(dev, &dev->sb);
-		if (!ret)
-			pr_err("nvm: device not initialized.\n");
-		else if (ret < 0)
-			pr_err("nvm: err (%d) on device initialization\n", ret);
-	}
+	ret = nvm_init(dev);
+	if (ret)
+		goto err_init;
 
 	/* register device with a supported media manager */
 	down_write(&nvm_lock);
-	if (ret > 0)
-		dev->mt = nvm_init_mgr(dev);
 	list_add(&dev->devices, &nvm_devices);
 	up_write(&nvm_lock);
 
 	return 0;
 err_init:
-	kfree(dev->lun_map);
+	dev->ops->destroy_dma_pool(dev->dma_pool);
 	return ret;
 }
 EXPORT_SYMBOL(nvm_register);
 
 void nvm_unregister(struct nvm_dev *dev)
 {
+	struct nvm_target *t, *tmp;
+
+	mutex_lock(&dev->mlock);
+	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
+		if (t->dev->parent != dev)
+			continue;
+		__nvm_remove_target(t);
+	}
+	mutex_unlock(&dev->mlock);
+
 	down_write(&nvm_lock);
 	list_del(&dev->devices);
 	up_write(&nvm_lock);
@@ -844,11 +1310,6 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	if (!dev->mt) {
-		pr_info("nvm: device has no media manager registered.\n");
-		return -ENODEV;
-	}
-
 	if (create->conf.type != NVM_CONFIG_TYPE_SIMPLE) {
 		pr_err("nvm: config type not valid\n");
 		return -EINVAL;
@@ -861,7 +1322,7 @@ static int __nvm_configure_create(struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
-	return dev->mt->create_tgt(dev, create);
+	return nvm_create_tgt(dev, create);
 }
 
 static long nvm_ioctl_info(struct file *file, void __user *arg)
@@ -923,16 +1384,14 @@ static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
 		struct nvm_ioctl_device_info *info = &devices->info[i];
 
 		sprintf(info->devname, "%s", dev->name);
-		if (dev->mt) {
-			info->bmversion[0] = dev->mt->version[0];
-			info->bmversion[1] = dev->mt->version[1];
-			info->bmversion[2] = dev->mt->version[2];
-			sprintf(info->bmname, "%s", dev->mt->name);
-		} else {
-			sprintf(info->bmname, "none");
-		}
 
+		/* kept for compatibility */
+		info->bmversion[0] = 1;
+		info->bmversion[1] = 0;
+		info->bmversion[2] = 0;
+		sprintf(info->bmname, "%s", "gennvm");
 		i++;
+
 		if (i > 31) {
 			pr_err("nvm: max 31 devices can be reported.\n");
 			break;
@@ -994,7 +1453,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	}
 
 	list_for_each_entry(dev, &nvm_devices, devices) {
-		ret = dev->mt->remove_tgt(dev, &remove);
+		ret = nvm_remove_tgt(dev, &remove);
 		if (!ret)
 			break;
 	}
@@ -1002,47 +1461,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 	return ret;
 }
 
-static void nvm_setup_nvm_sb_info(struct nvm_sb_info *info)
-{
-	info->seqnr = 1;
-	info->erase_cnt = 0;
-	info->version = 1;
-}
-
-static long __nvm_ioctl_dev_init(struct nvm_ioctl_dev_init *init)
-{
-	struct nvm_dev *dev;
-	struct nvm_sb_info info;
-	int ret;
-
-	down_write(&nvm_lock);
-	dev = nvm_find_nvm_dev(init->dev);
-	up_write(&nvm_lock);
-	if (!dev) {
-		pr_err("nvm: device not found\n");
-		return -EINVAL;
-	}
-
-	nvm_setup_nvm_sb_info(&info);
-
-	strncpy(info.mmtype, init->mmtype, NVM_MMTYPE_LEN);
-	info.fs_ppa.ppa = -1;
-
-	if (dev->identity.cap & NVM_ID_DCAP_BBLKMGMT) {
-		ret = nvm_init_sysblock(dev, &info);
-		if (ret)
-			return ret;
-	}
-
-	memcpy(&dev->sb, &info, sizeof(struct nvm_sb_info));
-
-	down_write(&nvm_lock);
-	dev->mt = nvm_init_mgr(dev);
-	up_write(&nvm_lock);
-
-	return 0;
-}
-
+/* kept for compatibility reasons */
 static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_dev_init init;
@@ -1058,15 +1477,13 @@ static long nvm_ioctl_dev_init(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
-	init.dev[DISK_NAME_LEN - 1] = '\0';
-
-	return __nvm_ioctl_dev_init(&init);
+	return 0;
 }
 
+/* Kept for compatibility reasons */
 static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_dev_factory fact;
-	struct nvm_dev *dev;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1079,19 +1496,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
 	if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
 		return -EINVAL;
 
-	down_write(&nvm_lock);
-	dev = nvm_find_nvm_dev(fact.dev);
-	up_write(&nvm_lock);
-	if (!dev) {
-		pr_err("nvm: device not found\n");
-		return -EINVAL;
-	}
-
-	nvm_free_mgr(dev);
-
-	if (dev->identity.cap & NVM_ID_DCAP_BBLKMGMT)
-		return nvm_dev_factory(dev, fact.flags);
-
 	return 0;
 }
 
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
deleted file mode 100644
index ca78800..0000000
--- a/drivers/lightnvm/gennvm.c
+++ /dev/null
@@ -1,657 +0,0 @@
-/*
- * Copyright (C) 2015 Matias Bjorling <m@bjorling.me>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
- * Implementation of a general nvm manager for Open-Channel SSDs.
- */
-
-#include "gennvm.h"
-
-static struct nvm_target *gen_find_target(struct gen_dev *gn, const char *name)
-{
-	struct nvm_target *tgt;
-
-	list_for_each_entry(tgt, &gn->targets, list)
-		if (!strcmp(name, tgt->disk->disk_name))
-			return tgt;
-
-	return NULL;
-}
-
-static const struct block_device_operations gen_fops = {
-	.owner		= THIS_MODULE,
-};
-
-static int gen_reserve_luns(struct nvm_dev *dev, struct nvm_target *t,
-			    int lun_begin, int lun_end)
-{
-	int i;
-
-	for (i = lun_begin; i <= lun_end; i++) {
-		if (test_and_set_bit(i, dev->lun_map)) {
-			pr_err("nvm: lun %d already allocated\n", i);
-			goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	while (--i > lun_begin)
-		clear_bit(i, dev->lun_map);
-
-	return -EBUSY;
-}
-
-static void gen_release_luns_err(struct nvm_dev *dev, int lun_begin,
-				 int lun_end)
-{
-	int i;
-
-	for (i = lun_begin; i <= lun_end; i++)
-		WARN_ON(!test_and_clear_bit(i, dev->lun_map));
-}
-
-static void gen_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-	struct gen_dev_map *dev_map = tgt_dev->map;
-	int i, j;
-
-	for (i = 0; i < dev_map->nr_chnls; i++) {
-		struct gen_ch_map *ch_map = &dev_map->chnls[i];
-		int *lun_offs = ch_map->lun_offs;
-		int ch = i + ch_map->ch_off;
-
-		for (j = 0; j < ch_map->nr_luns; j++) {
-			int lun = j + lun_offs[j];
-			int lunid = (ch * dev->geo.luns_per_chnl) + lun;
-
-			WARN_ON(!test_and_clear_bit(lunid, dev->lun_map));
-		}
-
-		kfree(ch_map->lun_offs);
-	}
-
-	kfree(dev_map->chnls);
-	kfree(dev_map);
-	kfree(tgt_dev->luns);
-	kfree(tgt_dev);
-}
-
-static struct nvm_tgt_dev *gen_create_tgt_dev(struct nvm_dev *dev,
-					      int lun_begin, int lun_end)
-{
-	struct nvm_tgt_dev *tgt_dev = NULL;
-	struct gen_dev_map *dev_rmap = dev->rmap;
-	struct gen_dev_map *dev_map;
-	struct ppa_addr *luns;
-	int nr_luns = lun_end - lun_begin + 1;
-	int luns_left = nr_luns;
-	int nr_chnls = nr_luns / dev->geo.luns_per_chnl;
-	int nr_chnls_mod = nr_luns % dev->geo.luns_per_chnl;
-	int bch = lun_begin / dev->geo.luns_per_chnl;
-	int blun = lun_begin % dev->geo.luns_per_chnl;
-	int lunid = 0;
-	int lun_balanced = 1;
-	int prev_nr_luns;
-	int i, j;
-
-	nr_chnls = nr_luns / dev->geo.luns_per_chnl;
-	nr_chnls = (nr_chnls_mod == 0) ? nr_chnls : nr_chnls + 1;
-
-	dev_map = kmalloc(sizeof(struct gen_dev_map), GFP_KERNEL);
-	if (!dev_map)
-		goto err_dev;
-
-	dev_map->chnls = kcalloc(nr_chnls, sizeof(struct gen_ch_map),
-								GFP_KERNEL);
-	if (!dev_map->chnls)
-		goto err_chnls;
-
-	luns = kcalloc(nr_luns, sizeof(struct ppa_addr), GFP_KERNEL);
-	if (!luns)
-		goto err_luns;
-
-	prev_nr_luns = (luns_left > dev->geo.luns_per_chnl) ?
-					dev->geo.luns_per_chnl : luns_left;
-	for (i = 0; i < nr_chnls; i++) {
-		struct gen_ch_map *ch_rmap = &dev_rmap->chnls[i + bch];
-		int *lun_roffs = ch_rmap->lun_offs;
-		struct gen_ch_map *ch_map = &dev_map->chnls[i];
-		int *lun_offs;
-		int luns_in_chnl = (luns_left > dev->geo.luns_per_chnl) ?
-					dev->geo.luns_per_chnl : luns_left;
-
-		if (lun_balanced && prev_nr_luns != luns_in_chnl)
-			lun_balanced = 0;
-
-		ch_map->ch_off = ch_rmap->ch_off = bch;
-		ch_map->nr_luns = luns_in_chnl;
-
-		lun_offs = kcalloc(luns_in_chnl, sizeof(int), GFP_KERNEL);
-		if (!lun_offs)
-			goto err_ch;
-
-		for (j = 0; j < luns_in_chnl; j++) {
-			luns[lunid].ppa = 0;
-			luns[lunid].g.ch = i;
-			luns[lunid++].g.lun = j;
-
-			lun_offs[j] = blun;
-			lun_roffs[j + blun] = blun;
-		}
-
-		ch_map->lun_offs = lun_offs;
-
-		/* when starting a new channel, lun offset is reset */
-		blun = 0;
-		luns_left -= luns_in_chnl;
-	}
-
-	dev_map->nr_chnls = nr_chnls;
-
-	tgt_dev = kmalloc(sizeof(struct nvm_tgt_dev), GFP_KERNEL);
-	if (!tgt_dev)
-		goto err_ch;
-
-	memcpy(&tgt_dev->geo, &dev->geo, sizeof(struct nvm_geo));
-	/* Target device only owns a portion of the physical device */
-	tgt_dev->geo.nr_chnls = nr_chnls;
-	tgt_dev->geo.nr_luns = nr_luns;
-	tgt_dev->geo.luns_per_chnl = (lun_balanced) ? prev_nr_luns : -1;
-	tgt_dev->total_secs = nr_luns * tgt_dev->geo.sec_per_lun;
-	tgt_dev->q = dev->q;
-	tgt_dev->map = dev_map;
-	tgt_dev->luns = luns;
-	memcpy(&tgt_dev->identity, &dev->identity, sizeof(struct nvm_id));
-
-	tgt_dev->parent = dev;
-
-	return tgt_dev;
-err_ch:
-	while (--i > 0)
-		kfree(dev_map->chnls[i].lun_offs);
-	kfree(luns);
-err_luns:
-	kfree(dev_map->chnls);
-err_chnls:
-	kfree(dev_map);
-err_dev:
-	return tgt_dev;
-}
-
-static int gen_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
-{
-	struct gen_dev *gn = dev->mp;
-	struct nvm_ioctl_create_simple *s = &create->conf.s;
-	struct request_queue *tqueue;
-	struct gendisk *tdisk;
-	struct nvm_tgt_type *tt;
-	struct nvm_target *t;
-	struct nvm_tgt_dev *tgt_dev;
-	void *targetdata;
-
-	tt = nvm_find_target_type(create->tgttype, 1);
-	if (!tt) {
-		pr_err("nvm: target type %s not found\n", create->tgttype);
-		return -EINVAL;
-	}
-
-	mutex_lock(&gn->lock);
-	t = gen_find_target(gn, create->tgtname);
-	if (t) {
-		pr_err("nvm: target name already exists.\n");
-		mutex_unlock(&gn->lock);
-		return -EINVAL;
-	}
-	mutex_unlock(&gn->lock);
-
-	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
-	if (!t)
-		return -ENOMEM;
-
-	if (gen_reserve_luns(dev, t, s->lun_begin, s->lun_end))
-		goto err_t;
-
-	tgt_dev = gen_create_tgt_dev(dev, s->lun_begin, s->lun_end);
-	if (!tgt_dev) {
-		pr_err("nvm: could not create target device\n");
-		goto err_reserve;
-	}
-
-	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
-	if (!tqueue)
-		goto err_dev;
-	blk_queue_make_request(tqueue, tt->make_rq);
-
-	tdisk = alloc_disk(0);
-	if (!tdisk)
-		goto err_queue;
-
-	sprintf(tdisk->disk_name, "%s", create->tgtname);
-	tdisk->flags = GENHD_FL_EXT_DEVT;
-	tdisk->major = 0;
-	tdisk->first_minor = 0;
-	tdisk->fops = &gen_fops;
-	tdisk->queue = tqueue;
-
-	targetdata = tt->init(tgt_dev, tdisk);
-	if (IS_ERR(targetdata))
-		goto err_init;
-
-	tdisk->private_data = targetdata;
-	tqueue->queuedata = targetdata;
-
-	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
-
-	set_capacity(tdisk, tt->capacity(targetdata));
-	add_disk(tdisk);
-
-	t->type = tt;
-	t->disk = tdisk;
-	t->dev = tgt_dev;
-
-	mutex_lock(&gn->lock);
-	list_add_tail(&t->list, &gn->targets);
-	mutex_unlock(&gn->lock);
-
-	return 0;
-err_init:
-	put_disk(tdisk);
-err_queue:
-	blk_cleanup_queue(tqueue);
-err_dev:
-	kfree(tgt_dev);
-err_reserve:
-	gen_release_luns_err(dev, s->lun_begin, s->lun_end);
-err_t:
-	kfree(t);
-	return -ENOMEM;
-}
-
-static void __gen_remove_target(struct nvm_target *t)
-{
-	struct nvm_tgt_type *tt = t->type;
-	struct gendisk *tdisk = t->disk;
-	struct request_queue *q = tdisk->queue;
-
-	del_gendisk(tdisk);
-	blk_cleanup_queue(q);
-
-	if (tt->exit)
-		tt->exit(tdisk->private_data);
-
-	gen_remove_tgt_dev(t->dev);
-	put_disk(tdisk);
-
-	list_del(&t->list);
-	kfree(t);
-}
-
-/**
- * gen_remove_tgt - Removes a target from the media manager
- * @dev:	device
- * @remove:	ioctl structure with target name to remove.
- *
- * Returns:
- * 0: on success
- * 1: on not found
- * <0: on error
- */
-static int gen_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
-{
-	struct gen_dev *gn = dev->mp;
-	struct nvm_target *t;
-
-	if (!gn)
-		return 1;
-
-	mutex_lock(&gn->lock);
-	t = gen_find_target(gn, remove->tgtname);
-	if (!t) {
-		mutex_unlock(&gn->lock);
-		return 1;
-	}
-	__gen_remove_target(t);
-	mutex_unlock(&gn->lock);
-
-	return 0;
-}
-
-static int gen_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct gen_dev *gn = dev->mp;
-	struct gen_area *area, *prev, *next;
-	sector_t begin = 0;
-	sector_t max_sectors = (geo->sec_size * dev->total_secs) >> 9;
-
-	if (len > max_sectors)
-		return -EINVAL;
-
-	area = kmalloc(sizeof(struct gen_area), GFP_KERNEL);
-	if (!area)
-		return -ENOMEM;
-
-	prev = NULL;
-
-	spin_lock(&dev->lock);
-	list_for_each_entry(next, &gn->area_list, list) {
-		if (begin + len > next->begin) {
-			begin = next->end;
-			prev = next;
-			continue;
-		}
-		break;
-	}
-
-	if ((begin + len) > max_sectors) {
-		spin_unlock(&dev->lock);
-		kfree(area);
-		return -EINVAL;
-	}
-
-	area->begin = *lba = begin;
-	area->end = begin + len;
-
-	if (prev) /* insert into sorted order */
-		list_add(&area->list, &prev->list);
-	else
-		list_add(&area->list, &gn->area_list);
-	spin_unlock(&dev->lock);
-
-	return 0;
-}
-
-static void gen_put_area(struct nvm_dev *dev, sector_t begin)
-{
-	struct gen_dev *gn = dev->mp;
-	struct gen_area *area;
-
-	spin_lock(&dev->lock);
-	list_for_each_entry(area, &gn->area_list, list) {
-		if (area->begin != begin)
-			continue;
-
-		list_del(&area->list);
-		spin_unlock(&dev->lock);
-		kfree(area);
-		return;
-	}
-	spin_unlock(&dev->lock);
-}
-
-static void gen_free(struct nvm_dev *dev)
-{
-	kfree(dev->mp);
-	kfree(dev->rmap);
-	dev->mp = NULL;
-}
-
-static int gen_register(struct nvm_dev *dev)
-{
-	struct gen_dev *gn;
-	struct gen_dev_map *dev_rmap;
-	int i, j;
-
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
-	gn = kzalloc(sizeof(struct gen_dev), GFP_KERNEL);
-	if (!gn)
-		goto err_gn;
-
-	dev_rmap = kmalloc(sizeof(struct gen_dev_map), GFP_KERNEL);
-	if (!dev_rmap)
-		goto err_rmap;
-
-	dev_rmap->chnls = kcalloc(dev->geo.nr_chnls, sizeof(struct gen_ch_map),
-								GFP_KERNEL);
-	if (!dev_rmap->chnls)
-		goto err_chnls;
-
-	for (i = 0; i < dev->geo.nr_chnls; i++) {
-		struct gen_ch_map *ch_rmap;
-		int *lun_roffs;
-		int luns_in_chnl = dev->geo.luns_per_chnl;
-
-		ch_rmap = &dev_rmap->chnls[i];
-
-		ch_rmap->ch_off = -1;
-		ch_rmap->nr_luns = luns_in_chnl;
-
-		lun_roffs = kcalloc(luns_in_chnl, sizeof(int), GFP_KERNEL);
-		if (!lun_roffs)
-			goto err_ch;
-
-		for (j = 0; j < luns_in_chnl; j++)
-			lun_roffs[j] = -1;
-
-		ch_rmap->lun_offs = lun_roffs;
-	}
-
-	gn->dev = dev;
-	gn->nr_luns = dev->geo.nr_luns;
-	INIT_LIST_HEAD(&gn->area_list);
-	mutex_init(&gn->lock);
-	INIT_LIST_HEAD(&gn->targets);
-	dev->mp = gn;
-	dev->rmap = dev_rmap;
-
-	return 1;
-err_ch:
-	while (--i >= 0)
-		kfree(dev_rmap->chnls[i].lun_offs);
-err_chnls:
-	kfree(dev_rmap);
-err_rmap:
-	gen_free(dev);
-err_gn:
-	module_put(THIS_MODULE);
-	return -ENOMEM;
-}
-
-static void gen_unregister(struct nvm_dev *dev)
-{
-	struct gen_dev *gn = dev->mp;
-	struct nvm_target *t, *tmp;
-
-	mutex_lock(&gn->lock);
-	list_for_each_entry_safe(t, tmp, &gn->targets, list) {
-		if (t->dev->parent != dev)
-			continue;
-		__gen_remove_target(t);
-	}
-	mutex_unlock(&gn->lock);
-
-	gen_free(dev);
-	module_put(THIS_MODULE);
-}
-
-static int gen_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
-{
-	struct gen_dev_map *dev_map = tgt_dev->map;
-	struct gen_ch_map *ch_map = &dev_map->chnls[p->g.ch];
-	int lun_off = ch_map->lun_offs[p->g.lun];
-	struct nvm_dev *dev = tgt_dev->parent;
-	struct gen_dev_map *dev_rmap = dev->rmap;
-	struct gen_ch_map *ch_rmap;
-	int lun_roff;
-
-	p->g.ch += ch_map->ch_off;
-	p->g.lun += lun_off;
-
-	ch_rmap = &dev_rmap->chnls[p->g.ch];
-	lun_roff = ch_rmap->lun_offs[p->g.lun];
-
-	if (unlikely(ch_rmap->ch_off < 0 || lun_roff < 0)) {
-		pr_err("nvm: corrupted device partition table\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int gen_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-	struct gen_dev_map *dev_rmap = dev->rmap;
-	struct gen_ch_map *ch_rmap = &dev_rmap->chnls[p->g.ch];
-	int lun_roff = ch_rmap->lun_offs[p->g.lun];
-
-	p->g.ch -= ch_rmap->ch_off;
-	p->g.lun -= lun_roff;
-
-	return 0;
-}
-
-static int gen_trans_rq(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
-			int flag)
-{
-	gen_trans_fn *f;
-	int i;
-	int ret = 0;
-
-	f = (flag == TRANS_TGT_TO_DEV) ? gen_map_to_dev : gen_map_to_tgt;
-
-	if (rqd->nr_ppas == 1)
-		return f(tgt_dev, &rqd->ppa_addr);
-
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		ret = f(tgt_dev, &rqd->ppa_list[i]);
-		if (ret)
-			goto out;
-	}
-
-out:
-	return ret;
-}
-
-static void gen_end_io(struct nvm_rq *rqd)
-{
-	struct nvm_tgt_dev *tgt_dev = rqd->dev;
-	struct nvm_tgt_instance *ins = rqd->ins;
-
-	/* Convert address space */
-	if (tgt_dev)
-		gen_trans_rq(tgt_dev, rqd, TRANS_DEV_TO_TGT);
-
-	ins->tt->end_io(rqd);
-}
-
-static int gen_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-
-	if (!dev->ops->submit_io)
-		return -ENODEV;
-
-	/* Convert address space */
-	gen_trans_rq(tgt_dev, rqd, TRANS_TGT_TO_DEV);
-	nvm_generic_to_addr_mode(dev, rqd);
-
-	rqd->dev = tgt_dev;
-	rqd->end_io = gen_end_io;
-	return dev->ops->submit_io(dev, rqd);
-}
-
-static int gen_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p,
-			 int flags)
-{
-	/* Convert address space */
-	gen_map_to_dev(tgt_dev, p);
-
-	return nvm_erase_ppa(tgt_dev->parent, p, 1, flags);
-}
-
-static struct ppa_addr gen_trans_ppa(struct nvm_tgt_dev *tgt_dev,
-				     struct ppa_addr p, int direction)
-{
-	gen_trans_fn *f;
-	struct ppa_addr ppa = p;
-
-	f = (direction == TRANS_TGT_TO_DEV) ? gen_map_to_dev : gen_map_to_tgt;
-	f(tgt_dev, &ppa);
-
-	return ppa;
-}
-
-static void gen_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
-			       int len)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct gen_dev_map *dev_rmap = dev->rmap;
-	u64 i;
-
-	for (i = 0; i < len; i++) {
-		struct gen_ch_map *ch_rmap;
-		int *lun_roffs;
-		struct ppa_addr gaddr;
-		u64 pba = le64_to_cpu(entries[i]);
-		int off;
-		u64 diff;
-
-		if (!pba)
-			continue;
-
-		gaddr = linear_to_generic_addr(geo, pba);
-		ch_rmap = &dev_rmap->chnls[gaddr.g.ch];
-		lun_roffs = ch_rmap->lun_offs;
-
-		off = gaddr.g.ch * geo->luns_per_chnl + gaddr.g.lun;
-
-		diff = ((ch_rmap->ch_off * geo->luns_per_chnl) +
-				(lun_roffs[gaddr.g.lun])) * geo->sec_per_lun;
-
-		entries[i] -= cpu_to_le64(diff);
-	}
-}
-
-static struct nvmm_type gen = {
-	.name			= "gennvm",
-	.version		= {0, 1, 0},
-
-	.register_mgr		= gen_register,
-	.unregister_mgr		= gen_unregister,
-
-	.create_tgt		= gen_create_tgt,
-	.remove_tgt		= gen_remove_tgt,
-
-	.submit_io		= gen_submit_io,
-	.erase_blk		= gen_erase_blk,
-
-	.get_area		= gen_get_area,
-	.put_area		= gen_put_area,
-
-	.trans_ppa		= gen_trans_ppa,
-	.part_to_tgt		= gen_part_to_tgt,
-};
-
-static int __init gen_module_init(void)
-{
-	return nvm_register_mgr(&gen);
-}
-
-static void gen_module_exit(void)
-{
-	nvm_unregister_mgr(&gen);
-}
-
-module_init(gen_module_init);
-module_exit(gen_module_exit);
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("General media manager for Open-Channel SSDs");
diff --git a/drivers/lightnvm/gennvm.h b/drivers/lightnvm/gennvm.h
deleted file mode 100644
index 6a4b3f3..0000000
--- a/drivers/lightnvm/gennvm.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright: Matias Bjorling <mb@bjorling.me>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- */
-
-#ifndef GENNVM_H_
-#define GENNVM_H_
-
-#include <linux/module.h>
-#include <linux/vmalloc.h>
-
-#include <linux/lightnvm.h>
-
-struct gen_dev {
-	struct nvm_dev *dev;
-
-	int nr_luns;
-	struct list_head area_list;
-
-	struct mutex lock;
-	struct list_head targets;
-};
-
-/* Map between virtual and physical channel and lun */
-struct gen_ch_map {
-	int ch_off;
-	int nr_luns;
-	int *lun_offs;
-};
-
-struct gen_dev_map {
-	struct gen_ch_map *chnls;
-	int nr_chnls;
-};
-
-struct gen_area {
-	struct list_head list;
-	sector_t begin;
-	sector_t end;	/* end is excluded */
-};
-
-static inline void *ch_map_to_lun_offs(struct gen_ch_map *ch_map)
-{
-	return ch_map + 1;
-}
-
-typedef int (gen_trans_fn)(struct nvm_tgt_dev *, struct ppa_addr *);
-
-#define gen_for_each_lun(bm, lun, i) \
-		for ((i) = 0, lun = &(bm)->luns[0]; \
-			(i) < (bm)->nr_luns; (i)++, lun = &(bm)->luns[(i)])
-
-#endif /* GENNVM_H_ */
diff --git a/drivers/lightnvm/sysblk.c b/drivers/lightnvm/sysblk.c
deleted file mode 100644
index 12002bf..0000000
--- a/drivers/lightnvm/sysblk.c
+++ /dev/null
@@ -1,733 +0,0 @@
-/*
- * Copyright (C) 2015 Matias Bjorling. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
- */
-
-#include <linux/lightnvm.h>
-
-#define MAX_SYSBLKS 3	/* remember to update mapping scheme on change */
-#define MAX_BLKS_PR_SYSBLK 2 /* 2 blks with 256 pages and 3000 erases
-			      * enables ~1.5M updates per sysblk unit
-			      */
-
-struct sysblk_scan {
-	/* A row is a collection of flash blocks for a system block. */
-	int nr_rows;
-	int row;
-	int act_blk[MAX_SYSBLKS];
-
-	int nr_ppas;
-	struct ppa_addr ppas[MAX_SYSBLKS * MAX_BLKS_PR_SYSBLK];/* all sysblks */
-};
-
-static inline int scan_ppa_idx(int row, int blkid)
-{
-	return (row * MAX_BLKS_PR_SYSBLK) + blkid;
-}
-
-static void nvm_sysblk_to_cpu(struct nvm_sb_info *info,
-			      struct nvm_system_block *sb)
-{
-	info->seqnr = be32_to_cpu(sb->seqnr);
-	info->erase_cnt = be32_to_cpu(sb->erase_cnt);
-	info->version = be16_to_cpu(sb->version);
-	strncpy(info->mmtype, sb->mmtype, NVM_MMTYPE_LEN);
-	info->fs_ppa.ppa = be64_to_cpu(sb->fs_ppa);
-}
-
-static void nvm_cpu_to_sysblk(struct nvm_system_block *sb,
-			      struct nvm_sb_info *info)
-{
-	sb->magic = cpu_to_be32(NVM_SYSBLK_MAGIC);
-	sb->seqnr = cpu_to_be32(info->seqnr);
-	sb->erase_cnt = cpu_to_be32(info->erase_cnt);
-	sb->version = cpu_to_be16(info->version);
-	strncpy(sb->mmtype, info->mmtype, NVM_MMTYPE_LEN);
-	sb->fs_ppa = cpu_to_be64(info->fs_ppa.ppa);
-}
-
-static int nvm_setup_sysblks(struct nvm_dev *dev, struct ppa_addr *sysblk_ppas)
-{
-	struct nvm_geo *geo = &dev->geo;
-	int nr_rows = min_t(int, MAX_SYSBLKS, geo->nr_chnls);
-	int i;
-
-	for (i = 0; i < nr_rows; i++)
-		sysblk_ppas[i].ppa = 0;
-
-	/* if possible, place sysblk at first channel, middle channel and last
-	 * channel of the device. If not, create only one or two sys blocks
-	 */
-	switch (geo->nr_chnls) {
-	case 2:
-		sysblk_ppas[1].g.ch = 1;
-		/* fall-through */
-	case 1:
-		sysblk_ppas[0].g.ch = 0;
-		break;
-	default:
-		sysblk_ppas[0].g.ch = 0;
-		sysblk_ppas[1].g.ch = geo->nr_chnls / 2;
-		sysblk_ppas[2].g.ch = geo->nr_chnls - 1;
-		break;
-	}
-
-	return nr_rows;
-}
-
-static void nvm_setup_sysblk_scan(struct nvm_dev *dev, struct sysblk_scan *s,
-						struct ppa_addr *sysblk_ppas)
-{
-	memset(s, 0, sizeof(struct sysblk_scan));
-	s->nr_rows = nvm_setup_sysblks(dev, sysblk_ppas);
-}
-
-static int sysblk_get_free_blks(struct nvm_dev *dev, struct ppa_addr ppa,
-					u8 *blks, int nr_blks,
-					struct sysblk_scan *s)
-{
-	struct ppa_addr *sppa;
-	int i, blkid = 0;
-
-	nr_blks = nvm_bb_tbl_fold(dev, blks, nr_blks);
-	if (nr_blks < 0)
-		return nr_blks;
-
-	for (i = 0; i < nr_blks; i++) {
-		if (blks[i] == NVM_BLK_T_HOST)
-			return -EEXIST;
-
-		if (blks[i] != NVM_BLK_T_FREE)
-			continue;
-
-		sppa = &s->ppas[scan_ppa_idx(s->row, blkid)];
-		sppa->g.ch = ppa.g.ch;
-		sppa->g.lun = ppa.g.lun;
-		sppa->g.blk = i;
-		s->nr_ppas++;
-		blkid++;
-
-		pr_debug("nvm: use (%u %u %u) as sysblk\n",
-					sppa->g.ch, sppa->g.lun, sppa->g.blk);
-		if (blkid > MAX_BLKS_PR_SYSBLK - 1)
-			return 0;
-	}
-
-	pr_err("nvm: sysblk failed get sysblk\n");
-	return -EINVAL;
-}
-
-static int sysblk_get_host_blks(struct nvm_dev *dev, struct ppa_addr ppa,
-					u8 *blks, int nr_blks,
-					struct sysblk_scan *s)
-{
-	int i, nr_sysblk = 0;
-
-	nr_blks = nvm_bb_tbl_fold(dev, blks, nr_blks);
-	if (nr_blks < 0)
-		return nr_blks;
-
-	for (i = 0; i < nr_blks; i++) {
-		if (blks[i] != NVM_BLK_T_HOST)
-			continue;
-
-		if (s->nr_ppas == MAX_BLKS_PR_SYSBLK * MAX_SYSBLKS) {
-			pr_err("nvm: too many host blks\n");
-			return -EINVAL;
-		}
-
-		ppa.g.blk = i;
-
-		s->ppas[scan_ppa_idx(s->row, nr_sysblk)] = ppa;
-		s->nr_ppas++;
-		nr_sysblk++;
-	}
-
-	return 0;
-}
-
-static int nvm_get_all_sysblks(struct nvm_dev *dev, struct sysblk_scan *s,
-				struct ppa_addr *ppas, int get_free)
-{
-	struct nvm_geo *geo = &dev->geo;
-	int i, nr_blks, ret = 0;
-	u8 *blks;
-
-	s->nr_ppas = 0;
-	nr_blks = geo->blks_per_lun * geo->plane_mode;
-
-	blks = kmalloc(nr_blks, GFP_KERNEL);
-	if (!blks)
-		return -ENOMEM;
-
-	for (i = 0; i < s->nr_rows; i++) {
-		s->row = i;
-
-		ret = nvm_get_bb_tbl(dev, ppas[i], blks);
-		if (ret) {
-			pr_err("nvm: failed bb tbl for ppa (%u %u)\n",
-							ppas[i].g.ch,
-							ppas[i].g.blk);
-			goto err_get;
-		}
-
-		if (get_free)
-			ret = sysblk_get_free_blks(dev, ppas[i], blks, nr_blks,
-									s);
-		else
-			ret = sysblk_get_host_blks(dev, ppas[i], blks, nr_blks,
-									s);
-
-		if (ret)
-			goto err_get;
-	}
-
-err_get:
-	kfree(blks);
-	return ret;
-}
-
-/*
- * scans a block for latest sysblk.
- * Returns:
- *	0 - newer sysblk not found. PPA is updated to latest page.
- *	1 - newer sysblk found and stored in *cur. PPA is updated to
- *	    next valid page.
- *	<0- error.
- */
-static int nvm_scan_block(struct nvm_dev *dev, struct ppa_addr *ppa,
-						struct nvm_system_block *sblk)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct nvm_system_block *cur;
-	int pg, ret, found = 0;
-
-	/* the full buffer for a flash page is allocated. Only the first of it
-	 * contains the system block information
-	 */
-	cur = kmalloc(geo->pfpg_size, GFP_KERNEL);
-	if (!cur)
-		return -ENOMEM;
-
-	/* perform linear scan through the block */
-	for (pg = 0; pg < dev->lps_per_blk; pg++) {
-		ppa->g.pg = ppa_to_slc(dev, pg);
-
-		ret = nvm_submit_ppa(dev, ppa, 1, NVM_OP_PREAD, NVM_IO_SLC_MODE,
-							cur, geo->pfpg_size);
-		if (ret) {
-			if (ret == NVM_RSP_ERR_EMPTYPAGE) {
-				pr_debug("nvm: sysblk scan empty ppa (%u %u %u %u)\n",
-							ppa->g.ch,
-							ppa->g.lun,
-							ppa->g.blk,
-							ppa->g.pg);
-				break;
-			}
-			pr_err("nvm: read failed (%x) for ppa (%u %u %u %u)",
-							ret,
-							ppa->g.ch,
-							ppa->g.lun,
-							ppa->g.blk,
-							ppa->g.pg);
-			break; /* if we can't read a page, continue to the
-				* next blk
-				*/
-		}
-
-		if (be32_to_cpu(cur->magic) != NVM_SYSBLK_MAGIC) {
-			pr_debug("nvm: scan break for ppa (%u %u %u %u)\n",
-							ppa->g.ch,
-							ppa->g.lun,
-							ppa->g.blk,
-							ppa->g.pg);
-			break; /* last valid page already found */
-		}
-
-		if (be32_to_cpu(cur->seqnr) < be32_to_cpu(sblk->seqnr))
-			continue;
-
-		memcpy(sblk, cur, sizeof(struct nvm_system_block));
-		found = 1;
-	}
-
-	kfree(cur);
-
-	return found;
-}
-
-static int nvm_sysblk_set_bb_tbl(struct nvm_dev *dev, struct sysblk_scan *s,
-								int type)
-{
-	return nvm_set_bb_tbl(dev, s->ppas, s->nr_ppas, type);
-}
-
-static int nvm_write_and_verify(struct nvm_dev *dev, struct nvm_sb_info *info,
-							struct sysblk_scan *s)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct nvm_system_block nvmsb;
-	void *buf;
-	int i, sect, ret = 0;
-	struct ppa_addr *ppas;
-
-	nvm_cpu_to_sysblk(&nvmsb, info);
-
-	buf = kzalloc(geo->pfpg_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	memcpy(buf, &nvmsb, sizeof(struct nvm_system_block));
-
-	ppas = kcalloc(geo->sec_per_pg, sizeof(struct ppa_addr), GFP_KERNEL);
-	if (!ppas) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	/* Write and verify */
-	for (i = 0; i < s->nr_rows; i++) {
-		ppas[0] = s->ppas[scan_ppa_idx(i, s->act_blk[i])];
-
-		pr_debug("nvm: writing sysblk to ppa (%u %u %u %u)\n",
-							ppas[0].g.ch,
-							ppas[0].g.lun,
-							ppas[0].g.blk,
-							ppas[0].g.pg);
-
-		/* Expand to all sectors within a flash page */
-		if (geo->sec_per_pg > 1) {
-			for (sect = 1; sect < geo->sec_per_pg; sect++) {
-				ppas[sect].ppa = ppas[0].ppa;
-				ppas[sect].g.sec = sect;
-			}
-		}
-
-		ret = nvm_submit_ppa(dev, ppas, geo->sec_per_pg, NVM_OP_PWRITE,
-					NVM_IO_SLC_MODE, buf, geo->pfpg_size);
-		if (ret) {
-			pr_err("nvm: sysblk failed program (%u %u %u)\n",
-							ppas[0].g.ch,
-							ppas[0].g.lun,
-							ppas[0].g.blk);
-			break;
-		}
-
-		ret = nvm_submit_ppa(dev, ppas, geo->sec_per_pg, NVM_OP_PREAD,
-					NVM_IO_SLC_MODE, buf, geo->pfpg_size);
-		if (ret) {
-			pr_err("nvm: sysblk failed read (%u %u %u)\n",
-							ppas[0].g.ch,
-							ppas[0].g.lun,
-							ppas[0].g.blk);
-			break;
-		}
-
-		if (memcmp(buf, &nvmsb, sizeof(struct nvm_system_block))) {
-			pr_err("nvm: sysblk failed verify (%u %u %u)\n",
-							ppas[0].g.ch,
-							ppas[0].g.lun,
-							ppas[0].g.blk);
-			ret = -EINVAL;
-			break;
-		}
-	}
-
-	kfree(ppas);
-err:
-	kfree(buf);
-
-	return ret;
-}
-
-static int nvm_prepare_new_sysblks(struct nvm_dev *dev, struct sysblk_scan *s)
-{
-	int i, ret;
-	unsigned long nxt_blk;
-	struct ppa_addr *ppa;
-
-	for (i = 0; i < s->nr_rows; i++) {
-		nxt_blk = (s->act_blk[i] + 1) % MAX_BLKS_PR_SYSBLK;
-		ppa = &s->ppas[scan_ppa_idx(i, nxt_blk)];
-		ppa->g.pg = ppa_to_slc(dev, 0);
-
-		ret = nvm_erase_ppa(dev, ppa, 1, 0);
-		if (ret)
-			return ret;
-
-		s->act_blk[i] = nxt_blk;
-	}
-
-	return 0;
-}
-
-int nvm_get_sysblock(struct nvm_dev *dev, struct nvm_sb_info *info)
-{
-	struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
-	struct sysblk_scan s;
-	struct nvm_system_block *cur;
-	int i, j, found = 0;
-	int ret = -ENOMEM;
-
-	/*
-	 * 1. setup sysblk locations
-	 * 2. get bad block list
-	 * 3. filter on host-specific (type 3)
-	 * 4. iterate through all and find the highest seq nr.
-	 * 5. return superblock information
-	 */
-
-	if (!dev->ops->get_bb_tbl)
-		return -EINVAL;
-
-	nvm_setup_sysblk_scan(dev, &s, sysblk_ppas);
-
-	mutex_lock(&dev->mlock);
-	ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
-	if (ret)
-		goto err_sysblk;
-
-	/* no sysblocks initialized */
-	if (!s.nr_ppas)
-		goto err_sysblk;
-
-	cur = kzalloc(sizeof(struct nvm_system_block), GFP_KERNEL);
-	if (!cur)
-		goto err_sysblk;
-
-	/* find the latest block across all sysblocks */
-	for (i = 0; i < s.nr_rows; i++) {
-		for (j = 0; j < MAX_BLKS_PR_SYSBLK; j++) {
-			struct ppa_addr ppa = s.ppas[scan_ppa_idx(i, j)];
-
-			ret = nvm_scan_block(dev, &ppa, cur);
-			if (ret > 0)
-				found = 1;
-			else if (ret < 0)
-				break;
-		}
-	}
-
-	nvm_sysblk_to_cpu(info, cur);
-
-	kfree(cur);
-err_sysblk:
-	mutex_unlock(&dev->mlock);
-
-	if (found)
-		return 1;
-	return ret;
-}
-
-int nvm_update_sysblock(struct nvm_dev *dev, struct nvm_sb_info *new)
-{
-	/* 1. for each latest superblock
-	 * 2. if room
-	 *    a. write new flash page entry with the updated information
-	 * 3. if no room
-	 *    a. find next available block on lun (linear search)
-	 *       if none, continue to next lun
-	 *       if none at all, report error. also report that it wasn't
-	 *       possible to write to all superblocks.
-	 *    c. write data to block.
-	 */
-	struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
-	struct sysblk_scan s;
-	struct nvm_system_block *cur;
-	int i, j, ppaidx, found = 0;
-	int ret = -ENOMEM;
-
-	if (!dev->ops->get_bb_tbl)
-		return -EINVAL;
-
-	nvm_setup_sysblk_scan(dev, &s, sysblk_ppas);
-
-	mutex_lock(&dev->mlock);
-	ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
-	if (ret)
-		goto err_sysblk;
-
-	cur = kzalloc(sizeof(struct nvm_system_block), GFP_KERNEL);
-	if (!cur)
-		goto err_sysblk;
-
-	/* Get the latest sysblk for each sysblk row */
-	for (i = 0; i < s.nr_rows; i++) {
-		found = 0;
-		for (j = 0; j < MAX_BLKS_PR_SYSBLK; j++) {
-			ppaidx = scan_ppa_idx(i, j);
-			ret = nvm_scan_block(dev, &s.ppas[ppaidx], cur);
-			if (ret > 0) {
-				s.act_blk[i] = j;
-				found = 1;
-			} else if (ret < 0)
-				break;
-		}
-	}
-
-	if (!found) {
-		pr_err("nvm: no valid sysblks found to update\n");
-		ret = -EINVAL;
-		goto err_cur;
-	}
-
-	/*
-	 * All sysblocks found. Check that they have same page id in their flash
-	 * blocks
-	 */
-	for (i = 1; i < s.nr_rows; i++) {
-		struct ppa_addr l = s.ppas[scan_ppa_idx(0, s.act_blk[0])];
-		struct ppa_addr r = s.ppas[scan_ppa_idx(i, s.act_blk[i])];
-
-		if (l.g.pg != r.g.pg) {
-			pr_err("nvm: sysblks not on same page. Previous update failed.\n");
-			ret = -EINVAL;
-			goto err_cur;
-		}
-	}
-
-	/*
-	 * Check that there haven't been another update to the seqnr since we
-	 * began
-	 */
-	if ((new->seqnr - 1) != be32_to_cpu(cur->seqnr)) {
-		pr_err("nvm: seq is not sequential\n");
-		ret = -EINVAL;
-		goto err_cur;
-	}
-
-	/*
-	 * When all pages in a block has been written, a new block is selected
-	 * and writing is performed on the new block.
-	 */
-	if (s.ppas[scan_ppa_idx(0, s.act_blk[0])].g.pg ==
-						dev->lps_per_blk - 1) {
-		ret = nvm_prepare_new_sysblks(dev, &s);
-		if (ret)
-			goto err_cur;
-	}
-
-	ret = nvm_write_and_verify(dev, new, &s);
-err_cur:
-	kfree(cur);
-err_sysblk:
-	mutex_unlock(&dev->mlock);
-
-	return ret;
-}
-
-int nvm_init_sysblock(struct nvm_dev *dev, struct nvm_sb_info *info)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
-	struct sysblk_scan s;
-	int ret;
-
-	/*
-	 * 1. select master blocks and select first available blks
-	 * 2. get bad block list
-	 * 3. mark MAX_SYSBLKS block as host-based device allocated.
-	 * 4. write and verify data to block
-	 */
-
-	if (!dev->ops->get_bb_tbl || !dev->ops->set_bb_tbl)
-		return -EINVAL;
-
-	if (!(geo->mccap & NVM_ID_CAP_SLC) || !dev->lps_per_blk) {
-		pr_err("nvm: memory does not support SLC access\n");
-		return -EINVAL;
-	}
-
-	/* Index all sysblocks and mark them as host-driven */
-	nvm_setup_sysblk_scan(dev, &s, sysblk_ppas);
-
-	mutex_lock(&dev->mlock);
-	ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 1);
-	if (ret)
-		goto err_mark;
-
-	ret = nvm_sysblk_set_bb_tbl(dev, &s, NVM_BLK_T_HOST);
-	if (ret)
-		goto err_mark;
-
-	/* Write to the first block of each row */
-	ret = nvm_write_and_verify(dev, info, &s);
-err_mark:
-	mutex_unlock(&dev->mlock);
-	return ret;
-}
-
-static int factory_nblks(int nblks)
-{
-	/* Round up to nearest BITS_PER_LONG */
-	return (nblks + (BITS_PER_LONG - 1)) & ~(BITS_PER_LONG - 1);
-}
-
-static unsigned int factory_blk_offset(struct nvm_geo *geo, struct ppa_addr ppa)
-{
-	int nblks = factory_nblks(geo->blks_per_lun);
-
-	return ((ppa.g.ch * geo->luns_per_chnl * nblks) + (ppa.g.lun * nblks)) /
-								BITS_PER_LONG;
-}
-
-static int nvm_factory_blks(struct nvm_dev *dev, struct ppa_addr ppa,
-					u8 *blks, int nr_blks,
-					unsigned long *blk_bitmap, int flags)
-{
-	int i, lunoff;
-
-	nr_blks = nvm_bb_tbl_fold(dev, blks, nr_blks);
-	if (nr_blks < 0)
-		return nr_blks;
-
-	lunoff = factory_blk_offset(&dev->geo, ppa);
-
-	/* non-set bits correspond to the block must be erased */
-	for (i = 0; i < nr_blks; i++) {
-		switch (blks[i]) {
-		case NVM_BLK_T_FREE:
-			if (flags & NVM_FACTORY_ERASE_ONLY_USER)
-				set_bit(i, &blk_bitmap[lunoff]);
-			break;
-		case NVM_BLK_T_HOST:
-			if (!(flags & NVM_FACTORY_RESET_HOST_BLKS))
-				set_bit(i, &blk_bitmap[lunoff]);
-			break;
-		case NVM_BLK_T_GRWN_BAD:
-			if (!(flags & NVM_FACTORY_RESET_GRWN_BBLKS))
-				set_bit(i, &blk_bitmap[lunoff]);
-			break;
-		default:
-			set_bit(i, &blk_bitmap[lunoff]);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int nvm_fact_get_blks(struct nvm_dev *dev, struct ppa_addr *erase_list,
-					int max_ppas, unsigned long *blk_bitmap)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr ppa;
-	int ch, lun, blkid, idx, done = 0, ppa_cnt = 0;
-	unsigned long *offset;
-
-	while (!done) {
-		done = 1;
-		nvm_for_each_lun_ppa(geo, ppa, ch, lun) {
-			idx = factory_blk_offset(geo, ppa);
-			offset = &blk_bitmap[idx];
-
-			blkid = find_first_zero_bit(offset, geo->blks_per_lun);
-			if (blkid >= geo->blks_per_lun)
-				continue;
-			set_bit(blkid, offset);
-
-			ppa.g.blk = blkid;
-			pr_debug("nvm: erase ppa (%u %u %u)\n",
-							ppa.g.ch,
-							ppa.g.lun,
-							ppa.g.blk);
-
-			erase_list[ppa_cnt] = ppa;
-			ppa_cnt++;
-			done = 0;
-
-			if (ppa_cnt == max_ppas)
-				return ppa_cnt;
-		}
-	}
-
-	return ppa_cnt;
-}
-
-static int nvm_fact_select_blks(struct nvm_dev *dev, unsigned long *blk_bitmap,
-								int flags)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr ppa;
-	int ch, lun, nr_blks, ret = 0;
-	u8 *blks;
-
-	nr_blks = geo->blks_per_lun * geo->plane_mode;
-	blks = kmalloc(nr_blks, GFP_KERNEL);
-	if (!blks)
-		return -ENOMEM;
-
-	nvm_for_each_lun_ppa(geo, ppa, ch, lun) {
-		ret = nvm_get_bb_tbl(dev, ppa, blks);
-		if (ret)
-			pr_err("nvm: failed bb tbl for ch%u lun%u\n",
-							ppa.g.ch, ppa.g.blk);
-
-		ret = nvm_factory_blks(dev, ppa, blks, nr_blks, blk_bitmap,
-									flags);
-		if (ret)
-			break;
-	}
-
-	kfree(blks);
-	return ret;
-}
-
-int nvm_dev_factory(struct nvm_dev *dev, int flags)
-{
-	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr *ppas;
-	int ppa_cnt, ret = -ENOMEM;
-	int max_ppas = dev->ops->max_phys_sect / geo->nr_planes;
-	struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
-	struct sysblk_scan s;
-	unsigned long *blk_bitmap;
-
-	blk_bitmap = kzalloc(factory_nblks(geo->blks_per_lun) * geo->nr_luns,
-								GFP_KERNEL);
-	if (!blk_bitmap)
-		return ret;
-
-	ppas = kcalloc(max_ppas, sizeof(struct ppa_addr), GFP_KERNEL);
-	if (!ppas)
-		goto err_blks;
-
-	/* create list of blks to be erased */
-	ret = nvm_fact_select_blks(dev, blk_bitmap, flags);
-	if (ret)
-		goto err_ppas;
-
-	/* continue to erase until list of blks until empty */
-	while ((ppa_cnt =
-			nvm_fact_get_blks(dev, ppas, max_ppas, blk_bitmap)) > 0)
-		nvm_erase_ppa(dev, ppas, ppa_cnt, 0);
-
-	/* mark host reserved blocks free */
-	if (flags & NVM_FACTORY_RESET_HOST_BLKS) {
-		nvm_setup_sysblk_scan(dev, &s, sysblk_ppas);
-		mutex_lock(&dev->mlock);
-		ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
-		if (!ret)
-			ret = nvm_sysblk_set_bb_tbl(dev, &s, NVM_BLK_T_FREE);
-		mutex_unlock(&dev->mlock);
-	}
-err_ppas:
-	kfree(ppas);
-err_blks:
-	kfree(blk_bitmap);
-	return ret;
-}
-EXPORT_SYMBOL(nvm_dev_factory);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 588d4a3..ad54ec9 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -372,7 +372,7 @@ static int nvme_nvm_get_l2p_tbl(struct nvm_dev *nvmdev, u64 slba, u32 nlb,
 		}
 
 		/* Transform physical address to target address space */
-		nvmdev->mt->part_to_tgt(nvmdev, entries, cmd_nlb);
+		nvm_part_to_tgt(nvmdev, entries, cmd_nlb);
 
 		if (update_l2p(cmd_slba, cmd_nlb, entries, priv)) {
 			ret = -EINTR;
@@ -633,10 +633,9 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 		return scnprintf(page, PAGE_SIZE, "%u\n", id->cap);
 	} else if (strcmp(attr->name, "device_mode") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", id->dom);
+	/* kept for compatibility */
 	} else if (strcmp(attr->name, "media_manager") == 0) {
-		if (!ndev->mt)
-			return scnprintf(page, PAGE_SIZE, "%s\n", "none");
-		return scnprintf(page, PAGE_SIZE, "%s\n", ndev->mt->name);
+		return scnprintf(page, PAGE_SIZE, "%s\n", "gennvm");
 	} else if (strcmp(attr->name, "ppa_format") == 0) {
 		return scnprintf(page, PAGE_SIZE,
 			"0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7c273bb..84309fe 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -80,8 +80,6 @@ struct nvm_dev_ops {
 	unsigned int		max_phys_sect;
 };
 
-
-
 #ifdef CONFIG_NVM
 
 #include <linux/blkdev.h>
@@ -272,15 +270,6 @@ enum {
 	NVM_BLK_ST_BAD =	0x8,	/* Bad block */
 };
 
-/* system block cpu representation */
-struct nvm_sb_info {
-	unsigned long		seqnr;
-	unsigned long		erase_cnt;
-	unsigned int		version;
-	char			mmtype[NVM_MMTYPE_LEN];
-	struct ppa_addr		fs_ppa;
-};
-
 /* Device generic information */
 struct nvm_geo {
 	int nr_chnls;
@@ -308,6 +297,7 @@ struct nvm_geo {
 	int sec_per_lun;
 };
 
+/* sub-device structure */
 struct nvm_tgt_dev {
 	/* Device information */
 	struct nvm_geo geo;
@@ -329,17 +319,10 @@ struct nvm_dev {
 
 	struct list_head devices;
 
-	/* Media manager */
-	struct nvmm_type *mt;
-	void *mp;
-
-	/* System blocks */
-	struct nvm_sb_info sb;
-
 	/* Device information */
 	struct nvm_geo geo;
 
-	/* lower page table */
+	  /* lower page table */
 	int lps_per_blk;
 	int *lptbl;
 
@@ -359,6 +342,10 @@ struct nvm_dev {
 
 	struct mutex mlock;
 	spinlock_t lock;
+
+	/* target management */
+	struct list_head area_list;
+	struct list_head targets;
 };
 
 static inline struct ppa_addr linear_to_generic_addr(struct nvm_geo *geo,
@@ -452,11 +439,6 @@ static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
 					(ppa1.g.blk == ppa2.g.blk));
 }
 
-static inline int ppa_to_slc(struct nvm_dev *dev, int slc_pg)
-{
-	return dev->lptbl[slc_pg];
-}
-
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *);
@@ -487,49 +469,6 @@ extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
 extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
 extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
 
-typedef int (nvmm_register_fn)(struct nvm_dev *);
-typedef void (nvmm_unregister_fn)(struct nvm_dev *);
-
-typedef int (nvmm_create_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_create *);
-typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
-typedef int (nvmm_submit_io_fn)(struct nvm_tgt_dev *, struct nvm_rq *);
-typedef int (nvmm_erase_blk_fn)(struct nvm_tgt_dev *, struct ppa_addr *, int);
-typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
-typedef void (nvmm_put_area_fn)(struct nvm_dev *, sector_t);
-typedef struct ppa_addr (nvmm_trans_ppa_fn)(struct nvm_tgt_dev *,
-					    struct ppa_addr, int);
-typedef void (nvmm_part_to_tgt_fn)(struct nvm_dev *, sector_t*, int);
-
-enum {
-	TRANS_TGT_TO_DEV =	0x0,
-	TRANS_DEV_TO_TGT =	0x1,
-};
-
-struct nvmm_type {
-	const char *name;
-	unsigned int version[3];
-
-	nvmm_register_fn *register_mgr;
-	nvmm_unregister_fn *unregister_mgr;
-
-	nvmm_create_tgt_fn *create_tgt;
-	nvmm_remove_tgt_fn *remove_tgt;
-
-	nvmm_submit_io_fn *submit_io;
-	nvmm_erase_blk_fn *erase_blk;
-
-	nvmm_get_area_fn *get_area;
-	nvmm_put_area_fn *put_area;
-
-	nvmm_trans_ppa_fn *trans_ppa;
-	nvmm_part_to_tgt_fn *part_to_tgt;
-
-	struct list_head list;
-};
-
-extern int nvm_register_mgr(struct nvmm_type *);
-extern void nvm_unregister_mgr(struct nvmm_type *);
-
 extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
@@ -559,31 +498,9 @@ extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
 extern int nvm_get_bb_tbl(struct nvm_dev *, struct ppa_addr, u8 *);
 extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, u8 *);
 
-/* sysblk.c */
-#define NVM_SYSBLK_MAGIC 0x4E564D53 /* "NVMS" */
-
-/* system block on disk representation */
-struct nvm_system_block {
-	__be32			magic;		/* magic signature */
-	__be32			seqnr;		/* sequence number */
-	__be32			erase_cnt;	/* erase count */
-	__be16			version;	/* version number */
-	u8			mmtype[NVM_MMTYPE_LEN]; /* media manager name */
-	__be64			fs_ppa;		/* PPA for media manager
-						 * superblock */
-};
-
-extern int nvm_get_sysblock(struct nvm_dev *, struct nvm_sb_info *);
-extern int nvm_update_sysblock(struct nvm_dev *, struct nvm_sb_info *);
-extern int nvm_init_sysblock(struct nvm_dev *, struct nvm_sb_info *);
-
 extern int nvm_dev_factory(struct nvm_dev *, int flags);
 
-#define nvm_for_each_lun_ppa(geo, ppa, chid, lunid)			\
-	for ((chid) = 0, (ppa).ppa = 0; (chid) < (geo)->nr_chnls;	\
-					(chid)++, (ppa).g.ch = (chid))	\
-		for ((lunid) = 0; (lunid) < (geo)->luns_per_chnl;	\
-					(lunid)++, (ppa).g.lun = (lunid))
+extern void nvm_part_to_tgt(struct nvm_dev *, sector_t *, int);
 
 #else /* CONFIG_NVM */
 struct nvm_dev_ops;
-- 
2.7.4

