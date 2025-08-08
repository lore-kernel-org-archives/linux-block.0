Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B28286439
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668718; cv=none; b=iKr0Cdof3dIZiShzTbc2x6BGmE65YAcVVqOkk9VG8aUfSPMSpJq2d0HTNWUGzVZc5/0b0BnMI5gupRt7HO3g5q5Ss/VIiS92Xcsui5FE/z2xQpwsr08wnT+iHMxiLVCrdd4nLvy7f+ciobevawtZbMI30aZVAQRhaFy3BjwISXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668718; c=relaxed/simple;
	bh=Qy9Lae43B2ABLb81iNTFSbjKmHPPjRTgXBL0k0rfcw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnTm5dHQqT5HcXS0L3tVoAvRN6NMlTagybdrxhrvk5w32/me/fENA1pHSq7kevEobuOIlY4H9PlXypdRmjL+SWzTOe484/mVADS3d/9270yYtQJ7n42e5OnbwevfKa2tRClmRzVuyB3CouDQrjvkOg3AWPB//eOa6ymHOTm8O94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C08uSVwK; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C08uSVwK"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FIuPx017534
	for <linux-block@vger.kernel.org>; Fri, 8 Aug 2025 08:58:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FkMrR99d59z6/nHcnOiZ1oYWkISyCmHMhuU85frwhOE=; b=C08uSVwKyNE5
	8GF27Czq2GHNKE3Y48L9c+4rHm1sGfh1iSPK5uESSMybxumIGCiWULLP6LGpGjfI
	y7rpFsaPR65eLMag/8m3MCdQVooEoeDy90dIlTrUScO4M9AF4C/AZYYPPJihyqqP
	jZoX5bCZujQ+FJh8sOHTlVhcDZ15JgtrU6VqBMfJedJZoq2SKOfGuuD+n9Id0tor
	Lrg5w4QmZZsM73dNTexG1Lt3K9L6tg/WeNcokfqROHd3fN61HZ9yHybdhAho5INS
	PxRoAAOblUp6fhH+nvRMYTT6n0h0ubMz2Y6rgCMjvN/0BFi503VjpVrNuuM+RhnL
	Vl+TjRVm2A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48dcw9tru1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 08 Aug 2025 08:58:36 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:35 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 276EC6C76BF; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being iterated
Date: Fri, 8 Aug 2025 08:58:20 -0700
Message-ID: <20250808155826.1864803-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808155826.1864803-1-kbusch@meta.com>
References: <20250808155826.1864803-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RjMHcsPusujoViEytvsSV_pJC6HcWr9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX2ShHlJPyCOM7 MdRv1naiGq14pFWrhFKef4Ip6kmJBAngqxh2uUdEXB8Lbo5iso/8CQpzMUGA5psL7ry9io6AP8k WfKmVlVLBn0rXviValWohNSYPBUQKmcgDS92vf2Vass/XKgTxVCRgAvwxL7N2cFp4jYnSjGLSRR
 cVamFCySwgmMiberSwxLSTjlZcuB6vUBkCYlPXEd5uKgLeoapw0r+PtZxOv7H9WIS+d4QuufDB/ npQWsPN19dO9572uvUM2ay8dlAQr5en+hI2l1uSOR+LA69NnWYVD9QoN9A278lrfDeqb6mLFMGp wgUhUFGwvvqDb+AKnwIZMDRse6i+aGHPx+U1QRctB4AQPt3y3iWlRwSgptJ7D8gWjITSpjP+h85
 WlB5tZIOv16O0UlGil60Ok/ibThw4jE8n0uerlWmHyZm0soRfbzkSehVkBxhTn2A3+xFsLAI
X-Authority-Analysis: v=2.4 cv=c8WrQQ9l c=1 sm=1 tr=0 ts=68961eac cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=RFQSphkRhlftazc-zEkA:9
X-Proofpoint-GUID: RjMHcsPusujoViEytvsSV_pJC6HcWr9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

