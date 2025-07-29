Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366D156C6A
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799710; cv=none; b=TMoQGSJqT6UvY+7Ku/N19MoLCrMrjW50Rp21yYtIj+Zdks+bn/pP+PoXGJK5eEd0T0AKUJMEIjpt9BqqEPETP4uG5RcpvtD5yptSXuIRG8CAzUH5CBH9YZfxIp4/pduTl5E07QOsVGnnGKhw72NTL3g6B/l1oUP4SayAlpnKvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799710; c=relaxed/simple;
	bh=2upsgqeZeycpG4h4M1ABycMwqk0cbDxFxy0dtzZ1Niw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvxtHqI6E0R1w0ihGlnSKVFdSr3F+cseIw1lIy8t9jLls/NeiB92UKCv0lkjqeNxH//979olUiUvLp6OCIR4YvloJFWVvl1DG6YTHrHPtt0LdHQsnWJ+A4mogzznReaACqOLBWN65i4lI4rWkVj9YAPjNOt7T+Efe/+a1zc4RxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NmaLLx2j; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NmaLLx2j"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6Xp3V028948
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tsocgB3H48ZHsbMAlkfUJaUCy9ES4+4B2Ib30xUZmbY=; b=NmaLLx2jXpSc
	ls7iyMahSUxBrPvwPRwvvuonugMAjbfwrllIBSXbgBtmR3FYaybNkd4glJZvPjHR
	c/yh6tnuF1GhsJ1fxY4xjRmkUSiVHMmjIrRTO4vYPlQcTMiXXi10h9wa5EeqIQPH
	7IPyvJE8toT5XC8rkV8J+Ux8UgxRCVRF89sgs/S3twZF9uWCcf4703iV4IJX6fAO
	nG6WuSYAegy2+v50dxCDQGbQQaTUceaGs3OO3zmIFg3FoVc+qpREoRK2t/S4HgYU
	UZguYIj+dINU1YHMy8IWQfEWIMKnUT/A5psAWj8UDGs0IbwnaglfzmWIgN7ifIqN
	+BzCFrdESg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486kevm484-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:07 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id F406A1CC4212; Tue, 29 Jul 2025 07:34:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 7/7] nvme: convert metadata mapping to dma iter
Date: Tue, 29 Jul 2025 07:34:42 -0700
Message-ID: <20250729143442.2586575-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729143442.2586575-1-kbusch@meta.com>
References: <20250729143442.2586575-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2YfJsWsYTZRU974he_ZdPniT4CJrBjdH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX845j51ohTDF0 i6Tv7EN8IYEhat7EKoClNgAcOoG2Qbr9VZ1TB4kUM4h74bPYWBObqd2WhNkvMv7D1Tt63baSuO0 y6bQhyn1dx7jdj8z7PxxY9UPRG2oznKEs4ifhjUHlNXXvxPbMOpLI/ourhtR0YWdBQFAwB7pQxb
 vEoDNo56te+NaGgLfmo6kkwjKViqYNUpZ1q+70N7Z3sD22tVy3l6ABDXJqQphx38U1SiEFfuq/B RCK42B/rPqa/1AkCuuJc1Wz//ikXexXCzgWc7y78fnGhWVk/RP0/vPk1anVLxPaWajpTOttb71q 2qBAJJoC9qP8ih7oSg3OFkbjBy6Hr1x++5Kik+RESIwcvYQq3jwVPqoYG932CLwZiA01+3LIIsX
 ARBzSiNx0wV6082Cvs3VGdSSsqYs1At5bkzRxhjaeTeD/KaF81aTCe4xEqOqu4GslG/Bln3H
