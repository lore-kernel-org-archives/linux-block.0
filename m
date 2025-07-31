Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7701ADFE4
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974330; cv=none; b=pDr0/KSztAz6nADK5zn034VJXy/NFpjmOjWPhXo6VvIk2sPUf1l0e5Cs8scZ5FL0S3tpFIDGQoyUe4w71bQqEaBEwG51I7P7qnxs812eqfdrcEVcpubg1RTQF7pj9Z8Jb27OmS+sM6L9G/BlEPEnDQCg8r7lqdYmmD9FrP/pwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974330; c=relaxed/simple;
	bh=66sm/xY+OOG5QiA1esM8ySyvWOImHGB/gVA5AZrvrNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMFM+afJy5nSowhRLkYmiTR4dC0VaNbQE7EXRQqzAa+tkrMxsoaUWP4hW5czloEhM7xJV4Z7gDtqyaQ+/l3OPjzfr1aJtq534IdFG3g/4STrPdS13RKKrVggiPV6vRqMV2z36RMI1DNvyKJnRcVYycQGe/2QwX7EMVhu3wyE+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uBI3Xuqy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uBI3Xuqy"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE76r4030010
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jm44b8T/0NNg/2olfz7iQ8K24NiGj2yLF9LeoHs0Rls=; b=uBI3XuqyJMPp
	YsUn0tKVVfOggakaugVoXp22qvUsl9qk1VUkUNTqcJ2FGpUIlxUd1IJdbK7kmjW7
	dSoOGbY/WtiMACzMc9DHs23e9Zx2akYYX79VnECI/HCnKt26wRGAtq1ZHHp0D69H
	DxIfBlfkbtt8jt/QPL7veSCAxoRs7j6JHZTNtFW7ZOjQGkcX9drnVIyBUjjQDSc0
	cFI8diV+xaBfMdmeJ5cmrxbU+yDrnL5jHfv239so2wv7Yt6CQp2MpTT0rVOdrGQx
	aSWXNkWjnnEJ+LMvoQpDCDOqSVAkUULYh7z6UGOFpUnJRhxiJrWBpBwqJHMPOjoL
	ww5zX97jdw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883m52me4-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:27 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:26 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2E994231DB5; Thu, 31 Jul 2025 08:05:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 8/8] nvme-pci: convert metadata mapping to dma iter
Date: Thu, 31 Jul 2025 08:05:13 -0700
Message-ID: <20250731150513.220395-9-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731150513.220395-1-kbusch@meta.com>
References: <20250731150513.220395-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CtGnO2rX2lusddSYJar4LRRHsgrEbI_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfXxu9IboDnJXpP Ea+sQO5PH99uuhlbbjMkJ3wYzA36Abr53Fhx5YutOc4SOHhYOxlcT2kDV4uMFlu0Vj+PycgcEPy fzyRDYfh5Y9usy5hBd1nZNJYYNU2P4OB3Yuz1DEnmSavhfG3iXRW51H45ZzVKfh4FqLqZZOuJ9e
 UaaokBHmiW/nMykXZr/XG3a9AqR6aqPq8xAdQ++D/7nWdUNzmfd1SJK1r2hapdgPksc+kAbcpfY TY3BJ1khoTLidHM8pnyzOFXaEd99efoT3HWS+oS6AGo4yGANFCixFPunZUxje964NjszcuAkBik VlAvHs9vDRLD9Wlx/WD/WCBuNi90MTDJZ5X9kYpjeWYjJbwlnaJ+pj9sT2HifxS4qu2qmVCTp1j
 QmX5rCiB5e13FxB3d5gza6d7AbSilmdlu/weCdAN9hlZ3ih3cAIdAZFPebIXayj24waGRVD8
