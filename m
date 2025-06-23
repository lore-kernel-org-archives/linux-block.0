Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743915B971
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687996; cv=none; b=pT5Y/Pay8OljWlHdHkZX3ob+6qJaVmL2AkNjXIoQZo8VW93AP4tX/DSh6Fq01fvd56SMF1QkmefrzN9wDVGkwyfWwPVZtlYYIXAHHZEF2ByTOVH3F0uLWovwAKZZVZdHp0DQZzacN1kHxMMT+cvac94Souqo31BW2tqjKymbDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687996; c=relaxed/simple;
	bh=ZLQmjDRd/F5neGdAd7K3k/CX2XbuvcAoRvdIi/NQtf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjTQUi9kn/aiI/S2ReggS6WRwsmwa7HSn2zlVfyDACkx1B7zgPUzKkkrNlflYDDNBdFKXAv/0npMnroGzZrPgfz71E1epF5g1svybg+wQqumIzaZBcUf6aTfMHnr8QvMRTzGEhF2I/gZmw9fMjAfNcpgb8hy15XnJMdwjVZkkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X7LgwW+t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7LgwW+t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4dvZH8x/z+zoatdMqg/HCCwdY+57eWLFYcfLppgAEgw=; b=X7LgwW+tIYCrnyKiKlQFy9pSf/
	13LGwthLzpVvFg9Nj8gJe0Mj/5H4LIOuem+hvfFqP//LwnZ9qiftOmXz9rs0ZKwgu4jeSHEd6es+r
	C63NzuA7R0/13ewPGLLFX78jJb3i7v6YXEs9kMw2N9dkeSB1/fKN8LWtBAaRg3YgcqZ9a5szaiTzJ
	XH3n5g8jQzHkJkPNykwj08N7nO/fAaDerXfohhcv6thdvebPM1CEIi9jHi6+I3kbpYsgclX+K3PCj
	z+R/gqPEUGCz+rn6LL+s8Mrv5KKhxTiRKUM0Ja76X1MGCMr91mStO/rhzNyVtwneT/2OmFT9YMm0H
	T4XE4dOg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThv5-00000002zpO-2C92;
	Mon, 23 Jun 2025 14:13:12 +0000
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
Subject: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Date: Mon, 23 Jun 2025 16:12:25 +0200
Message-ID: <20250623141259.76767-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
References: <20250623141259.76767-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the average segment size into a separate helper, and return a
tristate to distinguish the case where can use SGL vs where we have to
use SGLs.  This will allow the simplify the code and make more efficient
decisions in follow on changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..bc84438f0523 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -578,6 +578,12 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
+enum nvme_use_sgl {
+	SGL_UNSUPPORTED,
+	SGL_SUPPORTED,
+	SGL_FORCED,
+};
+
 static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
 					      struct request *req)
 {
@@ -587,23 +593,27 @@ static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
 		nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
-				     int nseg)
+static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
+		struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	unsigned int avg_seg_size;
 
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
+	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
+		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
+			return SGL_FORCED;
+		if (req->nr_integrity_segments > 1)
+			return SGL_FORCED;
+		return SGL_SUPPORTED;
+	}
 
-	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
-		return false;
-	if (!nvmeq->qid)
-		return false;
-	if (nvme_pci_metadata_use_sgls(dev, req))
-		return true;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return nvme_req(req)->flags & NVME_REQ_USERCMD;
-	return true;
+	return SGL_UNSUPPORTED;
+}
+
+static unsigned int nvme_pci_avg_seg_size(struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	return DIV_ROUND_UP(blk_rq_payload_bytes(req), iod->sgt.nents);
 }
 
 static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
@@ -851,6 +861,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	enum nvme_use_sgl use_sgl = nvme_pci_use_sgls(dev, req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
@@ -888,7 +899,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (use_sgl == SGL_FORCED ||
+	    (use_sgl == SGL_SUPPORTED &&
+	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
 		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
-- 
2.47.2

