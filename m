Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D8C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D394218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t54HCNPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfCUXLd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fd/dPmQxZgKEBIcWRRLczSGZk9dM2iNv8Eu7KME31HQ=; b=t54HCNPEO7qGjciasdLPMAtfjw
        bsIJOXLvQyoF5ggKjv8oIkNweA+ZjZ1lk4m8jV4AT6RmiouoA1MtahxpgsipA8gZCaTSTCnNvqCVc
        Uay1jYXjMa6v2peZvm8xt4v7RwKIuz2vlSFJODjdskCvgB4r1QjmxT4OY2jxGhNg2oxtvtkwxbLow
        vZYz3K3zuXl0zSzUZTzFSbk4+yn8Tg6qVva0GZROi8QSuL8En11i1KSieWUIVlG044PuMu40BHcno
        F4wDQpr9n+XwsDjc0Hd8RpCcjbCS11hgzzUW19FjpI3kzaSldiyTL1wMBv85byZ5ihCJMDVptmXY8
        3dOv4vQA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qN-00031d-Os; Thu, 21 Mar 2019 23:11:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 06/15] nvme-pci: remove nvme_init_iod
Date:   Thu, 21 Mar 2019 16:10:28 -0700
Message-Id: <20190321231037.25104-7-hch@lst.de>
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

nvme_init_iod should really be split into two parts: initialize a few
general iod fields, which can easily be done at the beginning of
nvme_queue_rq, and allocating the scatterlist if needed, which logically
belongs into nvme_map_data with the code making use of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 56 ++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bf0d71fe243e..3f06e942fb47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -208,10 +208,10 @@ struct nvme_queue {
 };
 
 /*
- * The nvme_iod describes the data in an I/O, including the list of PRP
- * entries.  You can't see it in this data structure because C doesn't let
- * me express that.  Use nvme_init_iod to ensure there's enough space
- * allocated to store the PRP list.
+ * The nvme_iod describes the data in an I/O.
+ *
+ * The sg pointer contains the list of PRP/SGL chunk allocations in addition
+ * to the actual struct scatterlist.
  */
 struct nvme_iod {
 	struct nvme_request req;
@@ -583,29 +583,6 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 	return true;
 }
 
-static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(rq);
-	int nseg = blk_rq_nr_phys_segments(rq);
-	unsigned int size = blk_rq_payload_bytes(rq);
-
-	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
-
-	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-		if (!iod->sg)
-			return BLK_STS_RESOURCE;
-	} else {
-		iod->sg = iod->inline_sg;
-	}
-
-	iod->aborted = 0;
-	iod->npages = -1;
-	iod->nents = 0;
-
-	return BLK_STS_OK;
-}
-
 static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -837,6 +814,17 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_IOERR;
 	int nr_mapped;
 
+	if (blk_rq_payload_bytes(req) > NVME_INT_BYTES(dev) ||
+	    blk_rq_nr_phys_segments(req) > NVME_INT_PAGES) {
+		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
+		if (!iod->sg)
+			return BLK_STS_RESOURCE;
+	} else {
+		iod->sg = iod->inline_sg;
+	}
+
+	iod->use_sgl = nvme_pci_use_sgls(dev, req);
+
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(q, req, iod->sg);
 	if (!iod->nents)
@@ -881,6 +869,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 out_unmap:
 	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 out:
+	nvme_free_iod(dev, req);
 	return ret;
 }
 
@@ -913,9 +902,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
+	iod->aborted = 0;
+	iod->npages = -1;
+	iod->nents = 0;
+
 	/*
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
@@ -927,21 +921,15 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	ret = nvme_init_iod(req, dev);
-	if (ret)
-		goto out_free_cmd;
-
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &cmnd);
 		if (ret)
-			goto out_cleanup_iod;
+			goto out_free_cmd;
 	}
 
 	blk_mq_start_request(req);
 	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
-out_cleanup_iod:
-	nvme_free_iod(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
-- 
2.20.1

