Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: don't look at the struct device dev_t in disk_devt
Date: Thu,  2 Nov 2017 21:29:52 +0300
Message-Id: <20171102182954.9263-6-hch@lst.de>
In-Reply-To: <20171102182954.9263-1-hch@lst.de>
References: <20171102182954.9263-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The hidden gendisks introduced in the next patch need to keep the dev
field in their struct device empty so that udev won't try to create
block device nodes for them.  To support that rewrite disk_devt to
look at the major and first_minor fields in the gendisk itself instead
of looking into the struct device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 block/genhd.c         | 4 ----
 include/linux/genhd.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index dd305c65ffb0..1174d24e405e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -649,10 +649,6 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 		return;
 	}
 	disk_to_dev(disk)->devt = devt;
-
-	/* ->major and ->first_minor aren't supposed to be
-	 * dereferenced from here on, but set them just in case.
-	 */
 	disk->major = MAJOR(devt);
 	disk->first_minor = MINOR(devt);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ea652bfcd675..5c0ed5db33c2 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -234,7 +234,7 @@ static inline bool disk_part_scan_enabled(struct gendisk *disk)
 
 static inline dev_t disk_devt(struct gendisk *disk)
 {
-	return disk_to_dev(disk)->devt;
+	return MKDEV(disk->major, disk->first_minor);
 }
 
 static inline dev_t part_devt(struct hd_struct *part)
-- 
2.14.2
