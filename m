Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4B1F4CAE
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099129; cv=none; b=fM51nN5oSBxiJvM0dTQpgGl/ggDeopNTwSJmRJAWUltnfG+KrsjtKqXF72FTcPW3rZNa1l7Xm7BCziS5nqmXuS+33Bhc/mB382iMuTuf1TRo+2ANGrp1rvZ1hAnTQWrL7216SwMsITp/jDhtyhNi+XlhN8AAwtpB/Q+fMemQaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099129; c=relaxed/simple;
	bh=qW4qYKlpDxN7zW8+Z/kx7g/A5Owh8paoIIlg7EXlHGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyncJDONBQJe0ZorIFXTR4d6rCM+kb7UqnhjHdzmcV+KugVsSmqclq1iHLMC0FNEe6wGSCSpvSs7VGTJdzMJvrpk28nhNZ2321iqvSlW0UWr0521+O/ko5vj2nLMj6UoMpWIfM8sOgkBqhOLVEJiLMFaMbG2x5DCzUCff9zY3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=W6B43aRb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="W6B43aRb"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57DF1ZML032629
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oiCc2meJfbV37sV6ENH9Vzp37vjuFD1hB1rqmVX2Fqo=; b=W6B43aRbrJTK
	0UmwnvhAo07U+kpk1GHXG0zMgcXzFquBNWBbatEA+1I/zDflloo9jdE+AvSojOen
	QL5tfg5Yayzv/bCoVl6cQHhkE66XCTabUmcxeATxLwDOPxgYk01CGwj1JDvHoICA
	jQIQObCbtj7F7p6NdzGJDjvfxCtQOvZLLWSqPt/8oEPM/WsYu6FA+nSd/fJr03y9
	Gj+AnKyPuz1pWFHWb6aftqHIZfvXHDE4RaZq5lKswTJAfIvcPzPuqJ6Sffi0r4T3
	l65TDs8vX7Y+QE23gC4SKvs/rk8PyS/o/69dJ+xnTBMkTtpLiJRky7RZTU81KVcZ
	sYijRP5UcQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 48gqmwte1f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 08:32:06 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 599D697CD7F; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 2/9] blk-mq-dma: provide the bio_vec array being iterated
Date: Wed, 13 Aug 2025 08:31:46 -0700
Message-ID: <20250813153153.3260897-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BaTY0qt2 c=1 sm=1 tr=0 ts=689caff6 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lw-f5-AQ3I1Vcfc_tFYA:9
X-Proofpoint-GUID: Ch4DBAkXq1ovMbW7uLZBawED30fcg38o
X-Proofpoint-ORIG-GUID: Ch4DBAkXq1ovMbW7uLZBawED30fcg38o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX+j/txI1dNmtt KWMlwIAPX8QbyCrzheDOX3z7Gaxk69pRPTzijoZ/SKQYKuF0laA55irJkC69bvbUrxZdOVoYy2a zZPVi64JMAlDAy/Hqe79TY922emyiPm9oajy5pEBfcKniEEH/3wkrOS2/O831hfSnYKaGtdaL/d
 tJJR2QYhXRsUqCKDkdp6YQwIgWn4vQqU5xyQ3tHK0UDfn7dErMty1jqz57764uXUnmGCQ5+tTWQ n+iapbsN7zHss6pm3ztpPDFxdn383Ylya2/6dwGMfDcPyfCSF9iKU3dIj7NmuWkz58Qmxi1xURQ l0wzWfAYLLQGOJmClS+RH4NMS4a7nvKi9exiunnOfaqz7KhMAPPRr1kSmeYUi29tbinLDnThfy9
 jBlAa1L6CpU5IwwQgubxfh1eJiRVcEIqMoBLWAfLc/237aUjE8ZcI/8yxnOA2dt37/Orp993
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add different sources of the bvec array,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-dma.c         | 56 ++++++++++++++++++++++----------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 51e7a0ff045f9..8f41fe740b465 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -16,23 +16,14 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter,
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		vec->paddr =3D bvec_phys(&req->special_vec);
-		vec->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvecs, iter->iter);
 	vec->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX=
);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvecs, &iter->iter, bv.bv_len);
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -43,19 +34,20 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter,
 		struct bio_vec next;
=20
 		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
+			if (!iter->bio || !iter->bio->bi_next)
 				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
+			iter->bvecs =3D iter->bio->bi_io_vec;
 		}
=20
-		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next =3D mp_bvec_iter_bvec(iter->bvecs, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
=20
 		bv.bv_len +=3D next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(iter->bvecs, &iter->iter, next.bv_len);
 	}
=20
 	vec->len =3D bv.bv_len;
@@ -125,6 +117,30 @@ static bool blk_rq_dma_map_iova(struct request *req,=
 struct device *dma_dev,
 	return true;
 }
=20
+static inline void blk_rq_map_iter_init(struct request *rq,
+					struct blk_map_iter *iter)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		*iter =3D (struct blk_map_iter) {
+			.bvecs =3D &rq->special_vec,
+			.iter =3D {
+				.bi_size =3D rq->special_vec.bv_len,
+			}
+		};
+       } else if (bio) {
+		*iter =3D (struct blk_map_iter) {
+			.bio =3D bio,
+			.bvecs =3D bio->bi_io_vec,
+			.iter =3D bio->bi_iter,
+		};
+	} else {
+		/* the internal flush request may not have bio attached */
+	        *iter =3D (struct blk_map_iter) {};
+	}
+}
+
 /**
  * blk_rq_dma_map_iter_start - map the first DMA segment for a request
  * @req:	request to map
@@ -153,8 +169,7 @@ bool blk_rq_dma_map_iter_start(struct request *req, s=
truct device *dma_dev,
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
 	struct phys_vec vec;
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
+	blk_rq_map_iter_init(req, &iter->iter);
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
=20
@@ -246,16 +261,11 @@ blk_next_sg(struct scatterlist **sg, struct scatter=
list *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct blk_map_iter iter =3D {
-		.bio	=3D rq->bio,
-	};
+	struct blk_map_iter iter;
 	struct phys_vec vec;
 	int nsegs =3D 0;
=20
-	/* the internal flush request may not have bio attached */
-	if (iter.bio)
-		iter.iter =3D iter.bio->bi_iter;
-
+	blk_rq_map_iter_init(rq, &iter);
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 6a7e3828673d7..e5cb5e46fc928 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -8,6 +8,7 @@
 struct blk_map_iter {
 	struct bvec_iter		iter;
 	struct bio			*bio;
+	struct bio_vec			*bvecs;
 };
=20
 struct blk_dma_iter {
--=20
2.47.3

