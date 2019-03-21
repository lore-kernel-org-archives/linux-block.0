Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E33C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00581218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXfMDwb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCUXMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:12:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ig7GqXoHZPgdkj33sZ9nPGcAdlSXMBhgaTI2SqAfns8=; b=SXfMDwb9dFFroII+dL6S2E+XuV
        WGo950S7RLAyAtTR4cZUh+iV8lfGTHUAIIjfzlYVaHijU5YsPD89AggHLzH+8arjtAIX+aT+FmH8K
        pd2L+aR1IIhavJC8+zeToS7Htupt/TDdoBTiLqE7G7JN7RU3g7/zqcjeze/l/B6PtZINHgLs0Csjy
        SUiVT/UJ7MSoTq0EBoCtLPIc0PQrcvKyO1CyQ/GWbYnaWRk39XAnNgXieu/YOPGfHbjbuiqdd6VIL
        Fg6yt2bsdm2XYyQEckXxgcXNlVmrVquJ6SRv2E5v8AdCnN4lzukTfEwXtLJQxImb5qo69L4SjW0Wg
        MCIVXPZg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76r0-0003qk-Ad; Thu, 21 Mar 2019 23:12:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 13/15] nvme-pci: optimize mapping of small single segment requests
Date:   Thu, 21 Mar 2019 16:10:35 -0700
Message-Id: <20190321231037.25104-14-hch@lst.de>
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

If a request is single segment and fits into one or two PRP entries we
do not have to create a scatterlist for it, but can just map the bio_vec
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 45 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c6047935e825..47fc4d653961 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -221,6 +221,7 @@ struct nvme_iod {
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
+	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t meta_dma;
 	struct scatterlist *sg;
 };
@@ -576,13 +577,18 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
-	if (iod->nents) {
-		/* P2PDMA requests do not need to be unmapped */
-		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
-			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
-
+	if (iod->dma_len) {
+		dma_unmap_page(dev->dev, dma_addr, iod->dma_len, dma_dir);
+		return;
 	}
 
+	WARN_ON_ONCE(!iod->nents);
+
+	/* P2PDMA requests do not need to be unmapped */
+	if (!is_pci_p2pdma_page(sg_page(iod->sg)))
+		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+
+
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			dma_addr);
@@ -795,6 +801,24 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
+static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
+		struct request *req, struct nvme_rw_command *cmnd,
+		struct bio_vec *bv)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	unsigned int first_prp_len = dev->ctrl.page_size - bv->bv_offset;
+
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	if (dma_mapping_error(dev->dev, iod->first_dma))
+		return BLK_STS_RESOURCE;
+	iod->dma_len = bv->bv_len;
+
+	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
+	if (bv->bv_len > first_prp_len)
+		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	return 0;
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -805,6 +829,17 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_IOERR;
 	int nr_mapped;
 
+	if (blk_rq_nr_phys_segments(req) == 1) {
+		struct bio_vec bv = req_bvec(req);
+
+		if (!is_pci_p2pdma_page(bv.bv_page)) {
+			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
+				return nvme_setup_prp_simple(dev, req,
+							     &cmnd->rw, &bv);
+		}
+	}
+
+	iod->dma_len = 0;
 	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sg)
 		return BLK_STS_RESOURCE;
-- 
2.20.1

