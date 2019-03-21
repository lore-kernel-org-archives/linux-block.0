Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D815FC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C310218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qvzd/wFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCUXMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:12:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCUXMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fJ6w7bf0gcERYQq1hEZRAowb+y3nN14BXF+s4AKFx60=; b=Qvzd/wFE/bFtBQmxVrE7nXZcYe
        JZ/EkYXquTek6QBlOr5L3pvG81Gpcqd4vxzvQ7Tx8kyL3BCZfytj2nxFdnBfZT2+FQefqNcfovWeA
        Tp+9P2BTEE9ippItwR7Kvc3lOnIzSb850CA2nwKmUp0mrIuOTwnHmY8vDvJUKhl8iTXPQPH0eZuTw
        7coicJHBF3c+162PBQLJ213Vnu1ZhaHoqWuk90wRpUSVQkE2GwTCpUwgD/pByKs1PqHxP0PNuZxgN
        phponrLpicMuVOwvqGylGpVOpjmC0c+Teg4FKyF+zGKqdNLgGjFGYvXOOsb0wDIm0aLLN5MsT+3k+
        mJ9a2NSw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76r5-0003x8-QA; Thu, 21 Mar 2019 23:12:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 14/15] nvme-pci: optimize mapping single segment requests using SGLs
Date:   Thu, 21 Mar 2019 16:10:36 -0700
Message-Id: <20190321231037.25104-15-hch@lst.de>
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

If the controller supports SGLs we can take another short cut for single
segment request, given that we can always map those without another
indirection structure, and thus don't need to create a scatterlist
structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 47fc4d653961..38869f59c296 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -819,6 +819,23 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	return 0;
 }
 
+static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
+		struct request *req, struct nvme_rw_command *cmnd,
+		struct bio_vec *bv)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	if (dma_mapping_error(dev->dev, iod->first_dma))
+		return BLK_STS_RESOURCE;
+	iod->dma_len = bv->bv_len;
+
+	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
+	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
+	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
+	return 0;
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -836,6 +853,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
+
+			if (iod->nvmeq->qid &&
+			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
+				return nvme_setup_sgl_simple(dev, req,
+							     &cmnd->rw, &bv);
 		}
 	}
 
-- 
2.20.1

