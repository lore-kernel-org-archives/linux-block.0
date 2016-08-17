Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 06/15] genhd: Add return code to device_add_disk
Date: Wed, 17 Aug 2016 15:15:06 +0800
Message-Id: <1471418115-3654-7-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

There are a number of places in device_add_disk that can fail, and even
more to come as we extend it.

Switch the return type of the function, and return the error code when
error happens.

The WARN_ON is kept because callers are not updated to check the error
yet.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/genhd.c         | 49 ++++++++++++++++++++++++++++++++++---------------
 include/linux/genhd.h |  2 +-
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4316d2d..ffb3929 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -595,9 +595,10 @@ exit:
  * This function registers the partitioning information in @disk
  * with the kernel.
  *
- * FIXME: error handling
+ * RETURNS:
+ * 0 on success, -errno on failure.
  */
-void device_add_disk(struct device *parent, struct gendisk *disk)
+int device_add_disk(struct device *parent, struct gendisk *disk)
 {
 	struct backing_dev_info *bdi;
 	dev_t devt;
@@ -613,10 +614,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 	disk->flags |= GENHD_FL_UP;
 
 	retval = blk_alloc_devt(&disk->part0, &devt);
-	if (retval) {
-		WARN_ON(1);
-		return;
-	}
+	if (retval)
+		goto fail;
 	disk_to_dev(disk)->devt = devt;
 
 	/* ->major and ->first_minor aren't supposed to be
@@ -625,16 +624,26 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 	disk->major = MAJOR(devt);
 	disk->first_minor = MINOR(devt);
 
-	disk_alloc_events(disk);
+	retval = disk_alloc_events(disk);
+	if (retval)
+		goto fail;
 
 	/* Register BDI before referencing it from bdev */
 	bdi = &disk->queue->backing_dev_info;
-	bdi_register_owner(bdi, disk_to_dev(disk));
+	retval = bdi_register_owner(bdi, disk_to_dev(disk));
+	if (retval)
+		goto fail;
 
-	blk_register_region(disk_devt(disk), disk->minors, NULL,
-			    exact_match, exact_lock, disk);
-	register_disk(parent, disk);
-	blk_register_queue(disk);
+	retval = blk_register_region(disk_devt(disk), disk->minors, NULL,
+				     exact_match, exact_lock, disk);
+	if (retval)
+		goto fail;
+	retval = register_disk(parent, disk);
+	if (retval)
+		goto fail;
+	retval = blk_register_queue(disk);
+	if (retval)
+		goto fail;
 
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
@@ -644,10 +653,20 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 
 	retval = sysfs_create_link(&disk_to_dev(disk)->kobj, &bdi->dev->kobj,
 				   "bdi");
+	if (retval)
+		goto fail;
+
+	retval = disk_add_events(disk);
+	if (retval)
+		goto fail;
+
+	retval = blk_integrity_add(disk);
+	if (retval)
+		goto fail;
+	return 0;
+fail:
 	WARN_ON(retval);
-
-	disk_add_events(disk);
-	blk_integrity_add(disk);
+	return retval;
 }
 EXPORT_SYMBOL(device_add_disk);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 85ce560..991b5ff 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -413,7 +413,7 @@ static inline void free_part_info(struct hd_struct *part)
 extern void part_round_stats(int cpu, struct hd_struct *part);
 
 /* block/genhd.c */
-extern void device_add_disk(struct device *parent, struct gendisk *disk);
+extern int device_add_disk(struct device *parent, struct gendisk *disk);
 
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
-- 
2.7.4
