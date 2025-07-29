Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BC1B0F0A
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799710; cv=none; b=mAKnrosiviaCPoyd52JhoEadkbhNUjlaVpr6JLrivA8JNZcizGEJs0kuQp1/BZqaEFduq8pjF0FQ+mEfin8D9t/NHqgbgvbYGVD/qzlifsLsvYLz4thPrq63knj2f0jv1HrFVpDXU5BFw05LPPL3t/tNfqeEiz5xv88l3vove2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799710; c=relaxed/simple;
	bh=CD/G2UFCoXLrBc0AJnQhUMidFkdZqPh3ya+olakXilg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPt41T2o7aniG2Zs/ezEGwxnj4WWJJmf0gCJ//jcCRFi1n4q06+FpRXRPvcucjFN0xpxBwZ6ImjBsh2g9S3Xt7jt7Lqu7YDUJhKt6iKMM+UT6r8Bzk/TsKTT31LdJSKx88b5Js9VeVpAwAQLDxLdHvcz/MAo/bcby+xezcFJcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vjT0Oajh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vjT0Oajh"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7R5HV018946
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5vT2iVAErtjJat8Ks7am4DzUZeGC35xV/9B3wNywCHk=; b=vjT0OajhH4Gm
	IfJjJT8UrK/iyOiCjLMD/aKxcaRXHpMKshMCRcAp6pyVEbFJa8JcBL9l441/Zlg7
	2UkGUjqiFaoVkIbCRLUnBW5ha99vicCmqSnagBGvhUdiR41AdI3El3XLdghcjTyT
	qGjugdiOo6zyV86LNKbCObtD+4PjS4RxGqaer5++hDwnhWxDllpsZ7TJKVUBve+w
	70iCz25/GyNZDI1SjJRAnneCAxoFK+rIUhVQnX+uFXrbB5SsiJd0txynC1Yh4PWA
	yes+PylH+ovX7NC3+kbgbp59e46RggSxntKMFQQ0kJGy5Py4wd1gW/xplHa5IiRk
	mLiHFPj50w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486swmja4t-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 07:35:07 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 14:34:57 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 7463E1CC41FC; Tue, 29 Jul 2025 07:34:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
Date: Tue, 29 Jul 2025 07:34:36 -0700
Message-ID: <20250729143442.2586575-2-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=KZHSsRYD c=1 sm=1 tr=0 ts=6888dc1b cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=vJZztQhXiBMcT6r6zj8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMiBTYWx0ZWRfX/a5G9i7iQ7D7 iKSPMGRAkz6gHkG3M5PWkY+z9o0L7mNKTf9QEeX5a2qzaD1ZjIvIXqSU15ggT862Ae+AUm5QdGI bLmThlJlR282r3R21nkPWBQSJcqLl7dKdl3qsXCROsgBt7PO1VeodR2tGqloAs9OZBEGhrJqjko
 EIsZV9b2KiKi/oNDXuporKddZbObKTCxIZ4l1R8pm9hMWEsaxFvDCnzp0qcubURZ1BasKXT0oRJ aO/3aQdiCb641P4eZq3JuY77S6aKs/TapPb0BawOOG9rZV9YF6N/hm1GXLMLHMxC/EJJ0pQs+dR l3oOmVPhYvm5z57rWSOhwEW+HAA47TCIXo09acBytjpdVFJ33JIHrj+T20YsgFa0npS16RZTSux
 w/CH2qag6FZrXarsU4TZv6Muh8TrNjFKZ0R+rRCxbQumITcPSgiGFkZbcFFz/OueFJD7XjsG
X-Proofpoint-ORIG-GUID: foFST7lus5I8OxnjBSTU0jEeSEDhlTdq
X-Proofpoint-GUID: foFST7lus5I8OxnjBSTU0jEeSEDhlTdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Create a type that fully captures the lower level physical address
iteration.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 93 +++++++++++++++++---------------------
 include/linux/blk-mq-dma.h |  9 +++-
 2 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef2..61fbdb715220f 100644
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
@@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, st=
ruct req_iterator *iter,
 	 * one could be merged into it.  This typically happens when moving to
 	 * the next bio, but some callers also don't pack bvecs tight.
 	 */
-	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
+	while (!iter->iter.bi_size ||
+	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
 		struct bio_vec next;
=20
 		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
-				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
 		}
@@ -58,7 +51,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct req_iterator *iter,
 		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
 	}
=20
-	vec->len =3D bv.bv_len;
+	iter->len =3D bv.bv_len;
 	return true;
 }
=20
@@ -77,29 +70,29 @@ static inline bool blk_can_dma_map_iova(struct reques=
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
-	if (dma_mapping_error(dma_dev, iter->addr)) {
+	iter->addr =3D dma_map_page(dma_dev, phys_to_page(iter->iter.paddr),
+			offset_in_page(iter->iter.paddr), iter->iter.len,
+			rq_dma_dir(req));
+	if (dma_mapping_error(dma_dev, iter->iter.paddr)) {
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
@@ -109,12 +102,12 @@ static bool blk_rq_dma_map_iova(struct request *req=
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
@@ -151,10 +144,10 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter)
 {
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
-	struct phys_vec vec;
+	struct blk_map_iter *map_iter =3D &iter->iter;
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
+	map_iter->bio =3D req->bio;
+	map_iter->iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -162,14 +155,14 @@ bool blk_rq_dma_map_iter_start(struct request *req,=
 struct device *dma_dev,
 	 * Grab the first segment ASAP because we'll need it to check for P2P
 	 * transfers.
 	 */
-	if (!blk_map_iter_next(req, &iter->iter, &vec))
+	if (!blk_map_iter_next(req, map_iter))
 		return false;
=20
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
 		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
-					 phys_to_page(vec.paddr))) {
+					 phys_to_page(map_iter->paddr))) {
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
+	    dma_iova_try_alloc(dma_dev, state, map_iter->paddr, total_len))
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

