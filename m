Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F129ACCC
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750884304; cv=none; b=BfOkqinM7MODOaMxvs1D8b6NCpaEdQlhj0NuAl9E3lRLmef2Ds3YcgarsK0MXlri7oXnNKlmcljqJFUjjt2Fw2VLhsEZYY9ORBJ4/dAegDWn4GXFvUc5OQ85U3LZx5a2iyXrv8DWH2cphaoZLScaINf9bPcHJVZdxHAuaSDhCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750884304; c=relaxed/simple;
	bh=6IciuTEFUr92DDP1Buh9rqE3jnakNFq0CgWQyLJpJrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZj4/J0h0oe6S2+vjz4Is/kFWuI3TUzLH7yrKVl/cEjaEkVlFb/x4uzNM1l07n2PNtal3Cu+A3wIY3qIY9I6SJcqCC+NvFNT3C92sfFJT7jsFWpKHvUJTGqYl/UtKu2+TAR/qnGN4Jxfpvu2ZxCDxXiprlnOmEA5LAj4+f+O8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MvKML5cf; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MvKML5cf"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJMF5x011152
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 13:45:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=Nrl/mM1f4nUDM+SPsl9lsAxt3jHm+mBbaf0FUbbncJ8=; b=MvKML5cfnWYN
	FCnL9Ra6bZ+zk79B/N6jfhWaGzqs6PhjwpRWnBb9F+VANysu6Kwcw22JlVN/FUgg
	Xv+bRgKN1/jSyD7tqsPYIwiA8BqztrWvQHfOdDospaDTkNz5AB8hEubIxaGp6/13
	nuKjOILb3eKu1GlqwHS5WbEhx/hwur2Qx4whTOsF+ig4AvmSqlKxIYh0RGVl3fC2
	bbGt2hlPSdj8KrgdmfSoLEnXXm8kx6GEQ5/+RGPBIZeaVIn65r5gUMfre/O/rphT
	0CDJwvQs22fP+eKKLaQvR/r6+cM9z5GHpRLoCEq1yNrBVeQwINr8J3TJu71DJ4Rx
	jMc0hCtCEg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47gext4dms-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 13:45:01 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Wed, 25 Jun 2025 20:44:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id CB8438C48C9; Wed, 25 Jun 2025 13:44:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <leon@kernel.org>, <joshi.k@samsung.com>,
        <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Date: Wed, 25 Jun 2025 13:44:45 -0700
Message-ID: <20250625204445.1802483-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625204445.1802483-1-kbusch@meta.com>
References: <20250625204445.1802483-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE1OSBTYWx0ZWRfX/GuDMY1nRt79 VieluoY2Wv7MjqackRl/ujjmjaKyUF9x9JWWk2Atb6nJpjZ+ir7tFNZA520D3QyA/7CKRDRg8Ec Hgi7xbo+I/gpPJ+sN16rTDLr0L18QHcsB9qr5ABhCzNklD5RjWCtxCV1FrhX2Rmj4D6pHpvrQpV
 O04HsYznM+Z9b2/R+Mqg/Ma9fb/CbPNMafW6ztJa5SKh1QNTSSjuQCxh4nbmXRNJHAx6ikJy++b 2a9bueJIAFZpdVc9bvv6BgdWj3CpB8bUXy+8ESuC9RtZYhZmVgqrwMYin7NiK+aP+q1YWHgtbs6 jiLhger2gYUeRur6AqriUlTAKyzgzuNH5VXeVFbJi13kikau/nGrC4ehRpLBOx9yEHmEhvzqhJd
 hymagsmF1PxZws3UuupvmSGMRgKLT/xQqZD88zCnQDhTja+kZ5rbNl3sfa2czBups8SxKVIY
X-Proofpoint-ORIG-GUID: xXb0kaLYb-a8x3pitdikh_qxDqxdHqgA
X-Authority-Analysis: v=2.4 cv=YuIPR5YX c=1 sm=1 tr=0 ts=685c5fcd cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=jSp59qru_JMrQpIs8J4A:9
X-Proofpoint-GUID: xXb0kaLYb-a8x3pitdikh_qxDqxdHqgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_07,2025-06-25_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Aligns data and metadata to the similar dma mapping scheme and removes
one more user of the scatter-gather dma mapping.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 69 +++++++++++++----------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38be1505dbd96..f82ef19fa0a3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -270,13 +270,13 @@ struct nvme_iod {
 	struct nvme_command cmd;
 	u8 flags;
 	u8 nr_descriptors;
+	u8 nr_meta_descriptors;
=20
 	unsigned int total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
=20
 	dma_addr_t meta_dma;
-	struct sg_table meta_sgt;
 	struct nvme_sgl_desc *meta_descriptor;
 };
=20
@@ -1010,70 +1010,39 @@ static blk_status_t nvme_map_data(struct request =
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
 static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
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
-
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
+	int i =3D 0;
=20
-	rc =3D dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
+	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev, &iter))
+		return iter.status;
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
-	if (entries =3D=3D 1) {
-		nvme_pci_sgl_set_data_sg(sg_list, sgl);
-		return BLK_STS_OK;
-	}
-
 	sgl_dma +=3D sizeof(*sg_list);
-	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
-	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data_sg(&sg_list[i + 1], sg);
=20
-	return BLK_STS_OK;
+	do {
+		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
=20
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
+	iod->nr_meta_descriptors =3D i;
+	return BLK_STS_OK;
 }
=20
 static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
@@ -1086,6 +1055,7 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
+	iod->nr_meta_descriptors =3D 0;
 	return BLK_STS_OK;
 }
=20
@@ -1107,7 +1077,6 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1222,19 +1191,23 @@ static __always_inline void nvme_unmap_metadata(s=
truct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	struct nvme_sgl_desc *sg_list =3D iod->meta_descriptor;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
 	struct nvme_dev *dev =3D nvmeq->dev;
+	int i;
=20
-	if (!iod->meta_sgt.nents) {
+	if (!iod->nr_meta_descriptors) {
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req).bv_len,
 			       rq_dma_dir(req));
 		return;
 	}
=20
+	for (i =3D 1; i <=3D iod->nr_meta_descriptors; i++)
+		dma_unmap_page(dev->dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir);
 	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
 			iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
 }
=20
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
--=20
2.47.1

