Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798835B123;
	Mon, 27 Oct 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550237; cv=none; b=e3YyG8IuwrX8NoOx9y/T745md3etE4jPs7bYoJObHNgh4wI7c2vMatDVa3yUx/fk4ncWZGvLhLx13TDM2BlqznWgcBqr/ynNJYrMAY3puoOp+AJIcpCELdDZd8Mv2BMIbW8bAzDlBzyH0wqyh90hBHGnV79qOcgT3Ukd26O8BmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550237; c=relaxed/simple;
	bh=6QYQBykKnq8P8i6JcyqUW4Tdtn9vg7PGX0fLf5OLFig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+kSHxZ3JCEkOGGjudbWuMmqqhO0VJTph6UMmteEF2aHuEQ2hTeOhe8y+27532cdCnp8orHbkL7eAS115unK/x10ha6P0gR+WbXT8LhdjtcsP1CRzP0hzEyqYKmTkA+OT/j4LgmCdryzMNR2bzQxcuOwYqddcfVr94UzpqD1wbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9V7cru4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9V7cru4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13883C4CEF1;
	Mon, 27 Oct 2025 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761550237;
	bh=6QYQBykKnq8P8i6JcyqUW4Tdtn9vg7PGX0fLf5OLFig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9V7cru4M8KrUrUl/ltq2NyjpAlmVtUbNbUtUeEv8pzqOHeLLvE5xa1/csfxJjFAN
	 L6ulWX5NAvgD398DuLkQDP2a4tjgUZWosvXGZEBt/FhNEB6D/n44+89tW8pEPXZZmr
	 NESiSO8Wm5pWxHyXH5t9gSCZlvJzGisvYfy85+Ksl6osa2vr3cYwWy9/K2X4p5qVjX
	 I+FiGXmXdkbRDyZCq5nLc3t3IUELurslLBQdBYBeNA2kkzZ4JHXUo23BO8ur26+E4l
	 o/70nO1P3vqfh+mTQLYeIe5V41RaRHkK7DS8f9PRkEq1U/A0WtezokD8gZYKQSbbLY
	 IKNrCzSS50MKw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/2] nvme-pci: migrate to dma_map_phys instead of map_page
Date: Mon, 27 Oct 2025 09:30:20 +0200
Message-ID: <20251027-block-with-mmio-v3-1-ac3370e1f7b7@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c      |  4 ++--
 drivers/nvme/host/pci.c | 25 +++++++++++++------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 449950029872..4ba7b0323da4 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
-	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
-			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
+			rq_dma_dir(req), 0);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f0..002412431940 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -685,20 +685,20 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
-static void nvme_free_prps(struct request *req)
+static void nvme_free_prps(struct request *req, unsigned int attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	unsigned int i;
 
 	for (i = 0; i < iod->nr_dma_vecs; i++)
-		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
-				iod->dma_vecs[i].len, rq_dma_dir(req));
+		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+			       iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
 static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
-		struct nvme_sgl_desc *sg_list)
+		struct nvme_sgl_desc *sg_list, unsigned int attrs)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	enum dma_data_direction dir = rq_dma_dir(req);
@@ -707,13 +707,14 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
 	unsigned int i;
 
 	if (sge->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
-		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sge->addr), len, dir,
+			       attrs);
 		return;
 	}
 
 	for (i = 0; i < len / sizeof(*sg_list); i++)
-		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-			le32_to_cpu(sg_list[i].length), dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir, attrs);
 }
 
 static void nvme_unmap_metadata(struct request *req)
@@ -734,10 +735,10 @@ static void nvme_unmap_metadata(struct request *req)
 	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
 					iod->meta_total_len)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
-			nvme_free_sgls(req, sge, &sge[1]);
+			nvme_free_sgls(req, sge, &sge[1], 0);
 		else
-			dma_unmap_page(dma_dev, iod->meta_dma,
-				       iod->meta_total_len, dir);
+			dma_unmap_phys(dma_dev, iod->meta_dma,
+				       iod->meta_total_len, dir, 0);
 	}
 
 	if (iod->meta_descriptor)
@@ -762,9 +763,9 @@ static void nvme_unmap_data(struct request *req)
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, iod->descriptors[0],
-				       &iod->cmd.common.dptr.sgl);
+				       &iod->cmd.common.dptr.sgl, 0);
 		else
-			nvme_free_prps(req);
+			nvme_free_prps(req, 0);
 	}
 
 	if (iod->nr_descriptors)

-- 
2.51.0

