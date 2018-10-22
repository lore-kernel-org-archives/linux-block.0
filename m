Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeJVS6V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Oct 2018 14:58:21 -0400
From: Igor Konopko <igor.j.konopko@intel.com>
To: mb@lightnvm.io, javier@cnexlabs.com, hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 3/5] lightnvm: Flexible DMA pool entry size
Date: Mon, 22 Oct 2018 12:36:09 +0200
Message-Id: <20181022103611.39271-4-igor.j.konopko@intel.com>
In-Reply-To: <20181022103611.39271-1-igor.j.konopko@intel.com>
References: <20181022103611.39271-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently whole lightnvm and pblk uses single DMA pool,
for which entry size is always equal to PAGE_SIZE.
PPA list always needs 8b*64, so there is only 56b*64
space for OOB meta. Since NVMe OOB meta can be bigger,
such as 128b, this solution is not robustness.

This patch add the possiblity to support OOB meta above
56b by changing DMA pool size based on OOB meta size.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c          | 45 ++++++++++++++++++++++++++++++++++------
 drivers/lightnvm/pblk-core.c     |  8 +++----
 drivers/lightnvm/pblk-recovery.c |  4 ++--
 drivers/lightnvm/pblk.h          | 10 ++++++++-
 drivers/nvme/host/lightnvm.c     |  8 +++++--
 include/linux/lightnvm.h         |  4 +++-
 6 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index efb976a863d2..68f0812077d5 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1145,11 +1145,9 @@ int nvm_register(struct nvm_dev *dev)
 	if (!dev->q || !dev->ops)
 		return -EINVAL;
 
-	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
-	if (!dev->dma_pool) {
-		pr_err("nvm: could not create dma pool\n");
-		return -ENOMEM;
-	}
+	ret = nvm_realloc_dma_pool(dev);
+	if (ret)
+		return ret;
 
 	ret = nvm_init(dev);
 	if (ret)
@@ -1162,7 +1160,12 @@ int nvm_register(struct nvm_dev *dev)
 
 	return 0;
 err_init:
-	dev->ops->destroy_dma_pool(dev->dma_pool);
+	if (dev->dma_pool) {
+		dev->ops->destroy_dma_pool(dev->dma_pool);
+		dev->dma_pool = NULL;
+		dev->dma_pool_size = 0;
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL(nvm_register);
@@ -1187,6 +1190,36 @@ void nvm_unregister(struct nvm_dev *dev)
 }
 EXPORT_SYMBOL(nvm_unregister);
 
+int nvm_realloc_dma_pool(struct nvm_dev *dev)
+{
+	int exp_pool_size;
+
+	exp_pool_size = max_t(int, PAGE_SIZE,
+			      (NVM_MAX_VLBA * (sizeof(u64) + dev->geo.sos)));
+	exp_pool_size = round_up(exp_pool_size, PAGE_SIZE);
+
+	if (dev->dma_pool_size >= exp_pool_size)
+		return 0;
+
+	if (dev->dma_pool) {
+		dev->ops->destroy_dma_pool(dev->dma_pool);
+		dev->dma_pool = NULL;
+		dev->dma_pool_size = 0;
+	}
+
+	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
+						  exp_pool_size);
+	if (!dev->dma_pool) {
+		dev->dma_pool_size = 0;
+		pr_err("nvm: could not create dma pool\n");
+		return -ENOMEM;
+	}
+	dev->dma_pool_size = exp_pool_size;
+
+	return 0;
+}
+EXPORT_SYMBOL(nvm_realloc_dma_pool);
+
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0f33055f40eb..b1e104765868 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -250,8 +250,8 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
 	if (rqd->nr_ppas == 1)
 		return 0;
 
-	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
-	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
+	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size(pblk);
+	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size(pblk);
 
 	return 0;
 }
@@ -846,8 +846,8 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	if (!meta_list)
 		return -ENOMEM;
 
-	ppa_list = meta_list + pblk_dma_meta_size;
-	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
+	ppa_list = meta_list + pblk_dma_meta_size(pblk);
+	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
 
 next_rq:
 	memset(&rqd, 0, sizeof(struct nvm_rq));
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 977b2ca5d849..b5c8a0ed9bb1 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -474,8 +474,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	if (!meta_list)
 		return -ENOMEM;
 
-	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
-	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
+	ppa_list = (void *)(meta_list) + pblk_dma_meta_size(pblk);
+	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
 
 	data = kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
 	if (!data) {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index d09c1b341e07..c03fa037d037 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -104,7 +104,6 @@ enum {
 	PBLK_RL_LOW = 4
 };
 
-#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
 #define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
 
 /* write buffer completion context */
@@ -1394,4 +1393,13 @@ static inline __le64 pblk_get_meta_lba(struct pblk *pblk, void *meta,
 {
 	return pblk_get_meta(pblk, meta, index)->lba;
 }
+
+static inline int pblk_dma_meta_size(struct pblk *pblk)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+
+	return max_t(int, sizeof(struct pblk_sec_meta), geo->sos)
+				* NVM_MAX_VLBA;
+}
 #endif /* PBLK_H_ */
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a4f3b263cd6c..d1e47a93bcfd 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -731,11 +731,12 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
 	return ret;
 }
 
-static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name)
+static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
+					int size)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
 
-	return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, PAGE_SIZE, 0);
+	return dma_pool_create(name, ns->ctrl->dev, size, PAGE_SIZE, 0);
 }
 
 static void nvme_nvm_destroy_dma_pool(void *pool)
@@ -982,6 +983,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
+
+	if (nvm_realloc_dma_pool(ndev))
+		nvm_unregister(ndev);
 }
 
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 2fdeac1a420d..9d3b7c627cac 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -90,7 +90,7 @@ typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
 							struct nvm_chk_meta *);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
+typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
 typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
 								dma_addr_t *);
@@ -420,6 +420,7 @@ struct nvm_dev {
 
 	unsigned long *lun_map;
 	void *dma_pool;
+	uint32_t dma_pool_size;
 
 	/* Backend device */
 	struct request_queue *q;
@@ -672,6 +673,7 @@ extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
 extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
 
 extern struct nvm_dev *nvm_alloc_dev(int);
+extern int nvm_realloc_dma_pool(struct nvm_dev *);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-- 
2.14.4
