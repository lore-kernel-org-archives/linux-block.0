Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: [resend PATCH v2 14/33] Revert "block: use DAX for partition table
 reads"
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Date: Mon, 17 Apr 2017 12:10:06 -0700
Message-ID: <149245620593.10206.1616718006783093047.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

commit d1a5f2b4d8a1 ("block: use DAX for partition table reads") was
part of a stalled effort to allow dax mappings of block devices. Since
then the device-dax mechanism has filled the role of dax-mapping static
device ranges.

Now that we are moving ->direct_access() from a block_device operation
to a dax_inode operation we would need block devices to map and carry
their own dax_inode reference.

Unless / until we decide to revive dax mapping of raw block devices
through the dax_inode scheme, there is no need to carry
read_dax_sector(). Its removal in turn allows for the removal of
bdev_direct_access() and should have been included in commit
223757016837 ("block_dev: remove DAX leftovers").

Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 block/partition-generic.c |   17 ++---------------
 fs/dax.c                  |   20 --------------------
 include/linux/dax.h       |    6 ------
 3 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 7afb9907821f..5dfac337b0f2 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -16,7 +16,6 @@
 #include <linux/kmod.h>
 #include <linux/ctype.h>
 #include <linux/genhd.h>
-#include <linux/dax.h>
 #include <linux/blktrace_api.h>
 
 #include "partitions/check.h"
@@ -631,24 +630,12 @@ int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
 	return 0;
 }
 
-static struct page *read_pagecache_sector(struct block_device *bdev, sector_t n)
-{
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
-
-	return read_mapping_page(mapping, (pgoff_t)(n >> (PAGE_SHIFT-9)),
-				 NULL);
-}
-
 unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
 {
+	struct address_space *mapping = bdev->bd_inode->i_mapping;
 	struct page *page;
 
-	/* don't populate page cache for dax capable devices */
-	if (IS_DAX(bdev->bd_inode))
-		page = read_dax_sector(bdev, n);
-	else
-		page = read_pagecache_sector(bdev, n);
-
+	page = read_mapping_page(mapping, (pgoff_t)(n >> (PAGE_SHIFT-9)), NULL);
 	if (!IS_ERR(page)) {
 		if (PageError(page))
 			goto fail;
diff --git a/fs/dax.c b/fs/dax.c
index de622d4282a6..b78a6947c4f5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -101,26 +101,6 @@ static int dax_is_empty_entry(void *entry)
 	return (unsigned long)entry & RADIX_DAX_EMPTY;
 }
 
-struct page *read_dax_sector(struct block_device *bdev, sector_t n)
-{
-	struct page *page = alloc_pages(GFP_KERNEL, 0);
-	struct blk_dax_ctl dax = {
-		.size = PAGE_SIZE,
-		.sector = n & ~((((int) PAGE_SIZE) / 512) - 1),
-	};
-	long rc;
-
-	if (!page)
-		return ERR_PTR(-ENOMEM);
-
-	rc = dax_map_atomic(bdev, &dax);
-	if (rc < 0)
-		return ERR_PTR(rc);
-	memcpy_from_pmem(page_address(page), dax.addr, PAGE_SIZE);
-	dax_unmap_atomic(bdev, &dax);
-	return page;
-}
-
 /*
  * DAX radix tree locking
  */
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 7e62e280c11f..0d0d890f9186 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -70,15 +70,9 @@ void dax_wake_mapping_entry_waiter(struct address_space *mapping,
 		pgoff_t index, void *entry, bool wake_all);
 
 #ifdef CONFIG_FS_DAX
-struct page *read_dax_sector(struct block_device *bdev, sector_t n);
 int __dax_zero_page_range(struct block_device *bdev, sector_t sector,
 		unsigned int offset, unsigned int length);
 #else
-static inline struct page *read_dax_sector(struct block_device *bdev,
-		sector_t n)
-{
-	return ERR_PTR(-ENXIO);
-}
 static inline int __dax_zero_page_range(struct block_device *bdev,
 		sector_t sector, unsigned int offset, unsigned int length)
 {
