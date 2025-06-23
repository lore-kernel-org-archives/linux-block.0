Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395C145FE8
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688002; cv=none; b=C0V52gP8IRNh5UqiH92s+wlqfxsfhNAMsGiNDtM7FjNkKOe2MyJlDtZhqVjFF04ikTmYLppj8LG332BA2wWoxPRJSkSpBeWzWfAucYKFOaYRq9HmvTaD9OrCvjM5DCTinr+NqyMSCMcL0zXW4YZS0j+o0FlotyZ702KM4A7X99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688002; c=relaxed/simple;
	bh=8os++eIhHeyGHzhJzfzkKKZzak9xYNRdb+nVZNdjXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr5fp9KScl6jUeXLo+1VVQJ5RfHtmtIiYVOkOcC40YfA6NwymeJgz6NSqsVxmwpin0rNx82ZD0MG5T1a7+aAlOrkyJTpuELU7SkhgCyaFk/3k2gqu3yoz8z4YPijugq3vkU43k/sgfH8J1Rdkgp37zGHXtZ0jECdtsolJXzGqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wpZ2FCdd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wpZ2FCdd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O2klEYS6LRCe986Y9dqzmTH5gzHrPAANMX8M1PU8CaY=; b=wpZ2FCddKBYxHw6ujFFEBFI+B+
	GxzHsgcwQYopixiePXXHmlJYkjCoMJ7nDgJ1zKifSIH9soJTl5DUMN6WJZmW/Vteg0e2d6mjI3P1V
	P5yWIQ4DjGK5pClazUZxFosJWM6y4RT9blWU+CV8Ztr6SxnWIuRz/DjDEs3DFWFFOCX5/zP7mD/2u
	iVEGg+ZXHOKLnyZ5uXRxhL3UVKFJVG9NuiPcRif5APzrp5VUdCQYkOerYqN5yNkLn+cNf+NgZW//q
	daH9Eej1os4d8ocQR1YvmVYu2a9pi7EvQDFz/RnI/V7YEcWXD2x1EEiLt00F2Zb6SDOY3aN9WbiL1
	TJh2IYFg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThvB-00000002zqE-3SHJ;
	Mon, 23 Jun 2025 14:13:18 +0000
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
	linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 5/8] nvme-pci: remove superfluous arguments
Date: Mon, 23 Jun 2025 16:12:27 +0200
Message-ID: <20250623141259.76767-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
References: <20250623141259.76767-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The call chain in the prep_rq and completion paths passes around a lot
of nvme_dev, nvme_queue and nvme_command arguments that can be trivially
derived from the passed in struct request.  Remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 105 +++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f7c43eeefb26..79114fa034d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -584,9 +584,11 @@ enum nvme_use_sgl {
 	SGL_FORCED,
 };
 
-static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
-					      struct request *req)
+static inline bool nvme_pci_metadata_use_sgls(struct request *req)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+
 	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
 		return false;
 	return req->nr_integrity_segments > 1 ||
@@ -624,8 +626,9 @@ static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
 	return nvmeq->descriptor_pools.large;
 }
 
-static void nvme_free_descriptors(struct nvme_queue *nvmeq, struct request *req)
+static void nvme_free_descriptors(struct request *req)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	dma_addr_t dma_addr = iod->first_dma;
@@ -647,22 +650,22 @@ static void nvme_free_descriptors(struct nvme_queue *nvmeq, struct request *req)
 	}
 }
 
-static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_queue *nvmeq,
-			    struct request *req)
+static void nvme_unmap_data(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
 	if (iod->dma_len) {
-		dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
+		dma_unmap_page(nvmeq->dev->dev, iod->first_dma, iod->dma_len,
 			       rq_dma_dir(req));
 		return;
 	}
 
 	WARN_ON_ONCE(!iod->sgt.nents);
 
-	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-	nvme_free_descriptors(nvmeq, req);
-	mempool_free(iod->sgt.sgl, dev->iod_mempool);
+	dma_unmap_sgtable(nvmeq->dev->dev, &iod->sgt, rq_dma_dir(req), 0);
+	nvme_free_descriptors(req);
+	mempool_free(iod->sgt.sgl, nvmeq->dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
@@ -679,10 +682,10 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 	}
 }
 
-static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
-		struct request *req, struct nvme_rw_command *cmnd)
+static blk_status_t nvme_pci_setup_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	int length = blk_rq_payload_bytes(req);
 	struct scatterlist *sg = iod->sgt.sgl;
 	int dma_len = sg_dma_len(sg);
@@ -751,11 +754,11 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 		dma_len = sg_dma_len(sg);
 	}
 done:
-	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sgt.sgl));
-	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
+	iod->cmd.common.dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sgt.sgl));
+	iod->cmd.common.dptr.prp2 = cpu_to_le64(iod->first_dma);
 	return BLK_STS_OK;
 free_prps:
-	nvme_free_descriptors(nvmeq, req);
+	nvme_free_descriptors(req);
 	return BLK_STS_RESOURCE;
 bad_sgl:
 	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
