Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B0227EBE
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448056; cv=none; b=jxVrzlTjWhzZOkbt8oIbXZUdv3vlBNZ3AtuNXB30LjZLbJ5wIWDqbULuWu79ntu84GMSnd8PCAWE6o2nThonJuuTA8GTGYXms4eRcM6ewNgaR71PG0FSs3fa6QQxc1TB1GNQpdxsSFGjKy0iuQqyu3r7jilGDiGfH50Y1a/SCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448056; c=relaxed/simple;
	bh=aORZ7MDKgtGD93YPuAZMcZ6SPm7OZVFIyZwWQ4oAvck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cw88MxIRf/vtt04dZM0oI4L7ZcmzWrbZD3oQRDhyTXaXKecheEAP0wNjrZqz88t43TN8UScHb6lrxAm61FVqEnKG+f+IbIYANsz8oXFdCHzNBTODkVzpejofA5sebdawkl7xvtpRjix+2bhfuyPf6LiccL51XgJ7W3bV3DiqB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiMutFgo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiMutFgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739448052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JU22T3CSnH+THatLJhezsF06FYAyScu/GN2ZCLAPZFg=;
	b=JiMutFgoeOq6L2NYsg8ZCmCvz3XZjC8g+Az0jqosmb//WBuHamfWKlM4elbkO0EInycqHQ
	b8SkfHWhtv6zprIFClwUGQldPNpVsY4vUgElCNuIVtJJ2837eLBz5Lxl5tlhmdxBSkSWMi
	T9PNO+5qDRBT9hbWwf0fE7+VeBiA3mg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-3O5MfwjVM2KjNnZEvU_9gQ-1; Thu,
 13 Feb 2025 07:00:49 -0500
X-MC-Unique: 3O5MfwjVM2KjNnZEvU_9gQ-1
X-Mimecast-MFC-AGG-ID: 3O5MfwjVM2KjNnZEvU_9gQ_1739448047
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C9B418EB2CF;
	Thu, 13 Feb 2025 12:00:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96B8D1800360;
	Thu, 13 Feb 2025 12:00:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Paul Bunyan <pbunyan@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH V3] block: make segment size limit workable for > 4K PAGE_SIZE
Date: Thu, 13 Feb 2025 20:00:40 +0800
Message-ID: <20250213120040.2271709-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

PAGE_SIZE is applied in validating block device queue limits, this way is
very fragile and is wrong:

- queue limits are read from hardware, which is often one readonly hardware
property

- PAGE_SIZE is one config option which can be changed during build time.

In RH lab, it has been found that max segment size of some mmc card is
less than 64K, then this kind of card can't be probed successfully when
same kernel is re-built with 64K PAGE_SIZE.

Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
with queue limits and checking if bio needn't split as a hint. Define
BLK_MIN_SEGMENT_SIZE as 4K(minimized PAGE_SIZE).

The following commits are depended for backporting:

commit 6aeb4f836480 ("block: remove bio_add_pc_page")
commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
commit b7175e24d6ac ("block: add a dma mapping iterator")

Cc: Paul Bunyan <pbunyan@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- rephrase commit log & fix patch style(Christoph)
	- more comment log(Christoph)
V2:
	- cover bio_split_rw_at()
	- add BLK_MIN_SEGMENT_SIZE

 block/blk-merge.c      | 2 +-
 block/blk-settings.c   | 6 +++---
 block/blk.h            | 8 ++++++--
 include/linux/blkdev.h | 2 ++
 4 files changed, 12 insertions(+), 6 deletions(-)

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
index 90fa5f28ccab..0eca1687bec4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -358,8 +358,12 @@ struct bio *bio_split_zone_append(struct bio *bio,
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
+		BLK_MIN_SEGMENT_SIZE;
 }
 
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 248416ecd01c..2021b2174268 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1163,6 +1163,8 @@ static inline bool bdev_is_partition(struct block_device *bdev)
 enum blk_default_limits {
 	BLK_MAX_SEGMENTS	= 128,
 	BLK_SAFE_MAX_SECTORS	= 255,
+	/* use minimized PAGE_SIZE as min segment size hint */
+	BLK_MIN_SEGMENT_SIZE	= 4096,
 	BLK_MAX_SEGMENT_SIZE	= 65536,
 	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
 };
-- 
2.47.1

