Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F18DC32753
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D192089E
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="JOI95AzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGaJmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:42:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45841 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGaJmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 05:42:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so8210947lfm.12
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVYd9Rjb1zedauayC59UHepF1L1QYQNNE4PKhmE9Kd4=;
        b=JOI95AzROG8gnpLKyQRW0ZocblqZjHpYx9ghlJ8q9AYJ8WNVXLv6lLE2gQn6ET54pS
         BJN+zSfPUtzU0sitK6V6ttUhuyFe/uXJFASXF32TGzhH18oI2Oy+Up2xOmwF32gKVsuk
         Rvb9iSqctIKy6lXtk/8W2PdrOQH9kS+vq4JkGlwelxy9ljzVy4L1qT41S5O+w6gn0IFo
         mZFfzgJioyC/Pp99I6FFVWqQgTZqyUz1YU8dbvMPwJzZY5qNl9+qlkv3cL3yNda7nMBi
         uN7PFYsMrPMSFxz2PGucPwYmssSb22t6nDvwDW3XBFnA/d1uHoNfzJFoYqjXZEGiB+Xr
         qBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AVYd9Rjb1zedauayC59UHepF1L1QYQNNE4PKhmE9Kd4=;
        b=UdaRWJlhLGj4enCGIEdJ6BifDg4U8WPnsIIm3PCYNkHHs4crVP65ODcx46ZcmstwpM
         vxFgNKc6Tfuhk+2rG2EbNKZauBrCRH9/BsbDz2ymB7TKRZQNo9e6zs6ZmePHMNLQniKl
         GXtXooGmlBTS3D0Csek+cnSsVp25x+lkcw2jQh+MHUjrZBmnqTGphxBy2SZ8REu0Kuao
         /2Xl/YdzL2aO3diYSTrQLtz9kUX5vkgk5igwGNfzNJjPTke3IS4Q5+W4Le9bZHh87VBH
         IUB1WzEad+uOo/HKjom3G6MgXe8b25FJbpKsjuWCsKOvEYcoH0KafBWKaPwY5mzxCoNb
         Qvww==
X-Gm-Message-State: APjAAAWMQhxYQfrjPcbaltqQC8ai+g3DvdBbhqSfMNf6qdEcXTftYr/D
        oOgFakTBtR9FrZQ5K0wep4I=
X-Google-Smtp-Source: APXvYqw2ByT2MQk28RLvGMX3/YVd74Edp6aRaSYjkH6sC38jgHnjvMto+y737ZYrzNvjhka/j+GxHA==
X-Received: by 2002:ac2:5690:: with SMTP id 16mr55625639lfr.43.1564566134534;
        Wed, 31 Jul 2019 02:42:14 -0700 (PDT)
Received: from titan.lan (90-230-197-193-no86.tbcn.telia.com. [90.230.197.193])
        by smtp.gmail.com with ESMTPSA id t4sm15408200ljh.9.2019.07.31.02.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 02:42:14 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans@owltronix.com>
Subject: [PATCH 1/4] lightnvm: remove nvm_submit_io_sync_fn
Date:   Wed, 31 Jul 2019 11:41:33 +0200
Message-Id: <1564566096-28756-2-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the redundant sync handling interface and wait for a completion
in the lightnvm core instead.

Signed-off-by: Hans Holmberg <hans@owltronix.com>
---
 drivers/lightnvm/core.c      | 35 +++++++++++++++++++++++++++++------
 drivers/nvme/host/lightnvm.c | 29 -----------------------------
 include/linux/lightnvm.h     |  2 --
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index a600934fdd9c..01d098fb96ac 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -752,12 +752,36 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
+static void nvm_sync_end_io(struct nvm_rq *rqd)
+{
+	struct completion *waiting = rqd->private;
+
+	complete(waiting);
+}
+
+static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+	int ret = 0;
+
+	rqd->end_io = nvm_sync_end_io;
+	rqd->private = &wait;
+
+	ret = dev->ops->submit_io(dev, rqd);
+	if (ret)
+		return ret;
+
+	wait_for_completion_io(&wait);
+
+	return 0;
+}
+
 int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
 	struct nvm_dev *dev = tgt_dev->parent;
 	int ret;
 
-	if (!dev->ops->submit_io_sync)
+	if (!dev->ops->submit_io)
 		return -ENODEV;
 
 	nvm_rq_tgt_to_dev(tgt_dev, rqd);
@@ -765,9 +789,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 	rqd->dev = tgt_dev;
 	rqd->flags = nvm_set_flags(&tgt_dev->geo, rqd);
 
-	/* In case of error, fail with right address format */
-	ret = dev->ops->submit_io_sync(dev, rqd);
-	nvm_rq_dev_to_tgt(tgt_dev, rqd);
+	ret = nvm_submit_io_wait(dev, rqd);
 
 	return ret;
 }
@@ -788,12 +810,13 @@ EXPORT_SYMBOL(nvm_end_io);
 
 static int nvm_submit_io_sync_raw(struct nvm_dev *dev, struct nvm_rq *rqd)
 {
-	if (!dev->ops->submit_io_sync)
+	if (!dev->ops->submit_io)
 		return -ENODEV;
 
+	rqd->dev = NULL;
 	rqd->flags = nvm_set_flags(&dev->geo, rqd);
 
-	return dev->ops->submit_io_sync(dev, rqd);
+	return nvm_submit_io_wait(dev, rqd);
 }
 
 static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr ppa)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ba009d4c9dfa..d6f121452d5d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -690,34 +690,6 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	return 0;
 }
 
-static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
-{
-	struct request_queue *q = dev->q;
-	struct request *rq;
-	struct nvme_nvm_command cmd;
-	int ret = 0;
-
-	memset(&cmd, 0, sizeof(struct nvme_nvm_command));
-
-	rq = nvme_nvm_alloc_request(q, rqd, &cmd);
-	if (IS_ERR(rq))
-		return PTR_ERR(rq);
-
-	/* I/Os can fail and the error is signaled through rqd. Callers must
-	 * handle the error accordingly.
-	 */
-	blk_execute_rq(q, NULL, rq, 0);
-	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-
-	rqd->ppa_status = le64_to_cpu(nvme_req(rq)->result.u64);
-	rqd->error = nvme_req(rq)->status;
-
-	blk_mq_free_request(rq);
-
-	return ret;
-}
-
 static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
 					int size)
 {
@@ -754,7 +726,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
 	.get_chk_meta		= nvme_nvm_get_chk_meta,
 
 	.submit_io		= nvme_nvm_submit_io,
-	.submit_io_sync		= nvme_nvm_submit_io_sync,
 
 	.create_dma_pool	= nvme_nvm_create_dma_pool,
 	.destroy_dma_pool	= nvme_nvm_destroy_dma_pool,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 4d0d5655c7b2..8891647b24b1 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -89,7 +89,6 @@ typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int, int);
 typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
 							struct nvm_chk_meta *);
 typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
 typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
@@ -104,7 +103,6 @@ struct nvm_dev_ops {
 	nvm_get_chk_meta_fn	*get_chk_meta;
 
 	nvm_submit_io_fn	*submit_io;
-	nvm_submit_io_sync_fn	*submit_io_sync;
 
 	nvm_create_dma_pool_fn	*create_dma_pool;
 	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
-- 
2.7.4

