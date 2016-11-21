Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38233 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbcKUMLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 07:11:11 -0500
Received: by mail-wm0-f42.google.com with SMTP id f82so141190530wmf.1
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2016 04:11:10 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 8/8] lightnvm: use target nvm on target-specific ops.
Date: Mon, 21 Nov 2016 13:10:37 +0100
Message-Id: <1479730237-20797-9-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
References: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On target-specific operations pass on nvm_tgt_dev instead of the generic
nvm device.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 15 ++++++++++-----
 drivers/lightnvm/rrpc.c  | 14 +++++++-------
 drivers/lightnvm/rrpc.h  |  2 +-
 include/linux/lightnvm.h |  6 +++---
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 3d8eaac..07bf989 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -86,8 +86,7 @@ void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
 }
 EXPORT_SYMBOL(nvm_dev_dma_alloc);
 
-void nvm_dev_dma_free(struct nvm_dev *dev, void *addr,
-							dma_addr_t dma_handler)
+void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
 {
 	dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
 }
@@ -227,9 +226,11 @@ int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p, int flags)
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
-int nvm_get_l2p_tbl(struct nvm_dev *dev, u64 slba, u32 nlb,
+int nvm_get_l2p_tbl(struct nvm_tgt_dev *tgt_dev, u64 slba, u32 nlb,
 		    nvm_l2p_update_fn *update_l2p, void *priv)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+
 	if (!dev->ops->get_l2p_tbl)
 		return 0;
 
@@ -237,14 +238,18 @@ int nvm_get_l2p_tbl(struct nvm_dev *dev, u64 slba, u32 nlb,
 }
 EXPORT_SYMBOL(nvm_get_l2p_tbl);
 
-int nvm_get_area(struct nvm_dev *dev, sector_t *lba, sector_t len)
+int nvm_get_area(struct nvm_tgt_dev *tgt_dev, sector_t *lba, sector_t len)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+
 	return dev->mt->get_area(dev, lba, len);
 }
 EXPORT_SYMBOL(nvm_get_area);
 
-void nvm_put_area(struct nvm_dev *dev, sector_t lba)
+void nvm_put_area(struct nvm_tgt_dev *tgt_dev, sector_t lba)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+
 	dev->mt->put_area(dev, lba);
 }
 EXPORT_SYMBOL(nvm_put_area);
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 5826c6b..78f2c22 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -983,8 +983,8 @@ static int rrpc_submit_io(struct rrpc *rrpc, struct bio *bio,
 		if (!(flags & NVM_IOTYPE_GC)) {
 			rrpc_unlock_rq(rrpc, rqd);
 			if (rqd->nr_ppas > 1)
-				nvm_dev_dma_free(dev->parent,
-					rqd->ppa_list, rqd->dma_ppa_list);
+				nvm_dev_dma_free(dev->parent, rqd->ppa_list,
+							rqd->dma_ppa_list);
 		}
 		return NVM_IO_ERR;
 	}
@@ -1116,7 +1116,7 @@ static int rrpc_l2p_update(u64 slba, u32 nlb, __le64 *entries, void *private)
 
 		div_u64_rem(pba, rrpc->nr_sects, &mod);
 
-		gaddr = rrpc_recov_addr(dev->parent, pba);
+		gaddr = rrpc_recov_addr(dev, pba);
 		rlun = rrpc_ppa_to_lun(rrpc, gaddr);
 		if (!rlun) {
 			pr_err("rrpc: l2p corruption on lba %llu\n",
@@ -1167,8 +1167,8 @@ static int rrpc_map_init(struct rrpc *rrpc)
 	}
 
 	/* Bring up the mapping table from device */
-	ret = nvm_get_l2p_tbl(dev->parent, rrpc->soffset, rrpc->nr_sects,
-					rrpc_l2p_update, rrpc);
+	ret = nvm_get_l2p_tbl(dev, rrpc->soffset, rrpc->nr_sects,
+							rrpc_l2p_update, rrpc);
 	if (ret) {
 		pr_err("nvm: rrpc: could not read L2P table.\n");
 		return -EINVAL;
@@ -1372,7 +1372,7 @@ static int rrpc_area_init(struct rrpc *rrpc, sector_t *begin)
 
 	size >>= 9;
 
-	ret = nvm_get_area(dev->parent, begin, size);
+	ret = nvm_get_area(dev, begin, size);
 	if (!ret)
 		*begin >>= (ilog2(dev->geo.sec_size) - 9);
 
@@ -1384,7 +1384,7 @@ static void rrpc_area_free(struct rrpc *rrpc)
 	struct nvm_tgt_dev *dev = rrpc->dev;
 	sector_t begin = rrpc->soffset << (ilog2(dev->geo.sec_size) - 9);
 
-	nvm_put_area(dev->parent, begin);
+	nvm_put_area(dev, begin);
 }
 
 static void rrpc_free(struct rrpc *rrpc)
diff --git a/drivers/lightnvm/rrpc.h b/drivers/lightnvm/rrpc.h
index bc8adba..94e4d73 100644
--- a/drivers/lightnvm/rrpc.h
+++ b/drivers/lightnvm/rrpc.h
@@ -184,7 +184,7 @@ static inline struct ppa_addr rrpc_linear_to_generic_addr(struct nvm_geo *geo,
 	return l;
 }
 
-static inline struct ppa_addr rrpc_recov_addr(struct nvm_dev *dev, u64 pba)
+static inline struct ppa_addr rrpc_recov_addr(struct nvm_tgt_dev *dev, u64 pba)
 {
 	return linear_to_generic_addr(&dev->geo, pba);
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 44780ef..5a8217f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -538,10 +538,10 @@ extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int, int);
 extern int nvm_erase_blk(struct nvm_tgt_dev *, struct ppa_addr *, int);
-extern int nvm_get_l2p_tbl(struct nvm_dev *, u64, u32, nvm_l2p_update_fn *,
+extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 			   void *);
-extern int nvm_get_area(struct nvm_dev *, sector_t *, sector_t);
-extern void nvm_put_area(struct nvm_dev *, sector_t);
+extern int nvm_get_area(struct nvm_tgt_dev *, sector_t *, sector_t);
+extern void nvm_put_area(struct nvm_tgt_dev *, sector_t);
 extern void nvm_end_io(struct nvm_rq *, int);
 extern int nvm_submit_ppa(struct nvm_dev *, struct ppa_addr *, int, int, int,
 								void *, int);
-- 
2.7.4

