Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6270 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdA1IoB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 03:44:01 -0500
Subject: [RFC PATCH 09/17] block: kill bdev_dax_capable()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: snitzer@redhat.com, toshi.kani@hpe.com, mawilcox@microsoft.com,
        linux-block@vger.kernel.org, jmoyer@redhat.com,
        linux-fsdevel@vger.kernel.org, ross.zwisler@linux.intel.com,
        hch@lst.de
Date: Sat, 28 Jan 2017 00:36:52 -0800
Message-ID: <148559261248.11180.9969692627177035979.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This is leftover dead code that has since been replaced by
bdev_dax_supported().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/block_dev.c         |   24 ------------------------
 include/linux/blkdev.h |    1 -
 2 files changed, 25 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 601b71b76d7f..edb1d2b16b8f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -807,30 +807,6 @@ int bdev_dax_supported(struct super_block *sb, int blocksize)
 }
 EXPORT_SYMBOL_GPL(bdev_dax_supported);
 
-/**
- * bdev_dax_capable() - Return if the raw device is capable for dax
- * @bdev: The device for raw block device access
- */
-bool bdev_dax_capable(struct block_device *bdev)
-{
-	struct blk_dax_ctl dax = {
-		.size = PAGE_SIZE,
-	};
-
-	if (!IS_ENABLED(CONFIG_FS_DAX))
-		return false;
-
-	dax.sector = 0;
-	if (bdev_direct_access(bdev, &dax) < 0)
-		return false;
-
-	dax.sector = bdev->bd_part->nr_sects - (PAGE_SIZE / 512);
-	if (bdev_direct_access(bdev, &dax) < 0)
-		return false;
-
-	return true;
-}
-
 /*
  * pseudo-fs
  */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3c0ff78b1219..5e7706f7d533 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1904,7 +1904,6 @@ extern int bdev_write_page(struct block_device *, sector_t, struct page *,
 						struct writeback_control *);
 extern long bdev_direct_access(struct block_device *, struct blk_dax_ctl *);
 extern int bdev_dax_supported(struct super_block *, int);
-extern bool bdev_dax_capable(struct block_device *);
 #else /* CONFIG_BLOCK */
 
 struct block_device;

