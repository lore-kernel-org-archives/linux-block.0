Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4F31E11B
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477399; cv=none; b=laVokqQ99KXItdsmozALtQfgQLs/N/LrY/j5J3X47aWsYeCbwXPrTApqHYrfpN2A0MFoNiWArq6m2oxEY6zLilVEc5vO+93CowLXVAYbFwDcfXSiO3/yQDnRTNk/z29GFpAPFpDnHeJ5boe+PnfUoMmp13fAXCcDUniNIYVjO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477399; c=relaxed/simple;
	bh=Sf/F4rkGv/AijyJAAb2Gp0VToIikTysdsvaQvjec9QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBWlz2bColjRBBsg3dV00oE7MUyyppF+sAqUBXdqth58oFNVMJJG3lF44Dc5jzClwf0hjE40qkxAaZACdm6X2piLq7g+AxRnfPPgHHlDP5a/lnXj/pfAu6WxrZ0i2RpKIhFBCIDb7alPMmFzSTsFcx0f7zZ1H+H4san22FdewWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qGLV30hd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qGLV30hd"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57T8ipbK3730783
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 07:23:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fvmLsbPd7bivJMBtoWIc6NzSQqgS5FoA4wv5OwDgbyY=; b=qGLV30hdyeBz
	rOBn1bXjUe7BFOuOyzysdjQhZd/rZQRQh7u7365fP+RchdRR40B/PShfS5KQeenb
	TfjwVbmGWN4PLy54wFxlZjN2bZqjjXBlHje84TKWEfk1x8bV+qEOG38d23GExHeX
	hv8kBgOJZFCE2TPzGvKPR216z6ASDIbqW8kABzeDrfrl3yD9QIqSqOV5dme7d+9e
	9A1bUJY4kWY49EDWUhdSd/ikBVhoyCidv7YSqkwUXSosG9J5YI5dOKC0uMX/ToMi
	N/ubzDXr2yiX5vzfA/gQG4NBge9OZ8oqZCcYmytCvdFNUEwUJTyUvMXZpjlS2/TO
	BtoYkMIHlg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48u54easbk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 07:23:17 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4F92811FADB7; Fri, 29 Aug 2025 07:23:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Date: Fri, 29 Aug 2025 07:23:07 -0700
Message-ID: <20250829142307.3769873-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829142307.3769873-1-kbusch@meta.com>
References: <20250829142307.3769873-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BqMQc29NXQogoZpBOChkY6r_3jj5FAeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDEyMSBTYWx0ZWRfXwb1sJ7Kou7P3
 X6h+ZsySN324T8FVzOmFrhMv/WGULxZR7RBHLnLbc4TPDs3R7xxkhgDjZZV4uwDIm3VzmTT6s1w
 dUZcvF/nLSZyhDMhIVOJgND/8n1CEwUXImBZ8pIDULXuAU730tFwVo46ByK2ca03I1qsc/ORRmF
 XTj5S9bolgpM4GttQQceY0W4qB2JB4WreKwQfOsq6dsZuJO8A+Ui9hyUzcyIVPcozj7dSbhgP6B
 d4oyGOfB4NIZ4JEAtcwP8eg3Oz4/4egcXsm/oyi0PlxYRzW0JC107tnhUKdR2pyTWwMxgJvriZi
 hGvtRHcAPz1YfggGqXl24TJvBHQvki4A7BDStFEs3xc7GOVszNM5dCKTtLRglI=
X-Proofpoint-ORIG-GUID: BqMQc29NXQogoZpBOChkY6r_3jj5FAeD
X-Authority-Analysis: v=2.4 cv=MeJsu4/f c=1 sm=1 tr=0 ts=68b1b7d5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=8eh8sI05T6IxmTZdt9kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_05,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We only need to consider data and metadata dma mapping types separately.
The request and bio integrity payload have enough flag bits to
internally track the mapping type for each. Add flags for these so the
caller doesn't need to track them, and provide separete request and
integrity helpers to the common code for unmpaping. This will make it
easier to scale as new mappings are added without burdening the caller
to track such things.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         |  2 +-
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 14 ++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 7 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 5709ce2bf3464..d3618ed106f4e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -252,7 +252,7 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 			bytes -=3D next;
 		}
=20
-		if (is_pci_p2pdma_page(page))
+		if (is_pci_p2pdma_page(pages[i]))
 			*is_p2p =3D true;
