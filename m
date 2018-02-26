Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34059 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeBZNRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so16957028wmd.1
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 05:17:35 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 08/19] lightnvm: rename number of channels and luns
Date: Mon, 26 Feb 2018 14:17:07 +0100
Message-Id: <1519651038-16845-9-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Normalize nomenclature for naming number of channels and number of luns
in order to improve readability. Use num_ch and num_lun.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      | 69 ++++++++++++++++++++++----------------------
 drivers/lightnvm/pblk-core.c |  4 +--
 drivers/lightnvm/pblk-init.c | 16 +++++-----
 drivers/lightnvm/pblk.h      |  6 ++--
 drivers/nvme/host/lightnvm.c | 20 ++++++-------
 include/linux/lightnvm.h     |  4 +--
 6 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 96f4e62d383b..45bed54488f9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -36,13 +36,13 @@ static DECLARE_RWSEM(nvm_lock);
 /* Map between virtual and physical channel and lun */
 struct nvm_ch_map {
 	int ch_off;
-	int nr_luns;
+	int num_lun;
 	int *lun_offs;
 };
 
 struct nvm_dev_map {
 	struct nvm_ch_map *chnls;
-	int nr_chnls;
+	int num_ch;
 };
 
 static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
@@ -115,15 +115,15 @@ static void nvm_remove_tgt_dev(struct nvm_tgt_dev *tgt_dev, int clear)
 	struct nvm_dev_map *dev_map = tgt_dev->map;
 	int i, j;
 