X-Authority-Analysis: v=2.4 cv=FNwbx/os c=1 sm=1 tr=0 ts=688b8637 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=wnoHOGPUN8WvbBk364wA:9
X-Proofpoint-ORIG-GUID: CtGnO2rX2lusddSYJar4LRRHsgrEbI_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Aligns data and metadata to the similar dma mapping scheme and removes
one more user of the scatter-gather dma mapping.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 152 +++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index decb3ad1508a7..42322c3985d98 100644
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
+	/* Metadata using non-coalesced MPTR */
+	IOD_META_MPTR		=3D 1U << 5,
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
@@ -644,6 +649,11 @@ static inline struct dma_pool *nvme_dma_pool(struct =
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
@@ -1023,70 +1033,96 @@ static blk_status_t nvme_map_data(struct request =
*req)
 	return nvme_pci_setup_data_prp(req, &iter);
 }
=20
-static void nvme_pci_sgl_set_data_sg(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
+static void nvme_free_meta_sgls(struct nvme_iod *iod, struct device *dma=
_dev,
+				enum dma_data_direction dir)
 {
-	sge->addr =3D cpu_to_le64(sg_dma_address(sg));
-	sge->length =3D cpu_to_le32(sg_dma_len(sg));
-	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
+	struct nvme_sgl_desc *sge =3D iod->meta_descriptor;
+
+	__nvme_free_sgls(dma_dev, sge, &sge[1], dir);
+}
+
+static void nvme_unmap_metadata(struct request *req)
+{
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct device *dma_dev =3D nvmeq->dev->dev;
+
+	if (iod->flags & IOD_META_MPTR) {
+		dma_unmap_page(dma_dev, iod->meta_dma,
+			       rq_integrity_vec(req).bv_len,
+			       rq_dma_dir(req));
+		return;
+	}
+
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+				iod->meta_total_len,
+				iod->flags & IOD_META_P2P_BUS_ADDR)) {
+		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
+			nvme_free_meta_sgls(iod, dma_dev, dir);
+		else
+			dma_unmap_page(dma_dev, iod->meta_dma,
+				       iod->meta_total_len, dir);
+	}
+
+	if (iod->meta_descriptor)
+		dma_pool_free(nvmeq->descriptor_pools.small,
+			      iod->meta_descriptor, iod->meta_dma);
 }
=20
 static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
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
+	int i =3D 0;
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
+	if (entries =3D=3D 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
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
-
 	iod->cmd.common.flags =3D NVME_CMD_SGL_METASEG;
 	iod->cmd.common.metadata =3D cpu_to_le64(sgl_dma);
-
-	sgl =3D iod->meta_sgt.sgl;
 	if (entries =3D=3D 1) {
-		nvme_pci_sgl_set_data_sg(sg_list, sgl);
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
+	do {
+		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		iod->meta_total_len +=3D iter.len;
+	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
=20
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
+	if (unlikely(iter.status))
+		nvme_unmap_metadata(req);
+	return iter.status;
 }
=20
 static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
@@ -1099,6 +1135,7 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
+	iod->flags |=3D IOD_META_MPTR;
 	return BLK_STS_OK;
 }
=20
@@ -1120,7 +1157,6 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1231,25 +1267,6 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 	*rqlist =3D requeue_list;
 }
=20
-static __always_inline void nvme_unmap_metadata(struct request *req)
-{
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
-
-	if (!iod->meta_sgt.nents) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
-		return;
-	}
-
-	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
-			iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-}
-
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	if (blk_integrity_rq(req))
@@ -3055,7 +3072,6 @@ static int nvme_disable_prepare_reset(struct nvme_d=
ev *dev, bool shutdown)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
-	size_t meta_size =3D sizeof(struct scatterlist) * (NVME_MAX_META_SEGS +=
 1);
 	size_t alloc_size =3D sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
=20
 	dev->dmavec_mempool =3D mempool_create_node(1,
@@ -3064,17 +3080,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
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
@@ -3524,7 +3530,6 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
@@ -3588,7 +3593,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
--=20
2.47.3

