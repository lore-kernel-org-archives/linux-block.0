Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34570 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdAWMAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 07:00:20 -0500
Received: by mail-wj0-f195.google.com with SMTP id ip10so1729696wjb.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 03:59:48 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 6/8] lightnvm: cleanup nvm transformation functions
Date: Mon, 23 Jan 2017 12:59:17 +0100
Message-Id: <20170123115919.14339-7-matias@cnexlabs.com>
In-Reply-To: <20170123115919.14339-1-matias@cnexlabs.com>
References: <20170123115919.14339-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Going from target specific ppa addresses to device was accomplished by
first converting target to generic ppa addresses and generic to device
addresses. The conversion was either open-coded or used the built-in
nvm_trans_* and nvm_map_* functions for conversion. Simplify the
interface and cleanup the calls to provide clean functions that now
either take a list of ppas or a nvm_rq, and is exposed through:

 void nvm_ppa_* - target to/from device with a list of PPAs,
 void nvm_rq_* - target to/from device with a nvm_rq.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 115 ++++++++++++++---------------------------------
 include/linux/lightnvm.h |  14 +++---
 2 files changed, 40 insertions(+), 89 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index a1a7a5a..0842c85 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -50,11 +50,6 @@ struct nvm_area {
 	sector_t end;	/* end is excluded */
 };
 
-enum {
-	TRANS_TGT_TO_DEV =	0x0,
-	TRANS_DEV_TO_TGT =	0x1,
-};
-
 static struct nvm_target *nvm_find_target(struct nvm_dev *dev, const char *name)
 {
 	struct nvm_target *tgt;
@@ -428,38 +423,46 @@ static void nvm_map_to_tgt(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p)
 	p->g.lun -= lun_roff;
 }
 
-static void nvm_trans_rq(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
-			int flag)
+static void nvm_ppa_tgt_to_dev(struct nvm_tgt_dev *tgt_dev,
+				struct ppa_addr *ppa_list, int nr_ppas)
 {
 	int i;
 
-	if (rqd->nr_ppas == 1) {
-		if (flag == TRANS_TGT_TO_DEV)
-			nvm_map_to_dev(tgt_dev, &rqd->ppa_addr);
-		else
-			nvm_map_to_tgt(tgt_dev, &rqd->ppa_addr);
-		return;
+	for (i = 0; i < nr_ppas; i++) {
+		nvm_map_to_dev(tgt_dev, &ppa_list[i]);
+		ppa_list[i] = generic_to_dev_addr(tgt_dev, ppa_list[i]);
 	}
+}
+
+static void nvm_ppa_dev_to_tgt(struct nvm_tgt_dev *tgt_dev,
+				struct ppa_addr *ppa_list, int nr_ppas)
+{
+	int i;
 
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		if (flag == TRANS_TGT_TO_DEV)
-			nvm_map_to_dev(tgt_dev, &rqd->ppa_list[i]);
-		else
-			nvm_map_to_tgt(tgt_dev, &rqd->ppa_list[i]);
+	for (i = 0; i < nr_ppas; i++) {
+		ppa_list[i] = dev_to_generic_addr(tgt_dev, ppa_list[i]);
+		nvm_map_to_tgt(tgt_dev, &ppa_list[i]);
 	}
 }
 
-static struct ppa_addr nvm_trans_ppa(struct nvm_tgt_dev *tgt_dev,
-				     struct ppa_addr p, int dir)
+static void nvm_rq_tgt_to_dev(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
-	struct ppa_addr ppa = p;
+	if (rqd->nr_ppas == 1) {
+		nvm_ppa_tgt_to_dev(tgt_dev, &rqd->ppa_addr, 1);
+		return;
+	}
+
+	nvm_ppa_tgt_to_dev(tgt_dev, rqd->ppa_list, rqd->nr_ppas);
+}
 
-	if (dir == TRANS_TGT_TO_DEV)
-		nvm_map_to_dev(tgt_dev, &ppa);
-	else
-		nvm_map_to_tgt(tgt_dev, &ppa);
+static void nvm_rq_dev_to_tgt(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
+{
+	if (rqd->nr_ppas == 1) {
+		nvm_ppa_dev_to_tgt(tgt_dev, &rqd->ppa_addr, 1);
+		return;
+	}
 
-	return ppa;
+	nvm_ppa_dev_to_tgt(tgt_dev, rqd->ppa_list, rqd->nr_ppas);
 }
 
 void nvm_part_to_tgt(struct nvm_dev *dev, sector_t *entries,
@@ -564,26 +567,6 @@ static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 	return NULL;
 }
 
-static void nvm_tgt_generic_to_addr_mode(struct nvm_tgt_dev *tgt_dev,
-					 struct nvm_rq *rqd)
-{
-	struct nvm_dev *dev = tgt_dev->parent;
-	int i;
-
-	if (rqd->nr_ppas > 1) {
-		for (i = 0; i < rqd->nr_ppas; i++) {
-			rqd->ppa_list[i] = nvm_trans_ppa(tgt_dev,
-					rqd->ppa_list[i], TRANS_TGT_TO_DEV);
-			rqd->ppa_list[i] = generic_to_dev_addr(dev,
-							rqd->ppa_list[i]);
-		}
-	} else {
-		rqd->ppa_addr = nvm_trans_ppa(tgt_dev, rqd->ppa_addr,
-						TRANS_TGT_TO_DEV);
-		rqd->ppa_addr = generic_to_dev_addr(dev, rqd->ppa_addr);
-	}
-}
-
 int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		       int nr_ppas, int type)
 {
@@ -599,7 +582,7 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
 	nvm_set_rqd_ppalist(dev, &rqd, ppas, nr_ppas, 1);
-	nvm_tgt_generic_to_addr_mode(tgt_dev, &rqd);
+	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
 
 	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
 	nvm_free_rqd_ppalist(dev, &rqd);
@@ -627,8 +610,7 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 	if (!dev->ops->submit_io)
 		return -ENODEV;
 
-	/* Convert address space */
-	nvm_generic_to_addr_mode(dev, rqd);
+	nvm_rq_tgt_to_dev(tgt_dev, rqd);
 
 	rqd->dev = tgt_dev;
 	return dev->ops->submit_io(dev, rqd);
@@ -652,7 +634,7 @@ int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas, int flags)
 	if (ret)
 		return ret;
 
-	nvm_generic_to_addr_mode(dev, &rqd);
+	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
 
 	rqd.flags = flags;
 
@@ -741,34 +723,6 @@ void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t begin)
 }
 EXPORT_SYMBOL(nvm_put_area);
 
