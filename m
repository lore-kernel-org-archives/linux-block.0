Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F1C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FED21479
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="etV1xnYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FED21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeKVC7M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:59:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbeKVC7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 21:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tPovuX7b0syaJzGPZ67nDZiUKksnOgDvYDR8Jn8LErE=; b=etV1xnYXbC6yK8xrsv87veb0sr
        LOX0K8YiVVbrGJ429uzofvB9+tIo6lNo39XxQMJ0YOr4YRxzmwx6Ry2zBtd5zR5z+9ISH55vhog/b
        dQXioN29m0Ng8AoyNynYYOZTksFCwCoxP7wjUvjB3Y01ZcR1Jdi2UVdY2Elp3bzSv5s9QI1A+q4Ik
        ETdfUdVAji/IrFuUii5f8H49RqGECU7XAzwUoIqwmMdkncAJg5EdqHQNMg4tF3NTzdtv9OsVgEcvt
        ia5NPD6irdEAmBTGyW1kSgWqj8TV/5Rp9fLV2/ADqExrI8ZnEj9zUGHfywnSuw5rCYSF3hoSdgbaO
        AeRSqcVQ==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPVIE-0002pn-1D; Wed, 21 Nov 2018 16:23:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 03/13] nvme-pci: cleanup SQ allocation a bit
Date:   Wed, 21 Nov 2018 17:23:37 +0100
Message-Id: <20181121162347.17430-4-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a bit flag to mark if the SQ was allocated from the CMB, and clean
up the surrounding code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8e9998b5d0f..608c52045b1b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -186,7 +186,6 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
-	bool sq_cmds_is_io;
 	spinlock_t cq_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
@@ -202,6 +201,7 @@ struct nvme_queue {
 	u8 cq_phase;
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
+#define NVMEQ_SQ_CMB		1
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -1337,17 +1337,15 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
+	if (!nvmeq->sq_cmds)
+		return;
 
-	if (nvmeq->sq_cmds) {
-		if (nvmeq->sq_cmds_is_io)
-			pci_free_p2pmem(to_pci_dev(nvmeq->q_dmadev),
-					nvmeq->sq_cmds,
-					SQ_SIZE(nvmeq->q_depth));
-		else
-			dma_free_coherent(nvmeq->q_dmadev,
-					  SQ_SIZE(nvmeq->q_depth),
-					  nvmeq->sq_cmds,
-					  nvmeq->sq_dma_addr);
+	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
+		pci_free_p2pmem(to_pci_dev(nvmeq->q_dmadev),
+				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
+	} else {
+		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
+				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
 }
 
@@ -1433,15 +1431,14 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
 		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
 						nvmeq->sq_cmds);
-		nvmeq->sq_cmds_is_io = true;
-	}
-
-	if (!nvmeq->sq_cmds) {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
-		nvmeq->sq_cmds_is_io = false;
+		if (nvmeq->sq_dma_addr) {
+			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
+			return 0; 
+		}
 	}
 
+	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
+				&nvmeq->sq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		return -ENOMEM;
 	return 0;
-- 
2.19.1

