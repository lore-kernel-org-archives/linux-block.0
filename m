Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4DFC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EE9218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NaFt4t84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCUXMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:12:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCUXMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LfjNXsN3o2AHquL1g8L5xDbXrIN82br20YgpHMBO7uU=; b=NaFt4t84SDtD7KlyQw0Vdgxj6g
        88jc3IsRxTaxMl8gjjBdrZ4EkurDb3IhwT+FoFnS7zpdmNWykuYtY3+uUSIbCUCc0zOJfoKaOygZF
        lbCzuZGOkoTMyaV3ppuwE49dEcqZIGnWyog7iQtSV06bxXeG1s6xkGNKp6SJxyGn6PWlvx2GhgAOt
        e4wU/nLpTz7DMi6Ym2klVql96N35G39xdR2kTaHRdFuEqA/nDIr6De3Nif4JgOECjZA/J7hcrEnDE
        sXcIj2kyZ9a9ipfUGYx8nFX28R7H10vesytNRY18LFDOQNkIWqc77aZqWOVYRMBsHEU6r93iWh4PX
        y1/r5VEQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76rB-0003zM-2x; Thu, 21 Mar 2019 23:12:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 15/15] nvme-pci: tidy up nvme_map_data
Date:   Thu, 21 Mar 2019 16:10:37 -0700
Message-Id: <20190321231037.25104-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove two pointless local variables, remove ret assignment that is
never used, move the use_sgl initialization closer to where it is used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38869f59c296..9ec0704d5f78 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -840,10 +840,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct request_queue *q = req->q;
-	enum dma_data_direction dma_dir = rq_data_dir(req) ?
-			DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	blk_status_t ret = BLK_STS_IOERR;
+	blk_status_t ret = BLK_STS_RESOURCE;
 	int nr_mapped;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
@@ -865,25 +862,21 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sg)
 		return BLK_STS_RESOURCE;
-
-	iod->use_sgl = nvme_pci_use_sgls(dev, req);
-
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
-	iod->nents = blk_rq_map_sg(q, req, iod->sg);
+	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
 		goto out;
 
-	ret = BLK_STS_RESOURCE;
-
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,
-					  dma_dir);
+					      rq_dma_dir(req));
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     dma_dir,  DMA_ATTR_NO_WARN);
+					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	if (!nr_mapped)
 		goto out;
 
+	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
-- 
2.20.1

