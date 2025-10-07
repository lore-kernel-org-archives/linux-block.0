Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A82D3EDF
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859586; cv=none; b=DnyIklE36KwdCB9z9Ng7fZTYBdeltIzwMdywUKE6K5oYbEQV8glGxHoDFSwttxxpLxCui8JW/Ta1NYlF37m+gV8eFzkWSmCneJqt5Rx8d2BE0Dr9hN2Gv6GXroS3QK6KQ91JunX8m0CbVBbTN1ikhnsDiBfuoPF7rmx94fSJXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859586; c=relaxed/simple;
	bh=2o9mYuIAejIspwaymXbyWyh0ybtBIRYMowLwaKT7d0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PovdQoh2m7suBOJdRV8Ao8Tzxar8sgADq2t/UhE3nSFpgU7Z8ugYGRBSvh9SwfEjg5F+F8U6JlCKnzkC9hXjanSLIijWTidO9X22eT0vhhWaMWHpgBSYrlrp1fxqJ42PeOgsKEa4sA4hp9a/8jIbhNClkQ2l+ROpS8wlEEKsj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e462vKpF; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e462vKpF"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 597FWeiF3666085
	for <linux-block@vger.kernel.org>; Tue, 7 Oct 2025 10:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uuqBMWLuCzQhX0PmhscpdJVGjiv+IuwVSa6Izqs6bcI=; b=e462vKpFo4RN
	2a9ANVzlxqgfeT/uGVGuUeSDcRhZIHUtPdDL+iAKh8edV1VvEmenLhjTpAokIABU
	XMbGbGuxrdwDV71zmuFv/zxmMx/TO46nvamEKHScEKSoYeapy6rTYeu7XyAd8HeK
	VATLWwq5nZMoEqcukZQUk8VJI+oYz28BYOwBMlsKVaThtxqR0uUJYJxwIZpqAXUw
	mqw97pTIjTANhw9R+Cw2sQZyg5wDVMacBbKn1YSt6cwR+B4B3Fap1J6Fw6FTvs1j
	4GomCzxW+upI67daouoM8icGWhlp5JLHD+i+YxZI1bPh0U456NRtCSO3vaZpmrkl
	rPq8GN3LGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49mwg6ms5t-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 07 Oct 2025 10:53:03 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 7 Oct 2025 17:52:59 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0CC64278193B; Tue,  7 Oct 2025 10:52:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 1/2] block: accumulate memory segment gaps per bio
Date: Tue, 7 Oct 2025 10:52:44 -0700
Message-ID: <20251007175245.3898972-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007175245.3898972-1-kbusch@meta.com>
References: <20251007175245.3898972-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: L3CIBvZWKFoLVfmEzT9m_h0EpFOdHptv
X-Proofpoint-ORIG-GUID: L3CIBvZWKFoLVfmEzT9m_h0EpFOdHptv
X-Authority-Analysis: v=2.4 cv=PsSergM3 c=1 sm=1 tr=0 ts=68e5537f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=S8h0BaExRh3C7Ut8becA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0MSBTYWx0ZWRfX0p9MmzV9mduk
 aElY98eZq9xh4djt6LgX4u83zVcrXo6E98ZzYvhVz7DFxoFo7GMxD0R3hKEDV0xqW3pAKC85TzZ
 nYii5QlxMWJBo9HCnyr7sgSy2bRqmGUWh0U7hSoMA+sR+b+nvPSIzPe3MO4N8JsbA55JqQoCa2i
 6ObKEbQsV77E2DqWZlPhnX496QlZwddW/Ogpu1dPaYuU74S6bPK081DGduBgXPZDLPsaHuld437
 4CnNeUv8E8SoYTeAOFjAXHJCrG9u+IYYEMUv3QibLVO8r+2u+5zmahyP0/O2S2c2IoToQyxqUGt
 frpmWn6TetOZQdm0mgKMbt+8jL76GZPLvLWDIN7d37gaTsB4AB1gQGiuxK/ypNvCkuUiYUBvT/0
 DEAu2ai+pKtaerUuBplTBO6NBOGwTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The blk-mq dma iterator has an optimization for requests that align to
the device's iommu merge boundary. This boundary may be larger than the
device's virtual boundary, but the code had been depending on that queue
limit to know ahead of time if the request is guaranteed to align to
that optimization.

