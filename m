Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF0237180
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866678; cv=none; b=OptZf0NM5lMdPOiigYFtVtRG6ZrWq3ri5pisl6pzJ58G+4zXfLZ9Q8P4tftZ5kX9QsLxfvzKRHC+eZ3wkh9CgO9sJryPSHOryjcjd2hAUXw4Nh6Q3KJs2ATN0C6cQEp6UNIcywnD9i0jKBjqPsWHD/vVk4xJGhfg9OQWGdO1VJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866678; c=relaxed/simple;
	bh=mm2fC9jItt3I3jal8CFXa/UU/06SBxOZ2lija3cTH/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaMLpmkq6usmHHNjx5TF8LEpzy335ES5RJbU69SLHGWRxfNzh3OqyJ/IhYT9l5P3CsfXNc8+Yx62nZtDqqwmMJaAo+ElVbDlxcuueU2PmIm4EGRr9QXVQ7dM2mj9HmZbkLeiISTiNViq3Sd+GaVCxB8yvzzaIVNIzAv5mgjK+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=f396gGKy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f396gGKy"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQXcY002432
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=76BL/8uzTnhWt7vmu3ND+81XTuCmI6331OYg+R6LQpM=; b=f396gGKyocq5
	t663m93JREXJPOvSwCIfKQF2vW/cKoxTUDcPWx+ZAk/cA70JBpByLIXagcalEbh8
	KWSO7tQfIgfqjJ7h8rGLpYq/imFx1X/EGzV9D0LVRMAGDSa/Z3S+RLagM5xykmky
	HI++blz5Kn9Ir4pfHmI4/S1l/JzDqc2cE9rfQgLvVakSPHmk/EmrVUeWelzw4TQP
	76a4Enn9kpwLLg5m3ZT2n/BRt2Q1bseSwpBTDUPknJ1yNAt+b6sCTVkwG29dZCt+
	kz9f2btNffBBpGgrlNCzRX4Zq+In8GxvvGrJeBd+xVq7GfX2a/CnAi0r/oATYBbl
	shJ5boKKAQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfgkp1x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:14 -0700 (PDT)
Received: from twshared24170.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:13 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A81221BE54AC5; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/5] block: add support for copy offload
Date: Wed, 21 May 2025 15:31:04 -0700
Message-ID: <20250521223107.709131-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
References: <20250521223107.709131-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JT2UgyYoBT3s3weQim0vju9Ut6gb-WKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfXwmW6Z/zFtTnq xIMb+3kbLqnGhAM2A5Xic6203CLnU3KWH/af3LgB735qRpLGDqFchpIomz+J1ygCAbQOtvX1RvX jE5nVgvpH83gfMz6OED3HYxLDNYz+mVRtcu0Epusmqkg6MlXLvekBdgGjENidYboGpdMcERgrCc
 DOR5DPcJakHCQfjlhYT5OwT2/WXVcGTKsSoLUpLtXoDhngk2nd5sfDLR6wUvyD/NhsCI+JyvE8k s4zelgjeHIA/5Ttn8Ts/iK3xEt3IxLmB/1/w42zw/vKnqm/H03xHRA16vsqYU0NLy5a1Okmt14a 1uhoNtAe6u5r3P4PVzSpWODsbtpdNr7tkaDhUfZByj9XKIOH9kmVA1YEQ/UAgtwS3C6xoNtPgtC
 DVUMTCOy7ZIcsSCNwSFxPpgEH4CIVdhV3pqF4p+eT9CF2hqS5/+OvAuHYsFw+tebOqFKpTox
X-Authority-Analysis: v=2.4 cv=I9BlRMgg c=1 sm=1 tr=0 ts=682e5432 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=HNuTtNmurC4DyLL3C8cA:9
X-Proofpoint-ORIG-GUID: JT2UgyYoBT3s3weQim0vju9Ut6gb-WKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Various storage protocols can support offloading block data copies.
Enhance the block layer to know about the device's copying capabilities,
introduce the new REQ_OP_COPY operation, and provide the infrastructure
to iterate, split, and merge these kinds of requests.

