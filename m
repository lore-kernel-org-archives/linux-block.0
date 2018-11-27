Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D80C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C7520989
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="PBp2ntGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C7520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeK1Ahu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:37:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44469 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeK1Ahu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 19:37:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so18988764edd.11
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 05:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAUB1hcW7rVAdhw2A9r3wdDYvSBm3FzJ091K4Hf3ICg=;
        b=PBp2ntGc5aZ2kqCSimkz1xVuR4k7RTjiIYtQqT1OIZjYbfFuJtg7fkqWeQZ2AG1ZKQ
         RBjcV3i2au/mJAHo597HcXvC0zguXisO+zsywVwB8LTap8v7uG8PR+4avsOkVGNhWNBE
         gCOG09mOrGwDUdGgzY+0/VdosxgmzHY77iM87PsrWdjegJx0fKp8ZA4fiaee/EulYh4F
         nKT8PY5AKc5vBuY1qZuI90098ueoYNWzqWtZyPOENVCAyQ9d7WGsOlbasVDQWrBZPHV2
         0uljEZDcctoEAvn8GXNo7iNBTqISNaBlyHnMu9i3fkB/4qnUR+s/IPoTmxpEKwIImjW6
         ERAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAUB1hcW7rVAdhw2A9r3wdDYvSBm3FzJ091K4Hf3ICg=;
        b=Nm8zLrO3NZtyF8Ly2+fw2oDs/S0cvV7GdrAcFMHMZ0VpxUFoXVP8vQibRWPAPIkAVM
         HRDspL404IOFnDs8mdwglfYEiHPP+5vpXu4VDSwebEbEQ48lttlTzIYgXolQWZ4Vrr31
         pcAlH1FvsM/+fpceFyZWj1DkTx4boi8FNx5v/tBY6ZAy96pQ8KPRNVVaq0oc3HWR4xdv
         mW+3PCfrqiYS/98tLKYt+h+Gi61hACqZAgt5ZzoxAjGuz1ClnTj53i1kL9fPMXxfn28l
         +WyaGSo8Uv40X/65dpzfXeRZYj/v67qfBp/lcc9Yj8oVmzMS8KzGzBzMDkcyaBh6CaWW
         Iydg==
X-Gm-Message-State: AGRZ1gItJZ23SZmd/zaIcpMdec48409jVA4AS2El5s1NE/o8SbL6ja4S
        eyUMv4GigtTDDoBqjlh0fYjynQ==
X-Google-Smtp-Source: AJdET5frs8YGyjDpt6ktiHZfMMgiGAYfOkMl1GVLNNhcnwMUrO/J2Ktr7M+gIkH8PvZFOu95iN/uRg==
X-Received: by 2002:a17:906:f14e:: with SMTP id gw14-v6mr23883803ejb.231.1543325989384;
        Tue, 27 Nov 2018 05:39:49 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id t26sm1024945eda.22.2018.11.27.05.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 05:39:48 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: remove dma alloc/free helpers
Date:   Tue, 27 Nov 2018 14:39:32 +0100
Message-Id: <1543325972-15136-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543325972-15136-1-git-send-email-javier@cnexlabs.com>
References: <1543325972-15136-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Time has shown that the LightNVM alloc/free dma helpers are merely
replacements of the native dma_pool operations. Thus, remove them and
let targets manage the LightNVM dma pool directly.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c          | 25 +++++++------------------
 drivers/lightnvm/pblk-core.c     | 10 +++++-----
 drivers/lightnvm/pblk-read.c     |  3 ++-
 drivers/lightnvm/pblk-recovery.c |  5 +++--
 drivers/nvme/host/lightnvm.c     | 16 +---------------
 include/linux/lightnvm.h         |  8 +-------
 6 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c3650b141a30..8b6ee35e4356 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -641,20 +641,6 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
 }
 EXPORT_SYMBOL(nvm_unregister_tgt_type);
 
-void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
-							dma_addr_t *dma_handler)
-{
-	return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
-								dma_handler);
-}
-EXPORT_SYMBOL(nvm_dev_dma_alloc);
-
-void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
-{
-	dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
-}
-EXPORT_SYMBOL(nvm_dev_dma_free);
-
 static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 {
 	struct nvm_dev *dev;
@@ -682,7 +668,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 	}
 
 	rqd->nr_ppas = nr_ppas;
-	rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
+	rqd->ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL,
+							&rqd->dma_ppa_list);
 	if (!rqd->ppa_list) {
 		pr_err("nvm: failed to allocate dma memory\n");
 		return -ENOMEM;
@@ -705,10 +692,12 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
 static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
 			struct nvm_rq *rqd)
 {
+	struct nvm_dev *dev = tgt_dev->parent;
+
 	if (!rqd->ppa_list)
 		return;
 
-	nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
+	dma_pool_free(dev->dma_pool, rqd->ppa_list, rqd->dma_ppa_list);
 }
 
 static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
