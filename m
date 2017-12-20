Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46618 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755942AbdLTRWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:22:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so11360514wme.5
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:22:20 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 06/25] lightnvm: remove lower page tables
Date: Wed, 20 Dec 2017 18:21:46 +0100
Message-Id: <20171220172205.26464-7-m@bjorling.me>
In-Reply-To: <20171220172205.26464-1-m@bjorling.me>
References: <20171220172205.26464-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The lower page table is unused. All page tables reported by 1.2
devices are all reporting a sequential 1:1 page mapping. This is
also not used going forward with the 2.0 revision.

Signed-off-by: Matias Bjørling <m@bjorling.me>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c      | 67 --------------------------------------------
 drivers/nvme/host/lightnvm.c | 14 ---------
 include/linux/lightnvm.h     |  6 ----
 3 files changed, 87 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 390d5ef..52059dd 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -751,53 +751,6 @@ int nvm_get_tgt_bb_tbl(struct nvm_tgt_dev *tgt_dev, struct ppa_addr ppa,
 }
 EXPORT_SYMBOL(nvm_get_tgt_bb_tbl);
 
-static int nvm_init_slc_tbl(struct nvm_dev *dev, struct nvm_id_group *grp)
-{
-	struct nvm_geo *geo = &dev->geo;
-	int i;
-
-	dev->lps_per_blk = geo->pgs_per_blk;
-	dev->lptbl = kcalloc(dev->lps_per_blk, sizeof(int), GFP_KERNEL);
-	if (!dev->lptbl)
-		return -ENOMEM;
-
-	/* Just a linear array */
-	for (i = 0; i < dev->lps_per_blk; i++)
-		dev->lptbl[i] = i;
-
-	return 0;
-}
-
-static int nvm_init_mlc_tbl(struct nvm_dev *dev, struct nvm_id_group *grp)
-{
-	int i, p;
-	struct nvm_id_lp_mlc *mlc = &grp->lptbl.mlc;
-
-	if (!mlc->num_pairs)
-		return 0;
-
-	dev->lps_per_blk = mlc->num_pairs;
-	dev->lptbl = kcalloc(dev->lps_per_blk, sizeof(int), GFP_KERNEL);
-	if (!dev->lptbl)
-		return -ENOMEM;
-
-	/* The lower page table encoding consists of a list of bytes, where each
-	 * has a lower and an upper half. The first half byte maintains the
-	 * increment value and every value after is an offset added to the
-	 * previous incrementation value
-	 */
-	dev->lptbl[0] = mlc->pairs[0] & 0xF;
-	for (i = 1; i < dev->lps_per_blk; i++) {
-		p = mlc->pairs[i >> 1];
-		if (i & 0x1) /* upper */
-			dev->lptbl[i] = dev->lptbl[i - 1] + ((p & 0xF0) >> 4);
-		else /* lower */
-			dev->lptbl[i] = dev->lptbl[i - 1] + (p & 0xF);
-	}
-
-	return 0;
-}
-
 static int nvm_core_init(struct nvm_dev *dev)
 {
 	struct nvm_id *id = &dev->identity;
@@ -846,25 +799,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	if (!dev->lun_map)
 		return -ENOMEM;
 
-	switch (grp->fmtype) {
-	case NVM_ID_FMTYPE_SLC:
-		if (nvm_init_slc_tbl(dev, grp)) {
-			ret = -ENOMEM;
-			goto err_fmtype;
-		}
-		break;
-	case NVM_ID_FMTYPE_MLC:
-		if (nvm_init_mlc_tbl(dev, grp)) {
-			ret = -ENOMEM;
-			goto err_fmtype;
-		}
-		break;
-	default:
-		pr_err("nvm: flash type not supported\n");
-		ret = -EINVAL;
-		goto err_fmtype;
-	}
-
 	INIT_LIST_HEAD(&dev->area_list);
 	INIT_LIST_HEAD(&dev->targets);
 	mutex_init(&dev->mlock);
@@ -890,7 +824,6 @@ static void nvm_free(struct nvm_dev *dev)
 		dev->ops->destroy_dma_pool(dev->dma_pool);
 
 	nvm_unregister_map(dev);
-	kfree(dev->lptbl);
 	kfree(dev->lun_map);
 	kfree(dev);
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index da2d6fe..9d0bca1 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -279,20 +279,6 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 
 	dst->cpar = le16_to_cpu(src->cpar);
 
-	if (dst->fmtype == NVM_ID_FMTYPE_MLC) {
-		memcpy(dst->lptbl.id, src->lptbl.id, 8);
-		dst->lptbl.mlc.num_pairs =
-				le16_to_cpu(src->lptbl.mlc.num_pairs);
-
-		if (dst->lptbl.mlc.num_pairs > NVME_NVM_LP_MLC_PAIRS) {
-			pr_err("nvm: number of MLC pairs not supported\n");
-			return -EINVAL;
-		}
-
-		memcpy(dst->lptbl.mlc.pairs, src->lptbl.mlc.pairs,
-					dst->lptbl.mlc.num_pairs);
-	}
-
 	return 0;
 }
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 900fe9f..312cfb1 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -175,8 +175,6 @@ struct nvm_id_group {
 	u32	mpos;
 	u32	mccap;
 	u16	cpar;
-
-	struct nvm_id_lp_tbl lptbl;
 };
 
 struct nvm_addr_format {
@@ -314,10 +312,6 @@ struct nvm_dev {
 	/* Device information */
 	struct nvm_geo geo;
 
-	  /* lower page table */
-	int lps_per_blk;
-	int *lptbl;
-
 	unsigned long total_secs;
 
 	unsigned long *lun_map;
-- 
2.9.3
