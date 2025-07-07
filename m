Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4028FFE6
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892762; cv=none; b=MbGIB3FyjzlFHt48MVbcq5KXpUXMu6GDiTu9xfwmQAs1tCsSn30hxX0VEOp5dSh6Hs2tm889cuWEJvJ78Nsg4f8jZeHVMMtN9QWzewB+HhMJv/9dV2CbU7DxYh6aN6K135Lu6AIv69Z05t8fXGuKlAjYqZaoPYPxmAZ9U5pua2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892762; c=relaxed/simple;
	bh=hpVwAXHPRr1nNPk84ET2dNIZTA9CBJm2PlyJxB4PwmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtYX5En1Li0ubeuoiSHnC4Rq5sHhXWnu73WseUlQv+reS4/xgJGeSR3NgpzLkilrkij79YNfxYN0kUqHpCMGf1RGLKP32I0cRvwQrLbniuhYPC9B3NmstZV9/4I7NNaC4cKmlRKMxyPDL0giDFfcxH7f8ukX6+3Mt+JFhTN1aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYRrLAxQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYRrLAxQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Yl4rSAtWm2DohyKC+WSCG8lQ0N5zr3M1Nf2Xp8x9Q7E=; b=AYRrLAxQNOW4FZqPl4FSzhS0lD
	HqM8AcsSAvvfNAwof3+gY2jlOmp0mTokNzKQou2XYtY3/3Z+GLY3C70ZWqQlzI2ZgWZBrXrj8zY94
	iHcfCDo/YKdE7iLaa1rjPV0grhXl1tDSnJHqhcC47B325pNNsHIHMa+yPeVhiXn4f2OUBMPmWEjQU
	XEoADLW4FR4SBhfLKBlD2fMvOqp2M+/VEZLoalS8x0K7lEhJJ8KRDWjCte0gPHWIzdcVOo1dG8ISM
	7y+6+vr4LhHum3oBI396U1JbJv2OWDWeyfkX0h/roVZiz2zHY025kTfxNg1DUddHcOD48R4oCrUrl
	5eT4TWoQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYlKj-00000002SeG-2agf;
	Mon, 07 Jul 2025 12:52:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me
Cc: ben.copeland@linaro.org,
	leon@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping
Date: Mon,  7 Jul 2025 14:52:23 +0200
Message-ID: <20250707125223.3022531-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The current version of the blk_rq_dma_map support in nvme-pci tries to
reconstruct the DMA mappings from the on the wire descriptors if they
are needed for unmapping.  While this is not the case for the direct
mapping fast path and the IOVA path, it is needed for the non-IOVA slow
path, e.g. when using the interconnect is not dma coherent, when using
swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.

While the reconstruction is easy and works fine for the SGL path, where
the on the wire representation maps 1:1 to DMA mappings, the code to
reconstruct the DMA mapping ranges from PRPs can't always work, as a
given PRP layout can come from different DMA mappings, and the current
code doesn't even always get that right.

Give up on this approach and track the actual DMA mapping when actually
needed again.

Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Reported-by: Ben Copeland <ben.copeland@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 114 ++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a7a8bdbf385..6af184f2b73b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -173,6 +173,7 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 
+	mempool_t *dmavec_mempool;
 	mempool_t *iod_meta_mempool;
 
 	/* shadow doorbell buffer support: */
@@ -262,6 +263,11 @@ enum nvme_iod_flags {
 	IOD_SINGLE_SEGMENT	= 1U << 2,
 };
 
+struct nvme_dma_vec {
+	dma_addr_t addr;
+	unsigned int len;
+};
+
 /*
  * The nvme_iod describes the data in an I/O.
  */
@@ -274,6 +280,8 @@ struct nvme_iod {
 	unsigned int total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
+	struct nvme_dma_vec *dma_vecs;
+	unsigned int nr_dma_vecs;
 
 	dma_addr_t meta_dma;
 	struct sg_table meta_sgt;
@@ -674,44 +682,12 @@ static void nvme_free_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	struct device *dma_dev = nvmeq->dev->dev;
-	enum dma_data_direction dir = rq_dma_dir(req);
-	int length = iod->total_len;
-	dma_addr_t dma_addr;
-	int i, desc;
-	__le64 *prp_list;
-	u32 dma_len;
-
-	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
-	dma_len = min_t(u32, length,
-		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	length -= dma_len;
-	if (!length) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		return;
-	}
-
-	if (length <= NVME_CTRL_PAGE_SIZE) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
-		dma_unmap_page(dma_dev, dma_addr, length, dir);
-		return;
-	}
-
-	i = 0;
-	desc = 0;
-	prp_list = iod->descriptors[desc];
-	do {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
-			prp_list = iod->descriptors[++desc];
-			i = 0;
-		}
+	unsigned int i;
 
-		dma_addr = le64_to_cpu(prp_list[i++]);
-		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
-		length -= dma_len;
-	} while (length);
+	for (i = 0; i < iod->nr_dma_vecs; i++)
+		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+				iod->dma_vecs[i].len, rq_dma_dir(req));
+	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
 static void nvme_free_sgls(struct request *req)
@@ -760,6 +736,23 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
 
+static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (iter->len)
+		return true;
+	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
+		return false;
+	if (dma_need_unmap(dma_dev)) {
+		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
+		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
+		iod->nr_dma_vecs++;
+	}
+	return true;
+}
+
 static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -770,6 +763,16 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
+	if (dma_need_unmap(nvmeq->dev->dev)) {
+		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
+				GFP_ATOMIC);
+		if (!iod->dma_vecs)
+			return BLK_STS_RESOURCE;
+		iod->dma_vecs[0].addr = iter->addr;
+		iod->dma_vecs[0].len = iter->len;
+		iod->nr_dma_vecs = 1;
+	}
+
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
 	 *
@@ -786,13 +789,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	if (!length)
 		goto done;
 
-	if (!iter->len) {
-		if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
-				&iod->dma_state, iter)) {
-			if (WARN_ON_ONCE(!iter->status))
-				goto bad_sgl;
-			goto done;
-		}
+	if (!nvme_pci_prp_iter_next(req, nvmeq->dev->dev, iter)) {
+		if (WARN_ON_ONCE(!iter->status))
+			goto bad_sgl;
+		goto done;
 	}
 
 	/*
@@ -831,13 +831,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 		if (!length)
 			break;
 
-		if (iter->len == 0) {
-			if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
-					&iod->dma_state, iter)) {
-				if (WARN_ON_ONCE(!iter->status))
-					goto bad_sgl;
-				goto done;
-			}
+		if (!nvme_pci_prp_iter_next(req, nvmeq->dev->dev, iter)) {
+			if (WARN_ON_ONCE(!iter->status))
+				goto bad_sgl;
+			goto done;
 		}
 
 		/*
@@ -3025,14 +3022,25 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
 	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
+	size_t alloc_size = sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
+
+	dev->dmavec_mempool = mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)alloc_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->dmavec_mempool)
+		return -ENOMEM;
 
 	dev->iod_meta_mempool = mempool_create_node(1,
 			mempool_kmalloc, mempool_kfree,
 			(void *)meta_size, GFP_KERNEL,
 			dev_to_node(dev->dev));
 	if (!dev->iod_meta_mempool)
-		return -ENOMEM;
+		goto free;
 	return 0;
+free:
+	mempool_destroy(dev->dmavec_mempool);
+	return -ENOMEM;
 }
 
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3477,6 +3485,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
+	mempool_destroy(dev->dmavec_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
@@ -3540,6 +3549,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
+	mempool_destroy(dev->dmavec_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
-- 
2.47.2

