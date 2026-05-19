Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6931714C
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211436; cv=none; b=KRT8pRcwyHlUakpXdUURB304tX5N634JJ0g1jjHMwN7njHmWdAb1xWc32XbIOSE3Wug51nDxgKUfFisrdqHQz+cbHwUuNXsxp+xvMdqI6S8HkRb15ZNLMxT/dmqxyswadOrPXW2K9dvt0PSTFKR3E/4nx6Qrx+NeeGJepsI2S4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211436; c=relaxed/simple;
	bh=e0oIcmN8+1ep1bh58F1tgTfUm4w1ul9QO85JG7GGepg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odK7A+6CpnYX7eS0NZc/lqFtJZZ9/guBw6JawhTLoK/TF3kMn1cqXUlSaKb9MaJ+5GJwO5bdUYIBPTss400FIUkbxF+ZMnGcsSmPxPVOgLKk4ofmWTqPo4+0Ube6XNZu3BTZFs+X/oGXz+G+Nn0PdAzckDLJVt//CIKe3RODU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HdJmUTvD; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HdJmUTvD"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JE8sUl2574853
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hAjNNmsJlmTwdygCv/v0MdTyBZ6EB8ZgAs7fQf87abM=; b=HdJmUTvD8RAH
	JK0f61PnJPIKNPPvI2MSvnOMu/YN2J/6eutxmLtUVrt5KmqFsdHEYb5mL1nasILB
	OZ5W2uyOB7TYAlowXkexOqj5hAjKUOnCGLNsQpAEEpx2L/mviKP4IwRa752vlnv9
	Dau8IoJhQlL+hoTApfmCz0cVbKsF7koHcXJ5JdNlV7znQv5KzXa3ht6YZcISpDfb
	231063T+a+HDDHaQw0/6R2/lcBHnNZr7OWMLo6B8EeQgwNULGC9bfXuus0J7Tofy
	Wp0ibTdBGNyXHfhcBAm6ZwY1oL6BIWFUjODyjIVpzsI+TVA0Ac58lnq1bQrxx76t
	/+iFZoaMyQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8sc51bm2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:23:51 -0700 (PDT)
Received: from twshared11179.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:48 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 428CA1A7597AD; Tue, 19 May 2026 10:23:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 4/5] block: move bio validation into __bio_split_to_limits
Date: Tue, 19 May 2026 10:23:25 -0700
Message-ID: <20260519172326.3462354-5-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TaimcxQh c=1 sm=1 tr=0 ts=6a0c9ca7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=41LZjE2E2PsU4Ko168kA:9
X-Proofpoint-ORIG-GUID: 02DrwNhy_JqeSXGVW5HSDjYkYSJzAeS3
X-Proofpoint-GUID: 02DrwNhy_JqeSXGVW5HSDjYkYSJzAeS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3MyBTYWx0ZWRfX68+VIYzGO2vy
 //MV1uzcoQhLclNqa3BDZGrOGYvv9YByKaMKABr5hmx3M+vUWd0vhSD3AO54gKw/5oJ3IAdLUpF
 Um6H7LOf+WnW3NUwJ3/97cr4uKMfaLTCOUhj0zZJRHsqIopQmtHoXO5ulm4o5uCP7eaAdTyE4eJ
 DAnX4TOeRWNPtp+87lRo8t2l5uOShEvDCE7gfB2FBSkUCxOx4pvtAjOdV6rKZ6aOj8oGuwGLbVA
 yFiXLV6BzYBcWPAMRKxmMm1syT2GcYgjJ9n7YUJImwfOI9tv6VTXJ/Nu024f4Xd/gcy2Ey10DC3
 2seqxxmoWf4dlD72jX83yMuXm9uD2cbNScJ2o6BGXw0laihkmIDhneZYSCfnHq42wHTl54icQl+
 3n9NxT+AvO5PYrrovWBeTscLW7vSabHLk27IdldZiUX1to+Q8EQ2rM1D9LBxccPlmzsno+ugz7o
 jxvIANrer6XoQUaLb+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The bio checks in submit_bio_noacct() compares queue limits to determine
whether operations like discard, write zeroes, zone append, and atomic
writes are supported and valid. These checks run before
bio_queue_enter(), so they race against any driver that updates queue
limits inside a freeze window.

Move all limit-dependent operation validation from submit_bio_noacct()
into __bio_split_to_limits(), which runs after the queue usage reference
has been acquired. This ensures that all checks are properly serialized
against limit updates.