-void nvm_addr_to_generic_mode(struct nvm_dev *dev, struct nvm_rq *rqd)
-{
-	int i;
-
-	if (rqd->nr_ppas > 1) {
-		for (i = 0; i < rqd->nr_ppas; i++)
-			rqd->ppa_list[i] = dev_to_generic_addr(dev,
-							rqd->ppa_list[i]);
-	} else {
-		rqd->ppa_addr = dev_to_generic_addr(dev, rqd->ppa_addr);
-	}
-}
-EXPORT_SYMBOL(nvm_addr_to_generic_mode);
-
-void nvm_generic_to_addr_mode(struct nvm_dev *dev, struct nvm_rq *rqd)
-{
-	int i;
-
-	if (rqd->nr_ppas > 1) {
-		for (i = 0; i < rqd->nr_ppas; i++)
-			rqd->ppa_list[i] = generic_to_dev_addr(dev,
-							rqd->ppa_list[i]);
-	} else {
-		rqd->ppa_addr = generic_to_dev_addr(dev, rqd->ppa_addr);
-	}
-}
-EXPORT_SYMBOL(nvm_generic_to_addr_mode);
-
 int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
 			const struct ppa_addr *ppas, int nr_ppas, int vblk)
 {
@@ -826,7 +780,7 @@ void nvm_end_io(struct nvm_rq *rqd, int error)
 
 	/* Convert address space */
 	if (tgt_dev)
-		nvm_trans_rq(tgt_dev, rqd, TRANS_DEV_TO_TGT);
+		nvm_rq_dev_to_tgt(tgt_dev, rqd);
 
 	rqd->error = error;
 	ins->tt->end_io(rqd);
@@ -874,8 +828,7 @@ int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 
-	ppa = nvm_trans_ppa(tgt_dev, ppa, TRANS_TGT_TO_DEV);
-	ppa = generic_to_dev_addr(dev, ppa);
+	nvm_ppa_tgt_to_dev(tgt_dev, &ppa, 1);
 
 	return dev->ops->get_bb_tbl(dev, ppa, blks);
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index cad1e1c..faa0fbf 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -378,10 +378,10 @@ static inline struct ppa_addr linear_to_generic_addr(struct nvm_geo *geo,
 	return l;
 }
 
-static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
-						struct ppa_addr r)
+static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
+						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &dev->geo;
+	struct nvm_geo *geo = &tgt_dev->geo;
 	struct ppa_addr l;
 
 	l.ppa = ((u64)r.g.blk) << geo->ppaf.blk_offset;
@@ -394,10 +394,10 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 	return l;
 }
 
-static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
-						struct ppa_addr r)
+static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
+						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &dev->geo;
+	struct nvm_geo *geo = &tgt_dev->geo;
 	struct ppa_addr l;
 
 	l.ppa = 0;
@@ -477,8 +477,6 @@ extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
 extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
-extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
-extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
-- 
2.7.4