=20
 		bvec_set_page(&bvec[nr_bvecs], pages[i], size, offset);
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 660b5e200ccf6..449950029872a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -174,6 +174,10 @@ static bool blk_dma_map_iter_start(struct request *r=
eq, struct device *dma_dev,
 	switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
 				 phys_to_page(vec.paddr))) {
 	case PCI_P2PDMA_MAP_BUS_ADDR:
+		if (iter->iter.is_integrity)
+			bio_integrity(req->bio)->bip_flags |=3D BIP_P2P_DMA;
+		else
+			req->cmd_flags |=3D REQ_P2PDMA;
 		return blk_dma_map_bus(iter, &vec);
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		/*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8a9dee55de33..28e203b894eb1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -260,12 +260,6 @@ enum nvme_iod_flags {
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	=3D 1U << 2,
=20
-	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
-	IOD_P2P_BUS_ADDR	=3D 1U << 3,
-
-	/* Metadata DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
-	IOD_META_P2P_BUS_ADDR	=3D 1U << 4,
-
 	/* Metadata using non-coalesced MPTR */
 	IOD_SINGLE_META_SEGMENT	=3D 1U << 5,
 };
@@ -737,9 +731,8 @@ static void nvme_unmap_metadata(struct request *req)
 		return;
 	}
=20
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-				iod->meta_total_len,
-				iod->flags & IOD_META_P2P_BUS_ADDR)) {
+	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+					iod->meta_total_len)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
 			nvme_free_sgls(req, sge, &sge[1]);
 		else
@@ -766,8 +759,7 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
=20
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
-				iod->flags & IOD_P2P_BUS_ADDR)) {
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, iod->descriptors[0],
 				       &iod->cmd.common.dptr.sgl);
@@ -1043,9 +1035,6 @@ static blk_status_t nvme_map_data(struct request *r=
eq)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
=20
-	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
-		iod->flags |=3D IOD_P2P_BUS_ADDR;
-
 	if (use_sgl =3D=3D SGL_FORCED ||
 	    (use_sgl =3D=3D SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >=3D sgl_threshold)))
@@ -1068,9 +1057,7 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct=
 request *req)
 						&iod->meta_dma_state, &iter))
 		return iter.status;
=20
-	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
-		iod->flags |=3D IOD_META_P2P_BUS_ADDR;
-	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
+	if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
 		entries =3D 1;
=20
 	/*
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.=
h
index 0a25716820fe0..851254f36eb36 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -13,6 +13,7 @@ enum bip_flags {
 	BIP_CHECK_GUARD		=3D 1 << 5, /* guard check */
 	BIP_CHECK_REFTAG	=3D 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	=3D 1 << 7, /* apptag check */
+	BIP_P2P_DMA		=3D 1 << 8, /* using P2P address */
 };
=20
 struct bio_integrity_payload {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index 78fe2459e6612..4746f3e6ad36d 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -27,6 +27,15 @@ static inline bool queue_limits_stack_integrity_bdev(s=
truct queue_limits *t,
=20
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
+
+static inline bool blk_rq_integrity_dma_unmap(struct request *req,
+		struct device *dma_dev, struct dma_iova_state *state,
+		size_t mapped_len)
+{
+	return blk_dma_unmap(req, dma_dev, state, mapped_len,
+			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA);
+}
+
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes);
@@ -115,6 +124,11 @@ static inline int blk_rq_map_integrity_sg(struct req=
uest *q,
 {
 	return 0;
 }
+static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
+		struct dma_iova_state *state, size_t mapped_len)
+{
+	return false;
+}
 static inline int blk_rq_integrity_map_user(struct request *rq,
 					    void __user *ubuf,
 					    ssize_t bytes)
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 0f45ea110ca12..51829958d8729 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -43,7 +43,7 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_i=
ova_state *state)
 }
=20
 /**
- * blk_rq_dma_unmap - try to DMA unmap a request
+ * blk_dma_unmap - try to DMA unmap a request
  * @req:	request to unmap
  * @dma_dev:	device to unmap from
  * @state:	DMA IOVA state
@@ -53,7 +53,7 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_i=
ova_state *state)
  * Returns %false if the callers need to manually unmap every DMA segmen=
t
  * mapped using @iter or %true if no work is left to be done.
  */
-static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
+static inline bool blk_dma_unmap(struct request *req, struct device *dma=
_dev,
 		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
 {
 	if (is_p2p)
@@ -68,4 +68,11 @@ static inline bool blk_rq_dma_unmap(struct request *re=
q, struct device *dma_dev,
 	return !dma_need_unmap(dma_dev);
 }
=20
+static inline bool blk_rq_dma_unmap(struct request *req, struct device *=
dma_dev,
+		struct dma_iova_state *state, size_t mapped_len)
+{
+	return blk_dma_unmap(req, dma_dev, state, mapped_len,
+				req->cmd_flags & REQ_P2PDMA);
+}
+
 #endif /* BLK_MQ_DMA_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 930daff207df2..09b99d52fd365 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -386,6 +386,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
+	__REQ_P2PDMA,		/* contains P2P DMA pages */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -418,6 +419,7 @@ enum req_flag_bits {
 #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
+#define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
=20
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
=20
--=20
2.47.3