The non-limit checks (crypto, fault injection, partition remap, and
flush flag handling) remain in submit_bio_noacct() as they do not
depend on queue limits.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 118 -----------------------------------------------
 block/blk.h      |  75 ++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 121 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c200d0fc44fe7..8360c2b5efee5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -519,25 +519,6 @@ static int __init fail_make_request_debugfs(void)
 late_initcall(fail_make_request_debugfs);
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
=20
-static inline void bio_check_ro(struct bio *bio)
-{
-	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
-		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
-			return;
-
-		if (bdev_test_flag(bio->bi_bdev, BD_RO_WARNED))
-			return;
-
-		bdev_set_flag(bio->bi_bdev, BD_RO_WARNED);
-
-		/*
-		 * Use ioctl to set underlying disk of raid/dm to read-only
-		 * will trigger this.
-		 */
-		pr_warn("Trying to write to read-only block-device %pg\n",
-			bio->bi_bdev);
-	}
-}
=20
 int should_fail_bio(struct bio *bio)
 {
@@ -566,39 +547,6 @@ static int blk_partition_remap(struct bio *bio)
 	return 0;
 }
=20
-/*
- * Check write append to a zoned block device.
- */
-static inline blk_status_t blk_check_zone_append(struct request_queue *q=
,
-						 struct bio *bio)
-{
-	int nr_sectors =3D bio_sectors(bio);
-
-	/* Only applicable to zoned block devices */
-	if (!bdev_is_zoned(bio->bi_bdev))
-		return BLK_STS_NOTSUPP;
-
-	/* The bio sector must point to the start of a sequential zone */
-	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector))
-		return BLK_STS_INVAL;
-
-	/*
-	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
-	 * split and could result in non-contiguous sectors being written in
-	 * different zones.
-	 */
-	if (nr_sectors > q->limits.chunk_sectors)
-		return BLK_STS_INVAL;
-
-	/* Make sure the BIO is small enough and will not get split */
-	if (nr_sectors > q->limits.max_zone_append_sectors)
-		return BLK_STS_INVAL;
-
-	bio->bi_opf |=3D REQ_NOMERGE;
-
-	return BLK_STS_OK;
-}
-
 static void __submit_bio(struct bio *bio)
 {
 	/* If plug is not used, add new plug here to cache nsecs time. */
@@ -731,18 +679,6 @@ void submit_bio_noacct_nocheck(struct bio *bio, bool=
 split)
 	}
 }
