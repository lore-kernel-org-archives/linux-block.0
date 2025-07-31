Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8581E
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974320; cv=none; b=h/vrC/rdThwBuQHy2i9QQ8XVQZFfRdx6NkJMo6dx30WTDIZyCxl0h7fKgn+T4bSal6vgnzDR971XKnPUzZBsGbA3fdvPMoOs9Fr2iShqZ+33qp71IXk2Ko/m2NP7kZlxvrYcukjTEWuXK/HL0LmaAzbMrBJcZmE9EOv4RBXpzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974320; c=relaxed/simple;
	bh=dLVbFB7skbkRUAN89Cw67Is+fTlUSYv3a8X98fSBndc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2Vcb9HKv6VeIjTPzAJ7ylwdGNyuyqQrVomcc1NxfKF0YsYnBgsXeHPcIAarXBiHriSCXZVsA3emZbckqHxwVBLMfy1TAgPoml13FVz5U2mV2yALyRRGXt6CAA5wp0ImZ0T1qI4GlmtVC2lqHpQnovSJZO2+vkxt7MqCll2bqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=u6atiFnu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="u6atiFnu"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56VE78Fq013381
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bZCBFvA7Jw7nxzi4zLKVihdBiwPApq11fQV4EpjuzbY=; b=u6atiFnuEsL+
	+0yGxZP1vcCvuLOKrLMf0r+mbprOBn/MvdENQUNxiEVe+tjlonAPWbwPEKdZ39XB
	ljCCA/ak8Vj2EiHxNYkKoH8tPAqRlFS+wvnFYtX8/D1iaTrUbPf2jq5bZFgjPyCl
	PgsaTxSkVIIZAh/smDpIqjZIoD3zpowfKiJGMVw+DgwyoBm+1TSg+ecnTNCA1F5M
	JHTiLf3FRXFR/OJ9x0bD58TlmLjtuILdmfbpE2amm+/UTbzMmKG8VdFRk2R7q4/d
	zh8XDNiQwcN4S4dt4QwWdh03RQz3K3C/j9s0hTGTlSffds9azdXOQSwdgc3R+GZR
	3PbP7iRYmg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4886r61mck-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:16 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E63C3231DA8; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 1/8] blk-mq-dma: introduce blk_map_iter
Date: Thu, 31 Jul 2025 08:05:06 -0700
Message-ID: <20250731150513.220395-2-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: TWoHaEkz3O_tjAUXrgsmnhRs1CvJTdlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfXw4XSDyRnmSRM FPH4/A4GnqZzfZkS8WCv5+TlEnrr0OIBVIHL4WmWvPfS78OgeK9AN8EljLBYypH8Z3UQoWA2tYK QP4TWH1MsxXiYHonAmT/+5JavHJsn2ArmHVquxiwLfT6z5kg1ZGfUrbCFHTEXLhjbMc6qIPSM8M
 ilEJIj7kiYhYcQyf0+7RboSFXprrzsIT5hz8sCi6r5U9v8zgJhDR4hhpugD3RGH0ZzKO6xveghQ tY5FscZOI7C7njnxqPYIcXXsiwzdbYuinlmIe2VgLgIbY6oS3LesIepIzjGGkOQM9yw9VO9ukEq 4tBy1Qy17p6oKmaHzZKYbBfKDAXQoQSBeLGCec1tIGsBRdFyOtp9vy5DloDtPcA4+On2zzapI/m
 90MLcZ5ONhkywa11AUvvRJn/2pxuN53tfnhEfVNSPOQd0TR2sjareIE8YDNTn0hqpLPJHZEM
X-Authority-Analysis: v=2.4 cv=BKSzrEQG c=1 sm=1 tr=0 ts=688b862c cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=_vUovkCjKnAsJJE3Rt0A:9
X-Proofpoint-GUID: TWoHaEkz3O_tjAUXrgsmnhRs1CvJTdlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Create a type that fully captures the lower level physical address
iteration.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 81 +++++++++++++++++---------------------
 include/linux/blk-mq-dma.h |  9 ++++-
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..ff4c9a7e19d83 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -5,13 +5,7 @@
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
=20
-struct phys_vec {
-	phys_addr_t	paddr;
-	u32		len;
-};
-
-static bool blk_map_iter_next(struct request *req, struct req_iterator *=
iter,
-			      struct phys_vec *vec)
+static bool blk_map_iter_next(struct request *req, struct blk_map_iter *=
iter)
 {
 	unsigned int max_size;
 	struct bio_vec bv;
@@ -19,8 +13,8 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		if (!iter->bio)
 			return false;
-		vec->paddr =3D bvec_phys(&req->special_vec);
-		vec->len =3D req->special_vec.bv_len;
+		iter->paddr =3D bvec_phys(&req->special_vec);
+		iter->len =3D req->special_vec.bv_len;
 		iter->bio =3D NULL;
 		return true;
 	}
@@ -29,8 +23,8 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 		return false;
=20
 	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
-	vec->paddr =3D bvec_phys(&bv);
-	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
+	iter->paddr =3D bvec_phys(&bv);
+	max_size =3D get_max_segment_size(&req->q->limits, iter->paddr, UINT_MA=
X);
 	bv.bv_len =3D min(bv.bv_len, max_size);
 	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
=20
@@ -58,7 +52,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
 	}
=20
-	vec->len =3D bv.bv_len;
+	iter->len =3D bv.bv_len;
 	return true;
 }
