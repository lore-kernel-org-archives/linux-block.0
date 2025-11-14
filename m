Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2926CE25;
	Fri, 14 Nov 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111253; cv=none; b=Mk2rhn+CQIEFoTnQt8ExT8hPiN+umihvAHBsupBDsfWyDQGLE+l8ejlFtPuO7p65rHASwxfLT1FZNnLC19cfh5do2U/p6V0lbc42cff7AO9Spi7YfAkiy1Bw2v3fUoOPzgSb0jjDHrrbPIXtbLvykJSTz3PiaS2mjoggvSyRxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111253; c=relaxed/simple;
	bh=XAljSBhzVRXXRx7yWEGZLYeRpou4+cIza7abgYQhaJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZ/MLg+uDgVqjs174k1BANVHg8G1MnWJjQ53nWiZLotaFZovxzQZIBHjlwui8k4F6kF4HFJmUxIyPiO+qkNQTonxlMMRmzluzP0Gi5MAYNT+eaYdrvuLg/4Zd6oN9U8ptTXKyMCrTvrSnEPF9I1vTwxgenCUum9t/hNMONOgeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYv1kEkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYv1kEkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E57CC116D0;
	Fri, 14 Nov 2025 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111253;
	bh=XAljSBhzVRXXRx7yWEGZLYeRpou4+cIza7abgYQhaJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYv1kEkZTQMkr4WVo4sas7uN1zWsnC4ROmPrQ4VPgVsDNv4H3IemhxcxoW6tV9IRO
	 5Hy44c2Odj76j3xBFBbVCAkrVzr0qZp4Veqat+98mMCPDFhzKJhyExF8gSQu9MEJUT
	 c0jFN3DE63YGbHrJ+EO7tDA+4n8dU8qf9F0RnqBil9c4kq426sf66e5L9+esqEnt/D
	 3H3gWbieqN7+sqjwHLxB5CjsurEM5btrbwgTf0DA+/8PNiz4JrzU+KeUtyZ9TQi+XO
	 kRrNqydWUgqmWYGbBNjYotVBWiUhlUnQO+eeqe28bhH926eqhLqRurDLsWamWpt4GF
	 00Dbym6snqyOg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 2/2] block-dma: properly take MMIO path
Date: Fri, 14 Nov 2025 11:07:04 +0200
Message-ID: <20251114-block-with-mmio-v5-2-69d00f73d766@nvidia.com>
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

In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
MMIO addresses, which require to avoid any memory cache flushing, as
an outcome of the discussion pointed in Link tag below.

In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
treated this as regular page and relied on "struct page" DMA flow.
That flow performs CPU cache flushing, which shouldn't be done here,
and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.

As a solution, let's encode peer-to-peer transaction type in NVMe IOD
flags variable and provide it to blk-mq-dma API.

Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            | 18 +++++++----
 drivers/nvme/host/pci.c       | 73 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/bio-integrity.h |  1 -
 include/linux/blk-integrity.h | 14 ---------
 include/linux/blk-mq-dma.h    | 28 ++++++++---------
 include/linux/blk_types.h     |  2 --
 6 files changed, 90 insertions(+), 46 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index cebfead826ee..e9108ccaf4b0 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -92,8 +92,13 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
+	unsigned int attrs = 0;
+
+	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
+		attrs |= DMA_ATTR_MMIO;
+
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
-			rq_dma_dir(req), 0);
+			rq_dma_dir(req), attrs);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
@@ -108,14 +113,18 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
 	unsigned int mapped = 0;
+	unsigned int attrs = 0;
 	int error;
 
 	iter->addr = state->addr;
 	iter->len = dma_iova_size(state);
 
+	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
+		attrs |= DMA_ATTR_MMIO;
+
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+				vec->len, dir, attrs);
 		if (error)
 			break;
 		mapped += vec->len;
@@ -162,6 +171,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status = BLK_STS_OK;
+	iter->p2pdma.map = PCI_P2PDMA_MAP_NONE;
 
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
@@ -173,10 +183,6 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
 				 phys_to_page(vec.paddr))) {
 	case PCI_P2PDMA_MAP_BUS_ADDR:
-		if (iter->iter.is_integrity)
-			bio_integrity(req->bio)->bip_flags |= BIP_P2P_DMA;
-		else
-			req->cmd_flags |= REQ_P2PDMA;
 		return blk_dma_map_bus(iter, &vec);
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		/*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d0dd836ccdb9..9085bed107fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -260,8 +260,20 @@ enum nvme_iod_flags {
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	= 1U << 2,
 
+	/* Data payload contains p2p memory */
+	IOD_DATA_P2P		= 1U << 3,
+
+	/* Metadata contains p2p memory */
+	IOD_META_P2P		= 1U << 4,
+
+	/* Data payload contains MMIO memory */
+	IOD_DATA_MMIO		= 1U << 5,
+
+	/* Metadata contains MMIO memory */
+	IOD_META_MMIO		= 1U << 6,
+
 	/* Metadata using non-coalesced MPTR */
-	IOD_SINGLE_META_SEGMENT	= 1U << 5,
+	IOD_SINGLE_META_SEGMENT	= 1U << 7,
 };
 
 struct nvme_dma_vec {
@@ -733,10 +745,12 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
 static void nvme_unmap_metadata(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	enum pci_p2pdma_map_type map = PCI_P2PDMA_MAP_NONE;
 	enum dma_data_direction dir = rq_dma_dir(req);
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct device *dma_dev = nvmeq->dev->dev;
 	struct nvme_sgl_desc *sge = iod->meta_descriptor;
+	unsigned int attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_META_SEGMENT) {
 		dma_unmap_page(dma_dev, iod->meta_dma,
@@ -745,13 +759,20 @@ static void nvme_unmap_metadata(struct request *req)
 		return;
 	}
 
-	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-					iod->meta_total_len)) {
+	if (iod->flags & IOD_META_P2P)
+		map = PCI_P2PDMA_MAP_BUS_ADDR;
+	else if (iod->flags & IOD_META_MMIO) {
+		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
+		attrs |= DMA_ATTR_MMIO;
+	}
+
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+			      iod->meta_total_len, map)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
-			nvme_free_sgls(req, sge, &sge[1], 0);
+			nvme_free_sgls(req, sge, &sge[1], attrs);
 		else
 			dma_unmap_phys(dma_dev, iod->meta_dma,
-				       iod->meta_total_len, dir, 0);
+				       iod->meta_total_len, dir, attrs);
 	}
 
 	if (iod->meta_descriptor)
