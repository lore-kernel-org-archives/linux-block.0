Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9DC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9F6218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpgZyLGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCUXMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:12:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wz/UdM+Nl7Ku/95Bd0bmJkpcdk5PGyK8D7W5iwklSHk=; b=lpgZyLGRcRrl4o3k88d5tnmCEo
        WbONSvcq1dA5HPLRC2lCyMqo3Gjkje9ytEqtPDdSW9KMg4gk7wP9WJ4lMRs7OoAZ7iX9rugksLC2U
        9ACm3pWWMFY1gsbDpZM1oL0yj/OwwNmzR0zDhrf01ztt1lQP9qs8t6+RV7Olp4SX0Neu+Ah1Uogtu
        8nlfzv7OZwoZEFFhRiwaLUv9o3hlo9aB+o7D69r6obcpGzqS5IOy7F7hVEVAlJGLNzzRytW1r++u+
        dGpS+H4EW1fN3yQZ/leNpmC3/DthEfJoh4QQNUT3gSVaDBr2f7BAsoufSI+GswTrILnPF0LqA/wzD
        CQ0D+BPg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qu-0003ja-Rs; Thu, 21 Mar 2019 23:12:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 12/15] nvme-pci: remove the inline scatterlist optimization
Date:   Thu, 21 Mar 2019 16:10:34 -0700
Message-Id: <20190321231037.25104-13-hch@lst.de>
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

We'll have a better way to optimize for small I/O that doesn't
require it soon, so remove the existing inline_sg case to make that
optimization easier to implement.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cf29d079ad5b..c6047935e825 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -223,7 +223,6 @@ struct nvme_iod {
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct scatterlist *sg;
-	struct scatterlist inline_sg[0];
 };
 
 /*
@@ -370,12 +369,6 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 	return true;
 }
 
-/*
- * Max size of iod being embedded in the request payload
- */
-#define NVME_INT_PAGES		2
-#define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->ctrl.page_size)
-
 /*
  * Will slightly overestimate the number of pages needed.  This is OK
  * as it only leads to a small amount of wasted memory for the lifetime of
@@ -410,15 +403,6 @@ static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
 	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
 
-static unsigned int nvme_pci_cmd_size(struct nvme_dev *dev, bool use_sgl)
-{
-	unsigned int alloc_size = nvme_pci_iod_alloc_size(dev,
-				    NVME_INT_BYTES(dev), NVME_INT_PAGES,
-				    use_sgl);
-
-	return sizeof(struct nvme_iod) + alloc_size;
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -621,8 +605,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 		dma_addr = next_dma_addr;
 	}
 
-	if (iod->sg != iod->inline_sg)
-		mempool_free(iod->sg, dev->iod_mempool);
+	mempool_free(iod->sg, dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
@@ -822,14 +805,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_IOERR;
 	int nr_mapped;
 
-	if (blk_rq_payload_bytes(req) > NVME_INT_BYTES(dev) ||
-	    blk_rq_nr_phys_segments(req) > NVME_INT_PAGES) {
-		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-		if (!iod->sg)
-			return BLK_STS_RESOURCE;
-	} else {
-		iod->sg = iod->inline_sg;
-	}
+	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
+	if (!iod->sg)
+		return BLK_STS_RESOURCE;
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 
@@ -1619,7 +1597,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
-		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
+		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
@@ -2266,11 +2244,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-		dev->tagset.cmd_size = nvme_pci_cmd_size(dev, false);
-		if ((dev->ctrl.sgls & ((1 << 0) | (1 << 1))) && sgl_threshold) {
-			dev->tagset.cmd_size = max(dev->tagset.cmd_size,
-					nvme_pci_cmd_size(dev, true));
-		}
+		dev->tagset.cmd_size = sizeof(struct nvme_iod);
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
-- 
2.20.1

