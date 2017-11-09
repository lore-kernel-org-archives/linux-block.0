Return-Path: <BATV+880bc34f87153fcb2b61+5191+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 6/7] block: create 'slaves' and 'holders' entries for hidden gendisks
Date: Thu,  9 Nov 2017 18:44:49 +0100
Message-Id: <20171109174450.17142-7-hch@lst.de>
In-Reply-To: <20171109174450.17142-1-hch@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

When creating nvme multipath devices we should populate the 'slaves' and
'holders' directorys properly to aid userspace topology detection.

Signed-off-by: Hannes Reinecke <hare@suse.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 835e907e6e01..3de1671631bf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -585,14 +585,14 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
+	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
+	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
+
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		dev_set_uevent_suppress(ddev, 0);
 		return;
 	}
 
-	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
-	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
-
 	/* No minors to use for partitions */
 	if (!disk_part_scan_enabled(disk))
 		goto exit;
@@ -728,11 +728,11 @@ void del_gendisk(struct gendisk *disk)
 		WARN_ON(1);
 	}
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+	if (!(disk->flags & GENHD_FL_HIDDEN))
 		blk_unregister_region(disk_devt(disk), disk->minors);
-		kobject_put(disk->part0.holder_dir);
-		kobject_put(disk->slave_dir);
-	}
+
+	kobject_put(disk->part0.holder_dir);
+	kobject_put(disk->slave_dir);
 
 	part_stat_set_all(&disk->part0, 0);
 	disk->part0.stamp = 0;
-- 
2.14.2
