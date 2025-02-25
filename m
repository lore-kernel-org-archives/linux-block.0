Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D912C544
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450123; cv=none; b=ZYh2q2zi7sH6X3NMdGE1gn0ZRZlQGkarVQWgeQyqvJYasQ/QTVbadrbrWqVYDVw3UEBuqYm+oDFjk7jS12O0lfJW4Xq+csnhU32l1tzBeW4vzkFB3MIqln8YB5LQk1gDORVQeLHM96IcOlgGTcqYUXx0+h4zmVOOLzlr2tkqW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450123; c=relaxed/simple;
	bh=RQgktN5mKcO276VpQdR9sNATKc1U/X+/ru1JpZ+lBrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR6n1ed3o2DrXXKUdE5A6FDU5KdCkxWopPRHafx8yX65hidYfmJ1Ba/7odM3ncUGEne+J2GaRdnAUTdGhaNdhXpqBezzCX5sQejyyR2rcKweXTWY5geZ0obm+VqJDp9B17tPKMiLqdQqJ0CRaRulDSe3rjqr8hSz8/szB+6/LHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTkMBTOm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTkMBTOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740450120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YsRNyWzOAJVYnBlKZUByfiz7qqiqhoQ9cusawn/jc4U=;
	b=BTkMBTOmCb7Ctl82JRcIEYgdS93sDMofyLZSBNbsC64ahmLPWSsMADqxNayONHdKEGWgdm
	nm8OAxXjqibungKYEI1F9NWEjSlqeSdfnMlUok/wAFMgnhm4CMNWoiJZzAjhX7XgNMYp3D
	f1gTnpOUvJ4WQ4ztsFiGqjwBFMycYaI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-Vj7838zEM7Ob_9340rwKag-1; Mon,
 24 Feb 2025 21:21:57 -0500
X-MC-Unique: Vj7838zEM7Ob_9340rwKag-1
X-Mimecast-MFC-AGG-ID: Vj7838zEM7Ob_9340rwKag_1740450115
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3107019373D8;
	Tue, 25 Feb 2025 02:21:55 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CC051800357;
	Tue, 25 Feb 2025 02:21:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5] block: make segment size limit workable for > 4K PAGE_SIZE
Date: Tue, 25 Feb 2025 10:21:41 +0800
Message-ID: <20250225022141.2154581-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Using PAGE_SIZE as a minimum expected DMA segment size in consideration
of devices which have a max DMA segment size of < 64k when used on 64k
PAGE_SIZE systems leads to devices not being able to probe such as
eMMC and Exynos UFS controller [0] [1] you can end up with a probe failure
as follows:

WARNING: CPU: 2 PID: 397 at block/blk-settings.c:339 blk_validate_limits+0x364/0x3c0

Ensure we use min(max_seg_size, seg_boundary_mask + 1) as the new min segment
size when max segment size is < PAGE_SIZE for 16k and 64k base page size systems.

If anyone need to backport this patch, the following commits are depended:

	commit 6aeb4f836480 ("block: remove bio_add_pc_page")
	commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
	commit b7175e24d6ac ("block: add a dma mapping iterator")

Link: https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/ # [0]
Link: https://lore.kernel.org/linux-block/1d55e942-5150-de4c-3a02-c3d066f87028@acm.org/ # [1]
Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>
Tested-by: Paul Bunyan <pbunyan@redhat.com>
Reviewed-by: Daniel Gomez <da.gomez@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V5:
	- update commit log(Luis Chamberlain, Daniel Gomez)
	- move BLK_MIN_SEGMENT_SIZE to private tag(Daniel Gomez)
	- add reviewed-by, tested-by tag
	
V4:
	- take Daniel's suggestion to add min_segment_size limit
	for avoiding to call into split code in case that max_seg_size
	is > PAGE_SIZE

V3:
	- rephrase commit log & fix patch style(Christoph)
	- more comment log(Christoph)
V2:
	- cover bio_split_rw_at()
	- add BLK_MIN_SEGMENT_SIZE

 block/blk-merge.c      |  2 +-
 block/blk-settings.c   | 14 +++++++++++---
 block/blk.h            |  9 +++++++--
 include/linux/blkdev.h |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 15cd231d560c..4fe2dfabfc9d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
 
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <= max_bytes &&
-		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
+		    bv.bv_offset + bv.bv_len <= lim->min_segment_size) {
 			nsegs++;
 			bytes += bv.bv_len;
 		} else {
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..b9c6f0ec1c49 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -246,6 +246,7 @@ int blk_validate_limits(struct queue_limits *lim)
 {
 	unsigned int max_hw_sectors;
 	unsigned int logical_block_sectors;
+	unsigned long seg_size;
 	int err;
 
 	/*
@@ -303,7 +304,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
 	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
@@ -341,7 +342,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->seg_boundary_mask)
 		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
-	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
 		return -EINVAL;
 
 	/*
@@ -362,10 +363,17 @@ int blk_validate_limits(struct queue_limits *lim)
 		 */
 		if (!lim->max_segment_size)
 			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
 			return -EINVAL;
 	}
 
+	/* setup min segment size for building new segment in fast path */
+	if (lim->seg_boundary_mask > lim->max_segment_size - 1)
+		seg_size = lim->max_segment_size;
+	else
+		seg_size = lim->seg_boundary_mask + 1;
+	lim->min_segment_size = min_t(unsigned int, seg_size, PAGE_SIZE);
+
 	/*
 	 * We require drivers to at least do logical block aligned I/O, but
 	 * historically could not check for that due to the separate calls
diff --git a/block/blk.h b/block/blk.h
index 90fa5f28ccab..9cf9a0099416 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -14,6 +14,7 @@
 struct elevator_type;
 
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
+#define	BLK_MIN_SEGMENT_SIZE	4096
 
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
@@ -358,8 +359,12 @@ struct bio *bio_split_zone_append(struct bio *bio,
 static inline bool bio_may_need_split(struct bio *bio,
 		const struct queue_limits *lim)
 {
-	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
-		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
+	if (lim->chunk_sectors)
+		return true;
+	if (bio->bi_vcnt != 1)
+		return true;
+	return bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
+		lim->min_segment_size;
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..58ff5aca83b6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -367,6 +367,7 @@ struct queue_limits {
 	unsigned int		max_sectors;
 	unsigned int		max_user_sectors;
 	unsigned int		max_segment_size;
+	unsigned int		min_segment_size;
 	unsigned int		physical_block_size;
 	unsigned int		logical_block_size;
 	unsigned int		alignment_offset;
-- 
2.47.1

