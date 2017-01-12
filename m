Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-block@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/2] f2fs: Rename bdev_zone_size to bdev_zone_sectors
Date: Thu, 12 Jan 2017 11:42:53 +0900
Message-Id: <20170112024253.5814-3-damien.lemoal@wdc.com>
In-Reply-To: <20170112024253.5814-1-damien.lemoal@wdc.com>
References: <20170112024253.5814-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

No functional change is introduced by this patch.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/segment.c | 4 ++--
 fs/f2fs/super.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0738f48..0d88024 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -713,8 +713,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 	}
 	sector = SECTOR_FROM_BLOCK(blkstart);
 
-	if (sector & (bdev_zone_size(bdev) - 1) ||
-				nr_sects != bdev_zone_size(bdev)) {
+	if (sector & (bdev_zone_sectors(bdev) - 1) ||
+	    nr_sects != bdev_zone_sectors(bdev)) {
 		f2fs_msg(sbi->sb, KERN_INFO,
 			"(%d) %s: Unaligned discard attempted (block %x + %x)",
 			devi, sbi->s_ndevs ? FDEV(devi).path: "",
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 702638e..46fd30d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1553,16 +1553,16 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 		return 0;
 
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
-				SECTOR_TO_BLOCK(bdev_zone_size(bdev)))
+				SECTOR_TO_BLOCK(bdev_zone_sectors(bdev)))
 		return -EINVAL;
-	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(bdev_zone_size(bdev));
+	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(bdev_zone_sectors(bdev));
 	if (sbi->log_blocks_per_blkz && sbi->log_blocks_per_blkz !=
 				__ilog2_u32(sbi->blocks_per_blkz))
 		return -EINVAL;
 	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
 	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
 					sbi->log_blocks_per_blkz;
-	if (nr_sectors & (bdev_zone_size(bdev) - 1))
+	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
 		FDEV(devi).nr_blkz++;
 
 	FDEV(devi).blkz_type = kmalloc(FDEV(devi).nr_blkz, GFP_KERNEL);
-- 
2.9.3

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
