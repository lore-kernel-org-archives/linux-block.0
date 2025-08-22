Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0743314D7
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882663; cv=none; b=Xq23+TdPBxaTNpQtvSztrmt6sJrYW3sCpkE2gZQwT1xagEMQqnK16dpWcQT3udNWUkfhAKxWC+Us2fAQZu4c4qHOkXF3EcfNM6lOVMSIOn8R66+qr0RlWHQDIUHlGKK3WKw3M/lfPNf9+/hCtfPkm6JIWWKqp4jw80bXkj3CTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882663; c=relaxed/simple;
	bh=siG3rqPeWYx/FOZYceF6K5VABi2BqBI12It1MnUnB9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KFfAJ5MfB0un247QvGfiGPpX4UGPQPY9pRpQV1RonrxAi7eJNhFh22lnPuFVshA/aK9UR6u7OEOpOyRNAUOJDkwXSK3VnymWQY23yeuLFS7THN6EZbciKux64E1Qxe7U09/+WxJsOxF9OoIqPowT3X+dPPR4pkmTVeD5Nzq2Zwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RPDDqw6+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RPDDqw6+"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57MGDIlj3540321
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 10:10:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=fgdy+fZjYX4yFEe2i1
	+utS3elAgraOTifFsEuqqPIIg=; b=RPDDqw6+PUljwF1t3lr5JW5HdBkJuymRXx
	f8UEuRMdrFHiK7z+6mvf8+t5iOPQcSgjGxvCfST9aGJZeo6UDX3OUQp6OIuX7nV5
	QBzXX6+cVJoFI8M1tHfNUZipmk6Nw95TdqVWi5BTQq+6mSa6EA7wW+l3k5liEZky
	dAcOdGLXnHgpFVQcJXSilaSNGFiMMVWSUogEZba427olSNB3OjhLZKjJOa5ks8kU
	qTozbXZXRNzWkBAtD9Qd/PcIKP7qHfMRDfqtU+LlnO5QD6rzkS1EhC3T8g1Q6En7
	M5WOx2t8M+9W8j2t9Q6BtfvRfJQMAzxUlHXt9nYhiEDmVfvO1bOg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48ptdr16bu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 10:10:56 -0700 (PDT)
Received: from twshared51809.40.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 22 Aug 2025 17:10:55 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id DF03BE246FF; Fri, 22 Aug 2025 10:10:40 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <ming.lei@redhat.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: rename min_segment_size
Date: Fri, 22 Aug 2025 10:10:38 -0700
Message-ID: <20250822171038.1847867-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE1NyBTYWx0ZWRfX9dcGDlkh1s3F
 KmK1L319nwzkZA5qUQpMA01NhoQVz9svjRYc8TKXy3/2b70GLJ9QaHaZ/zvbUwCS3kaS6J8sX+o
 RyRqtiYNuGRGg3oN44cwFSvnG8iwfHuk5ZzH8ZYXHZhsJKxljAe9h2xR1Bwo+iuWId4BCVQEIzK
 +Z8rLEKWrYG7y/kiXtfQingOYheXsTlTxH2SLjn9eQrXNhfIPR+HJengSP/xHc9VJk3jR6TY55q
 GUnyji8fFRNAU47ymMqbUPX/VKHYVd0AEn4QQg1vK2uu5kOQSsFSOySEgR0NlGqZw3uHnk5xw1e
 7vMt+BrNJ4k3Vg2N5ZFR87NhBhz/KG55iXMv1qBvWIpvWM0ArFyeiFkljFoGm47L6r+aF8xi79D
 IgmlqYp9jXzNSz5vsWoHXE52MmmRNMiqvNUPeq4pGTIWXxziJJkG7oilyPn3T0JxNKwD8W3r
X-Proofpoint-ORIG-GUID: 7jFmCspnWKHw6foI9bP-fucBKw9s3gjz
X-Proofpoint-GUID: 7jFmCspnWKHw6foI9bP-fucBKw9s3gjz
X-Authority-Analysis: v=2.4 cv=E6KUZadl c=1 sm=1 tr=0 ts=68a8a4a0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=ed2C8nVDbJhc1O_0NaQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Despite its name, the block layer is fine with segments smaller that the
"min_segment_size" limit. The value is an optimization limit indicating
the largest aligned segment that can be used without considering segment
boundary limits, so give it a name that reflects that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-merge.c      | 2 +-
 block/blk-settings.c   | 4 ++--
 block/blk.h            | 2 +-
 include/linux/blkdev.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be52..863a4a6d3da62 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -307,7 +307,7 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
-		    bv.bv_offset + bv.bv_len <=3D lim->min_segment_size) {
+		    bv.bv_offset + bv.bv_len <=3D lim->max_aligned_segment) {
 			nsegs++;
 			bytes +=3D bv.bv_len;
 		} else {
diff --git a/block/blk-settings.c b/block/blk-settings.c
index d6438e6c276dc..a61d676ff4c49 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -442,12 +442,12 @@ int blk_validate_limits(struct queue_limits *lim)
 			return -EINVAL;
 	}
=20
-	/* setup min segment size for building new segment in fast path */
+	/* setup max aligned segment size for building new segment in fast path=
 */
 	if (lim->seg_boundary_mask > lim->max_segment_size - 1)
 		seg_size =3D lim->max_segment_size;
 	else
 		seg_size =3D lim->seg_boundary_mask + 1;
-	lim->min_segment_size =3D min_t(unsigned int, seg_size, PAGE_SIZE);
+	lim->max_aligned_segment =3D min_t(unsigned int, seg_size, PAGE_SIZE);
=20
 	/*
 	 * We require drivers to at least do logical block aligned I/O, but
diff --git a/block/blk.h b/block/blk.h
index 46f566f9b1266..ed60d3dcdf93c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -376,7 +376,7 @@ static inline bool bio_may_need_split(struct bio *bio=
,
 	if (bio->bi_vcnt !=3D 1)
 		return true;
 	return bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
-		lim->min_segment_size;
+		lim->max_aligned_segment;
 }
=20
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe1797bbec420..b8d4333716e59 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -378,7 +378,7 @@ struct queue_limits {
 	unsigned int		max_sectors;
 	unsigned int		max_user_sectors;
 	unsigned int		max_segment_size;
-	unsigned int		min_segment_size;
+	unsigned int		max_aligned_segment;
 	unsigned int		physical_block_size;
 	unsigned int		logical_block_size;
 	unsigned int		alignment_offset;
--=20
2.47.3

