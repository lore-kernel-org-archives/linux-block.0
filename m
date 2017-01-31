Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:53760
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751943AbdAaMSF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 07:18:05 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <axboe@fb.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 04/12] lightnvm: remove nvm_get_bb_tbl and nvm_set_bb_tbl
Date: Tue, 31 Jan 2017 13:17:12 +0100
Message-ID: <20170131121720.10971-5-matias@cnexlabs.com>
In-Reply-To: <20170131121720.10971-1-matias@cnexlabs.com>
References: <20170131121720.10971-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since the merge of gennvm and core, there is no longer a need for the
device specific bad block functions.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 40 ++++------------------------------------
 include/linux/lightnvm.h |  2 --
 2 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index ffdf048..18d4873 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -605,33 +605,6 @@ static void nvm_tgt_generic_to_addr_mode(struct nvm_tgt_dev *tgt_dev,
 	}
 }
 
-int nvm_set_bb_tbl(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
-								int type)
-{
-	struct nvm_rq rqd;
-	int ret;
-
-	if (nr_ppas > dev->ops->max_phys_sect) {
-		pr_err("nvm: unable to update all sysblocks atomically\n");
-		return -EINVAL;
-	}
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	nvm_set_rqd_ppalist(dev, &rqd, ppas, nr_ppas, 1);
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
-}
-EXPORT_SYMBOL(nvm_set_bb_tbl);
-
 int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas,
 		       int nr_ppas, int type)
 {
@@ -919,20 +892,15 @@ int nvm_bb_tbl_fold(struct nvm_dev *dev, u8 *blks, int nr_blks)
 }
 EXPORT_SYMBOL(nvm_bb_tbl_fold);
 
-int nvm_get_bb_tbl(struct nvm_dev *dev, struct ppa_addr ppa, u8 *blks)
-{
-	ppa = generic_to_dev_addr(dev, ppa);
-
-	return dev->ops->get_bb_tbl(dev, ppa, blks);
-}
-EXPORT_SYMBOL(nvm_get_bb_tbl);
-
 int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
 		       u8 *blks)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+
 	ppa = nvm_trans_ppa(tgt_dev, ppa, TRANS_TGT_TO_DEV);
+	ppa = generic_to_dev_addr(dev, ppa);
 
-	return nvm_get_bb_tbl(tgt_dev->parent, ppa, blks);
+	return dev->ops->get_bb_tbl(dev, ppa, blks);
 }
 EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index abb3d55..cad1e1c 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -473,7 +473,6 @@ extern struct nvm_dev *nvm_alloc_dev(int);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-extern int nvm_set_bb_tbl(struct nvm_dev *, struct ppa_addr *, int, int);
 extern int nvm_set_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr *,
 			      int, int);
 extern int nvm_max_phys_sects(struct nvm_tgt_dev *);
@@ -490,7 +489,6 @@ extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
 extern void nvm_put_area(struct nvm_tgt_dev *, sector_t);
 extern void nvm_end_io(struct nvm_rq *, int);
 extern int nvm_bb_tbl_fold(struct nvm_dev *, u8 *, int);
-extern int nvm_get_bb_tbl(struct nvm_dev *, struct ppa_addr, u8 *);
 extern int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *, struct ppa_addr, u8 *);
 
 extern int nvm_dev_factory(struct nvm_dev *, int flags);
-- 
2.9.3