-	for (i = 0; i < dev_map->nr_chnls; i++) {
+	for (i = 0; i < dev_map->num_ch; i++) {
 		struct nvm_ch_map *ch_map = &dev_map->chnls[i];
 		int *lun_offs = ch_map->lun_offs;
 		int ch = i + ch_map->ch_off;
 
 		if (clear) {
-			for (j = 0; j < ch_map->nr_luns; j++) {
+			for (j = 0; j < ch_map->num_lun; j++) {
 				int lun = j + lun_offs[j];
-				int lunid = (ch * dev_geo->nr_luns) + lun;
+				int lunid = (ch * dev_geo->num_lun) + lun;
 
 				WARN_ON(!test_and_clear_bit(lunid,
 							dev->lun_map));
@@ -149,47 +149,46 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 	struct nvm_dev_map *dev_rmap = dev->rmap;
 	struct nvm_dev_map *dev_map;
 	struct ppa_addr *luns;
-	int nr_luns = lun_end - lun_begin + 1;
-	int luns_left = nr_luns;
-	int nr_chnls = nr_luns / dev_geo->nr_luns;
-	int nr_chnls_mod = nr_luns % dev_geo->nr_luns;
-	int bch = lun_begin / dev_geo->nr_luns;
-	int blun = lun_begin % dev_geo->nr_luns;
+	int num_lun = lun_end - lun_begin + 1;
+	int luns_left = num_lun;
+	int num_ch = num_lun / dev_geo->num_lun;
+	int num_ch_mod = num_lun % dev_geo->num_lun;
+	int bch = lun_begin / dev_geo->num_lun;
+	int blun = lun_begin % dev_geo->num_lun;
 	int lunid = 0;
 	int lun_balanced = 1;
-	int sec_per_lun, prev_nr_luns;
+	int sec_per_lun, prev_num_lun;
 	int i, j;
 
-	nr_chnls = (nr_chnls_mod == 0) ? nr_chnls : nr_chnls + 1;
+	num_ch = (num_ch_mod == 0) ? num_ch : num_ch + 1;
 
 	dev_map = kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
 	if (!dev_map)
 		goto err_dev;
 
-	dev_map->chnls = kcalloc(nr_chnls, sizeof(struct nvm_ch_map),
-								GFP_KERNEL);
+	dev_map->chnls = kcalloc(num_ch, sizeof(struct nvm_ch_map), GFP_KERNEL);
 	if (!dev_map->chnls)
 		goto err_chnls;
 
-	luns = kcalloc(nr_luns, sizeof(struct ppa_addr), GFP_KERNEL);
+	luns = kcalloc(num_lun, sizeof(struct ppa_addr), GFP_KERNEL);
 	if (!luns)
 		goto err_luns;
 
-	prev_nr_luns = (luns_left > dev_geo->nr_luns) ?
-					dev_geo->nr_luns : luns_left;
-	for (i = 0; i < nr_chnls; i++) {
+	prev_num_lun = (luns_left > dev_geo->num_lun) ?
+					dev_geo->num_lun : luns_left;
+	for (i = 0; i < num_ch; i++) {
 		struct nvm_ch_map *ch_rmap = &dev_rmap->chnls[i + bch];
 		int *lun_roffs = ch_rmap->lun_offs;
 		struct nvm_ch_map *ch_map = &dev_map->chnls[i];
 		int *lun_offs;
-		int luns_in_chnl = (luns_left > dev_geo->nr_luns) ?
-					dev_geo->nr_luns : luns_left;
+		int luns_in_chnl = (luns_left > dev_geo->num_lun) ?
+					dev_geo->num_lun : luns_left;
 
-		if (lun_balanced && prev_nr_luns != luns_in_chnl)
+		if (lun_balanced && prev_num_lun != luns_in_chnl)
 			lun_balanced = 0;
 
 		ch_map->ch_off = ch_rmap->ch_off = bch;
-		ch_map->nr_luns = luns_in_chnl;
+		ch_map->num_lun = luns_in_chnl;
 
 		lun_offs = kcalloc(luns_in_chnl, sizeof(int), GFP_KERNEL);
 		if (!lun_offs)
@@ -211,22 +210,22 @@ static struct nvm_tgt_dev *nvm_create_tgt_dev(struct nvm_dev *dev,
 		luns_left -= luns_in_chnl;
 	}
 
-	dev_map->nr_chnls = nr_chnls;
+	dev_map->num_ch = num_ch;
 
 	tgt_dev = kmalloc(sizeof(struct nvm_tgt_dev), GFP_KERNEL);
 	if (!tgt_dev)
 		goto err_ch;
 
 	/* Target device only owns a portion of the physical device */
-	tgt_dev->geo.nr_chnls = nr_chnls;
-	tgt_dev->geo.nr_luns = (lun_balanced) ? prev_nr_luns : -1;
-	tgt_dev->geo.all_luns = nr_luns;
-	tgt_dev->geo.all_chunks = nr_luns * dev_geo->c.num_chk;
+	tgt_dev->geo.num_ch = num_ch;
+	tgt_dev->geo.num_lun = (lun_balanced) ? prev_num_lun : -1;
+	tgt_dev->geo.all_luns = num_lun;
+	tgt_dev->geo.all_chunks = num_lun * dev_geo->c.num_chk;
 
 	tgt_dev->geo.op = op;
 
 	sec_per_lun = dev_geo->c.clba * dev_geo->c.num_chk;
-	tgt_dev->geo.total_secs = nr_luns * sec_per_lun;
+	tgt_dev->geo.total_secs = num_lun * sec_per_lun;
 
 	tgt_dev->geo.c = dev_geo->c;
 
@@ -511,20 +510,20 @@ static int nvm_register_map(struct nvm_dev *dev)
 	if (!rmap)
 		goto err_rmap;
 
-	rmap->chnls = kcalloc(dev_geo->nr_chnls, sizeof(struct nvm_ch_map),
+	rmap->chnls = kcalloc(dev_geo->num_ch, sizeof(struct nvm_ch_map),
 								GFP_KERNEL);
 	if (!rmap->chnls)
 		goto err_chnls;
 
-	for (i = 0; i < dev_geo->nr_chnls; i++) {
+	for (i = 0; i < dev_geo->num_ch; i++) {
 		struct nvm_ch_map *ch_rmap;
 		int *lun_roffs;
-		int luns_in_chnl = dev_geo->nr_luns;
+		int luns_in_chnl = dev_geo->num_lun;
 
 		ch_rmap = &rmap->chnls[i];
 
 		ch_rmap->ch_off = -1;
-		ch_rmap->nr_luns = luns_in_chnl;
+		ch_rmap->num_lun = luns_in_chnl;
 
 		lun_roffs = kcalloc(luns_in_chnl, sizeof(int), GFP_KERNEL);
 		if (!lun_roffs)
@@ -554,7 +553,7 @@ static void nvm_unregister_map(struct nvm_dev *dev)
 	struct nvm_dev_map *rmap = dev->rmap;
 	int i;
 
-	for (i = 0; i < dev_geo->nr_chnls; i++)
+	for (i = 0; i < dev_geo->num_ch; i++)
 		kfree(rmap->chnls[i].lun_offs);
 
 	kfree(rmap->chnls);
@@ -910,7 +909,7 @@ static int nvm_init(struct nvm_dev *dev)
 	pr_info("nvm: registered %s [%u/%u/%u/%u/%u]\n",
 			dev->name, dev_geo->c.ws_min, dev_geo->c.ws_opt,
 			dev_geo->c.num_chk, dev_geo->all_luns,
-			dev_geo->nr_chnls);
+			dev_geo->num_ch);
 	return 0;
 err:
 	pr_err("nvm: failed to initialize nvm\n");
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 519af8b9eab7..7c726003a8d2 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1752,10 +1752,10 @@ void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_lun *rlun;
-	int nr_luns = geo->all_luns;
+	int num_lun = geo->all_luns;
 	int bit = -1;
 
-	while ((bit = find_next_bit(lun_bitmap, nr_luns, bit + 1)) < nr_luns) {
+	while ((bit = find_next_bit(lun_bitmap, num_lun, bit + 1)) < num_lun) {
 		rlun = &pblk->luns[bit];
 		up(&rlun->wr_sem);
 	}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 6e0567971cf6..7e3297be517d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -162,15 +162,15 @@ static int pblk_set_addrf_12(struct nvm_geo *geo,
 	int power_len;
 
 	/* Re-calculate channel and lun format to adapt to configuration */
-	power_len = get_count_order(geo->nr_chnls);
-	if (1 << power_len != geo->nr_chnls) {
+	power_len = get_count_order(geo->num_ch);
+	if (1 << power_len != geo->num_ch) {
 		pr_err("pblk: supports only power-of-two channel config.\n");
 		return -EINVAL;
 	}
 	dst->ch_len = power_len;
 
-	power_len = get_count_order(geo->nr_luns);
-	if (1 << power_len != geo->nr_luns) {
+	power_len = get_count_order(geo->num_lun);
+	if (1 << power_len != geo->num_lun) {
 		pr_err("pblk: supports only power-of-two LUN config.\n");
 		return -EINVAL;
 	}
@@ -498,7 +498,7 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 	int i;
 
 	/* TODO: Implement unbalanced LUN support */
-	if (geo->nr_luns < 0) {
+	if (geo->num_lun < 0) {
 		pr_err("pblk: unbalanced LUN config.\n");
 		return -EINVAL;
 	}
@@ -510,9 +510,9 @@ static int pblk_luns_init(struct pblk *pblk, struct ppa_addr *luns)
 
 	for (i = 0; i < geo->all_luns; i++) {
 		/* Stripe across channels */
-		int ch = i % geo->nr_chnls;
-		int lun_raw = i / geo->nr_chnls;
-		int lunid = lun_raw + ch * geo->nr_luns;
+		int ch = i % geo->num_ch;
+		int lun_raw = i / geo->num_ch;
+		int lunid = lun_raw + ch * geo->num_lun;
 
 		rlun = &pblk->luns[i];
 		rlun->bppa = luns[lunid];
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 67ffb53608f7..1f32284b0aec 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -941,7 +941,7 @@ static inline int pblk_ppa_to_line(struct ppa_addr p)
 
 static inline int pblk_ppa_to_pos(struct nvm_geo *geo, struct ppa_addr p)
 {
-	return p.g.lun * geo->nr_chnls + p.g.ch;
+	return p.g.lun * geo->num_ch + p.g.ch;
 }
 
 static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
@@ -1214,8 +1214,8 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
 		ppa = &ppas[i];
 
 		if (!ppa->c.is_cached &&
-				ppa->g.ch < geo->nr_chnls &&
-				ppa->g.lun < geo->nr_luns &&
+				ppa->g.ch < geo->num_ch &&
+				ppa->g.lun < geo->num_lun &&
 				ppa->g.pl < geo->c.num_pln &&
 				ppa->g.blk < geo->c.num_chk &&
 				ppa->g.pg < geo->c.num_pg &&
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 4ea553c91756..f3f524dc1389 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -302,9 +302,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	/* Set compacted version for upper layers */
 	dev_geo->c.version = NVM_OCSSD_SPEC_12;
 
-	dev_geo->nr_chnls = src->num_ch;
-	dev_geo->nr_luns = src->num_lun;
-	dev_geo->all_luns = dev_geo->nr_chnls * dev_geo->nr_luns;
+	dev_geo->num_ch = src->num_ch;
+	dev_geo->num_lun = src->num_lun;
+	dev_geo->all_luns = dev_geo->num_ch * dev_geo->num_lun;
 
 	dev_geo->c.num_chk = le16_to_cpu(src->num_chk);
 
@@ -404,9 +404,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 		return -EINVAL;
 	}
 
-	dev_geo->nr_chnls = le16_to_cpu(id->num_grp);
-	dev_geo->nr_luns = le16_to_cpu(id->num_pu);
-	dev_geo->all_luns = dev_geo->nr_chnls * dev_geo->nr_luns;
+	dev_geo->num_ch = le16_to_cpu(id->num_grp);
+	dev_geo->num_lun = le16_to_cpu(id->num_pu);
+	dev_geo->all_luns = dev_geo->num_ch * dev_geo->num_lun;
 
 	dev_geo->c.num_chk = le32_to_cpu(id->num_chk);
 	dev_geo->c.clba = le32_to_cpu(id->clba);
@@ -1005,9 +1005,9 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
 	} else if (strcmp(attr->name, "flash_media_type") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.fmtype);
 	} else if (strcmp(attr->name, "num_channels") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->nr_chnls);
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_ch);
 	} else if (strcmp(attr->name, "num_luns") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->nr_luns);
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_lun);
 	} else if (strcmp(attr->name, "num_planes") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.num_pln);
 	} else if (strcmp(attr->name, "num_blocks") == 0) {	/* u16 */
@@ -1055,9 +1055,9 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
 	attr = &dattr->attr;
 
 	if (strcmp(attr->name, "groups") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->nr_chnls);
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_ch);
 	} else if (strcmp(attr->name, "punits") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->nr_luns);
+		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_lun);
 	} else if (strcmp(attr->name, "chunks") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.num_chk);
 	} else if (strcmp(attr->name, "clba") == 0) {
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e8e6bfd4d0d4..797594d6519f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -323,8 +323,8 @@ struct nvm_geo {
 	u8	minor_ver_id;
 
 	/* instance specific geometry */
-	int nr_chnls;
-	int nr_luns;		/* per channel */
+	int num_ch;
+	int num_lun;		/* per channel */
 
 	int op;			/* over-provision in instance */
 
-- 
2.7.4
