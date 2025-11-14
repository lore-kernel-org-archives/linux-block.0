Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF07305E01;
	Fri, 14 Nov 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111257; cv=none; b=guURTpTtuRWGm1YD4TSxvl84ZF23gP1JbOK5R0PnxPhIBxe/T+xmgxMXdJWYTXUPURRlY5Z6xR9nVcn3dz5fAMjanSeG3N4OLmF5KJvRmPXu1o8j3n/QkSgphfp8y6k0YByU6SKsdZ1aYkiOj0Wd5mOZFpq+Bj1w+JSYZ2NLR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111257; c=relaxed/simple;
	bh=YaWZXYmXx+PhMXWHJqf6Jb8nEtJj1VHDpaFRLnqYjvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDAXm6HM8ZwBG1viYNtmopQ9tZcx/PUhlnwAAPza6Ihdg3qgf3muo4Fk7WS67mwnWuoPYIjkSYHqu7S8yc/JhziGfj8LBh3Zkw3yb1ec32fpiXqDjYIw6Pv5Usrh4E55EVCi9pxn+yBCBqzvYbONjOhVyvbNlt9ZtP0EUvcC7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNGg7Jar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNGg7Jar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED82C116D0;
	Fri, 14 Nov 2025 09:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111256;
	bh=YaWZXYmXx+PhMXWHJqf6Jb8nEtJj1VHDpaFRLnqYjvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNGg7Jarpo+tHGgf0g22G5KMf9LnRtGr39pGZUWgp6zcKGCHePuEyXMZsMDF7RjbX
	 czmei7aZNKsVbc0kzTpgWcSxdALqakUGrBKCRfv/1bSL8ls393PZWhiw+sKkfHoHrH
	 HbwGBNK3Z9Z7JBQiwRjIBwCUALstMYGyGeGfJ1HDS2tP/N6o44tN8ZIWToQz+AKzWB
	 WI3JNw42CDv9vvVOoZsdTtG3we7m1FE/OzfusjC3P3c3/fZrn3xDNPWXSdQdA458CY
	 xj450VBSsYcNOByZBeY7uXgzzLBqk+LJBY0WPf0pGd50F6ZMc+H6wCZ1XljquGO1a6
	 v757mRpfm4CiA==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 1/2] nvme-pci: migrate to dma_map_phys instead of map_page
Date: Fri, 14 Nov 2025 11:07:03 +0200
Message-ID: <20251114-block-with-mmio-v5-1-69d00f73d766@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
References: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c      |  4 ++--
 drivers/nvme/host/pci.c | 25 +++++++++++++------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index b4f456472961..cebfead826ee 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -92,8 +92,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
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
index 3c1727df1e36..d0dd836ccdb9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -698,20 +698,20 @@ static void nvme_free_descriptors(struct request *req)
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
@@ -720,13 +720,14 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
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
@@ -747,10 +748,10 @@ static void nvme_unmap_metadata(struct request *req)
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
@@ -775,9 +776,9 @@ static void nvme_unmap_data(struct request *req)
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
2.51.1