A copy command must provide the device with a list of source LBAs and
their lengths, and a destination LBA. The 'struct bio' type doesn't
readily have a way to describe such a thing. But a copy request doesn't
use host memory for data, so the bio's bio_vec is unused space. This
patch adds a new purpose to the bio_vec where it can provide a vector of
sectors instead of memory pages.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c               | 25 ++++++++++++++
 block/blk-core.c          |  4 +++
 block/blk-lib.c           | 47 ++++++++++++++++++++++-----
 block/blk-merge.c         | 28 +++++++++++++++-
 block/blk-sysfs.c         |  9 ++++++
 block/blk.h               | 17 +++++++++-
 include/linux/bio.h       | 20 ++++++++++++
 include/linux/blk-mq.h    |  5 +++
 include/linux/blk_types.h |  2 ++
 include/linux/blkdev.h    | 14 ++++++++
 include/linux/bvec.h      | 68 +++++++++++++++++++++++++++++++++++++--
 11 files changed, 226 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3c0a558c90f52..9c73a895c987b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1156,6 +1156,31 @@ void bio_iov_bvec_set(struct bio *bio, const struc=
t iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
=20
+static int bvec_try_merge_copy_src(struct bio *bio, struct bio_vec *src)
+{
+	struct bio_vec *bv;
+
+	if (!bio->bi_vcnt)
+		return false;
+
+	bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];
+	if (bv->bv_sector + src->bv_sectors !=3D src->bv_sector)
+		return false;
+
+	bv->bv_sectors +=3D src->bv_sectors;
+	return true;
+}
+
+int bio_add_copy_src(struct bio *bio, struct bio_vec *src)
+{
+	if (bvec_try_merge_copy_src(bio, src))
+		return 0;
+	if (bio->bi_vcnt >=3D bio->bi_max_vecs)
+		return -EINVAL;
+	bio->bi_io_vec[bio->bi_vcnt++] =3D *src;
+	return 0;
+}
+
 static unsigned int get_contig_folio_len(unsigned int *num_pages,
 					 struct page **pages, unsigned int i,
 					 struct folio *folio, size_t left,
diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f25..cb3d9879e2d65 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -837,6 +837,10 @@ void submit_bio_noacct(struct bio *bio)
 		if (!bdev_max_discard_sectors(bdev))
 			goto not_supported;
 		break;
+	case REQ_OP_COPY:
+		if (!bdev_copy_sectors(bdev))
+			goto not_supported;
+		break;
 	case REQ_OP_SECURE_ERASE:
 		if (!bdev_max_secure_erase_sectors(bdev))
 			goto not_supported;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index a819ded0ed3a9..a538acbaa2cd7 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -369,14 +369,7 @@ int blkdev_issue_secure_erase(struct block_device *b=
dev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_secure_erase);
=20
-/**
- * blkdev_copy - copy source sectors to a destination on the same block =
device
- * @dst_sector:	start sector of the destination to copy to
- * @src_sector:	start sector of the source to copy from
- * @nr_sects:	number of sectors to copy
- * @gfp:	allocation flags to use
- */
-int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
+static int __blkdev_copy(struct block_device *bdev, sector_t dst_sector,
 		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
 {
 	unsigned int nr_vecs =3D __blkdev_sectors_to_bio_pages(nr_sects);
@@ -429,4 +422,42 @@ int blkdev_copy(struct block_device *bdev, sector_t =
dst_sector,
 	kvfree(buf);
 	return ret;
 }
+
+static int blkdev_copy_offload(struct block_device *bdev, sector_t dst_s=
ector,
+		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
+{
+	struct bio *bio;
+	int ret;
+
+	struct bio_vec bv =3D {
+		.bv_sector =3D src_sector,
+		.bv_sectors =3D nr_sects,
+	};
+
+	bio =3D bio_alloc(bdev, 1, REQ_OP_COPY, gfp);
+	bio_add_copy_src(bio, &bv);
+	bio->bi_iter.bi_sector =3D dst_sector;
+	bio->bi_iter.bi_size =3D nr_sects << SECTOR_SHIFT;
+
+	ret =3D submit_bio_wait(bio);
+	bio_put(bio);
+	return ret;
+
+}
+
+/**
+ * blkdev_copy - copy source sectors to a destination on the same block =
device
+ * @dst_sector:	start sector of the destination to copy to
+ * @src_sector:	start sector of the source to copy from
+ * @nr_sects:	number of sectors to copy
+ * @gfp:	allocation flags to use
+ */
+int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
+		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
+{
+	if (bdev_copy_sectors(bdev))
+		return blkdev_copy_offload(bdev, dst_sector, src_sector,
+					nr_sects, gfp);
+	return __blkdev_copy(bdev, dst_sector, src_sector, nr_sects, gfp);
+}
 EXPORT_SYMBOL_GPL(blkdev_copy);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add50..8085fc0a27c2f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -399,6 +399,31 @@ struct bio *bio_split_write_zeroes(struct bio *bio,
 	return bio_submit_split(bio, max_sectors);
 }
=20
+struct bio *bio_split_copy(struct bio *bio, const struct queue_limits *l=
im,
+		unsigned *nr_segs)
+{
+	unsigned nsegs =3D 0, sectors =3D 0, mcss =3D lim->max_copy_segment_sec=
tors;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	bio_for_each_copy_bvec(bv, bio, iter, mcss) {
+		unsigned s;
+
+		s =3D min(lim->max_copy_sectors - sectors, bv.bv_sectors);
+		nsegs +=3D 1;
+		sectors +=3D s;
+
+		if (nsegs >=3D lim->max_copy_segments || sectors >=3D lim->max_copy_se=
ctors)
+			break;
+	}
+
+	if (sectors =3D=3D bio_sectors(bio))
+		sectors =3D 0;
+
+	*nr_segs =3D nsegs;
+	return bio_submit_split(bio, sectors);
+}
+
 /**
  * bio_split_to_limits - split a bio to fit the queue limits
  * @bio:     bio to be split
@@ -467,6 +492,7 @@ static inline unsigned int blk_rq_get_max_sectors(str=
uct request *rq,
=20
 	if (!boundary_sectors ||
 	    req_op(rq) =3D=3D REQ_OP_DISCARD ||
+	    req_op(rq) =3D=3D REQ_OP_COPY ||
 	    req_op(rq) =3D=3D REQ_OP_SECURE_ERASE)
 		return max_sectors;
 	return min(max_sectors,
@@ -753,7 +779,7 @@ static struct request *attempt_merge(struct request_q=
ueue *q,
=20
 	req->__data_len +=3D blk_rq_bytes(next);
=20
-	if (!blk_discard_mergable(req))
+	if (!blk_discard_mergable(req) && !blk_copy_mergable(req))
 		elv_merge_requests(q, req, next);
=20
 	blk_crypto_rq_put_keyslot(next);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b2b9b89d6967c..93ce41f399363 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -132,6 +132,7 @@ static ssize_t queue_##_field##_show(struct gendisk *=
disk, char *page)	\
=20
 QUEUE_SYSFS_LIMIT_SHOW(max_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_discard_segments)
+QUEUE_SYSFS_LIMIT_SHOW(max_copy_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_integrity_segments)
 QUEUE_SYSFS_LIMIT_SHOW(max_segment_size)
 QUEUE_SYSFS_LIMIT_SHOW(max_write_streams)
@@ -160,6 +161,8 @@ static ssize_t queue_##_field##_show(struct gendisk *=
disk, char *page)	\
=20
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_discard_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_hw_discard_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_copy_sectors)
+QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_copy_segment_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(max_write_zeroes_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_max_sectors)
 QUEUE_SYSFS_LIMIT_SHOW_SECTORS_TO_BYTES(atomic_write_boundary_sectors)
@@ -501,10 +504,13 @@ QUEUE_LIM_RO_ENTRY(queue_io_min, "minimum_io_size")=
;
 QUEUE_LIM_RO_ENTRY(queue_io_opt, "optimal_io_size");
=20
 QUEUE_LIM_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_copy_segments, "max_copy_segments");
 QUEUE_LIM_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_LIM_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes")=
;
 QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
+QUEUE_RO_ENTRY(queue_max_copy_sectors, "copy_max_bytes");
+QUEUE_RO_ENTRY(queue_max_copy_segment_sectors, "copy_segment_max_bytes")=
;
=20
 QUEUE_LIM_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_byt=
es");
 QUEUE_LIM_RO_ENTRY(queue_atomic_write_boundary_sectors,
@@ -644,6 +650,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
 	&queue_max_discard_segments_entry.attr,
+	&queue_max_copy_segments_entry.attr,
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&queue_max_write_streams_entry.attr,
@@ -657,6 +664,8 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_discard_granularity_entry.attr,
 	&queue_max_discard_sectors_entry.attr,
 	&queue_max_hw_discard_sectors_entry.attr,
+	&queue_max_copy_sectors_entry.attr,
+	&queue_max_copy_segment_sectors_entry.attr,
 	&queue_atomic_write_max_sectors_entry.attr,
 	&queue_atomic_write_boundary_sectors_entry.attr,
 	&queue_atomic_write_unit_min_entry.attr,
diff --git a/block/blk.h b/block/blk.h
index 37ec459fe6562..685f3eeca46e0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -185,10 +185,20 @@ static inline bool blk_discard_mergable(struct requ=
est *req)
 	return false;
 }
=20
+static inline bool blk_copy_mergable(struct request *req)
+{
+	if (req_op(req) =3D=3D REQ_OP_COPY &&
+	    queue_max_copy_segments(req->q) > 1)
+		return true;
+	return false;
+}
+
 static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 {
 	if (req_op(rq) =3D=3D REQ_OP_DISCARD)
 		return queue_max_discard_segments(rq->q);
+	if (req_op(rq) =3D=3D REQ_OP_COPY)
+		return queue_max_copy_segments(rq->q);
 	return queue_max_segments(rq->q);
 }
=20
@@ -200,7 +210,8 @@ static inline unsigned int blk_queue_get_max_sectors(=
struct request *rq)
 	if (unlikely(op =3D=3D REQ_OP_DISCARD || op =3D=3D REQ_OP_SECURE_ERASE)=
)
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
-
+	if (unlikely(op =3D=3D REQ_OP_COPY))
+		return q->limits.max_copy_sectors;
 	if (unlikely(op =3D=3D REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
=20
@@ -347,6 +358,8 @@ struct bio *bio_split_rw(struct bio *bio, const struc=
t queue_limits *lim,
 		unsigned *nr_segs);
 struct bio *bio_split_zone_append(struct bio *bio,
 		const struct queue_limits *lim, unsigned *nr_segs);
+struct bio *bio_split_copy(struct bio *bio, const struct queue_limits *l=
im,
+		unsigned *nsegs);
=20
 /*
  * All drivers must accept single-segments bios that are smaller than PA=
GE_SIZE.
@@ -397,6 +410,8 @@ static inline struct bio *__bio_split_to_limits(struc=
t bio *bio,
 		return bio_split_discard(bio, lim, nr_segs);
 	case REQ_OP_WRITE_ZEROES:
 		return bio_split_write_zeroes(bio, lim, nr_segs);
+	case REQ_OP_COPY:
+		return bio_split_copy(bio, lim, nr_segs);
 	default:
 		/* other operations can't be split */
 		*nr_segs =3D 0;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9c37c66ef9ca3..e25bcde9ec59d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -54,6 +54,7 @@ static inline bool bio_has_data(struct bio *bio)
 	if (bio &&
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) !=3D REQ_OP_DISCARD &&
+	    bio_op(bio) !=3D REQ_OP_COPY &&
 	    bio_op(bio) !=3D REQ_OP_SECURE_ERASE &&
 	    bio_op(bio) !=3D REQ_OP_WRITE_ZEROES)
 		return true;
@@ -68,6 +69,11 @@ static inline bool bio_no_advance_iter(const struct bi=
o *bio)
 	       bio_op(bio) =3D=3D REQ_OP_WRITE_ZEROES;
 }
=20
+static inline bool bio_sector_advance_iter(const struct bio *bio)
+{
+	return bio_op(bio) =3D=3D REQ_OP_COPY;
+}
+
 static inline void *bio_data(struct bio *bio)
 {
 	if (bio_has_data(bio))
@@ -100,6 +106,8 @@ static inline void bio_advance_iter(const struct bio =
*bio,
=20
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -=3D bytes;
+	else if (bio_sector_advance_iter(bio))
+		bvec_iter_sector_advance(bio->bi_io_vec, iter, bytes);
 	else
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
@@ -114,6 +122,8 @@ static inline void bio_advance_iter_single(const stru=
ct bio *bio,
=20
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -=3D bytes;
+	else if (bio_sector_advance_iter(bio))
+		bvec_iter_sector_advance_single(bio->bi_io_vec, iter, bytes);
 	else
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
 }
@@ -155,6 +165,15 @@ static inline void bio_advance(struct bio *bio, unsi=
gned int nbytes)
 		((bvl =3D mp_bvec_iter_bvec((bio)->bi_io_vec, (iter))), 1); \
 	     bio_advance_iter_single((bio), &(iter), (bvl).bv_len))
=20
+#define __bio_for_each_copy_bvec(bvl, bio, iter, start, max)		\
+	for (iter =3D (start);						\
+	     (iter).bi_size &&						\
+		((bvl =3D copy_bvec_iter_bvec((bio)->bi_io_vec, (iter), max)), 1); \
+	     bio_advance_iter_single((bio), &(iter), (bvl).bv_sectors << SECTOR=
_SHIFT))
+
+#define bio_for_each_copy_bvec(bvl, bio, iter, max)			\
+	__bio_for_each_copy_bvec(bvl, bio, iter, (bio)->bi_iter, max)
+
 /* iterate over multi-page bvec */
 #define bio_for_each_bvec(bvl, bio, iter)			\
 	__bio_for_each_bvec(bvl, bio, iter, (bio)->bi_iter)
@@ -409,6 +428,7 @@ extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf=
);
 void bio_chain(struct bio *, struct bio *);
=20
+int bio_add_copy_src(struct bio *bio, struct bio_vec *src);
 int __must_check bio_add_page(struct bio *bio, struct page *page, unsign=
ed len,
 			      unsigned off);
 bool __must_check bio_add_folio(struct bio *bio, struct folio *folio,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index de8c85a03bb7f..49816e7f7df7d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1049,6 +1049,11 @@ struct req_iterator {
 	struct bio *bio;
 };
=20
+#define rq_for_each_copy_bvec(bvl, _rq, _iter)			\
+	__rq_for_each_bio(_iter.bio, _rq)			\
+		bio_for_each_copy_bvec(bvl, _iter.bio, _iter.iter, \
+			_rq->q->limits.max_copy_segment_sectors)
+
 #define __rq_for_each_bio(_bio, rq)	\
 	if ((rq->bio))			\
 		for (_bio =3D (rq)->bio; _bio; _bio =3D _bio->bi_next)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c8..361d44c0d1317 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -355,6 +355,8 @@ enum req_op {
 	REQ_OP_ZONE_RESET	=3D (__force blk_opf_t)13,
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	=3D (__force blk_opf_t)15,
+	/* Copy offload sectors to the device */
+	REQ_OP_COPY		=3D (__force blk_opf_t)17,
=20
 	/* Driver private requests */
 	REQ_OP_DRV_IN		=3D (__force blk_opf_t)34,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7d71b126ec9b..e39ba0e91d43e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -399,9 +399,13 @@ struct queue_limits {
 	unsigned int		atomic_write_hw_unit_max;
 	unsigned int		atomic_write_unit_max;
=20
+	unsigned int		max_copy_sectors;
+	unsigned int		max_copy_segment_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
+	unsigned short		max_copy_segments;
=20
 	unsigned short		max_write_streams;
 	unsigned int		write_stream_granularity;
@@ -1271,6 +1275,11 @@ static inline unsigned short queue_max_discard_seg=
ments(const struct request_que
 	return q->limits.max_discard_segments;
 }
=20
+static inline unsigned short queue_max_copy_segments(const struct reques=
t_queue *q)
+{
+	return q->limits.max_copy_segments;
+}
+
 static inline unsigned int queue_max_segment_size(const struct request_q=
ueue *q)
 {
 	return q->limits.max_segment_size;
@@ -1380,6 +1389,11 @@ static inline unsigned int bdev_write_zeroes_secto=
rs(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_zeroes_sectors;
 }
=20
+static inline unsigned int bdev_copy_sectors(struct block_device *bdev)
+{
+	return bdev_limits(bdev)->max_copy_sectors;
+}
+
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
 	return blk_queue_nonrot(bdev_get_queue(bdev));
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 204b22a99c4ba..7cc82738ede8a 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -21,6 +21,8 @@ struct page;
  * @bv_page:   First page associated with the address range.
  * @bv_len:    Number of bytes in the address range.
  * @bv_offset: Start of the address range relative to the start of @bv_p=
age.
+ * @bv_sector: Start sector associated with the source block range
+ * @bv_sectors: Number of sectors in the block range
  *
  * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
  *
@@ -29,9 +31,17 @@ struct page;
  * This holds because page_is_mergeable() checks the above property.
  */
 struct bio_vec {
-	struct page	*bv_page;
-	unsigned int	bv_len;
-	unsigned int	bv_offset;
+	union {
+		struct {
+			struct page	*bv_page;
+			unsigned int	bv_len;
+			unsigned int	bv_offset;
+		};
+		struct {
+			sector_t	bv_sector;
+			sector_t	bv_sectors;
+		};
+	};
 };
=20
 /**
@@ -118,6 +128,21 @@ struct bvec_iter_all {
 	.bv_offset	=3D mp_bvec_iter_offset((bvec), (iter)),	\
 })
=20
+/* sector based bvec helpers */
+#define copy_bvec_iter_sector(bvec, iter)			\
+	(__bvec_iter_bvec((bvec), (iter))->bv_sector) + 	\
+		((iter).bi_bvec_done >> 9)
+
+#define copy_bvec_iter_sectors(bvec, iter)			\
+	(__bvec_iter_bvec((bvec), (iter))->bv_sectors) -	\
+		((iter).bi_bvec_done >> 9)
+
+#define copy_bvec_iter_bvec(bvec, iter, max)			\
+((struct bio_vec) {						\
+	.bv_sector	=3D copy_bvec_iter_sector((bvec), (iter)),	\
+	.bv_sectors	=3D min(max, copy_bvec_iter_sectors((bvec), (iter))),	\
+})
+
 /* For building single-page bvec in flight */
  #define bvec_iter_offset(bvec, iter)				\
 	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
@@ -161,6 +186,30 @@ static inline bool bvec_iter_advance(const struct bi=
o_vec *bv,
 	return true;
 }
=20
+static inline bool bvec_iter_sector_advance(const struct bio_vec *bv,
+		struct bvec_iter *iter, unsigned bytes)
+{
+	unsigned int idx =3D iter->bi_idx;
+
+	if (WARN_ONCE(bytes > iter->bi_size,
+			"Attempted to advance past end of bvec iter\n")) {
+		iter->bi_size =3D 0;
+		return false;
+	}
+
+	iter->bi_size -=3D bytes;
+	bytes +=3D iter->bi_bvec_done;
+
+	while (bytes && bytes >> 9 >=3D bv[idx].bv_sectors) {
+		bytes -=3D bv[idx].bv_sectors << 9;
+		idx++;
+	}
+
+	iter->bi_idx =3D idx;
+	iter->bi_bvec_done =3D bytes;
+	return true;
+}
+
 /*
  * A simpler version of bvec_iter_advance(), @bytes should not span
  * across multiple bvec entries, i.e. bytes <=3D bv[i->bi_idx].bv_len
@@ -178,6 +227,19 @@ static inline void bvec_iter_advance_single(const st=
ruct bio_vec *bv,
 	iter->bi_size -=3D bytes;
 }
=20
+static inline void bvec_iter_sector_advance_single(const struct bio_vec =
*bv,
+		struct bvec_iter *iter, unsigned bytes)
+{
+	unsigned int done =3D iter->bi_bvec_done + bytes;
+
+	if (done =3D=3D bv[iter->bi_idx].bv_sectors << 9) {
+		done =3D 0;
+		iter->bi_idx++;
+	}
+	iter->bi_bvec_done =3D done;
+	iter->bi_size -=3D bytes;
+}
+
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter =3D (start);						\
 	     (iter).bi_size &&						\
--=20
2.47.1

