Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8F2F49F7;
	Sat, 15 Nov 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763223781; cv=none; b=L3d6pWl0nf6iwgD6g+rjgcKfjxVGuQrFjn+9qt7kNAk3gC5vXFYN2u6YVacClCBlRohnT31zVMOyJ+6VjGaVfSUdTFOMFVOFe0GCdQ+RYnEGCS3TTjvZ78ET7w3nnHGB8C3jj1nSoYyy0O6Te9iJjS50Y1QAuxcZM1SNXgUXHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763223781; c=relaxed/simple;
	bh=+Zit3IUi3+3qp/xyVCn+u9DD0OS8MW7uZRmMOI9ajMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRkDObYn7JqiuT0qwtbCHJm8/qzFnnvUUJa9wWwav6oCE+zKbolOotxQzkce67q3j9e4D9Vreqg9mgFA9VRnkuka53gfiLZsW/44bRFfYPfdSig3+mwKHVOpC00RDYnkLJsESz7BsJ38ypWXJggg552a2ybEaPAd1YiH79MkFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSGB27sz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSGB27sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F7FC4CEF5;
	Sat, 15 Nov 2025 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763223779;
	bh=+Zit3IUi3+3qp/xyVCn+u9DD0OS8MW7uZRmMOI9ajMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eSGB27szIAE3fn8b9ZrkODZBIUdtMbn+ErVuNHYBzwNID79f2CsTtXZ6jwAzJNmwn
	 BJQQD2+qzLMge4r0212cKwCsGuZeo1WJkBQM/ltKxiMfmRpyLv5Tj/TsAo63VtSy7U
	 aL4ySqfoVAeLSjuXeaPRaOtb1jBT1tRhNRD5ZYWVSkC/jQ54qH47o2wRN4IdsMkrPn
	 /kr3JViKdnvHS1jCWeeuRNiBGq4JRlnMq6nbyGEppY4NFfKlgbuO34J6Qg7RDsat7H
	 7dkrzzPS6CLjcZwWLV0ftQidim7wVp+a0CuCJuJFA/aeCmexLRKZyuJ+ygjSz8y29A
	 N+DBgRq6SHO/g==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle larger sizes
Date: Sat, 15 Nov 2025 18:22:45 +0200
Message-ID: <20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
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

This patch changes the length variables from unsigned int to size_t.
Using size_t ensures that we can handle larger sizes, as size_t is
always equal to or larger than the previously used u32 type.

Originally, u32 was used because blk-mq-dma code evolved from
scatter-gather implementation, which uses unsigned int to describe length.
This change will also allow us to reuse the existing struct phys_vec in places
that don't need scatter-gather.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c      | 14 +++++++++-----
 drivers/nvme/host/pci.c |  4 ++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index e9108ccaf4b0..cc3e2548cc30 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -8,7 +8,7 @@
 
 struct phys_vec {
 	phys_addr_t	paddr;
-	u32		len;
+	size_t		len;
 };
 
 static bool __blk_map_iter_next(struct blk_map_iter *iter)
@@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 		struct phys_vec *vec)
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
-	unsigned int mapped = 0;
 	unsigned int attrs = 0;
+	size_t mapped = 0;
 	int error;
 
 	iter->addr = state->addr;
@@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 	blk_rq_map_iter_init(rq, &iter);
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
-		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
-				offset_in_page(vec.paddr));
+
+		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
+		sg_set_page(*last_sg, phys_to_page(vec.paddr),
+			    (unsigned int)vec.len, offset_in_page(vec.paddr));
 		nsegs++;
 	}
 
@@ -416,7 +418,9 @@ int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
 
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		sg = blk_next_sg(&sg, sglist);
-		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
+
+		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
+		sg_set_page(sg, phys_to_page(vec.paddr), (unsigned int)vec.len,
 				offset_in_page(vec.paddr));
 		segments++;
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9085bed107fd..de512efa742d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -290,14 +290,14 @@ struct nvme_iod {
 	u8 flags;
 	u8 nr_descriptors;
 
-	unsigned int total_len;
+	size_t total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 	struct nvme_dma_vec *dma_vecs;
 	unsigned int nr_dma_vecs;
 
 	dma_addr_t meta_dma;
-	unsigned int meta_total_len;
+	size_t meta_total_len;
 	struct dma_iova_state meta_dma_state;
 	struct nvme_sgl_desc *meta_descriptor;
 };

-- 
2.51.1

