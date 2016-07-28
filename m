Return-Path: <mnghuan@gmail.com>
Return-Path: <mnghuan@gmail.com>
From: Minfei Huang <mnghuan@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minfei Huang <mnghuan@gmail.com>,
	Minfei Huang <minfei.hmf@alibaba-inc.com>
Subject: [PATCH] blk-core: Fix the bad IO during checking bio
Date: Thu, 28 Jul 2016 18:19:44 +0800
Message-Id: <1469701184-50412-1-git-send-email-mnghuan@gmail.com>
List-ID: <linux-block@vger.kernel.org>

We will handle IO as a bad IO, if its range exceeds the disk's capacity
in function bio_check_eod. Also we should catch the corner case if
inode->i_size is set to 0 during disabling disk.

Fix the coming IO as a bad IO as well, if inode->i_size is set to 0.

Signed-off-by: Minfei Huang <mnghuan@gmail.com>
Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
---
 block/blk-core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2475b1c7..765dfc4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1896,25 +1896,23 @@ static inline bool should_fail_request(struct hd_struct *part,
  */
 static inline int bio_check_eod(struct bio *bio, unsigned int nr_sectors)
 {
-	sector_t maxsector;
+	sector_t maxsector, sector;
 
 	if (!nr_sectors)
 		return 0;
 
 	/* Test device or partition size, when known. */
 	maxsector = i_size_read(bio->bi_bdev->bd_inode) >> 9;
-	if (maxsector) {
-		sector_t sector = bio->bi_iter.bi_sector;
+	sector = bio->bi_iter.bi_sector;
 
-		if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
-			/*
-			 * This may well happen - the kernel calls bread()
-			 * without checking the size of the device, e.g., when
-			 * mounting a device.
-			 */
-			handle_bad_sector(bio);
-			return 1;
-		}
+	if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
+		/*
+		 * This may well happen - the kernel calls bread()
+		 * without checking the size of the device, e.g., when
+		 * mounting a device.
+		 */
+		handle_bad_sector(bio);
+		return 1;
 	}
 
 	return 0;
-- 
2.7.4 (Apple Git-66)