This will make it easier to add different sources of the bvec table,
like for upcoming integrity support, rather than assume to use the bio's
bi_io_vec. It also makes iterating "special" payloads more in common
with iterating normal payloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c         | 56 ++++++++++++++++++++++----------------
 include/linux/blk-mq-dma.h |  1 +
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ff4c9a7e19d83..4a013703bcba5 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,23 +10,14 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 	unsigned int max_size;
 	struct bio_vec bv;
=20
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		iter->paddr =3D bvec_phys(&req->special_vec);
-		iter->len =3D req->special_vec.bv_len;
-		iter->bio =3D NULL;
-		return true;
-	}
-
 	if (!iter->iter.bi_size)
 		return false;
=20
-	bv =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 	iter->paddr =3D bvec_phys(&bv);
 	max_size =3D get_max_segment_size(&req->q->limits, iter->paddr, UINT_MA=
X);
 	bv.bv_len =3D min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(iter->bvec, &iter->iter, bv.bv_len);
=20
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -37,19 +28,20 @@ static bool blk_map_iter_next(struct request *req, st=
ruct blk_map_iter *iter)
 		struct bio_vec next;
=20
 		if (!iter->iter.bi_size) {
-			if (!iter->bio->bi_next)
+			if (!iter->bio || !iter->bio->bi_next)
 				break;
 			iter->bio =3D iter->bio->bi_next;
 			iter->iter =3D iter->bio->bi_iter;
+			iter->bvec =3D iter->bio->bi_io_vec;
 		}
=20
-		next =3D mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next =3D mp_bvec_iter_bvec(iter->bvec, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
=20
 		bv.bv_len +=3D next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(iter->bvec, &iter->iter, next.bv_len);
 	}
=20
 	iter->len =3D bv.bv_len;
@@ -119,6 +111,30 @@ static bool blk_rq_dma_map_iova(struct request *req,=
 struct device *dma_dev,
 	return true;
 }
=20
+static struct blk_map_iter blk_rq_map_iter(struct request *rq)
+{
+	struct bio *bio =3D rq->bio;
+
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		return (struct blk_map_iter) {
+			.bvec =3D &rq->special_vec,
+			.iter =3D {
+				.bi_size =3D rq->special_vec.bv_len,
+			}
+		};
+       }
+
+	/* the internal flush request may not have bio attached */
+	if (!bio)
+	        return (struct blk_map_iter) {};
+
+	return (struct blk_map_iter) {
+		.bio =3D bio,
+		.bvec =3D bio->bi_io_vec,
+		.iter =3D bio->bi_iter,
+	};
+}
+
 /**
  * blk_rq_dma_map_iter_start - map the first DMA segment for a request
  * @req:	request to map
@@ -146,10 +162,9 @@ bool blk_rq_dma_map_iter_start(struct request *req, =
struct device *dma_dev,
 {
 	unsigned int total_len =3D blk_rq_payload_bytes(req);
=20
-	iter->iter.bio =3D req->bio;
-	iter->iter.iter =3D req->bio->bi_iter;
 	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
 	iter->status =3D BLK_STS_OK;
+	iter->iter =3D blk_rq_map_iter(req);
=20
 	/*
 	 * Grab the first segment ASAP because we'll need it to check for P2P
@@ -237,16 +252,9 @@ blk_next_sg(struct scatterlist **sg, struct scatterl=
ist *sglist)
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		    struct scatterlist **last_sg)
 {
-	struct bio *bio =3D rq->bio;
-	struct blk_map_iter iter =3D {
-		.bio	=3D bio,
-	};
+	struct blk_map_iter iter =3D blk_rq_map_iter(rq);
 	int nsegs =3D 0;
=20
-	/* the internal flush request may not have bio attached */
-	if (bio)
-		iter.iter =3D bio->bi_iter;
-
 	while (blk_map_iter_next(rq, &iter)) {
 		*last_sg =3D blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(iter.paddr), iter.len,
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 1e5988afdb978..c82f880dee914 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -8,6 +8,7 @@
 struct blk_map_iter {
 	phys_addr_t			paddr;
 	u32				len;
+	struct bio_vec                  *bvec;
 	struct bvec_iter		iter;
 	struct bio			*bio;
 };
--=20
2.47.3

