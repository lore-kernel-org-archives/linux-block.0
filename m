Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65225D1F5
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532049; cv=none; b=CPMWzCywJ8hQheCxF+b9OtGDgG32sXhfvmirXyfssm+JqRzISxhdXOdchtMRtkfUeIsqyp599JIM9RJV8gQjBIc/TcfX8U0fC9UZIRM3pt7YNfzWa5MU2+ZqPDr7UeVz3TpezRhKBeNjkxflchmUy9hVLPvLutRbvWeKCe8qBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532049; c=relaxed/simple;
	bh=o3IQnELHJyVQD6N4IZSGbmDCkKfuLx2jzclm+61L6IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkPbKjds9ZajGbbEIiK24A4yfD6NDkadSo1bhWfmxUk79AfY7xTcy4lahYQ/HeWTOFC9P2x2IIpjojCBtW/1Y+UKqOK6xcQ+MLI1pml8ASWAUjA5LH9IDbMx5alFCUMQfUJs1DYVV8T+5TZiHoCxt2B3jwT88yEKMoRC8SPn0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IFnLfCJh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFnLfCJh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CCo2ImpgmdhL2lI9YPHJoAms+C0Dytco15Yvs7ulJkE=; b=IFnLfCJhl3ad/SvafMeLwVOyc7
	uHMa341BMsMvmZ0KrLyTjWoLZHFp3RuLlW4UHM9TiCRIF0wS5m+hOFOCsCxuwU5dkOtKcVYTaZdkX
	WUNwnn45guYZvGuSjxOtQL8r+x8SFTBPBFqnC9M9K6IB7+L4e1RKhs6ZhliCkDhX23sAevZrx/ORe
	Ayo9Q/w8Iq3O0qylJky1oF89Ap2CzTrSIBlavp2AOjamuqf+2bUfxtDpwTAT4PXz/nTZ7TRbJ2Q0+
	GGFBxDMDYzljjLZXOQ815AkAafQZ4pIrvne4KZ71WyVl+iHhY+AA39YIi94t2FDGCtKr9v6jEhgz9
	ly3O3c1Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCm-00000005nep-3VZM;
	Tue, 10 Jun 2025 05:07:25 +0000
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
Subject: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Date: Tue, 10 Jun 2025 07:06:41 +0200
Message-ID: <20250610050713.2046316-4-hch@lst.de>
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

Move the nvme_ctrl_meta_sgl_supported into the callers.  2 out of
three already have it, and the third will be simplified in follow on
patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..449a9950b46c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -578,11 +578,8 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
-static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
-					      struct request *req)
+static inline bool nvme_pci_metadata_use_sgls(struct request *req)
 {
-	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
-		return false;
 	return req->nr_integrity_segments > 1 ||
 		nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
@@ -599,7 +596,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 		return false;
 	if (!nvmeq->qid)
 		return false;
-	if (nvme_pci_metadata_use_sgls(dev, req))
+	if (nvme_pci_metadata_use_sgls(req))
 		return true;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return nvme_req(req)->flags & NVME_REQ_USERCMD;
@@ -858,7 +855,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (!nvme_pci_metadata_use_sgls(dev, req) &&
+			if ((!nvme_ctrl_meta_sgl_supported(&dev->ctrl) ||
+			     !nvme_pci_metadata_use_sgls(req)) &&
 			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
 			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
@@ -981,7 +979,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
-	    nvme_pci_metadata_use_sgls(dev, req))
+	    nvme_pci_metadata_use_sgls(req))
 		return nvme_pci_setup_meta_sgls(dev, req);
 	return nvme_pci_setup_meta_mptr(dev, req);
 }
-- 
2.47.2

