Return-Path: <suhua.tanke@gmail.com>
Return-Path: <suhua.tanke@gmail.com>
From: Su Hua <suhua.tanke@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Su Hua <suhua.tanke@gmail.com>
Subject: [PATCH] block: Add a check for fdisk
Date: Thu, 30 Aug 2018 17:11:27 +0800
Message-Id: <1535620287-27189-1-git-send-email-suhua.tanke@gmail.com>
List-ID: <linux-block@vger.kernel.org>

When a block device is acquired in the form of FMODE_EXCL, I think it
should not be allowed to perform partition operations, similar to when
mount is executed.

Signed-off-by: Su Hua <suhua.tanke@gmail.com>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5a8975a..a8daa31 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -440,7 +440,7 @@ static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct hd_struct *part;
 	int res;
 
-	if (bdev->bd_part_count || bdev->bd_super)
+	if (bdev->bd_part_count || bdev->bd_super || bdev->bd_holders)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.7.4
