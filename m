Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE811E1C3F
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851346; cv=none; b=l3tDmpDnZU7UMkPeoETcGkBFryCo7IuQajUYyOPSLluWl6cNFUT70qbqr2OEgK7efXiIb/AsKB+cuLffBrjkDpe8Kp1HjinQEhU6+MAd7QcTK/OzpuVQi72EE/ccukMourU/cchMh9sqejIpehXH0WFC1gm8OchLeJW/e7P7EsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851346; c=relaxed/simple;
	bh=hT4hGCV2Y+6GJgECJDtyQfS0Ogg5x0r6i7XU/SZbBbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXWB3QczdJnoL2/bmNFB5/Y97+d+pIr/MwI26JQN7h8yA+YFRurzL9Dslw9C05ElcrMvQYWbTJaujWbM/2hUcqT3BbbfyJC+3k+6qjywkIGi5fv71aW/ONDO5a4joCJHUh7VYOFV0hP1xe5SenUixaVUlPKxOAeSGOD7eofAb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sOZHVRT/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sOZHVRT/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=D2ki4IvdKHj9Sus0o30qpogdG7XEExoecyhz9hcVIXU=; b=sOZHVRT/D0V0rbHle9E0Oad9Xm
	t7FrZqSswRnL13S+C+WVx79qqBXmh/KFQhbOT6epFWXxwUR6QCy/+vWhwYDMubm/hJ23cS5iGQaKW
	tz+CJOAAbWDlKHYxVaVm/D/xDK2CbtLif1w2GH+imUsZt3Y7VXE4P3+vbvg1iTYBg7kGM2IA1GRE5
	1wpHmLHcF+Q7PTfetKGuwo3b8prH2tGYuZYdu+o7NbBe5SFVs43YUgVlzo61EV4GRHIvJtxXShs33
	9LYfjDDHkOIFp/y6E8wNwlB3ekoV1pHOIcQb6Gcur+1Oz/2+noNPTSho80BadKZmqBhJ4BkzPhbgA
	6gdecvMg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPm-00000008UzL-07Yo;
	Wed, 25 Jun 2025 11:35:42 +0000
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
Date: Wed, 25 Jun 2025 13:35:00 +0200
Message-ID: <20250625113531.522027-4-hch@lst.de>
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

Move the average segment size into a separate helper, and return a
tristate to distinguish the case where can use SGL vs where we have to
use SGLs.  This will allow the simplify the code and make more efficient
decisions in follow on changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..16ff87fe3dd9 100644
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
+	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
 		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
-- 
2.47.2