=20
-static blk_status_t blk_validate_atomic_write_op_size(struct request_que=
ue *q,
-						 struct bio *bio)
-{
-	if (bio->bi_iter.bi_size > queue_atomic_write_unit_max_bytes(q))
-		return BLK_STS_INVAL;
-
-	if (bio->bi_iter.bi_size % queue_atomic_write_unit_min_bytes(q))
-		return BLK_STS_INVAL;
-
-	return BLK_STS_OK;
-}
-
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -755,7 +691,6 @@ static blk_status_t blk_validate_atomic_write_op_size=
(struct request_queue *q,
 void submit_bio_noacct(struct bio *bio)
 {
 	struct block_device *bdev =3D bio->bi_bdev;
-	struct request_queue *q =3D bdev_get_queue(bdev);
 	blk_status_t status =3D BLK_STS_IOERR;
=20
 	might_sleep();
@@ -776,7 +711,6 @@ void submit_bio_noacct(struct bio *bio)
=20
 	if (should_fail_bio(bio))
 		goto end_io;
-	bio_check_ro(bio);
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (bdev_is_partition(bdev) &&
 		    unlikely(blk_partition_remap(bio)))
@@ -800,58 +734,6 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
=20
-	switch (bio_op(bio)) {
-	case REQ_OP_READ:
-		break;
-	case REQ_OP_WRITE:
-		if (bio->bi_opf & REQ_ATOMIC) {
-			status =3D blk_validate_atomic_write_op_size(q, bio);
-			if (status !=3D BLK_STS_OK)
-				goto end_io;
-		}
-		break;
-	case REQ_OP_FLUSH:
-		/*
-		 * REQ_OP_FLUSH can't be submitted through bios, it is only
-		 * synthetized in struct request by the flush state machine.
-		 */
-		goto not_supported;
-	case REQ_OP_DISCARD:
-		if (!bdev_max_discard_sectors(bdev))
-			goto not_supported;
-		break;
-	case REQ_OP_SECURE_ERASE:
-		if (!bdev_max_secure_erase_sectors(bdev))
-			goto not_supported;
-		break;
-	case REQ_OP_ZONE_APPEND:
-		status =3D blk_check_zone_append(q, bio);
-		if (status !=3D BLK_STS_OK)
-			goto end_io;
-		break;
-	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
-			goto not_supported;
-		break;
-	case REQ_OP_ZONE_RESET:
-	case REQ_OP_ZONE_OPEN:
-	case REQ_OP_ZONE_CLOSE:
-	case REQ_OP_ZONE_FINISH:
-	case REQ_OP_ZONE_RESET_ALL:
-		if (!bdev_is_zoned(bio->bi_bdev))
-			goto not_supported;
-		break;
-	case REQ_OP_DRV_IN:
-	case REQ_OP_DRV_OUT:
-		/*
-		 * Driver private operations are only used with passthrough
-		 * requests.
-		 */
-		fallthrough;
-	default:
-		goto not_supported;
-	}
-
 	if (blk_throtl_bio(bio))
 		return;
 	submit_bio_noacct_nocheck(bio, false);
diff --git a/block/blk.h b/block/blk.h
index e70acb2d358e3..d3b897e9b5ee9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -407,6 +407,22 @@ static inline bool bio_may_need_split(struct bio *bi=
o,
 	return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
 }
=20
+static inline void bio_check_ro(struct bio *bio)
+{
+	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
+		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
+			return;
+
+		if (bdev_test_flag(bio->bi_bdev, BD_RO_WARNED))
+			return;
+
+		bdev_set_flag(bio->bi_bdev, BD_RO_WARNED);
+
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bio->bi_bdev);
+	}
+}
+
 /**
  * __bio_split_to_limits - split a bio to fit the queue limits
  * @bio:     bio to be split
@@ -423,6 +439,8 @@ static inline bool bio_may_need_split(struct bio *bio=
,
 static inline struct bio *__bio_split_to_limits(struct bio *bio,
 		const struct queue_limits *lim, unsigned int *nr_segs)
 {
+	bio_check_ro(bio);
+
 	if (unlikely(bio_end_sector(bio) > bdev_nr_sectors(bio->bi_bdev) +
 					   bio->bi_bdev->bd_start_sect)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
@@ -435,24 +453,75 @@ static inline struct bio *__bio_split_to_limits(str=
uct bio *bio,
 	}
=20
 	switch (bio_op(bio)) {
-	case REQ_OP_READ:
 	case REQ_OP_WRITE:
+		if (bio->bi_opf & REQ_ATOMIC) {
+			if (bio->bi_iter.bi_size > lim->atomic_write_unit_max ||
+			    bio->bi_iter.bi_size % lim->atomic_write_unit_min)
+				goto invalid;
+		}
+		fallthrough;
+	case REQ_OP_READ:
 		if (bio_may_need_split(bio, lim))
 			return bio_split_rw(bio, lim, nr_segs);
 		*nr_segs =3D 1;
 		return bio;
 	case REQ_OP_ZONE_APPEND:
+		/* Only applicable to zoned block devices */
+		if (!(lim->features & BLK_FEAT_ZONED))
+			goto not_supported;
+
+		/* The bio sector must point to the start of a sequential zone */
+		if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector))
+			goto invalid;
+
+		/*
+		 * Not allowed to cross zone boundaries. Otherwise, the BIO
+		 * will be split and could result in non-contiguous sectors
+		 * being written in different zones.
+		 */
+		if (bio_sectors(bio) > lim->chunk_sectors)
+			goto invalid;
+
+		/* Make sure the BIO is small enough and will not get split */
+		if (bio_sectors(bio) > lim->max_zone_append_sectors)
+			goto invalid;
+
+		bio->bi_opf |=3D REQ_NOMERGE;
 		return bio_split_zone_append(bio, lim, nr_segs);
 	case REQ_OP_DISCARD:
+		if (!lim->max_discard_sectors)
+			goto not_supported;
+		return bio_split_discard(bio, lim, nr_segs);
 	case REQ_OP_SECURE_ERASE:
+		if (!lim->max_secure_erase_sectors)
+			goto not_supported;
 		return bio_split_discard(bio, lim, nr_segs);
 	case REQ_OP_WRITE_ZEROES:
+		if (!lim->max_write_zeroes_sectors)
+			goto not_supported;
 		return bio_split_write_zeroes(bio, lim, nr_segs);
-	default:
-		/* other operations can't be split */
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_RESET_ALL:
+		if (!(lim->features & BLK_FEAT_ZONED))
+			goto not_supported;
 		*nr_segs =3D 0;
 		return bio;
+	default:
+		WARN_ON_ONCE(1);
+		goto not_supported;
 	}
+
+invalid:
+	bio->bi_status =3D BLK_STS_INVAL;
+	bio_endio(bio);
+	return NULL;
+not_supported:
+	bio->bi_status =3D BLK_STS_NOTSUPP;
+	bio_endio(bio);
+	return NULL;
 ioerr:
 	bio_io_error(bio);
 	return NULL;
--=20
2.53.0-Meta

