Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7756C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A501C218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ar8K2yiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCUXMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:12:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LYFwEzWNNvVUMCGovlRHLnNrfAVChJZQTVYNuFWrJb8=; b=Ar8K2yiOjJHgcWSH51IrPrc7Fu
        IoH7Kz1k2P5MOqJW8fXVMGlSjBcUcQQKOBUzK262aKZ9NMQdKhzZ/DovjrSZS71uKMI+auUydO8UY
        DWhVq6icPSXXXqSGLZPZZaC9qb24dEJrfzcSD5AOwi34bj7B9n1p/b0JxsqwjWEk+ld2CfAc97nn6
        NRxiOvZ4FN1WIF11xMIOSdgn8wuxXVtYZ4lIep06fTxoKqcVi0sdYbUp5LRqHBJwP6a5Uz04F+iKw
        wkOG6uK1YBFuNsnqFqwS8AswyRCc4H8+HgsKPgp1Pux758lAaNtdGKYxpjb4e888/gUyKZn/3aPVx
        uDh1mKxw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qp-0003cA-En; Thu, 21 Mar 2019 23:11:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 11/15] nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data
Date:   Thu, 21 Mar 2019 16:10:33 -0700
Message-Id: <20190321231037.25104-12-hch@lst.de>
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

This prepares for some bigger changes to the data mapping helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 48 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7dad24e0406..cf29d079ad5b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -592,11 +592,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
-	if (blk_integrity_rq(req)) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-				rq_integrity_vec(req)->bv_len, dma_dir);
-	}
-
 	if (iod->nents) {
 		/* P2PDMA requests do not need to be unmapped */
 		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
@@ -858,24 +853,23 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
-
+out:
 	if (ret != BLK_STS_OK)
-		goto out;
-
-	ret = BLK_STS_IOERR;
-	if (blk_integrity_rq(req)) {
-		iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-				dma_dir, 0);
-		if (dma_mapping_error(dev->dev, iod->meta_dma))
-			goto out;
-		cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
-	}
+		nvme_unmap_data(dev, req);
+	return ret;
+}
 
-	return BLK_STS_OK;
+static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
+		struct nvme_command *cmnd)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-out:
-	nvme_unmap_data(dev, req);
-	return ret;
+	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
+			rq_dma_dir(req), 0);
+	if (dma_mapping_error(dev->dev, iod->meta_dma))
+		return BLK_STS_IOERR;
+	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+	return 0;
 }
 
 /*
@@ -913,9 +907,17 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_free_cmd;
 	}
 
+	if (blk_integrity_rq(req)) {
+		ret = nvme_map_metadata(dev, req, &cmnd);
+		if (ret)
+			goto out_unmap_data;
+	}
+
 	blk_mq_start_request(req);
 	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
+out_unmap_data:
+	nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
@@ -924,10 +926,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev = iod->nvmeq->dev;
 
 	nvme_cleanup_cmd(req);
+	if (blk_integrity_rq(req))
+		dma_unmap_page(dev->dev, iod->meta_dma,
+			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
 	if (blk_rq_nr_phys_segments(req))
-		nvme_unmap_data(iod->nvmeq->dev, req);
+		nvme_unmap_data(dev, req);
 	nvme_complete_rq(req);
 }
 
-- 
2.20.1