X-Authority-Analysis: v=2.4 cv=YN+fyQGx c=1 sm=1 tr=0 ts=6888dc1b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=BRFPTy0GvKBLt4V1GPoA:9
X-Proofpoint-GUID: 2YfJsWsYTZRU974he_ZdPniT4CJrBjdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Aligns data and metadata to the similar dma mapping scheme and removes
one more user of the scatter-gather dma mapping.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 174 +++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 93 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cefa8344f670..6fdc0023c4abb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -172,9 +172,7 @@ struct nvme_dev {
 	u32 last_ps;
 	bool hmb;
 	struct sg_table *hmb_sgt;
-
 	mempool_t *dmavec_mempool;
-	mempool_t *iod_meta_mempool;
=20
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -264,6 +262,12 @@ enum nvme_iod_flags {
=20
 	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
 	IOD_P2P_BUS_ADDR	=3D 1U << 3,
+
+	/* Metadata DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
+	IOD_META_P2P_BUS_ADDR	=3D 1U << 4,
+
+	/* Metadata DMA mapped as a single SGL data segment */
+	IOD_META_SINGLE_SEG	=3D 1U << 5,
 };
=20
 struct nvme_dma_vec {
@@ -281,13 +285,14 @@ struct nvme_iod {
 	u8 nr_descriptors;
=20
 	unsigned int total_len;
+	unsigned int meta_total_len;
 	struct dma_iova_state dma_state;
+	struct dma_iova_state meta_dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 	struct nvme_dma_vec *dma_vecs;
 	unsigned int nr_dma_vecs;
=20
 	dma_addr_t meta_dma;
-	struct sg_table meta_sgt;
 	struct nvme_sgl_desc *meta_descriptor;
 };
=20
@@ -604,8 +609,7 @@ static inline bool nvme_pci_metadata_use_sgls(struct =
request *req)
=20
 	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
 		return false;
-	return req->nr_integrity_segments > 1 ||
-		nvme_req(req)->flags & NVME_REQ_USERCMD;
+	return nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
=20
 static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
@@ -644,6 +648,11 @@ static inline struct dma_pool *nvme_dma_pool(struct =
nvme_queue *nvmeq,
 	return nvmeq->descriptor_pools.large;
 }
=20
+static inline bool nvme_pci_cmd_use_meta_sgl(struct nvme_command *cmd)
+{
+	return (cmd->common.flags & NVME_CMD_SGL_ALL) =3D=3D NVME_CMD_SGL_METAS=
EG;
+}
+
 static inline bool nvme_pci_cmd_use_sgl(struct nvme_command *cmd)
 {
 	return cmd->common.flags &
@@ -1014,93 +1023,65 @@ static blk_status_t nvme_map_data(struct request =
*req)
 	return nvme_pci_setup_data_prp(req, &iter);
 }
=20
-static void nvme_pci_sgl_set_data_sg(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
-{
-	sge->addr =3D cpu_to_le64(sg_dma_address(sg));
-	sge->length =3D cpu_to_le32(sg_dma_len(sg));
-	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
-}
-
-static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
+static blk_status_t nvme_map_metadata(struct request *req)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
+	unsigned int entries =3D req->nr_integrity_segments;
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev =3D nvmeq->dev;
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sgl, *sg;
-	unsigned int entries;
+	struct blk_dma_iter iter;
 	dma_addr_t sgl_dma;
-	int rc, i;
-
-	iod->meta_sgt.sgl =3D mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
-	if (!iod->meta_sgt.sgl)
-		return BLK_STS_RESOURCE;
+	int i;
=20
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
+	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
+						&iod->meta_dma_state, &iter))
+		return iter.status;
=20
-	rc =3D dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
+	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		iod->flags |=3D IOD_META_P2P_BUS_ADDR;
+	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
+		entries =3D 1;
+
+	if (WARN_ON_ONCE(!nvme_ctrl_meta_sgl_supported(&dev->ctrl) &&
+			 entries > 1))
+		return BLK_STS_NOTSUPP;
+
+	if (entries =3D=3D 1 && !nvme_pci_metadata_use_sgls(req)) {
+		iod->cmd.common.metadata =3D cpu_to_le64(iter.addr);
+		iod->meta_total_len =3D iter.len;
+		iod->meta_dma =3D iter.addr;
+		iod->meta_descriptor =3D NULL;
+		return BLK_STS_OK;
+	}
=20
 	sg_list =3D dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
 			&sgl_dma);
 	if (!sg_list)
