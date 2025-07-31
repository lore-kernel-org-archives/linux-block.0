Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6681E
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974326; cv=none; b=aCOXakqhMmBfxVzM2CAwbd75XYQRi8IBXqPESPrLROsDNM9kiqHO5URYAhzkU1EogyNMIHR0f2gIImfQLEvwj8SxNcLr7mSG4s9egaeMzMb1hTCwZpM170WdFdqwI0ORAVYa7sVnRfqCNalXv/9njbaHNexwbDuWnPHDg+rukhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974326; c=relaxed/simple;
	bh=Qy9Lae43B2ABLb81iNTFSbjKmHPPjRTgXBL0k0rfcw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sy6ZAyEnceptp6+RB0qiRsXbEWjNhHjjNkVOnr0cl3CSoxCDTJbocj5oqs6TrMmDlY3Vx3rvPeJA8IncOC8/IZbnN/sHg1CTiLBWyYE8CEotKNMzciNtiGZJziZ2Muw35s1Wb/qAgZ27n1EKMCb0Ib61hooyHvi+Dp0N/xB2tBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FTZPX81x; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FTZPX81x"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VE7PuD012177
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FkMrR99d59z6/nHcnOiZ1oYWkISyCmHMhuU85frwhOE=; b=FTZPX81xWk1A
	1dx4umBCAluAwfo7hOPw+esO/gri6Q63MrkVEjoH5/dMRsTakWlJ+T53hCHFGwkQ
	F8WOo6LTmktka/3dvH5F2dAuACTripp2jPHIur8N7nH0vPC6hX/0El1Ca6INKBJs
	AfLp+TQ1+ERHPvv9c5tnqFUknrljuHiF01gHBp+JvJvK6SSYl0RYcc8bp8YWm6qY
	ZgOKbslHycCmF0SFog6OC5TVsanw3aZO8ly8LLUfUbZb10LXvk+hVkcdCTPJItCa
	s0buBJ4+5XWKYwHuzxuCiygzeJCOBZOqmGgW2m6zMFcOSBd2AIUgK7TFYu74ve9g
	gznYrlDS4g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4883mj2k8f-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 08:05:23 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 15:05:22 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id ECE37231DAA; Thu, 31 Jul 2025 08:05:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 2/8] blk-mq-dma: provide the bio_vec list being iterated
Date: Thu, 31 Jul 2025 08:05:07 -0700
Message-ID: <20250731150513.220395-3-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=K/giHzWI c=1 sm=1 tr=0 ts=688b8633 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=RFQSphkRhlftazc-zEkA:9
X-Proofpoint-ORIG-GUID: QgRjwx9Nhv0btcF-iljz5kXQDfQgC-45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMiBTYWx0ZWRfX8embvj2UpDNb zaH9x+otr+1zDJYGGlqAzLjx4F/oE+G2T78LwYq4Nw/wp9poCt+csDeoPfv+1Eas0atuDcLc2Zr KAJx6LTCciytO9pXCRo1H0zaeeUOIWKA0VNdvivnl/mWUvcpICfNQ9H2LdhEdJNIno3SMwuPOQN
 dt5q7hxorWIqvNIdJG9VGL9ANzn2mYxRr3o3MArBKCbTtd0WbzvN89ADerdtK3QnamJXkGkfK8K Gognw0Vb3FmGwqQE4u3UvyFbpQvHABX2tit/rf/J3uCshiPBCXBQvq/BLtems9vuiFXS1xjRpXY ijIHQeW+n/7gBe+Xwds7xdPpy39Rb1lI0yBBv46Tej9LcO9ZS/QBfGJpd/AXPPsrudHzCe2hi7f
 1sux1pct/86nPCcl0x/3jg0sTzqWxUSviiiWCr1/eLu5k7NSodRWlip610OUbKNJmPACbrfb
X-Proofpoint-GUID: QgRjwx9Nhv0btcF-iljz5kXQDfQgC-45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01

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

