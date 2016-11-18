Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34452 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbcKROoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:00 -0500
Received: by mail-wm0-f52.google.com with SMTP id u144so6268630wmu.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:00 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 03/20] lightnvm: export set bad block table
Date: Fri, 18 Nov 2016 15:43:25 +0100
Message-Id: <1479480222-18790-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Bad blocks should be managed by block owners. This would be either
targets for data blocks or sysblk for system blocks.

In order to support this, export two functions: One to mark a block as
an specific type (e.g., bad block) and another to update the bad block
table on the device.

Move bad block management to rrpc.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   | 27 +++++++++++++++++++++++++++
 drivers/lightnvm/gennvm.c | 24 ------------------------
 drivers/lightnvm/rrpc.c   | 34 +++++++++++++++++++++++++++++++++-
 drivers/lightnvm/sysblk.c | 29 +++++------------------------
 include/linux/lightnvm.h  | 13 ++++++++++++-
 5 files changed, 77 insertions(+), 50 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8664fe0..6527cf6 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -196,6 +196,33 @@ void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 }
 EXPORT_SYMBOL(nvm_mark_blk);
 
+int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
+								int type)
+{
+	struct nvm_rq rqd;
+	int ret;
+
+	if (nr_ppas > dev->ops->max_phys_sect) {
+		pr_err("nvm: unable to update all sysblocks atomically\n");
+		return -EINVAL;
+	}
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+
+	nvm_set_rqd_ppalist(dev, &rqd, ppas, nr_ppas, 1);
+	nvm_generic_to_addr_mode(dev, &rqd);
+
+	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
+	nvm_free_rqd_ppalist(dev, &rqd);
+	if (ret) {
+		pr_err("nvm: sysblk failed bb mark\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(nvm_set_bb_tbl);
+
 int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
 	return dev->mt->submit_io(dev, rqd);
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index a7e17fa..e969e3a 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -543,34 +543,10 @@ static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
 	blk->state = type;
 }
 
-/*
- * mark block bad in gen. It is expected that the target recovers separately
- */
-static void gen_mark_blk_bad(struct nvm_dev *dev, struct nvm_rq *rqd)
-{
-	int bit = -1;
-	int max_secs = dev->ops->max_phys_sect;
-	void *comp_bits = &rqd->ppa_status;
-
-	nvm_addr_to_generic_mode(dev, rqd);
-
-	/* look up blocks and mark them as bad */
-	if (rqd->nr_ppas == 1) {
-		gen_mark_blk(dev, rqd->ppa_addr, NVM_BLK_ST_BAD);
-		return;
-	}
-
-	while ((bit = find_next_bit(comp_bits, max_secs, bit + 1)) < max_secs)
-		gen_mark_blk(dev, rqd->ppa_list[bit], NVM_BLK_ST_BAD);
-}
-
 static void gen_end_io(struct nvm_rq *rqd)
 {
 	struct nvm_tgt_instance *ins = rqd->ins;
 
-	if (rqd->error == NVM_RSP_ERR_FAILWRITE)
-		gen_mark_blk_bad(rqd->dev, rqd);
-
 	ins->tt->end_io(rqd);
 }
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 067e890..2b71b7e 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -675,6 +675,34 @@ static void rrpc_run_gc(struct rrpc *rrpc, struct rrpc_block *rblk)
 	queue_work(rrpc->kgc_wq, &gcb->ws_gc);
 }
 
+static void __rrpc_mark_bad_block(struct nvm_dev *dev, struct ppa_addr *ppa)
+{
+		nvm_mark_blk(dev, *ppa, NVM_BLK_ST_BAD);
+		nvm_set_bb_tbl(dev, ppa, 1, NVM_BLK_T_GRWN_BAD);
+}
+
+static void rrpc_mark_bad_block(struct rrpc *rrpc, struct nvm_rq *rqd)
+{
+	struct nvm_dev *dev = rrpc->dev;
+	void *comp_bits = &rqd->ppa_status;
+	struct ppa_addr ppa, prev_ppa;
+	int nr_ppas = rqd->nr_ppas;
+	int bit;
+
+	if (rqd->nr_ppas == 1)
+		__rrpc_mark_bad_block(dev, &rqd->ppa_addr);
+
+	ppa_set_empty(&prev_ppa);
+	bit = -1;
+	while ((bit = find_next_bit(comp_bits, nr_ppas, bit + 1)) < nr_ppas) {
+		ppa = rqd->ppa_list[bit];
+		if (ppa_cmp_blk(ppa, prev_ppa))
+			continue;
+
+		__rrpc_mark_bad_block(dev, &ppa);
+	}
+}
+
 static void rrpc_end_io_write(struct rrpc *rrpc, struct rrpc_rq *rrqd,
 						sector_t laddr, uint8_t npages)
 {
@@ -701,8 +729,12 @@ static void rrpc_end_io(struct nvm_rq *rqd)
 	uint8_t npages = rqd->nr_ppas;
 	sector_t laddr = rrpc_get_laddr(rqd->bio) - npages;
 
-	if (bio_data_dir(rqd->bio) == WRITE)
+	if (bio_data_dir(rqd->bio) == WRITE) {
+		if (rqd->error == NVM_RSP_ERR_FAILWRITE)
+			rrpc_mark_bad_block(rrpc, rqd);
+
 		rrpc_end_io_write(rrpc, rrqd, laddr, npages);
+	}
 
 	bio_put(rqd->bio);
 
diff --git a/drivers/lightnvm/sysblk.c b/drivers/lightnvm/sysblk.c
index d229067..fa644af 100644
--- a/drivers/lightnvm/sysblk.c
+++ b/drivers/lightnvm/sysblk.c
@@ -267,29 +267,10 @@ static int nvm_scan_block(struct nvm_dev *dev, struct ppa_addr *ppa,
 	return found;
 }
 
-static int nvm_set_bb_tbl(struct nvm_dev *dev, struct sysblk_scan *s, int type)
+static int nvm_sysblk_set_bb_tbl(struct nvm_dev *dev, struct sysblk_scan *s,
+								int type)
 {
-	struct nvm_rq rqd;
-	int ret;
-
-	if (s->nr_ppas > dev->ops->max_phys_sect) {
-		pr_err("nvm: unable to update all sysblocks atomically\n");
-		return -EINVAL;
-	}
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	nvm_set_rqd_ppalist(dev, &rqd, s->ppas, s->nr_ppas, 1);
-	nvm_generic_to_addr_mode(dev, &rqd);
-
-	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
-	nvm_free_rqd_ppalist(dev, &rqd);
-	if (ret) {
-		pr_err("nvm: sysblk failed bb mark\n");
-		return -EINVAL;
-	}
-
-	return 0;
+	return nvm_set_bb_tbl(dev, s->ppas, s->nr_ppas, type);
 }
 
 static int nvm_write_and_verify(struct nvm_dev *dev, struct nvm_sb_info *info,
@@ -573,7 +554,7 @@ int nvm_init_sysblock(struct nvm_dev *dev, struct nvm_sb_info *info)
 	if (ret)
 		goto err_mark;
 
-	ret = nvm_set_bb_tbl(dev, &s, NVM_BLK_T_HOST);
+	ret = nvm_sysblk_set_bb_tbl(dev, &s, NVM_BLK_T_HOST);
 	if (ret)
 		goto err_mark;
 
@@ -733,7 +714,7 @@ int nvm_dev_factory(struct nvm_dev *dev, int flags)
 		mutex_lock(&dev->mlock);
 		ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
 		if (!ret)
-			ret = nvm_set_bb_tbl(dev, &s, NVM_BLK_T_FREE);
+			ret = nvm_sysblk_set_bb_tbl(dev, &s, NVM_BLK_T_FREE);
 		mutex_unlock(&dev->mlock);
 	}
 err_ppas:
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index d87be02..4480d1c 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -423,6 +423,15 @@ static inline struct ppa_addr block_to_ppa(struct nvm_dev *dev,
 	return ppa;
 }
 
+static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
+{
+	if (ppa_empty(ppa1) || ppa_empty(ppa2))
+		return 0;
+
+	return ((ppa1.g.ch == ppa2.g.ch) && (ppa1.g.lun == ppa2.g.lun) &&
+					(ppa1.g.blk == ppa2.g.blk));
+}
+
 static inline int ppa_to_slc(struct nvm_dev *dev, int slc_pg)
 {
 	return dev->lptbl[slc_pg];
@@ -528,7 +537,9 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type);
+extern void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type);
+extern int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas,
+							int nr_ppas, int type);
 
 extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
-- 
2.7.4

