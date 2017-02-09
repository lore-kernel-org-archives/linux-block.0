Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/10] block: Unhash also block device inode for the whole device
Date: Thu,  9 Feb 2017 13:44:25 +0100
Message-Id: <20170209124433.2626-3-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Iteration over partitions in del_gendisk() omits part0. Add
bdev_unhash_inode() call for the whole device. Otherwise if the device
number gets reused, bdev inode will be still associated with the old
(stale) bdi.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index 6cb9f3a34a92..f6c4d4400759 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -655,6 +655,7 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_exit(&piter);
 
 	invalidate_partition(disk, 0);
+	bdev_unhash_inode(disk_devt(disk));
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 
-- 
2.10.2
