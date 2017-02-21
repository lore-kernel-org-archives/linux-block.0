Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/13] block: Move bdev_unhash_inode() after invalidate_partition()
Date: Tue, 21 Feb 2017 18:09:46 +0100
Message-Id: <20170221170958.21845-2-jack@suse.cz>
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Move bdev_unhash_inode() after invalidate_partition() as
invalidate_partition() looks up bdev and it cannot find the right bdev
inode after bdev_unhash_inode() is called. Thus invalidate_partition()
would not invalidate page cache of the previously used bdev. Also use
part_devt() when calling bdev_unhash_inode() instead of manually
creating the device number.

Tested-by: Lekshmi Pillai <lekshmicpillai@in.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d9ccd42f3675..6cb9f3a34a92 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -648,9 +648,8 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
-		bdev_unhash_inode(MKDEV(disk->major,
-					disk->first_minor + part->partno));
 		invalidate_partition(disk, part->partno);
+		bdev_unhash_inode(part_devt(part));
 		delete_partition(disk, part->partno);
 	}
 	disk_part_iter_exit(&piter);
-- 
2.10.2
