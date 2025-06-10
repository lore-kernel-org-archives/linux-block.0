Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CF25D1F5
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532052; cv=none; b=UCQwl2XY4IUSr/QWXS6YMlnOYyqahZPhzJ3xPvuTaKzHHiAxI6DIQNDWOhrXxvjyJrNarUfPyj2eWVYNXAwoH9Eczb18Jdfli8kUDNL94S6uCHvljcIQ7d5amXk/FTynGKX7OKCn96zO6DnKZa7Plj5pXp+kmx170CS5TKLF4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532052; c=relaxed/simple;
	bh=PxqUwuKc8kISyeJ8aYK/spizyx3mIsr08ulW9Av+N1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4psPe7rH7kwUlkHLRgP2goNd0A8+H6nJmDOtsKH+Y3O1siXMk8jvddP/pzRV1nlpRBySY1WVn5LH6hseOAicM9xah9tH7lB+fNkotlYSu2osUCGGpZsCnS/KeHXNG4hb3nuWmIBNBIvmmDH9RG6mQcrSsc9gGtcK1BLHWLYUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lq0seTfx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lq0seTfx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ls7n2WDbl7oMgiApmHT4ASNiGzoRhOm2OKW8Bg0CTjE=; b=lq0seTfxgECviMKgmX417noZCj
	QzqjQdc67DW9HGcVIoqulzUYGYrjGPyIBmLSSm/ef+qNNn2lci7DVeOLPkosxtah/EaVmEm9sU2WN
	suUF6LYpe9pJe3Bt/UWL/2LsxgN+/0bIkONACRJjJJchg6bmjJGtkA6SCF7inoponyLgH+SOPDFvd
	Bt5YA0e/EdbRp2kcJpBqYF832e4BPraXVakW7rVjuJ50MSU/c9J44i2jNpvvYBVZtfoBTKAz8l8WB
	AeAZlS52mUH9cP++hZbSi+zXcw1o3fR5clEqFne8eHzGCmgiPUKTSl/ZZs+h/YzSctsq+9M0VfGqO
	ZJLBDOrA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCp-00000005ngE-3iPd;
	Tue, 10 Jun 2025 05:07:28 +0000
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
Subject: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Date: Tue, 10 Jun 2025 07:06:42 +0200
Message-ID: <20250610050713.2046316-5-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610050713.2046316-1-hch@lst.de>
References: <20250610050713.2046316-1-hch@lst.de>
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
index 449a9950b46c..0b85c11d3c96 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -578,29 +578,39 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
+enum nvme_use_sgl {
+	SGL_UNSUPPORTED,
+	SGL_SUPPORTED,
+	SGL_FORCED,
+};
+
 static inline bool nvme_pci_metadata_use_sgls(struct request *req)
 {
 	return req->nr_integrity_segments > 1 ||
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
+		if (nvme_pci_metadata_use_sgls(req))
+			return SGL_FORCED;
+		return SGL_SUPPORTED;
+	}
 
-	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
-		return false;
-	if (!nvmeq->qid)
-		return false;
-	if (nvme_pci_metadata_use_sgls(req))
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
@@ -848,6 +858,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	enum nvme_use_sgl use_sgl = nvme_pci_use_sgls(dev, req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
@@ -886,7 +897,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (use_sgl == SGL_FORCED ||
+	    (use_sgl == SGL_SUPPORTED &&
+	     (!sgl_threshold || nvme_pci_avg_seg_size(req) < sgl_threshold)))
 		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
-- 
2.47.2

