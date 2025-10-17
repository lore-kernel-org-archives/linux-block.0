Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017D33468F;
	Fri, 17 Oct 2025 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679135; cv=none; b=fqQK4trfAjlsC2/bQbbqwUBr9V9kKUoEjcdG0+8l2nDanCqieH7aNNZMc6EZ2N37xAz5aA2+5tSISOxhoiJIsQ/XMRd9vU4CJ2ZJP0fGcCLg0igKQ04MvfNaHOcOfhl1l3Fj3P8keM05ZuOd0sxOaIORmQERaBOMXgmtcTxI68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679135; c=relaxed/simple;
	bh=OpQMzB0nbAikwEUSyrTHgexMEqRPz+w6Ig5EcaTjQpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gm19Q5a30pwPr/bsWmenNKz1T5XX+2ePp/jvfDVIBmG1cBeGsVNHDwHSfHubC+6Rf6P9FpSaeGJnBqq7tt+bGfJbt5ItMGo76gWopJ23Bjf51d/tzIpQQjpn8NcgDp0Qt6iXn5/2Pgolu10PQ4RtmYCq5RgyWp6U2x7xEOBynQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUM1GpBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUM1GpBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE324C4CEE7;
	Fri, 17 Oct 2025 05:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679134;
	bh=OpQMzB0nbAikwEUSyrTHgexMEqRPz+w6Ig5EcaTjQpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUM1GpBbrGzpY2Jrl/xtzB5Oyh5OU5OZdGN6XE9sfqSsGy+oMMYeIMxzWEY/2MT8l
	 AnKE4QXwhdS6vBhSTQ2rCLKYgXDwDJFDdNM2h1sMyY1VR+lXBCALudTSZFR/cyvBmH
	 +N2bE33Mk6vxd5NZ+cu+R5uQ3wtPS9fkVX0SIDaXalkclSzIlht+HNmq3fY/vSH5qn
	 CaZk8595crpdBFs7AAV/TcbtdqWHqfMEhVSINA2AALZDJ6iYGiu+cHe8d3SOsjNQLg
	 0zaehXlK8KHPSCWUDL4ZkaHKXsCIfUUYYjrUQdaFBAVQh05eDTZvnY6AtcGmmysbNs
	 xT3r46MEIh9Wg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-pci: unmap MMIO pages with appropriate interface
Date: Fri, 17 Oct 2025 08:31:59 +0300
Message-ID: <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
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

