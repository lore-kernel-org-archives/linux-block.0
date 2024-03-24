Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6312107
	for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711287438; cv=none; b=EJ5hxiaVKUfBPOlhuruifQq6OddIfk6BIPMByJLMizxyOL2k9BST8qQDuYudIr2pxkBp4ho/VpUto0pG7NLkQ1fQgzw48/WDRvCiBNFUPCets0fqAuCFSrSBtnzEvRv6Kp3J2RJi5tGRvWBtNG53R0XIYDW3qG4fTvFWEeHf/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711287438; c=relaxed/simple;
	bh=obkzoISKFME38mMoUpqyesSPf80Bew847m7FkWr3SLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3OPkZfHBKkZdk0swE2Rcu4tu2PLyJ5EPvLrmZFPpsdpXjR6OuHtpuJsvgQtvSBCwh0U1QHcAK24EhCQD75xozniZ8sTpiJbl6Kc+SvFq9gqI0SjHVzJb13wZ1PW5kNt7puusYz8On5zKUjcCa02/zyNfHIlXQkHST7+QMyhhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNfJTUn6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNfJTUn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711287435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6cKByn2OBPklE8PuGDNeAk8hrhzrul4zFIiRsckPUlE=;
	b=gNfJTUn6Ivr1V52SPEqW7nwloJpX6iWCv5R0fm1N8yX97WQbT8rS3uOqNy51ob6UmSrxTK
	OxapjjF0lZccgxKih+Eu6qelTFdyoVO2qdyvFcfmsm7Aj7Zlc4ZTsplO+0U6JDtYkD3tgJ
	//EvHCY8Alzk2jc56Kzb+R11Mq+ZPT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-QzpZgfpuPx6untMmSuhPKw-1; Sun,
 24 Mar 2024 09:37:12 -0400
X-MC-Unique: QzpZgfpuPx6untMmSuhPKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1E3C3C01DB4;
	Sun, 24 Mar 2024 13:37:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B024A1121306;
	Sun, 24 Mar 2024 13:37:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Date: Sun, 24 Mar 2024 21:37:02 +0800
Message-ID: <20240324133702.1328237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

For any FS bio, its start sector and size have to be aligned with the
queue's logical block size from beginning, because bio split code can't
make one aligned bio.

This rule is obvious, but there is still user which may send unaligned
bio to block layer, and it is observed that dm-integrity can do that,
and cause double free of driver's dma meta buffer.

So failfast unaligned bio from submit_bio_noacct() for avoiding more
troubles.

Meantime remove this kind of check in dio and discard code path.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove the check in dio and discard code path
	- check .bi_sector with (logical_block_size >> 9) - 1

 block/blk-core.c | 16 ++++++++++++++++
 block/blk-lib.c  | 17 -----------------
 block/fops.c     |  3 +--
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..2d86922f95e3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -729,6 +729,19 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 		__submit_bio_noacct(bio);
 }
 
+static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
+{
+	unsigned int bs = q->limits.logical_block_size;
+
+	if (bio->bi_iter.bi_size & (bs - 1))
+		return false;
+
+	if (bio->bi_iter.bi_sector & ((bs >> SECTOR_SHIFT) - 1))
+		return false;
+
+	return true;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -780,6 +793,9 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
+	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
+		goto end_io;
+
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		bio_clear_polled(bio);
 
diff --git a/block/blk-lib.c b/block/blk-lib.c
index a6954eafb8c8..ea1a7d16ffdf 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -39,7 +39,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
 	struct bio *bio = *biop;
-	sector_t bs_mask;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
@@ -53,10 +52,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		return -EOPNOTSUPP;
 	}
 
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
-
 	if (!nr_sects)
 		return -EINVAL;
 
@@ -217,11 +212,6 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		unsigned flags)
 {
 	int ret;
-	sector_t bs_mask;
-
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
 
 	ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp_mask,
 			biop, flags);
@@ -250,15 +240,10 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
 {
 	int ret = 0;
-	sector_t bs_mask;
 	struct bio *bio;
 	struct blk_plug plug;
 	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
 
-	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
-
 retry:
 	bio = NULL;
 	blk_start_plug(&plug);
@@ -313,8 +298,6 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 
 	if (max_sectors == 0)
 		return -EOPNOTSUPP;
-	if ((sector | nr_sects) & bs_mask)
-		return -EINVAL;
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe8..75595c728190 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -37,8 +37,7 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 			      struct iov_iter *iter)
 {
-	return pos & (bdev_logical_block_size(bdev) - 1) ||
-		!bdev_iter_is_aligned(bdev, iter);
+	return !bdev_iter_is_aligned(bdev, iter);
 }
 
 #define DIO_INLINE_BIO_VECS 4
-- 
2.41.0