@@ -761,9 +782,11 @@ static void nvme_unmap_metadata(struct request *req)
 
 static void nvme_unmap_data(struct request *req)
 {
+	enum pci_p2pdma_map_type map = PCI_P2PDMA_MAP_NONE;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct device *dma_dev = nvmeq->dev->dev;
+	unsigned int attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
@@ -773,12 +796,20 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
 
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
+	if (iod->flags & IOD_DATA_P2P)
+		map = PCI_P2PDMA_MAP_BUS_ADDR;
+	else if (iod->flags & IOD_DATA_MMIO) {
+		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
+		attrs |= DMA_ATTR_MMIO;
+	}
+
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
+			      map)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, iod->descriptors[0],
-				       &iod->cmd.common.dptr.sgl, 0);
+				       &iod->cmd.common.dptr.sgl, attrs);
 		else
-			nvme_free_prps(req, 0);
+			nvme_free_prps(req, attrs);
 	}
 
 	if (iod->nr_descriptors)
@@ -1049,6 +1080,19 @@ static blk_status_t nvme_map_data(struct request *req)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
 
+	switch (iter.p2pdma.map) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		iod->flags |= IOD_DATA_P2P;
+		break;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		iod->flags |= IOD_DATA_MMIO;
+		break;
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	default:
+		return BLK_STS_RESOURCE;
+	}
+
 	if (use_sgl == SGL_FORCED ||
 	    (use_sgl == SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
@@ -1071,6 +1115,19 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 						&iod->meta_dma_state, &iter))
 		return iter.status;
 
+	switch (iter.p2pdma.map) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		iod->flags |= IOD_META_P2P;
+		break;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		iod->flags |= IOD_META_MMIO;
+		break;
+	case PCI_P2PDMA_MAP_NONE:
+		break;
+	default:
+		return BLK_STS_RESOURCE;
+	}
+
 	if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
 		entries = 1;
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 3d05296a5afe..21e4652dcfd2 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -13,7 +13,6 @@ enum bip_flags {
 	BIP_CHECK_GUARD		= 1 << 5, /* guard check */
 	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
-	BIP_P2P_DMA		= 1 << 8, /* using P2P address */
 
 	BIP_MEMPOOL		= 1 << 15, /* buffer backed by mempool */
 };
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c2030fd8ba0a..a6b84206eb94 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -33,14 +33,6 @@ static inline bool queue_limits_stack_integrity_bdev(struct queue_limits *t,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 
-static inline bool blk_rq_integrity_dma_unmap(struct request *req,
-		struct device *dma_dev, struct dma_iova_state *state,
-		size_t mapped_len)
-{
-	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA);
-}
-
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
@@ -129,12 +121,6 @@ static inline int blk_rq_map_integrity_sg(struct request *q,
 {
 	return 0;
 }
-static inline bool blk_rq_integrity_dma_unmap(struct request *req,
-		struct device *dma_dev, struct dma_iova_state *state,
-		size_t mapped_len)
-{
-	return false;
-}
 static inline int blk_rq_integrity_map_user(struct request *rq,
 					    void __user *ubuf,
 					    ssize_t bytes)
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 51829958d872..cb88fc791fbd 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -16,13 +16,13 @@ struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
 	u32				len;
+	struct pci_p2pdma_map_state	p2pdma;
 
 	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
 	blk_status_t			status;
 
 	/* Internal to blk_rq_dma_map_iter_* */
 	struct blk_map_iter		iter;
-	struct pci_p2pdma_map_state	p2pdma;
 };
 
 bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
@@ -43,36 +43,34 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
 }
 
 /**
- * blk_dma_unmap - try to DMA unmap a request
+ * blk_rq_dma_unmap - try to DMA unmap a request
  * @req:	request to unmap
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
- * @is_p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @map:	peer-to-peer mapping type
  *
  * Returns %false if the callers need to manually unmap every DMA segment
  * mapped using @iter or %true if no work is left to be done.
  */
-static inline bool blk_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
+static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
+		struct dma_iova_state *state, size_t mapped_len,
+		enum pci_p2pdma_map_type map)
 {
-	if (is_p2p)
+	if (map == PCI_P2PDMA_MAP_BUS_ADDR)
 		return true;
 
 	if (dma_use_iova(state)) {
+		unsigned int attrs = 0;
+
+		if (map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
+			attrs |= DMA_ATTR_MMIO;
+
 		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
-				 0);
+				 attrs);
 		return true;
 	}
 
 	return !dma_need_unmap(dma_dev);
 }
-
-static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
-{
-	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-				req->cmd_flags & REQ_P2PDMA);
-}
-
 #endif /* BLK_MQ_DMA_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 53501ebb0623..d884cc1256ec 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -393,7 +393,6 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
-	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -426,7 +425,6 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
-#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 

-- 
2.51.1

