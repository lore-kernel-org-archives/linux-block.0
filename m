Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:38409 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdJANYi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Oct 2017 09:24:38 -0400
Date: Sun, 1 Oct 2017 16:24:36 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH 3/6] lightnvm: remove unused argument from nvm_set_tgt_bb_tbl
Message-ID: <20171001132434.GA5714@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

vblk isn't being used anyway and if we ever have a usecase we can
introduce this again.  This makes the logic easier and removes
unnecessary checks.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c  | 29 ++++++++++++-----------------
 include/linux/lightnvm.h |  2 +-
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index ddae430..9cd1c4b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -616,7 +616,7 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
+	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
 	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
 
 	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
@@ -680,7 +680,7 @@ int nvm_erase_sync(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 	rqd.private = &wait;
 	rqd.flags = geo->plane_mode >> 1;
 
-	ret = nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
+	ret = nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
 	if (ret)
 		return ret;
 
@@ -776,14 +776,14 @@ void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t begin)
 EXPORT_SYMBOL(nvm_put_area);
 
 int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
-			const struct ppa_addr *ppas, int nr_ppas, int vblk)
+			const struct ppa_addr *ppas, int nr_ppas)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	struct nvm_geo *geo = &tgt_dev->geo;
 	int i, plane_cnt, pl_idx;
 	struct ppa_addr ppa;
 
-	if ((!vblk || geo->plane_mode == NVM_PLANE_SINGLE) && nr_ppas == 1) {
+	if (geo->plane_mode == NVM_PLANE_SINGLE && nr_ppas == 1) {
 		rqd->nr_ppas = nr_ppas;
 		rqd->ppa_addr = ppas[0];
 
@@ -797,19 +797,14 @@ int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 		return -ENOMEM;
 	}
 
-	if (!vblk) {
-		for (i = 0; i < nr_ppas; i++)
-			rqd->ppa_list[i] = ppas[i];
-	} else {
-		plane_cnt = geo->plane_mode;
-		rqd->nr_ppas *= plane_cnt;
-
-		for (i = 0; i < nr_ppas; i++) {
-			for (pl_idx = 0; pl_idx < plane_cnt; pl_idx++) {
-				ppa = ppas[i];
-				ppa.g.pl = pl_idx;
-				rqd->ppa_list[(pl_idx * nr_ppas) + i] = ppa;
-			}
+	plane_cnt = geo->plane_mode;
+	rqd->nr_ppas *= plane_cnt;
+
+	for (i = 0; i < nr_ppas; i++) {
+		for (pl_idx = 0; pl_idx < plane_cnt; pl_idx++) {
+			ppa = ppas[i];
+			ppa.g.pl = pl_idx;
+			rqd->ppa_list[(pl_idx * nr_ppas) + i] = ppa;
 		}
 	}
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 81b71c6d..c8c014b 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -481,7 +481,7 @@ extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
 extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
 extern int nvm_erase_sync(struct nvm_tgt_dev *, struct ppa_addr *, int);
 extern int nvm_set_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq *,
-					const struct ppa_addr *, int, int);
+					const struct ppa_addr *, int);
 extern void nvm_free_rqd_ppalist(struct nvm_tgt_dev *, struct nvm_rq *);
 extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 			   void *);
-- 
2.7.4
