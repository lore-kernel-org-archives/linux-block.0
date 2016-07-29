Return-Path: <ross.zwisler@linux.intel.com>
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] block: remove BLK_DEV_DAX config option
Date: Fri, 29 Jul 2016 12:23:14 -0600
Message-Id: <20160729182314.6368-1-ross.zwisler@linux.intel.com>
List-ID: <linux-block@vger.kernel.org>

The functionality for block device DAX was already removed with this
commit:

commit acc93d30d7d4 ("Revert "block: enable dax for raw block devices"")

However, we still had a config option hanging around that was always
disabled because it depended on CONFIG_BROKEN.  This config option was
introduced in this commit:

commit 03cdadb04077 ("block: disable block device DAX by default")

This change reverts that commit, removing the dead config option.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 block/Kconfig  | 13 -------------
 fs/block_dev.c |  5 +----
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 0363cd7..161491d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -88,19 +88,6 @@ config BLK_DEV_INTEGRITY
 	T10/SCSI Data Integrity Field or the T13/ATA External Path
 	Protection.  If in doubt, say N.
 
-config BLK_DEV_DAX
-	bool "Block device DAX support"
-	depends on FS_DAX
-	depends on BROKEN
-	help
-	  When DAX support is available (CONFIG_FS_DAX) raw block
-	  devices can also support direct userspace access to the
-	  storage capacity via MMAP(2) similar to a file on a
-	  DAX-enabled filesystem.  However, the DAX I/O-path disables
-	  some standard I/O-statistics, and the MMAP(2) path has some
-	  operational differences due to bypassing the page
-	  cache.  If in doubt, say N.
-
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 71ccab1..ab7ebee 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1287,10 +1287,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_disk = disk;
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
-		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
-			bdev->bd_inode->i_flags = S_DAX;
-		else
-			bdev->bd_inode->i_flags = 0;
+		bdev->bd_inode->i_flags = 0;
 
 		if (!partno) {
 			ret = -ENXIO;
-- 
2.9.0
