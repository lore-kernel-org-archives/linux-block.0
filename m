Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B330C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 15:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71DC205C9
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71DC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbeKXCfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:35:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:38788 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391053AbeKXCfk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 21:35:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 07:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,270,1539673200"; 
   d="scan'208";a="110944899"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2018 07:50:54 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v3 3/5] lightnvm: Flexible DMA pool entry size
Date:   Fri, 23 Nov 2018 16:45:36 +0100
Message-Id: <20181123154538.59748-4-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181123154538.59748-1-igor.j.konopko@intel.com>
References: <20181123154538.59748-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently whole lightnvm and pblk uses single DMA pool,
for which entry size is always equal to PAGE_SIZE.
PPA list always needs 8b*64, so there is only 56b*64
space for OOB meta. Since NVMe OOB meta can be bigger,
such as 128b, this solution is not robustness.

This patch add the possiblity to support OOB meta above
56b by changing DMA pool size based on OOB meta size.

It also allows pblk to use OOB metadata >=16b.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c          | 30 ++++++++++++++++++++----------
 drivers/lightnvm/pblk-core.c     |  8 ++++----
 drivers/lightnvm/pblk-init.c     |  2 +-
 drivers/lightnvm/pblk-recovery.c |  4 ++--
 drivers/lightnvm/pblk.h          |  6 +++++-
 drivers/nvme/host/lightnvm.c     | 15 +++++++++------
 include/linux/lightnvm.h         |  3 ++-
 7 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 73ab3cf26868..c3650b141a30 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1145,15 +1145,9 @@ int nvm_register(struct nvm_dev *dev)
 	if (!dev->q || !dev->ops)
 		return -EINVAL;
 
-	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
-	if (!dev->dma_pool) {
-		pr_err("nvm: could not create dma pool\n");
-		return -ENOMEM;
-	}
-
 	ret = nvm_init(dev);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	/* register device with a supported media manager */
 	down_write(&nvm_lock);
@@ -1161,9 +1155,6 @@ int nvm_register(struct nvm_dev *dev)
 	up_write(&nvm_lock);
 
 	return 0;
-err_init:
-	dev->ops->destroy_dma_pool(dev->dma_pool);
-	return ret;
 }
 EXPORT_SYMBOL(nvm_register);
 
@@ -1187,6 +1178,25 @@ void nvm_unregister(struct nvm_dev *dev)
 }
 EXPORT_SYMBOL(nvm_unregister);
 
+int nvm_alloc_dma_pool(struct nvm_dev *dev)
+{
+	int exp_pool_size;
+
+	exp_pool_size = max_t(int, PAGE_SIZE,
+			      (NVM_MAX_VLBA * (sizeof(u64) + dev->geo.sos)));
+	exp_pool_size = round_up(exp_pool_size, PAGE_SIZE);
+
+	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
+						  exp_pool_size);
+	if (!dev->dma_pool) {
+		pr_err("nvm: could not create dma pool\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(nvm_alloc_dma_pool);
+
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 9509d6dbed53..2ebd3b079a96 100644
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
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 6e7a0c6c6655..b67bca810eb7 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -410,7 +410,7 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
 	pblk->oob_meta_size = geo->sos;
-	if (pblk->oob_meta_size != sizeof(struct pblk_sec_meta)) {
+	if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
 		pblk_err(pblk, "Unsupported metadata size\n");
 		return -EINVAL;
 	}
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 902c54ab1318..5bb8a2a4f87b 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -475,8 +475,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	if (!meta_list)
 		return -ENOMEM;
 
-	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
-	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
+	ppa_list = (void *)(meta_list) + pblk_dma_meta_size(pblk);
+	dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
 
 	data = kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
 	if (!data) {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 80f356688803..9087d53d5c25 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -104,7 +104,6 @@ enum {
 	PBLK_RL_LOW = 4
 };
 
-#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
 #define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
 
 /* write buffer completion context */
@@ -1388,4 +1387,9 @@ static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
 {
 	return meta + pblk->oob_meta_size * index;
 }
+
+static inline int pblk_dma_meta_size(struct pblk *pblk)
+{
+	return pblk->oob_meta_size * NVM_MAX_VLBA;
+}
 #endif /* PBLK_H_ */
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index d64805dc8efb..55076912a673 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -732,11 +732,12 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
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
@@ -978,11 +979,13 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
-	if (geo->version == NVM_OCSSD_SPEC_12)
-		return;
+	if (geo->version != NVM_OCSSD_SPEC_12) {
+		geo->csecs = 1 << ns->lba_shift;
+		geo->sos = ns->ms;
+	}
 
-	geo->csecs = 1 << ns->lba_shift;
-	geo->sos = ns->ms;
+	if (nvm_alloc_dma_pool(ndev))
+		nvm_unregister(ndev);
 }
 
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 2fdeac1a420d..8b4564c17656 100644
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
@@ -672,6 +672,7 @@ extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
 extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
 
 extern struct nvm_dev *nvm_alloc_dev(int);
+extern int nvm_alloc_dma_pool(struct nvm_dev *);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-- 
2.14.4

