Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35936 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755661AbcK1VkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:40:04 -0500
Received: by mail-wj0-f193.google.com with SMTP id jb2so15789890wjb.3
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:58 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 23/23] lightnvm: transform target get/set bad block
Date: Mon, 28 Nov 2016 22:39:14 +0100
Message-Id: <20161128213914.12516-24-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

Since targets are given a virtual target device, it is necessary to
translate all communication between targets and the backend device.
Implement the translation layer for get/set bad block table.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/gennvm.c | 19 +++++++++++-----
 drivers/lightnvm/rrpc.c   |  4 ++--
 include/linux/lightnvm.h  | 15 +++++++++---
 4 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 07bf989..7622e3d 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -175,6 +175,26 @@ static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 	return NULL;
 }
 
+static void nvm_tgt_generic_to_addr_mode(struct nvm_tgt_dev *tgt_dev,
+					 struct nvm_rq *rqd)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+	int i;
+
+	if (rqd->nr_ppas > 1) {
+		for (i = 0; i < rqd->nr_ppas; i++) {
+			rqd->ppa_list[i] = dev->mt->trans_ppa(tgt_dev,
+					rqd->ppa_list[i], TRANS_TGT_TO_DEV);
+			rqd->ppa_list[i] = generic_to_dev_addr(dev,
+							rqd->ppa_list[i]);
+		}
+	} else {
+		rqd->ppa_addr = dev->mt->trans_ppa(tgt_dev, rqd->ppa_addr,
+						TRANS_TGT_TO_DEV);
+		rqd->ppa_addr = generic_to_dev_addr(dev, rqd->ppa_addr);
+	}
+}
+
 int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
 								int type)
 {
@@ -202,6 +222,34 @@ int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
 }
 EXPORT_SYMBOL(nvm_set_bb_tbl);
 
+int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
+		       int nr_ppas, int type)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_rq rqd;
+	int ret;
+
+	if (nr_ppas > dev->ops->max_phys_sect) {
+		pr_err("nvm: unable to update all blocks atomically\n");
+		return -EINVAL;
+	}
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+
+	nvm_set_rqd_ppalist(dev, &rqd, ppas, nr_ppas, 1);
+	nvm_tgt_generic_to_addr_mode(tgt_dev, &rqd);
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
+EXPORT_SYMBOL(nvm_set_tgt_bb_tbl);
+
 int nvm_max_phys_sects(struct nvm_tgt_dev *tgt_dev)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
@@ -519,6 +567,16 @@ int nvm_get_bb_tbl(struct nvm_dev *dev, struct ppa_addr ppa, u8 *blks)
 }
 EXPORT_SYMBOL(nvm_get_bb_tbl);
 
+int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
+		       u8 *blks)
+{
+	struct nvm_dev *dev = tgt_dev->parent;
+
+	ppa = dev->mt->trans_ppa(tgt_dev, ppa, TRANS_TGT_TO_DEV);
+	return nvm_get_bb_tbl(dev, ppa, blks);
+}
+EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);
+
 static int nvm_init_slc_tbl(struct nvm_dev *dev, struct nvm_id_group *grp)
 {
 	struct nvm_geo *geo = &dev->geo;
diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index befa828..ca78800 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -482,12 +482,6 @@ static void gen_unregister(struct nvm_dev *dev)
 	module_put(THIS_MODULE);
 }
 
-enum {
-	TRANS_TGT_TO_DEV =	0x0,
-	TRANS_DEV_TO_TGT =	0x1,
-};
-
-
 static int gen_map_to_dev(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 {
 	struct gen_dev_map *dev_map = tgt_dev->map;
@@ -584,6 +578,18 @@ static int gen_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p,
 	return nvm_erase_ppa(tgt_dev->parent, p, 1, flags);
 }
 
+static struct ppa_addr gen_trans_ppa(struct nvm_tgt_dev *tgt_dev,
+				     struct ppa_addr p, int direction)
+{
+	gen_trans_fn *f;
+	struct ppa_addr ppa = p;
+
+	f = (direction == TRANS_TGT_TO_DEV) ? gen_map_to_dev : gen_map_to_tgt;
+	f(tgt_dev, &ppa);
+
+	return ppa;
+}
+
 static void gen_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
 			       int len)
 {
@@ -631,6 +637,7 @@ static struct nvmm_type gen = {
 	.get_area		= gen_get_area,
 	.put_area		= gen_put_area,
 
+	.trans_ppa		= gen_trans_ppa,
 	.part_to_tgt		= gen_part_to_tgt,
 };
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 8a27bcc..9fb7de3 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -735,7 +735,7 @@ static void __rrpc_mark_bad_block(struct rrpc *rrpc, struct ppa_addr ppa)
 	rblk = &rlun->blocks[ppa.g.blk];
 	rblk->state = NVM_BLK_ST_BAD;
 
-	nvm_set_bb_tbl(dev->parent, &ppa, 1, NVM_BLK_T_GRWN_BAD);
+	nvm_set_tgt_bb_tbl(dev, &ppa, 1, NVM_BLK_T_GRWN_BAD);
 }
 
 static void rrpc_mark_bad_block(struct rrpc *rrpc, struct nvm_rq *rqd)
@@ -1267,7 +1267,7 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
 	ppa.g.ch = rlun->bppa.g.ch;
 	ppa.g.lun = rlun->bppa.g.lun;
 
-	ret = nvm_get_bb_tbl(dev->parent, ppa, blks);
+	ret = nvm_get_tgt_bb_tbl(dev, ppa, blks);
 	if (ret) {
 		pr_err("rrpc: could not get BB table\n");
 		goto out;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e76f9c4..7c273bb 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -496,8 +496,15 @@ typedef int (nvmm_submit_io_fn)(struct nvm_tgt_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_tgt_dev *, struct ppa_addr *, int);
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
 typedef void (nvmm_put_area_fn)(struct nvm_dev *, sector_t);
+typedef struct ppa_addr (nvmm_trans_ppa_fn)(struct nvm_tgt_dev *,
+					    struct ppa_addr, int);
 typedef void (nvmm_part_to_tgt_fn)(struct nvm_dev *, sector_t*, int);
 
+enum {
+	TRANS_TGT_TO_DEV =	0x0,
+	TRANS_DEV_TO_TGT =	0x1,
+};
+
 struct nvmm_type {
 	const char *name;
 	unsigned int version[3];
@@ -514,6 +521,7 @@ struct nvmm_type {
 	nvmm_get_area_fn *get_area;
 	nvmm_put_area_fn *put_area;
 
+	nvmm_trans_ppa_fn *trans_ppa;
 	nvmm_part_to_tgt_fn *part_to_tgt;
 
 	struct list_head list;
@@ -526,9 +534,9 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-extern int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas,
-							int nr_ppas, int type);
-
+extern int nvm_set_bb_tbl(struct nvm_dev *, struct ppa_addr *, int, int);
+extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
+			      int, int);
 extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
 extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
@@ -549,6 +557,7 @@ extern int nvm_submit_ppa_list(struct nvm_dev *, struct ppa_addr *, int, int,
 							int, void *, int);
 extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
 extern int nvm_get_bb_tbl(struct nvm_dev *, struct ppa_addr, u8 *);
+extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, u8 *);
 
 /* sysblk.c */
 #define NVM_SYSBLK_MAGIC 0x4E564D53 /* "NVMS" */
-- 
2.9.3