-		goto out_unmap_sg;
+		return BLK_STS_RESOURCE;
=20
-	entries =3D iod->meta_sgt.nents;
 	iod->meta_descriptor =3D sg_list;
 	iod->meta_dma =3D sgl_dma;
=20
 	iod->cmd.common.flags =3D NVME_CMD_SGL_METASEG;
 	iod->cmd.common.metadata =3D cpu_to_le64(sgl_dma);
=20
-	sgl =3D iod->meta_sgt.sgl;
 	if (entries =3D=3D 1) {
-		nvme_pci_sgl_set_data_sg(sg_list, sgl);
+		iod->flags |=3D IOD_META_SINGLE_SEG;
+		iod->meta_total_len =3D iter.len;
+		nvme_pci_sgl_set_data(sg_list, &iter);
 		return BLK_STS_OK;
 	}
=20
 	sgl_dma +=3D sizeof(*sg_list);
-	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
-	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data_sg(&sg_list[i + 1], sg);
-
-	return BLK_STS_OK;
-
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
-}
-
-static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
-{
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct bio_vec bv =3D rq_integrity_vec(req);
-
-	iod->meta_dma =3D dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0=
);
-	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
-		return BLK_STS_IOERR;
-	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
-	return BLK_STS_OK;
-}
-
-static blk_status_t nvme_map_metadata(struct request *req)
-{
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	i =3D 0;
+	do {
+		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		iod->meta_total_len +=3D iter.len;
+	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
=20
-	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
-	    nvme_pci_metadata_use_sgls(req))
-		return nvme_pci_setup_meta_sgls(req);
-	return nvme_pci_setup_meta_mptr(req);
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
+	return iter.status;
 }
=20
 static blk_status_t nvme_prep_rq(struct request *req)
@@ -1111,7 +1092,6 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1222,23 +1202,44 @@ static void nvme_queue_rqs(struct rq_list *rqlist=
)
 	*rqlist =3D requeue_list;
 }
=20
+static void nvme_free_meta_sgls(struct nvme_iod *iod, struct device *dma=
_dev,
+				enum dma_data_direction dir)
+{
+	struct nvme_sgl_desc *sg_list =3D iod->meta_descriptor;
+	int i, nr_entries;
+
+	if (iod->flags & IOD_META_SINGLE_SEG) {
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list->addr),
+				le32_to_cpu(sg_list->length), dir);
+		return;
+	}
+
+	nr_entries =3D le32_to_cpu(sg_list->length);
+	for (i =3D 1; i <=3D nr_entries; i++)
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir);
+}
+
 static __always_inline void nvme_unmap_metadata(struct request *req)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct device *dma_dev =3D nvmeq->dev->dev;
=20
-	if (!iod->meta_sgt.nents) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
-		return;
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+				iod->meta_total_len,
+				iod->flags & IOD_META_P2P_BUS_ADDR)) {
+		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
+			nvme_free_meta_sgls(iod, dma_dev, dir);
+		else
+			dma_unmap_page(dma_dev, iod->meta_dma,
+				       iod->meta_total_len, dir);
 	}
=20
-	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
-			iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
+	if (iod->meta_descriptor)
+		dma_pool_free(nvmeq->descriptor_pools.small,
+			      iod->meta_descriptor, iod->meta_dma);
 }
=20
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
@@ -3046,7 +3047,6 @@ static int nvme_disable_prepare_reset(struct nvme_d=
ev *dev, bool shutdown)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
-	size_t meta_size =3D sizeof(struct scatterlist) * (NVME_MAX_META_SEGS +=
 1);
 	size_t alloc_size =3D sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
=20
 	dev->dmavec_mempool =3D mempool_create_node(1,
@@ -3055,17 +3055,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
dev *dev)
 			dev_to_node(dev->dev));
 	if (!dev->dmavec_mempool)
 		return -ENOMEM;
-
-	dev->iod_meta_mempool =3D mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)meta_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_meta_mempool)
-		goto free;
 	return 0;
-free:
-	mempool_destroy(dev->dmavec_mempool);
-	return -ENOMEM;
 }
=20
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3515,7 +3505,6 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
@@ -3579,7 +3568,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
--=20
2.47.3