Rather than rely on that queue limit, which many devices may not report,
save the lowest set bit of any boundary gap between each segment in the
bio while checking the segments. The request turns this into a mask for
merging and quickly checking per io if the request can use the iova
optimization.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               |  1 +
 block/blk-map.c           |  3 +++
 block/blk-merge.c         | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-dma.c        |  3 +--
 block/blk-mq.c            | 10 ++++++++++
 block/blk.h               |  9 +++++++--
 include/linux/bio.h       |  2 ++
 include/linux/blk-mq.h    |  8 ++++++++
 include/linux/blk_types.h | 12 ++++++++++++
 9 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278d..7b13bdf72de09 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -253,6 +253,7 @@ void bio_init(struct bio *bio, struct block_device *b=
dev, struct bio_vec *table,
 	bio->bi_write_hint =3D 0;
 	bio->bi_write_stream =3D 0;
 	bio->bi_status =3D 0;
+	bio->bi_bvec_gap_bit =3D 0;
 	bio->bi_iter.bi_sector =3D 0;
 	bio->bi_iter.bi_size =3D 0;
 	bio->bi_iter.bi_idx =3D 0;
diff --git a/block/blk-map.c b/block/blk-map.c
index 60faf036fb6e4..770baf6001718 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,6 +459,7 @@ int blk_rq_append_bio(struct request *rq, struct bio =
*bio)
 	if (rq->bio) {
 		if (!ll_back_merge_fn(rq, bio, nr_segs))
 			return -EINVAL;
+		rq->phys_gap |=3D bio_seg_gap(rq->q, rq->biotail, bio);
 		rq->biotail->bi_next =3D bio;
 		rq->biotail =3D bio;
 		rq->__data_len +=3D bio->bi_iter.bi_size;
@@ -469,6 +470,8 @@ int blk_rq_append_bio(struct request *rq, struct bio =
*bio)
 	rq->nr_phys_segments =3D nr_segs;
 	rq->bio =3D rq->biotail =3D bio;
 	rq->__data_len =3D bio->bi_iter.bi_size;
+	if (bio->bi_bvec_gap_bit)
+		rq->phys_gap =3D 1 << (bio->bi_bvec_gap_bit - 1);
 	return 0;
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 37864c5d287ef..aadf8cab92ec5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -302,6 +302,12 @@ static unsigned int bio_split_alignment(struct bio *=
bio,
 	return lim->logical_block_size;
 }
=20
+static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
+					struct bio_vec *bv)
+{
+	return __bvec_gap(bvprv, bv->bv_offset, U32_MAX);
+}
+
 /**
  * bio_split_io_at - check if and where to split a bio
  * @bio:  [in] bio to be split
@@ -318,9 +324,9 @@ static unsigned int bio_split_alignment(struct bio *b=
io,
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
 {
+	unsigned nsegs =3D 0, bytes =3D 0, gaps =3D 0;
 	struct bio_vec bv, bvprv, *bvprvp =3D NULL;
 	struct bvec_iter iter;
-	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
 		if (bv.bv_offset & lim->dma_alignment ||
@@ -331,8 +337,11 @@ int bio_split_io_at(struct bio *bio, const struct qu=
eue_limits *lim,
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
-			goto split;
+		if (bvprvp) {
+			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
+				goto split;
+			gaps |=3D bvec_seg_gap(bvprvp, &bv);
+		}
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
@@ -350,6 +359,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 	}
=20
 	*segs =3D nsegs;
+	bio->bi_bvec_gap_bit =3D ffs(gaps);
 	return 0;
 split:
 	if (bio->bi_opf & REQ_ATOMIC)
@@ -385,6 +395,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
+	bio->bi_bvec_gap_bit =3D ffs(gaps);
 	return bytes >> SECTOR_SHIFT;
 }
 EXPORT_SYMBOL_GPL(bio_split_io_at);
@@ -721,6 +732,24 @@ static bool blk_atomic_write_mergeable_rqs(struct re=
quest *rq,
 	return (rq->cmd_flags & REQ_ATOMIC) =3D=3D (next->cmd_flags & REQ_ATOMI=
C);
 }
=20
+inline unsigned int bio_seg_gap(struct request_queue *q, struct bio *pre=
v,
+				struct bio *next)
+{
+	unsigned int gaps =3D 0;
+	struct bio_vec pb, nb;
+
+	if (prev->bi_bvec_gap_bit)
+		gaps |=3D 1 << (prev->bi_bvec_gap_bit - 1);
+	if (next->bi_bvec_gap_bit)
+		gaps |=3D 1 << (next->bi_bvec_gap_bit - 1);
+
+	bio_get_last_bvec(prev, &pb);
+	bio_get_first_bvec(next, &nb);
+	if (!biovec_phys_mergeable(q, &pb, &nb))
+		gaps |=3D bvec_seg_gap(&pb, &nb);
+	return gaps;
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be hel=
d.
@@ -785,6 +814,8 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
 	if (next->start_time_ns < req->start_time_ns)
 		req->start_time_ns =3D next->start_time_ns;
=20
+	req->phys_gap |=3D bio_seg_gap(req->q, req->biotail, next->bio) |
+			   next->phys_gap;
 	req->biotail->bi_next =3D next->bio;
 	req->biotail =3D next->biotail;
=20
@@ -908,6 +939,7 @@ enum bio_merge_status bio_attempt_back_merge(struct r=
equest *req,
 	if (req->rq_flags & RQF_ZONE_WRITE_PLUGGING)
 		blk_zone_write_plug_bio_merged(bio);
=20
+	req->phys_gap |=3D bio_seg_gap(req->q, req->biotail, bio);
 	req->biotail->bi_next =3D bio;
 	req->biotail =3D bio;
 	req->__data_len +=3D bio->bi_iter.bi_size;
@@ -942,6 +974,7 @@ static enum bio_merge_status bio_attempt_front_merge(=
struct request *req,
=20
 	blk_update_mixed_merge(req, bio, true);
=20
+	req->phys_gap |=3D bio_seg_gap(req->q, bio, req->bio);
 	bio->bi_next =3D req->bio;
 	req->bio =3D bio;
=20
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 449950029872a..0f2de31987def 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, stru=
ct blk_map_iter *iter,
 static inline bool blk_can_dma_map_iova(struct request *req,
 		struct device *dma_dev)
 {
-	return !((queue_virt_boundary(req->q) + 1) &
-		dma_get_merge_boundary(dma_dev));
+	return !(req->phys_gap & dma_get_merge_boundary(dma_dev));
 }
=20
 static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *=
vec)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 09f5794141615..a5095bfc15964 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -376,6 +376,7 @@ void blk_rq_init(struct request_queue *q, struct requ=
est *rq)
 	INIT_LIST_HEAD(&rq->queuelist);
 	rq->q =3D q;
 	rq->__sector =3D (sector_t) -1;
+	rq->phys_gap =3D 0;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag =3D BLK_MQ_NO_TAG;
@@ -668,6 +669,7 @@ struct request *blk_mq_alloc_request(struct request_q=
ueue *q, blk_opf_t opf,
 			goto out_queue_exit;
 	}
 	rq->__data_len =3D 0;
+	rq->phys_gap =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -748,6 +750,7 @@ struct request *blk_mq_alloc_request_hctx(struct requ=
est_queue *q,
 	rq =3D blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
 	rq->__data_len =3D 0;
+	rq->phys_gap =3D 0;
 	rq->__sector =3D (sector_t) -1;
 	rq->bio =3D rq->biotail =3D NULL;
 	return rq;
@@ -2674,6 +2677,12 @@ static void blk_mq_bio_to_request(struct request *=
rq, struct bio *bio,
 	rq->bio =3D rq->biotail =3D bio;
 	rq->__sector =3D bio->bi_iter.bi_sector;
 	rq->__data_len =3D bio->bi_iter.bi_size;
+
+	if (bio->bi_bvec_gap_bit)
+		rq->phys_gap =3D 1 << (bio->bi_bvec_gap_bit - 1);
+	else
+		rq->phys_gap  =3D 0;
+
 	rq->nr_phys_segments =3D nr_segs;
 	if (bio_integrity(bio))
 		rq->nr_integrity_segments =3D blk_rq_count_integrity_sg(rq->q,
@@ -3380,6 +3389,7 @@ int blk_rq_prep_clone(struct request *rq, struct re=
quest *rq_src,
 	}
 	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
 	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
+	rq->phys_gap =3D rq_src->phys_gap;
=20
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/block/blk.h b/block/blk.h
index 170794632135d..0617b167fcb8d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -140,11 +140,16 @@ static inline bool biovec_phys_mergeable(struct req=
uest_queue *q,
 	return true;
 }
=20
+static inline u32 __bvec_gap(struct bio_vec *bprv, unsigned int offset,
+				unsigned long mask)
+{
+	return (offset | (bprv->bv_offset + bprv->bv_len)) & mask;
+}
+
 static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	return (offset & lim->virt_boundary_mask) ||
-		((bprv->bv_offset + bprv->bv_len) & lim->virt_boundary_mask);
+	return __bvec_gap(bprv, offset, lim->virt_boundary_mask);
 }
=20
 /*
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 16c1c85613b76..3ae305d7a6c59 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,6 +324,8 @@ extern struct bio *bio_split(struct bio *bio, int sec=
tors,
 			     gfp_t gfp, struct bio_set *bs);
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes, unsigned len_align);
+unsigned int bio_seg_gap(struct request_queue *q, struct bio *prev,
+			struct bio *next);
=20
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b25d12545f46d..31546f3e943b2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -152,6 +152,14 @@ struct request {
 	unsigned short nr_phys_segments;
 	unsigned short nr_integrity_segments;
=20
+	/*
+	 * A mask that contains bits set for virtual address gaps between
+	 * physical segments. This provides information necessary for dma
+	 * optimization opprotunities, like for testing if the segments can be
+	 * coalesced against the device's iommu granule.
+	 */
+	unsigned int phys_gap;
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct bio_crypt_ctx *crypt_ctx;
 	struct blk_crypto_keyslot *crypt_keyslot;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8e8d1cc8b06c4..4162afd313463 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -218,6 +218,18 @@ struct bio {
 	enum rw_hint		bi_write_hint;
 	u8			bi_write_stream;
 	blk_status_t		bi_status;
+
+	/*
+	 * The bvec gap bit indicates the lowest set bit in any address offset
+	 * between all bi_io_vecs. This field is initialized only after
+	 * splitting to the hardware limits. It may be used to consider DMA
+	 * optimization when performing that mapping. The value is compared to
+	 * a power of two mask where the result depends on any bit set within
+	 * the mask, so saving the lowest bit is sufficient to know if any
+	 * segment gap collides with the mask.
+	 */
+	u8			bi_bvec_gap_bit;
+
 	atomic_t		__bi_remaining;
=20
 	struct bvec_iter	bi_iter;
--=20
2.47.3