@@ -1178,7 +1167,7 @@ void nvm_unregister(struct nvm_dev *dev)
 }
 EXPORT_SYMBOL(nvm_unregister);
 
-int nvm_alloc_dma_pool(struct nvm_dev *dev)
+int nvm_create_dma_pool(struct nvm_dev *dev)
 {
 	int exp_pool_size;
 
@@ -1195,7 +1184,7 @@ int nvm_alloc_dma_pool(struct nvm_dev *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(nvm_alloc_dma_pool);
+EXPORT_SYMBOL(nvm_create_dma_pool);
 
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 615817bf97e3..61a2a5330ecf 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -242,7 +242,7 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 
-	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+	rqd->meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
 							&rqd->dma_meta_list);
 	if (!rqd->meta_list)
 		return -ENOMEM;
@@ -261,8 +261,8 @@ void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
 	struct nvm_tgt_dev *dev = pblk->dev;
 
 	if (rqd->meta_list)
-		nvm_dev_dma_free(dev->parent, rqd->meta_list,
-				rqd->dma_meta_list);
+		dma_pool_free(dev->parent->dma_pool, rqd->meta_list,
+							rqd->dma_meta_list);
 }
 
 /* Caller must guarantee that the request is a valid type */
@@ -846,7 +846,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 	int i, j;
 	int ret;
 
-	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+	meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
 							&dma_meta_list);
 	if (!meta_list)
 		return -ENOMEM;
@@ -925,7 +925,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 		goto next_rq;
 
 free_rqd_dma:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	dma_pool_free(dev->parent->dma_pool, rqd.meta_list, rqd.dma_meta_list);
 	return ret;
 }
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 32b285cf5846..1576f357c9af 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -507,7 +507,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	return NVM_IO_OK;
 
 fail_meta_free:
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
+	dma_pool_free(dev->parent->dma_pool, rqd->meta_list,
+							rqd->dma_meta_list);
 fail_rqd_free:
 	pblk_free_rqd(pblk, rqd, PBLK_READ);
 	return ret;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 65abc043e268..80d5b5bd4ab7 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -472,7 +472,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	int ret = 0;
 
-	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
+	meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
+								&dma_meta_list);
 	if (!meta_list)
 		return -ENOMEM;
 
@@ -508,7 +509,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	mempool_free(rqd, &pblk->r_rq_pool);
 	kfree(data);
 free_meta_list:
-	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
+	dma_pool_free(dev->parent->dma_pool, meta_list, dma_meta_list);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 049425ad8592..dd300ce9983f 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -747,18 +747,6 @@ static void nvme_nvm_destroy_dma_pool(void *pool)
 	dma_pool_destroy(dma_pool);
 }
 
-static void *nvme_nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
-				    gfp_t mem_flags, dma_addr_t *dma_handler)
-{
-	return dma_pool_alloc(pool, mem_flags, dma_handler);
-}
-
-static void nvme_nvm_dev_dma_free(void *pool, void *addr,
-							dma_addr_t dma_handler)
-{
-	dma_pool_free(pool, addr, dma_handler);
-}
-
 static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.identity		= nvme_nvm_identity,
 
@@ -772,8 +760,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 
 	.create_dma_pool	= nvme_nvm_create_dma_pool,
 	.destroy_dma_pool	= nvme_nvm_destroy_dma_pool,
-	.dev_dma_alloc		= nvme_nvm_dev_dma_alloc,
-	.dev_dma_free		= nvme_nvm_dev_dma_free,
 };
 
 static int nvme_nvm_submit_user_cmd(struct request_queue *q,
@@ -985,7 +971,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
 		geo->ext = ns->ext;
 	}
 
-	if (nvm_alloc_dma_pool(ndev))
+	if (nvm_create_dma_pool(ndev))
 		nvm_unregister(ndev);
 }
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index fd7b519f3ad2..7ca38b8bf133 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -94,7 +94,6 @@ typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
 typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
 								dma_addr_t *);
-typedef void (nvm_dev_dma_free_fn)(void *, void*, dma_addr_t);
 
 struct nvm_dev_ops {
 	nvm_id_fn		*identity;
@@ -108,8 +107,6 @@ struct nvm_dev_ops {
 
 	nvm_create_dma_pool_fn	*create_dma_pool;
 	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
-	nvm_dev_dma_alloc_fn	*dev_dma_alloc;
-	nvm_dev_dma_free_fn	*dev_dma_free;
 };
 
 #ifdef CONFIG_NVM
@@ -669,11 +666,8 @@ struct nvm_tgt_type {
 extern int nvm_register_tgt_type(struct nvm_tgt_type *);
 extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
 
-extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
-extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
-
 extern struct nvm_dev *nvm_alloc_dev(int);
-extern int nvm_alloc_dma_pool(struct nvm_dev *);
+extern int nvm_create_dma_pool(struct nvm_dev *);
 extern int nvm_register(struct nvm_dev *);
 extern void nvm_unregister(struct nvm_dev *);
 
-- 
2.7.4

