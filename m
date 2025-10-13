Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F830F7F1;
	Mon, 13 Oct 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369677; cv=none; b=Z8uAX1YKTtoZN/s8Afjt8tY9ju4dgeGXe2hMNG5t9lJ2RoE4gvrJP5LbxZH8GBlWRzZhe/q+9WbX9CoEemMTVvkuQpc1jYLw+12QahwYJfCdUyaA5Y+avs0757Vho3uwG8luD5uhmXXQL3+YmlW19/3hDzDqJA7etVPfXb2tc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369677; c=relaxed/simple;
	bh=cTfVUlcIZmB2VTW1tCVb8Ovby/1S+8U9GtrGTaQ5l08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFKFaS7cSXnvht/zLOTy6Te+pXt6FsB1g/tgrQCG1/sVBKFPzqtyxxtAaW0T3scyAGFxe+3hiAa8tHT5uCHkeMjR0rQid0n2xWxj7ur5PsA7HeCPw62YhG/o0C2oty1GiQTuwyjrz2Sg9DFpcuO4eYhjQyHjoLTf58yexZjbaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXU+QPQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXU+QPQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108DAC4CEE7;
	Mon, 13 Oct 2025 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369676;
	bh=cTfVUlcIZmB2VTW1tCVb8Ovby/1S+8U9GtrGTaQ5l08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXU+QPQhMsdd3GMO5wxISxbQdnoHt4rFW9wze89jVxeWTZO8xSkdGVK/A2amY9VVk
	 +hEf3LfvGn3znYRQpFXnXtdeWt/DeFXzCnIB5gKUr/uJeMMsR+IM3d43T8NbSJ8ats
	 XhAvnsmtLk+cAQCOeSHjpM94vBWbkUjmKOqf7ipzrL7Y6PBBROo0ZnMC5rImj1fXkB
	 kys909uRqRTmgUs8Z5nKOy1rHy1TqNDLnP2OrzSE/flEUn8ajRP2t2EUq/+ivs19de
	 E5+CbZKAnwPaTQbrywVVwzVorrNNoPJbTX0kCBOdBnsvglahM45Fiu6lC2RwDNkRDl
	 hHdfbA5P5/5Nw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 4/4] nvme-pci: unmap MMIO pages with appropriate interface
Date: Mon, 13 Oct 2025 18:34:12 +0300
Message-ID: <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760369219.git.leon@kernel.org>
References: <cover.1760369219.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Block layer maps MMIO memory through dma_map_phys() interface
with help of DMA_ATTR_MMIO attribute. There is a need to unmap
that memory with the appropriate unmap function, something which
wasn't possible before adding new REQ attribute to block layer in
previous patch.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f0..2e9fb3c7bc09 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -689,11 +689,15 @@ static void nvme_free_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	unsigned int attrs = 0;
 	unsigned int i;
 
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	for (i = 0; i < iod->nr_dma_vecs; i++)
-		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
-				iod->dma_vecs[i].len, rq_dma_dir(req));
+		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+				iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
@@ -704,16 +708,20 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
 	enum dma_data_direction dir = rq_dma_dir(req);
 	unsigned int len = le32_to_cpu(sge->length);
 	struct device *dma_dev = nvmeq->dev->dev;
+	unsigned int attrs = 0;
 	unsigned int i;
 
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	if (sge->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
-		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sge->addr), len, dir, attrs);
 		return;
 	}
 
 	for (i = 0; i < len / sizeof(*sg_list); i++)
-		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-			le32_to_cpu(sg_list[i].length), dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir, attrs);
 }
 
 static void nvme_unmap_metadata(struct request *req)
-- 
2.51.0

