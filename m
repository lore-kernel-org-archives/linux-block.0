Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55001 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdJMMrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id i124so21517957wmf.3
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:46 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 41/58] lightnvm: remove unused argument from nvm_set_tgt_bb_tbl
Date: Fri, 13 Oct 2017 14:46:30 +0200
Message-Id: <20171013124647.32668-42-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Rakesh Pandit <rakesh@tuxera.com>

vblk isn't being used anyway and if we ever have a usecase we can
introduce this again.  This makes the logic easier and removes
unnecessary checks.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c  | 27 +++++++++++----------------
 include/linux/lightnvm.h |  2 +-
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 798964f..231c928 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -633,7 +633,7 @@ int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
+	nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
 	nvm_rq_tgt_to_dev(tgt_dev, &rqd);
 
 	ret = dev->ops->set_bb_tbl(dev, &rqd.ppa_addr, rqd.nr_ppas, type);
@@ -697,7 +697,7 @@ int nvm_erase_sync(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 	rqd.private = &wait;
 	rqd.flags = geo->plane_mode >> 1;
 
-	ret = nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas, 1);
+	ret = nvm_set_rqd_ppalist(tgt_dev, &rqd, ppas, nr_ppas);
 	if (ret)
 		return ret;
 
@@ -793,14 +793,14 @@ void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t begin)
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
 
@@ -814,19 +814,14 @@ int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 		return -ENOMEM;
 	}
 
-	if (!vblk) {
-		for (i = 0; i < nr_ppas; i++)
-			rqd->ppa_list[i] = ppas[i];
-	} else {
-		plane_cnt = geo->plane_mode;
-		rqd->nr_ppas *= plane_cnt;
+	plane_cnt = geo->plane_mode;
+	rqd->nr_ppas *= plane_cnt;
 
-		for (i = 0; i < nr_ppas; i++) {
-			for (pl_idx = 0; pl_idx < plane_cnt; pl_idx++) {
-				ppa = ppas[i];
-				ppa.g.pl = pl_idx;
-				rqd->ppa_list[(pl_idx * nr_ppas) + i] = ppa;
-			}
+	for (i = 0; i < nr_ppas; i++) {
+		for (pl_idx = 0; pl_idx < plane_cnt; pl_idx++) {
+			ppa = ppas[i];
+			ppa.g.pl = pl_idx;
+			rqd->ppa_list[(pl_idx * nr_ppas) + i] = ppa;
 		}
 	}
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7b80ac9..32ec35b 100644
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
2.9.3
