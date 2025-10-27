Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88B35B123;
	Mon, 27 Oct 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550241; cv=none; b=HQjDc1POF2JMLzK9dEJ7oqTQTz/qxzsDDYdFwh5phWHsCTs+89/3HX/dQV8AfVMFRYbDGV6K+8+FhrbTK3Mo16M2dPZ9OgwFnsNpVp2sjLMozL28MoqSTJIKGAt513Igk4XkEn/l4S+n05YyjATzO3uLGLfZvvIFU2esCUt4ATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550241; c=relaxed/simple;
	bh=2ke4z9bNwHMWYxREi2Oir/9XIOuSflOgB7DZwpltV7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQkKvZBMWnw0xX2rn4C2kirzyfbmvpo4dkhLUsAYAWDHgHlavplqwGvdQXFVQHO7ghg9ENUPpIIYGo38SPpFJX6etmFodFAy51OoYOvGimJrlKPHJfGbSvyCYiVyoBf4CJ2Wj1ostAqPhbGgkMBdnoA88U1VeWIuU270OCAQhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVqcye6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVqcye6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42338C4CEF1;
	Mon, 27 Oct 2025 07:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761550241;
	bh=2ke4z9bNwHMWYxREi2Oir/9XIOuSflOgB7DZwpltV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVqcye6EeZARpQvFJF1/Yh0rgpiyGxSvfi87/Uxootps22b9ESQxHFVFRmWarRONg
	 /eYW5W68WLUdPZ5f2X5LMidl7Lqw/1SsAxFXyuUQDz1y1qX5as2LwFvi5XpQEKDtne
	 +WMUHH5yZJCV7xD2ZLu44TDlhfawrmBlPo9dm+DUcgxursVKgUryH/U5gRckFcNY0h
	 13wEBF3L5/+6PDDcWYePZMBKohVHncQa0jUmFP4ST7YXsbeBMMk7RdQ1MpsbSG3TZk
	 7F8ThINt+aWSEp2R5Y3cR47Yfcy8Uqnyxv1Yf185A/5w+1H4f8P2koWPitpRcTqwbK
	 zDWFQuKaicUvA==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/2] block-dma: properly take MMIO path
Date: Mon, 27 Oct 2025 09:30:21 +0200
Message-ID: <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
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
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            | 17 +++++++----
 drivers/nvme/host/pci.c       | 69 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/bio-integrity.h |  1 -
 include/linux/blk-integrity.h | 14 ---------
 include/linux/blk-mq-dma.h    | 28 ++++++++----------
 include/linux/blk_types.h     |  2 --
 6 files changed, 85 insertions(+), 46 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 4ba7b0323da4..98554929507a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,13 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
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
@@ -109,14 +114,18 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
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
@@ -174,10 +183,6 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
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
index 002412431940..dbf1a924d7bf 100644
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
@@ -720,10 +732,12 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
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
@@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
 		return;
 	}
 
-	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-					iod->meta_total_len)) {
+	if (iod->flags & IOD_META_P2P)
+		map = PCI_P2PDMA_MAP_BUS_ADDR;
+	if (iod->flags & IOD_META_MMIO) {
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
@@ -748,9 +769,11 @@ static void nvme_unmap_metadata(struct request *req)
 
 static void nvme_unmap_data(struct request *req)
 {
+	enum pci_p2pdma_map_type map = PCI_P2PDMA_MAP_NONE;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct device *dma_dev = nvmeq->dev->dev;
+	unsigned int attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
@@ -760,12 +783,20 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
 
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
+	if (iod->flags & IOD_DATA_P2P)
+		map = PCI_P2PDMA_MAP_BUS_ADDR;
+	if (iod->flags & IOD_DATA_MMIO) {
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
@@ -1036,6 +1067,17 @@ static blk_status_t nvme_map_data(struct request *req)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
 
+	switch (iter.p2pdma.map) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		iod->flags |= IOD_DATA_P2P;
+		break;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		iod->flags |= IOD_DATA_MMIO;
+		break;
+	default:
+		return BLK_STS_RESOURCE;
+	}
+
 	if (use_sgl == SGL_FORCED ||
 	    (use_sgl == SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
@@ -1058,6 +1100,17 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 						&iod->meta_dma_state, &iter))
 		return iter.status;
 
+	switch (iter.p2pdma.map) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		iod->flags |= IOD_META_P2P;
+		break;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		iod->flags |= IOD_META_MMIO;
+		break;
+	default:
+		return BLK_STS_RESOURCE;
+	}
+
 	if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
 		entries = 1;
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 851254f36eb3..0a25716820fe 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -13,7 +13,6 @@ enum bip_flags {
 	BIP_CHECK_GUARD		= 1 << 5, /* guard check */
 	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
-	BIP_P2P_DMA		= 1 << 8, /* using P2P address */
 };
 
 struct bio_integrity_payload {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b659373788f6..b9e6376b5e36 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -28,14 +28,6 @@ static inline bool queue_limits_stack_integrity_bdev(struct queue_limits *t,
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
@@ -124,12 +116,6 @@ static inline int blk_rq_map_integrity_sg(struct request *q,
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
index 8e8d1cc8b06c..1f8e429c4c77 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -381,7 +381,6 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
-	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -414,7 +413,6 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
-#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 

-- 
2.51.0

