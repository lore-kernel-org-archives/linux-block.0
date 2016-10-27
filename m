Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37052 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942929AbcJ0OuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 10:50:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id 140so28759096wmv.0
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 07:50:16 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 5/7] lightnvm: export set bad block table
Date: Thu, 27 Oct 2016 16:49:41 +0200
Message-Id: <1477579783-5289-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
References: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Bad blocks should be managed by block owners. This would be either
targets for data blocks or sysblk for system blocks.

In order to support this, export two functions: One to mark a block as
an specific type (e.g., bad block) and another to update the bad block
table on the device.

Move bad block management to rrpc.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c   | 27 +++++++++++++++++++++++++++
 drivers/lightnvm/gennvm.c | 25 +------------------------
 drivers/lightnvm/rrpc.c   | 34 +++++++++++++++++++++++++++++++++-
 drivers/lightnvm/sysblk.c | 29 +++++------------------------
 include/linux/lightnvm.h  | 17 ++++++++++++++++-
 5 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 4be3879..a81ed1c 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -197,6 +197,33 @@ void nvm_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
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
index 575afc4..ae19a61 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -611,34 +611,11 @@ static void gen_mark_blk(struct nvm_dev *dev, struct ppa_addr ppa, int type)
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
+	/* Write failures and bad blocks are managed within the target */
 	ins->tt->end_io(rqd);
 }
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index cb30ccf..8deef2e 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -716,6 +716,34 @@ static void rrpc_run_gc(struct rrpc *rrpc, struct rrpc_block *rblk)
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
@@ -742,8 +770,12 @@ static void rrpc_end_io(struct nvm_rq *rqd)
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
index 1957829..e3ccaff 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -425,6 +425,19 @@ static inline struct ppa_addr block_to_ppa(struct nvm_dev *dev,
 	return ppa;
 }
 
+static inline int ppa_cmp_blk(struct ppa_addr ppa1, struct ppa_addr ppa2)
+{
+	if (ppa_empty(ppa1) || ppa_empty(ppa2))
+		return 0;
+
+
+	if ((ppa1.g.ch == ppa2.g.ch) && (ppa1.g.lun == ppa2.g.lun) &&
+					(ppa1.g.blk == ppa2.g.blk))
+		return 1;
+
+	return 0;
+}
+
 static inline int ppa_to_slc(struct nvm_dev *dev, int slc_pg)
 {
 	return dev->lptbl[slc_pg];
@@ -538,7 +551,9 @@ extern struct nvm_dev *nvm_alloc_dev(int);
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

