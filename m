Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224041917D6
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851348; cv=none; b=Wl3ro42w3t/0zgCj1A0LdN0go/5U1d1vRa0YZwd2FUMVajsobCIHP/UPF5pM1oY2zaIjp6/YSlQ7WLe9swsZAdRVPzhZSjutSKMomo7HKJa6/vQ2mPO02ix3nvg67BvcVorwnBuz1lvL0gg7H507w90o9qrKx33mToRnJAmFCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851348; c=relaxed/simple;
	bh=B8PT89ouS2QjjEeAMPJMe/QEKXV4bpP7R4TVJI3IvJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBMfPq9XlIgJI/II2+hBzxSG50uBGkdd2EMyNjn0f+8C7VjLwq2/r1APe9KRUspr2Jy0YINADqqBcRFi9uUUJsMLkibyt6Sj2n3zRNWovJz4UG6Mx/LgtDne/k7OTo5OI29P1stf7ngNutO5vJM0HkxQ+6h4Slop9hmpxCG2Tis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BrIXCB5C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BrIXCB5C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EwbtlexYnjVdNcBrHiPAerjJetMmm6MNvfCxWFFKSZg=; b=BrIXCB5CKNX3sCMOoi2JA7TxUT
	bGmp7Qa0JVaMHmQOpubeR74GE0+xEaw3b7qEri2lCbPUHXtjmBkj2XmbWFpizRnXJWbpmCx/uBUuS
	zmhh5mEqGFySxNvvKCfSmxDvXtlRU/VvSSUQJhH9dIg8BoYQk4bAOBZlE7vfzlre/gwXorVywZyAl
	U9cKwVqGJOBkZzUOilk9uCdq1O1bqBRGncIzbvVoGjoG2JZ4cwKRlQI4G+ttVd7/4bWDhn9mENbKx
	OGK0jc+l1EVWa8JprfHLJq2vMpsVq/QzS6fhVXb3bI5eNFg5HPv8qYdXQEd4zkGpp75rHxW79KluA
	ik8WjKNg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPo-00000008Uzr-1xWO;
	Wed, 25 Jun 2025 11:35:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
Date: Wed, 25 Jun 2025 13:35:01 +0200
Message-ID: <20250625113531.522027-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
References: <20250625113531.522027-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
Merge them into a single helper that makes use of the previously added
use_sgl tristate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 76 +++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 16ff87fe3dd9..1203219543df 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -817,42 +817,41 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 	return BLK_STS_OK;
 }
 
-static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
+static blk_status_t nvme_pci_setup_data_simple(struct request *req,
+		enum nvme_use_sgl use_sgl)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
-
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->first_dma))
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct bio_vec bv = req_bvec(req);
+	unsigned int prp1_offset = bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
+	bool prp_possible = prp1_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2;
+	dma_addr_t dma_addr;
+
+	if (!use_sgl && !prp_possible)
+		return BLK_STS_AGAIN;
+	if (is_pci_p2pdma_page(bv.bv_page))
+		return BLK_STS_AGAIN;
+
+	dma_addr = dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0);
+	if (dma_mapping_error(nvmeq->dev->dev, dma_addr))
 		return BLK_STS_RESOURCE;
-	iod->dma_len = bv->bv_len;
-
-	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
-	if (bv->bv_len > first_prp_len)
-		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
-	else
-		cmnd->dptr.prp2 = 0;
-	return BLK_STS_OK;
-}
+	iod->dma_len = bv.bv_len;
 
-static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	if (use_sgl == SGL_FORCED || !prp_possible) {
+		iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+		iod->cmd.common.dptr.sgl.addr = cpu_to_le64(dma_addr);
+		iod->cmd.common.dptr.sgl.length = cpu_to_le32(bv.bv_len);
+		iod->cmd.common.dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
+	} else {
+		unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - prp1_offset;
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->first_dma))
-		return BLK_STS_RESOURCE;
-	iod->dma_len = bv->bv_len;
+		iod->cmd.common.dptr.prp1 = cpu_to_le64(dma_addr);
+		iod->cmd.common.dptr.prp2 = 0;
+		if (bv.bv_len > first_prp_len)
+			iod->cmd.common.dptr.prp2 =
+				cpu_to_le64(dma_addr + first_prp_len);
+	}
 
-	cmnd->flags = NVME_CMD_SGL_METABUF;
-	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
-	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
-	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
 	return BLK_STS_OK;
 }
 
@@ -866,20 +865,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct bio_vec bv = req_bvec(req);
-
-		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (!nvme_pci_metadata_use_sgls(dev, req) &&
-			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
-			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
-				return nvme_setup_prp_simple(dev, req,
-							     &cmnd->rw, &bv);
-
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
-				return nvme_setup_sgl_simple(dev, req,
-							     &cmnd->rw, &bv);
-		}
+		ret = nvme_pci_setup_data_simple(req, use_sgl);
+		if (ret != BLK_STS_AGAIN)
+			return ret;
 	}
 
 	iod->dma_len = 0;
-- 
2.47.2