=20
@@ -77,29 +71,29 @@ static inline bool blk_can_dma_map_iova(struct reques=
t *req,
 		dma_get_merge_boundary(dma_dev));
 }
=20
-static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
+static bool blk_dma_map_bus(struct blk_dma_iter *iter)
 {
-	iter->addr =3D pci_p2pdma_bus_addr_map(&iter->p2pdma, vec->paddr);
-	iter->len =3D vec->len;
+	iter->addr =3D pci_p2pdma_bus_addr_map(&iter->p2pdma, iter->iter.paddr)=
;
+	iter->len =3D iter->iter.len;
 	return true;
 }
=20
 static bool blk_dma_map_direct(struct request *req, struct device *dma_d=
ev,
-		struct blk_dma_iter *iter, struct phys_vec *vec)
+		struct blk_dma_iter *iter)
 {
-	iter->addr =3D dma_map_page(dma_dev, phys_to_page(vec->paddr),
-			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	iter->addr =3D dma_map_page(dma_dev, phys_to_page(iter->iter.paddr),
+			offset_in_page(iter->iter.paddr), iter->iter.len,
+			rq_dma_dir(req));
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status =3D BLK_STS_RESOURCE;
 		return false;
 	}
-	iter->len =3D vec->len;
+	iter->len =3D iter->iter.len;
 	return true;
 }
=20
 static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_=
dev,
-		struct dma_iova_state *state, struct blk_dma_iter *iter,
-		struct phys_vec *vec)
+		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	enum dma_data_direction dir =3D rq_dma_dir(req);
 	unsigned int mapped =3D 0;
@@ -109,12 +103,12 @@ static bool blk_rq_dma_map_iova(struct request *req=
, struct device *dma_dev,
 	iter->len =3D dma_iova_size(state);
=20
 	do {
-		error =3D dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+		error =3D dma_iova_link(dma_dev, state, iter->iter.paddr, mapped,
+				iter->iter.len, dir, 0);
 		if (error)
 			break;
-		mapped +=3D vec->len;
-	} while (blk_map_iter_next(req, &iter->iter, vec));
+		mapped +=3D iter->iter.len;
+	} while (blk_map_iter_next(req, &iter->iter));
=20
 	error =3D dma_iova_sync(dma_dev, state, 0, mapped);
 	if (error) {
@@ -151,7 +145,6 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
-	struct phys_vec vec;
=20
 	iter->iter.bio =3D req->bio;
 	iter->iter.iter =3D req->bio->bi_iter;
@@ -162,14 +155,14 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
 	 */
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, &iter->iter))
 		return false;
=20
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
 		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(vec.paddr))) {
+					 phys_to_page(iter->iter.paddr))) {
 		case PCI_P2PDMA_MAP_BUS_ADDR:
-			return blk_dma_map_bus(iter, &vec);
+			return blk_dma_map_bus(iter);
 		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 			/*
 			 * P2P transfers through the host bridge are treated the
@@ -184,9 +177,9 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 	}
=20
 	if (blk_can_dma_map_iova(req, dma_dev) &&
-	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
-		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
-	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+	    dma_iova_try_alloc(dma_dev, state, iter->iter.paddr, total_len))
+		return blk_rq_dma_map_iova(req, dma_dev, state, iter);
+	return blk_dma_map_direct(req, dma_dev, iter);
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
=20
@@ -211,14 +204,12 @@ EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
 bool blk_rq_dma_map_iter_next(struct request *req, struct device *dma_de=
v,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
-	struct phys_vec vec;
-
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, &iter->iter))
 		return false;
=20
 	if (iter->p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
-		return blk_dma_map_bus(iter, &vec);
-	return blk_dma_map_direct(req, dma_dev, iter, &vec);
+		return blk_dma_map_bus(iter);
+	return blk_dma_map_direct(req, dma_dev, iter);
 }
 EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_next);
=20
@@ -246,20 +237,20 @@ blk_next_sg(struct scatterlist **sg, struct scatter=
list *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct req_iterator iter =3D {
-		.bio	=3D rq->bio,
+	struct bio *bio =3D rq->bio;
+	struct blk_map_iter iter =3D {
+		.bio	=3D bio,
 	};
-	struct phys_vec vec;
 	int nsegs =3D 0;
=20
 	/* the internal flush request may not have bio attached */
-	if (iter.bio)
-		iter.iter =3D iter.bio->bi_iter;
+	if (bio)
+		iter.iter =3D bio->bi_iter;
=20
-	while (blk_map_iter_next(rq, &iter, &vec)) {
+	while (blk_map_iter_next(rq, &iter)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
-		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
-				offset_in_page(vec.paddr));
+		sg_set_page(*last_sg, phys_to_page(iter.paddr), iter.len,
+				offset_in_page(iter.paddr));
 		nsegs++;
 	}
=20
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index c26a01aeae006..1e5988afdb978 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -5,6 +5,13 @@
 #include <linux/blk-mq.h>
 #include <linux/pci-p2pdma.h>
=20
+struct blk_map_iter {
+	phys_addr_t			paddr;
+	u32				len;
+	struct bvec_iter		iter;
+	struct bio			*bio;
+};
+
 struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
@@ -14,7 +21,7 @@ struct blk_dma_iter {
 	blk_status_t			status;
=20
 	/* Internal to blk_rq_dma_map_iter_* */
-	struct req_iterator		iter;
+	struct blk_map_iter		iter;
 	struct pci_p2pdma_map_state	p2pdma;
 };
=20
--=20
2.47.3

