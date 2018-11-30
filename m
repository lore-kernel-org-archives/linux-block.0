Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C5C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72592082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 11:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeK3W60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:58:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:41003 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeK3W60 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 17:58:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 03:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="108549591"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2018 03:49:24 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v5 3/5] lightnvm: Flexible DMA pool entry size
Date:   Fri, 30 Nov 2018 12:44:00 +0100
Message-Id: <20181130114402.43793-4-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181130114402.43793-1-igor.j.konopko@intel.com>
References: <20181130114402.43793-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently whole lightnvm and pblk uses single DMA pool,
for which entry size is always equal to PAGE_SIZE.
PPA list always needs 8B*64, so there is only 56B*64
space for OOB meta. Since NVMe OOB meta can be bigger,
such as 128B, this solution is not robustness.

This patch add the possiblity to support OOB meta above
56b by changing DMA pool size based on OOB meta size.

It also allows pblk to use OOB metadata >=16B.

Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/core.c          | 9 +++++++--
 drivers/lightnvm/pblk-core.c     | 8 ++++----
 drivers/lightnvm/pblk-init.c     | 2 +-
 drivers/lightnvm/pblk-recovery.c | 4 ++--
 drivers/lightnvm/pblk.h          | 6 +++++-
 drivers/nvme/host/lightnvm.c     | 5 +++--
 include/linux/lightnvm.h         | 2 +-
 7 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 69b841d682c7..5f82036fe322 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -1140,7 +1140,7 @@ EXPORT_SYMBOL(nvm_alloc_dev);
 
 int nvm_register(struct nvm_dev *dev)
 {
-	int ret;
+	int ret, exp_pool_size;
 
 	if (!dev->q || !dev->ops)
 		return -EINVAL;
@@ -1149,7 +1149,12 @@ int nvm_register(struct nvm_dev *dev)
 	if (ret)
 		return ret;
 
-	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
+	exp_pool_size = max_t(int, PAGE_SIZE,
+			      (NVM_MAX_VLBA * (sizeof(u64) + dev->geo.sos)));
+	exp_pool_size = round_up(exp_pool_size, PAGE_SIZE);
+
+	dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist",
+						  exp_pool_size);
 	if (!dev->dma_pool) {
 		pr_err("nvm: could not create dma pool\n");
 		nvm_free(dev);
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e732b2d12a23..7e3397f8ead1 100644
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
index 33361bfb85c3..ff6a6df369c3 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -406,7 +406,7 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
 	pblk->oob_meta_size = geo->sos;
-	if (pblk->oob_meta_size != sizeof(struct pblk_sec_meta)) {
+	if (pblk->oob_meta_size < sizeof(struct pblk_sec_meta)) {
 		pblk_err(pblk, "Unsupported metadata size\n");
 		return -EINVAL;
 	}
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index e4dd634ba05f..3a775d10f616 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -481,8 +481,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
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
index 51d957ccf328..ba268d7cf141 100644
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
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 2fdeac1a420d..7afedaddbd15 100644
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
-- 
2.14.5

