Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CE2D5939
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928012; cv=none; b=Vc1b4XF0I6w0fBQ5PhMxkxiwtMArL9FtZE1u5lDHHar5vKmzNwD1anTAL289aTqY8Uw6nae806aNN5OwNMbkWBGhhzSSYevb9nuMMv8/ayflBm1MmTWWNPxo5cL+2StSsRp81f7DYIQbUncnoLGjnGrGwjOIoDMPYnKlY29Va10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928012; c=relaxed/simple;
	bh=OeoTshe3BdPFOqyevynlOP8yrJTDApw3u2rDqscdxAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRseuOU8fxOYtjCSVwpQK/x0xnyAGb/+HmL/gBFrFtiaWOuedEXht/1q96IX/JBTCRmExyPtVThPPFFEDMlCgrvi6p3F3LNowds0OIUXtYV+er1UpqVajvsWqLT8PRvA9VEdFPj1H3F80wNeAlXusEm8JmD/UjrC0/zIhHIyEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DEGPCxNx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DEGPCxNx"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 583J83KF3438984
	for <linux-block@vger.kernel.org>; Wed, 3 Sep 2025 12:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=40j+UgwEuN3AtV/CDpkJ+OWLMkFVQ8v0JC761N1WWjQ=; b=DEGPCxNxxAm7
	4KLk3/udVaEzXEZoA5mwBFJAQpiWpt9krXcvk0sIDw3KVQJ8Jll/pdoJscEhQueT
	QRPoHt0bwJyeTAZBuS4EWMkPiJqdFrqYUnLCV+EMx71MWbQF/x00OyeGCs6LTeP/
	g7Ayluk1EQY06tMEvRCnJLQl9/Awn3++xiPv1gO9TOf84s1jDu4AXR7ajq9Yl4lp
	e9GPWp/jqb+rUQ10BPeCSlXTWXKxsUodZoqga/flMHPfssLCP0JybhnSm3FI9ox4
	xDz/zEKppDNxedWiFNHw5QKiidF0BUBiXriIkee1uwaabyZuZlGkIMm1utj0j8Vb
	77AH/Ja1Tg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48xq6g2t0c-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 12:33:28 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 3 Sep 2025 19:33:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CC84C14CE624; Wed,  3 Sep 2025 12:33:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Leon
 Romanovsky <leonro@nvidia.com>
Subject: [PATCHv3 2/2] blk-mq-dma: bring back p2p request flags
Date: Wed, 3 Sep 2025 12:33:17 -0700
Message-ID: <20250903193317.3185435-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250903193317.3185435-1-kbusch@meta.com>
References: <20250903193317.3185435-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xjST3BpZ6GsHIQnFJDYytJXkkOKS2jey
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE5NiBTYWx0ZWRfX9Zf3pbLg0IkC
 F/Ovr6/GYGNkKPQxkqIfMwtZVxHtfZfa9dfPXmI4LJ4tcgoN99IzOA4P5+vlxMdf8cwugeDQHd9
 r3KMrYtRqMMW90OCrxEqaTuAQLNrC6LQ35rVw69Q2GVqmco7B/hPvQBEr9qCj+x8m/FK1DYD2kh
 iQJc8jYQXiSinyDwPAxu7UxF1elmVNX6ZcshFm++EjcI4I1ES/BW+6ON5BwuN+O/S/2tWF35RMv
 4nweXw7Z0+0+js3BeE/+ZhtmS/lVgbeptPHx3YYEIXwbmzJCcXjb4a9++fXYY7YcuHrBhbUCRTF
 hE2vvpUOdWuIlLK+S4U3dPrADFIzaikmkT3+M5VoBRLQ4iQnUliwLdZ4cl3CVU=
X-Authority-Analysis: v=2.4 cv=E/HNpbdl c=1 sm=1 tr=0 ts=68b89808 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=KeZPkw9lY6AM_2-iRd4A:9
X-Proofpoint-GUID: xjST3BpZ6GsHIQnFJDYytJXkkOKS2jey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We only need to consider data and metadata dma mapping types separately.
The request and bio integrity payload have enough flag bits to
internally track the mapping type for each. Use these so the caller
doesn't need to track them, and provide separete request and integrity
helpers to the common code. This will make it easier to scale new
mappings, like the proposed MMIO attribute, without burdening the caller
to track such things.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 15 +++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 6 files changed, 35 insertions(+), 19 deletions(-)

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
index 78fe2459e6612..b659373788f60 100644
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
@@ -115,6 +124,12 @@ static inline int blk_rq_map_integrity_sg(struct req=
uest *q,
 {
 	return 0;
 }
+static inline bool blk_rq_integrity_dma_unmap(struct request *req,
+		struct device *dma_dev, struct dma_iova_state *state,
+		size_t mapped_len)
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

