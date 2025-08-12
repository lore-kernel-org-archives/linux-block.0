Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B3288C24
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006863; cv=none; b=jo6tBDFwwrVhQ1Swz7tthXETcgBV/r93D1rkzGYGCUAf7r0KhVmKV7J4L8D6KF6RQu3tWd518soVF33F5uy0w4Fyo9P63fS+UdAoj9L53b6aWjXUcCem5vQgS1Pbx015IMkVmjY3E8B8pfYvhw+XueObBvJvfBq5Qur7nmS5apM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006863; c=relaxed/simple;
	bh=6/WSdchtE3nkJb9rnKQj6N7N7BlnhU4GcZ8seSQ4We0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yd5xv9Z/UNBtQyZbVs+2foASGZboOSi2q3fmXsEHCtPTI4uXXn+mUpaM99CLgJhLZDhheqryOrBSsYC+ojzYtTZFEibZHSvQZqTXdn0bZ/dAV6/U7rGZ5T9WD68IdULbecxWIzLbD54FvkbjWhYg3efGuckZdExEY39EDcbSasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y8vHyTSh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y8vHyTSh"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDpjkj006845
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CYReooKpTAGn/vR9y2RCTbwRKjsuvRuuurKnIf3s24g=; b=Y8vHyTShu4tC
	0aSpuvNSRtPY8ASd2ZeXq/WGcFNCiL2HWVeOO/ZD74Fi166Ga0UQ0+4mc6IJcQzZ
	mq77Q8v6dXLRtYJYJWko3/U9E/+BE1PCoQvWPiiFaPFyuBRmnt9Bt0Ssg1wdEjW1
	MjpaNxZC4Zv6Nk5k0WhN8f11aIKrysR3Z5U5BFxt7dxvaKopbbB1XqEKP+BsnHu+
	jaT7YYReIZNQNDca2aYDo1meFJLRGM3RDLFpZMgzH9GpfgVY7sYRUAhScqpFYhFe
	ne0fW0rhHsMDGTnKkDFnr/UzjnAXlC/yEcJ07/Z9Njk0bTD42+NsfDTuUIDlJV29
	DGYIetSiVw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g120b14n-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 06:54:20 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 834DF8D4078; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 2/8] blk-mq-dma: provide the bio_vec array being iterated
Date: Tue, 12 Aug 2025 06:52:04 -0700
Message-ID: <20250812135210.4172178-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KJdaDEFo c=1 sm=1 tr=0 ts=689b478c cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=lw-f5-AQ3I1Vcfc_tFYA:9
X-Proofpoint-ORIG-GUID: I1uRPcPdDWwrZ1_ivRTmVcYHl2b7U0sh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfXw8qx3j8eQKO0 SQvYE/K9dU067QSQPqlWbXIqMtKPnFm4xwm8spBIZdtd1bynrE15k19Ap9arzREYRyGo4AWJH+V m1eh7MhsWYASU32biPfFYwznDW+hTy5f2qGFCkvi0BT+k6lpzMfTAQcWFV6y20818WOsN3R5Eh4
 N/WxKtyuDDSsCr6BZ8FEVEJ5sSl3CYTc97Ug+3W3Hc/6vYeyHhW/CVjCEVbiQ+8T9UcKM+S1J61 4zTEkizxFgOXAXbqjCjsumiDr3WvjkNWejluZpen+H8Ief4lzAu2fqweI6k5KyJWjQDigGsFMON sMTpP/elBxKf8SbLOkucq0F7ttHIhCPRJm5R8C5tNyN8+NIEDwi8QlUGPq2m/avYbXgvLnyqDaO
 ZtmhUIM0lBM/VF6Ao1OserVACrpfufMq42G/2d6YRnd9iyzZTFq9gOholzc/pDT9HzPrSobY
X-Proofpoint-GUID: I1uRPcPdDWwrZ1_ivRTmVcYHl2b7U0sh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add different sources of the bvec array,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
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

