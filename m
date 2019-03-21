Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1167C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADF2218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q9SgN0gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCUXLz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DGzVvfpJzJOYLs0KiGmd31aSQaIpiiDqnKZ528J12ps=; b=Q9SgN0gyhoE1SPcL73EATsu+MB
        rCe2mr6hpNv1IyCbBi6EZY/uYocRLv7mor3RtTyD6VKMWxlYyGeQPTJ68kkCfwK/FMDIHTv4jXkZ+
        iyIMYEwTDkKBnkPF2dWHEDFMfsQi2EPC23aNzDuWVqELrkbHiT/BCUm9wrdrF2XucplhdRG05Bvwz
        WkL4lY+6r8v6pIXlchtGcjFC7lMzRvZpDjKT/Fcf4LrBJ7wWydAaou7WC73/TKLtA+o/ePwgjWU/z
        9Fl6Yjca8YFE3bq1M93EWRBQcBm+9o3Vh0YTwjWvStGp2eZe15+QqLOJTGRQwnN3joR9mCR6IZghT
        4bRJQTvg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qj-0003UY-Q1; Thu, 21 Mar 2019 23:11:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 10/15] nvme-pci: do not build a scatterlist to map metadata
Date:   Thu, 21 Mar 2019 16:10:32 -0700
Message-Id: <20190321231037.25104-11-hch@lst.de>
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

We always have exactly one segment, so we can simply call dma_map_bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bc4ee869fe82..a7dad24e0406 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -221,7 +221,7 @@ struct nvme_iod {
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
-	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
+	dma_addr_t meta_dma;
 	struct scatterlist *sg;
 	struct scatterlist inline_sg[0];
 };
@@ -592,13 +592,16 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
+	if (blk_integrity_rq(req)) {
+		dma_unmap_page(dev->dev, iod->meta_dma,
+				rq_integrity_vec(req)->bv_len, dma_dir);
+	}
+
 	if (iod->nents) {
 		/* P2PDMA requests do not need to be unmapped */
 		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
 			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 
-		if (blk_integrity_rq(req))
-			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
 	}
 
 	if (iod->npages == 0)
@@ -861,17 +864,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 
 	ret = BLK_STS_IOERR;
 	if (blk_integrity_rq(req)) {
-		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
-			goto out;
-
-		sg_init_table(&iod->meta_sg, 1);
-		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
-			goto out;
-
-		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
+		iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
+				dma_dir, 0);
+		if (dma_mapping_error(dev->dev, iod->meta_dma))
 			goto out;
-
-		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
+		cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
 	}
 
 	return BLK_STS_OK;
-- 
2.20.1

