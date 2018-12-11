Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D541C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B362087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="CyYc+mfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B362087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeLKTRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45299 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeLKTRZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so13989409ljd.12
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuHkYCc1pSOJySrvNVvgNje28iXaXVLRa8Ef9qUtsfM=;
        b=CyYc+mfhLDW9znjopQZgZngtJU770RVkZp6aCpKswjUAf9fbYUjzXN7YMyVIC++bgc
         fRpk/fzFyazpqybpoZAq5DBrIl9Ykp2T1RGm6+IcNxkbOkWfThQ1VgZsR+DWKl1Nke5a
         WttvZfh4PJCwN/VvFqtHcAsQpA8ce0llclKrNBmCer17PSJCvgsvQ/ppYORZUhsEJCxe
         RoEyy7L2dRZt3AQxUfz/G53a1YG4XFNGVh3VKR5vPSGJxnjyRXrRIUXSFM9G+N679U1h
         j5k4XN+e9N/2rNdm/0qN5lMX1u1UiIDyir+QAAfTegsV2DV/5ItD/rG7fVQyPJ7dBEiD
         MjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuHkYCc1pSOJySrvNVvgNje28iXaXVLRa8Ef9qUtsfM=;
        b=TB2oDlLaESwqiM6rvh8XsqtNEyaVIV6iwjfCB1xeDWFEysx2zbDRG0Y4QxYB44MNxJ
         56BjR/Dzh0R74+zCkHVZD61TcfyirW0OGzsMz8hNVUX2b+lbrjCtnIgGw+R/OzOp61Mc
         9bM6TAA/SqYwtzmNcqtAvL69TFVbIcjKkrr6/5cwNxY2D6ameOnkooLKOtt9Lo1c8MSO
         Bi3QrM8KqBY9cWPekZQfQ6n5sGsdDq/azVwNqc7nm0jy38Ji493NulUOC2qOjADqViaK
         FaQQWu1Jvnj/5dg06pH7xg8CdMrIj07/bjsbRZixZTCe3NjQ7aWsqQhSfJuKvQE4CjD2
         RgIQ==
X-Gm-Message-State: AA+aEWZYUJHDYCNaCHi0nGerPQtXtl0Vs8hb+F8eDC1hupjaLREEo8Y0
        WgU1IkEjHBi4KN9XlmXFZmh7mA==
X-Google-Smtp-Source: AFSGD/WebBX2q9kDNIFc4ogjAN8cwDthILbjFvA/XF/mDpj5dyy7Sqd+rKzOvmSo+qjOHEQIrtUeAA==
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr10472053lji.30.1544555842527;
        Tue, 11 Dec 2018 11:17:22 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:21 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 18/21] lightnvm: dynamic DMA pool entry size
Date:   Tue, 11 Dec 2018 20:16:24 +0100
Message-Id: <20181211191627.15542-19-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently lightnvm and pblk uses single DMA pool, for which the entry
size always is equal to PAGE_SIZE. The contents of each entry allocated
from the DMA pool consists of a PPA list (8bytes * 64), leaving
56bytes * 64 space for metadata. Since the metadata field can be bigger,
such as 128 bytes, the static size does not cover this use-case.

This patch adds support for I/O metadata above 56 bytes by changing DMA
pool size based on device meta size and allows pblk to use OOB metadata
>=16B.

Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
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
2.17.1

