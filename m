Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3D3C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0B218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BAeSNT7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCUXLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oto/17k7Jidf6p2HfURUBaVjB/7kMEL+0xlJ0wkaBNk=; b=BAeSNT7NV5QC6TXJbSJGer68re
        AgeDoKNND80LhFdy66BBM6LpobSSTCMmc/GIlChvb3dPKp73wm7blbA657tZvBNsxdOwKm+A1ta9t
        N7CXOOnIxNuVY+b5VuAPdEeVP6j7iJ5+8giT0a7JakWWnPeCeK4nDKpJ3HNgQSBCBBYt9eIpFPzNx
        jCw6OjLxrF24fgU3ThnXUtXoLu+iCtuH8FhPcAQuGfrpd158xxe8ebplmRd+Nlg0az+SxUcYWs8jX
        mwPRV2//q3akMZ7g11FwIxveJ3jaT+LsSKZPxAoDgvVT25JDcY5T9IZyQ0+UQCh9vA4RM023AmszG
        vKxzzOjg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qY-0003GD-Mt; Thu, 21 Mar 2019 23:11:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 08/15] nvme-pci: merge nvme_free_iod into nvme_unmap_data
Date:   Thu, 21 Mar 2019 16:10:30 -0700
Message-Id: <20190321231037.25104-9-hch@lst.de>
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

This means we now have a function that undoes everything nvme_map_data
does and we can simplify the error handling a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 44 ++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2fb35d44010a..ce8bdc15ec3c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -583,14 +583,24 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 	return true;
 }
 
-static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
+static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	enum dma_data_direction dma_dir = rq_data_dir(req) ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
-
 	int i;
 
+	if (iod->nents) {
+		/* P2PDMA requests do not need to be unmapped */
+		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+
+		if (blk_integrity_rq(req))
+			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
+	}
+
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			dma_addr);
@@ -847,50 +857,30 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
 
 	if (ret != BLK_STS_OK)
-		goto out_unmap;
+		goto out;
 
 	ret = BLK_STS_IOERR;
 	if (blk_integrity_rq(req)) {
 		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
-			goto out_unmap;
+			goto out;
 
 		sg_init_table(&iod->meta_sg, 1);
 		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
-			goto out_unmap;
+			goto out;
 
 		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
-			goto out_unmap;
+			goto out;
 
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
 	}
 
 	return BLK_STS_OK;
 
-out_unmap:
-	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 out:
-	nvme_free_iod(dev, req);
+	nvme_unmap_data(dev, req);
 	return ret;
 }
 
-static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	enum dma_data_direction dma_dir = rq_data_dir(req) ?
-			DMA_TO_DEVICE : DMA_FROM_DEVICE;
-
-	if (iod->nents) {
-		/* P2PDMA requests do not need to be unmapped */
-		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
-			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
-
-		if (blk_integrity_rq(req))
-			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
-	}
-
-	nvme_free_iod(dev, req);
-}
-
 /*
  * NOTE: ns is NULL when called on the admin queue.
  */
-- 
2.20.1

