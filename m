Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7754782
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178220; cv=none; b=DKpX1Pd/51G0qbyqGtKrh3O1CfC3Qro4xhfGMyfFP9i7S2z7fgx/5+GGoZ1ySG1DOoqfP4rmq6JOrz/lTjexZcyILy0UQGI1aNB2Q4noXSeadlAdAaMgo9/cL5K7EiykXNSLwgPyHFOqu5IGHKpwZ6/OHVJN7PpomtUwlqOYfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178220; c=relaxed/simple;
	bh=dyq2zkms5uLAkJy6+Ur+7Fxh8c+H4JntxqnuUInLUT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSycDK2yzWZYDtc4UVkv+vs4E7yMKdNwD5D50stxdblEnS80ZLjpWfGSqE4CgPmgkVbLgNLuVF//lq3cshEp4PCvQ/+MhVPV/ObhiTyvFcPhTeHLFUO9bHC1ZMv0/oiZSKpJ+UJLbicpstd8KoIg60kdnijbrRL/OXgqMbaW1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3dSjEEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3dSjEEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739178217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OPbqxC+bBkn/rw22qBBUlqkLeiUsxuz4Hm1R7a6w1sc=;
	b=D3dSjEEKZk4TMP3n5dXSb4UABSDZwvb8FrmF1ftyDGkx1/81vH5wjoTxvi0EKTpts5CQzf
	iPk/tan/KunHJVOJ+Jy1x81AXXcadO0m4ZriWqRfB+UzwTXbRAbO2jwIqr4al2HcHjrOnx
	HkVb4JFzj/iyMdKaUpOz+L/eqgipMC0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-CTXqqA8kP1yYx5SRptLVYw-1; Mon,
 10 Feb 2025 04:03:35 -0500
X-MC-Unique: CTXqqA8kP1yYx5SRptLVYw-1
X-Mimecast-MFC-AGG-ID: CTXqqA8kP1yYx5SRptLVYw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9DE31800873;
	Mon, 10 Feb 2025 09:03:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9ADC31800352;
	Mon, 10 Feb 2025 09:03:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2] block: make segment size limit workable for > 4K PAGE_SIZE
Date: Mon, 10 Feb 2025 17:03:19 +0800
Message-ID: <20250210090319.1519778-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

PAGE_SIZE is applied in some block device queue limits, this way is
very fragile and is wrong:

- queue limits are read from hardware, which is often one readonly
hardware property

- PAGE_SIZE is one config option which can be changed during build time.

In RH lab, it has been found that max segment size of some mmc card is
less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.

Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
as 4K(minimized PAGE_SIZE).

Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- cover bio_split_rw_at()
	- add BLK_MIN_SEGMENT_SIZE

 block/blk-merge.c      | 2 +-
 block/blk-settings.c   | 6 +++---
 block/blk.h            | 2 +-
 include/linux/blkdev.h | 1 +
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..b55c52a42303 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
 			nsegs++;
 			bytes += bv.bv_len;
 		} else {
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..539a64ad7989 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -303,7 +303,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
 	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
@@ -341,7 +341,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->seg_boundary_mask)
 		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
-	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
 		return -EINVAL;
 
 	/*
@@ -362,7 +362,7 @@ int blk_validate_limits(struct queue_limits *lim)
 		 */
 		if (!lim->max_segment_size)
 			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
 			return -EINVAL;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 90fa5f28ccab..cbfa8a3d4e42 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -359,7 +359,7 @@ static inline bool bio_may_need_split(struct bio *bio,
 		const struct queue_limits *lim)
 {
 	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
-		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
+		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > BLK_MIN_SEGMENT_SIZE;
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..32188af4051e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1163,6 +1163,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
 enum blk_default_limits {
 	BLK_MAX_SEGMENTS	= 128,
 	BLK_SAFE_MAX_SECTORS	= 255,
+	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */
 	BLK_MAX_SEGMENT_SIZE	= 65536,
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
-- 
2.47.1

