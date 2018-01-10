Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33723 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965935AbeAJQTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jan 2018 11:19:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so6050761wme.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2018 08:19:09 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 2/2] block: add bdev_read_only() checks to common helpers
Date: Wed, 10 Jan 2018 17:18:38 +0100
Message-Id: <1515601118-23192-3-git-send-email-idryomov@gmail.com>
In-Reply-To: <1515601118-23192-1-git-send-email-idryomov@gmail.com>
References: <1515601118-23192-1-git-send-email-idryomov@gmail.com>
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
index 2bc544ce3d2e..a676084d4740 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -37,6 +37,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	if (flags & BLKDEV_DISCARD_SECURE) {
 		if (!blk_queue_secure_erase(q))
 			return -EOPNOTSUPP;
@@ -156,6 +159,9 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
@@ -233,6 +239,9 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	if (!q)
 		return -ENXIO;
 
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
 	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
 	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev);
 
@@ -287,6 +296,9 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
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
