Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:55490 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753764AbdKISpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 13:45:36 -0500
Received: by mail-wr0-f196.google.com with SMTP id l8so6468801wre.12
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 10:45:36 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/2] block: add bdev_read_only() checks to common helpers
Date: Thu,  9 Nov 2017 19:45:01 +0100
Message-Id: <1510253101-10291-3-git-send-email-idryomov@gmail.com>
In-Reply-To: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
References: <1510253101-10291-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Similar to blkdev_write_iter(), return -EPERM if the partition is
read-only.  This covers ioctl(), fallocate() and most in-kernel users
but isn't meant to be exhaustive -- everything else will be caught in
generic_make_request_checks(), fail with -EIO and can be fixed later.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/blk-lib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index f625fda5f095..64fe863ae43a 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -36,6 +36,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secure_erase(q))
 			return -EOPNOTSUPP;
@@ -155,6 +158,9 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
@@ -232,6 +238,9 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
 	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev);
 
@@ -286,6 +295,9 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	while (nr_sects != 0) {
 		bio = next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
 			       gfp_mask);
-- 
2.4.3