@@ -780,10 +783,10 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
-static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
-		struct request *req, struct nvme_rw_command *cmd)
+static blk_status_t nvme_pci_setup_sgls(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sg = iod->sgt.sgl;
 	unsigned int entries = iod->sgt.nents;
@@ -791,10 +794,10 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 	int i = 0;
 
 	/* setting the transfer type as SGL */
-	cmd->flags = NVME_CMD_SGL_METABUF;
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1) {
-		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
+		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, sg);
 		return BLK_STS_OK;
 	}
 
@@ -808,7 +811,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 	iod->descriptors[iod->nr_descriptors++] = sg_list;
 	iod->first_dma = sgl_dma;
 
-	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
+	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, entries);
 	do {
 		nvme_pci_sgl_set_data(&sg_list[i++], sg);
 		sg = sg_next(sg);
@@ -855,11 +858,11 @@ static blk_status_t nvme_pci_setup_data_simple(struct request *req,
 	return BLK_STS_OK;
 }
 
-static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
-		struct nvme_command *cmnd)
+static blk_status_t nvme_map_data(struct request *req)
 {
-	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
 	enum nvme_use_sgl use_sgl = nvme_pci_use_sgls(dev, req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
@@ -890,9 +893,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (use_sgl == SGL_FORCED ||
 	    (use_sgl == SGL_SUPPORTED &&
 	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
-		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
+		ret = nvme_pci_setup_sgls(req);
 	else
-		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
+		ret = nvme_pci_setup_prps(req);
 	if (ret != BLK_STS_OK)
 		goto out_unmap_sg;
 	return BLK_STS_OK;
@@ -904,12 +907,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return ret;
 }
 
-static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
-					     struct request *req)
+static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_rw_command *cmnd = &iod->cmd.rw;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sgl, *sg;
 	unsigned int entries;
@@ -940,8 +942,8 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 	iod->meta_descriptor = sg_list;
 	iod->meta_dma = sgl_dma;
 
-	cmnd->flags = NVME_CMD_SGL_METASEG;
-	cmnd->metadata = cpu_to_le64(sgl_dma);
+	iod->cmd.common.flags = NVME_CMD_SGL_METASEG;
+	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 
 	sgl = iod->meta_sgt.sgl;
 	if (entries == 1) {
@@ -963,31 +965,30 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 	return BLK_STS_RESOURCE;
 }
 
-static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
-					     struct request *req)
+static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct bio_vec bv = rq_integrity_vec(req);
-	struct nvme_command *cmnd = &iod->cmd;
 
-	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->meta_dma))
+	iod->meta_dma = dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0);
+	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
-	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+	iod->cmd.common.metadata = cpu_to_le64(iod->meta_dma);
 	return BLK_STS_OK;
 }
 
-static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
+static blk_status_t nvme_map_metadata(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
-	    nvme_pci_metadata_use_sgls(dev, req))
-		return nvme_pci_setup_meta_sgls(dev, req);
-	return nvme_pci_setup_meta_mptr(dev, req);
+	    nvme_pci_metadata_use_sgls(req))
+		return nvme_pci_setup_meta_sgls(req);
+	return nvme_pci_setup_meta_mptr(req);
 }
 
-static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
+static blk_status_t nvme_prep_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
@@ -1002,13 +1003,13 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, &iod->cmd);
+		ret = nvme_map_data(req);
 		if (ret)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req);
+		ret = nvme_map_metadata(req);
 		if (ret)
 			goto out_unmap_data;
 	}
@@ -1017,7 +1018,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	return BLK_STS_OK;
 out_unmap_data:
 	if (blk_rq_nr_phys_segments(req))
-		nvme_unmap_data(dev, req->mq_hctx->driver_data, req);
+		nvme_unmap_data(req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
@@ -1042,7 +1043,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
 		return nvme_fail_nonready_command(&dev->ctrl, req);
 
-	ret = nvme_prep_rq(dev, req);
+	ret = nvme_prep_rq(req);
 	if (unlikely(ret))
 		return ret;
 	spin_lock(&nvmeq->sq_lock);
@@ -1080,7 +1081,7 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
 		return false;
 
-	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
+	return nvme_prep_rq(req) == BLK_STS_OK;
 }
 
 static void nvme_queue_rqs(struct rq_list *rqlist)
@@ -1106,11 +1107,11 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 	*rqlist = requeue_list;
 }
 
-static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
-						struct nvme_queue *nvmeq,
-						struct request *req)
+static __always_inline void nvme_unmap_metadata(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
 
 	if (!iod->meta_sgt.nents) {
 		dma_unmap_page(dev->dev, iod->meta_dma,
@@ -1127,14 +1128,10 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
 
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
-	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	struct nvme_dev *dev = nvmeq->dev;
-
 	if (blk_integrity_rq(req))
-		nvme_unmap_metadata(dev, nvmeq, req);
-
+		nvme_unmap_metadata(req);
 	if (blk_rq_nr_phys_segments(req))
-		nvme_unmap_data(dev, nvmeq, req);
+		nvme_unmap_data(req);
 }
 
 static void nvme_pci_complete_rq(struct request *req)
-- 
2.47.2

