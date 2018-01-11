Return-Path: <jack@suse.cz>
Date: Thu, 11 Jan 2018 18:00:08 +0100
From: Jan Kara <jack@suse.cz>
To: Hou Tao <houtao1@huawei.com>
Cc: Foy <long7573@126.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>,
	Paolo Valente <paolo.valente@linaro.org>, security@kernel.org,
	syzkaller@googlegroups.com, linux-block@vger.kernel.org
Subject: Re: blkdev loop UAF
Message-ID: <20180111170008.24crzej4utoh5s3p@quack2.suse.cz>
References: <654967ea.6cce.160e43379f6.Coremail.long7573@126.com>
 <20180111082441.myaxc2upbjhcucqh@mwanda>
 <69a2465f-dd67-6962-4f15-57fa9cbafe4d@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hjvekzqqbx3hsm5b"
In-Reply-To: <69a2465f-dd67-6962-4f15-57fa9cbafe4d@huawei.com>
List-ID: <linux-block@vger.kernel.org>


--hjvekzqqbx3hsm5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 11-01-18 19:22:39, Hou Tao wrote:
> Hi,
> 
> On 2018/1/11 16:24, Dan Carpenter wrote:
> > Thanks for your report and the patch.  I am sending it to the
> > linux-block devs since it's already public.
> > 
> > regards,
> > dan carpenter
> 
> The User-after-free problem is not specific for loop device, it can also
> be reproduced on scsi device, and there are more race problems caused by
> the race between bdev open and gendisk shutdown [1].
> 
> The cause of the UAF problem is that there are two instances of gendisk which share
> the same bdev. After the process owning the new gendisk increases bdev->bd_openers,
> the other process which owns the older gendisk will find bdev->bd_openers is not zero
> and will put the last reference of the older gendisk and cause User-after-free.
> 
> I had proposed a patch for the problem, but it's still an incomplete fix for the race
> between gendisk shutdown and bdev opening.
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 4a181fc..5ecdb9f 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1510,6 +1510,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>                 if (bdev->bd_bdi == &noop_backing_dev_info)
>                         bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
>         } else {
> +               if (bdev->bd_disk != disk) {
> +                       ret = -ENXIO;
> +                       goto out_unlock_bdev;
> +               }
> +
>                 if (bdev->bd_contains == bdev) {
>                         ret = 0;
>                         if (bdev->bd_disk->fops->open)
> 
> 
> As far as I know, Jan Kara is working on these problems. So, Jan, any suggestions ?

Yeah, thanks for the ping. I was working today to get this fixed. I have
about 6 patches (attached) which should fix all the outstanding issues I'm
aware of.  So far they are only boot tested. I will give them more
stress-testing next week and then post them officially but if you have time,
feel free to try them out as well. Thanks!

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--hjvekzqqbx3hsm5b
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-genhd-Fix-leaked-module-reference-for-NVME-devices.patch"

>From 7acbaaf7925cfd5440b7f7bf9902d84136624007 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 11 Jan 2018 15:11:03 +0100
Subject: [PATCH 1/6] genhd: Fix leaked module reference for NVME devices

Commit 8ddcd653257c "block: introduce GENHD_FL_HIDDEN" added handling of
hidden devices to get_gendisk() but forgot to drop module reference
which is also acquired by get_disk(). Drop the reference as necessary.

Arguably the function naming here is misleading as put_disk() is *not*
the counterpart of get_disk() but let's fix that in the follow up
commit since that will be more intrusive.

Fixes: 8ddcd653257c18a669fcb75ee42c37054908e0d6
CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 96a66f671720..22f4fc340a3a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -802,7 +802,10 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	}
 
 	if (disk && unlikely(disk->flags & GENHD_FL_HIDDEN)) {
+		struct module *owner = disk->fops->owner;
+
 		put_disk(disk);
+		module_put(owner);
 		disk = NULL;
 	}
 	return disk;
-- 
2.13.6


--hjvekzqqbx3hsm5b
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-genhd-Rename-get_disk-to-get_disk_and_module.patch"

>From d660ec31e06f683f53c37b9195b85d363fb255ea Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 11 Jan 2018 15:27:38 +0100
Subject: [PATCH 2/6] genhd: Rename get_disk() to get_disk_and_module()

Rename get_disk() to get_disk_and_module() to make sure what the
function does. It's not a great name but at least it is now clear that
put_disk() is not it's counterpart.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c           | 10 ++++------
 drivers/block/amiflop.c |  2 +-
 drivers/block/ataflop.c |  2 +-
 drivers/block/brd.c     |  2 +-
 drivers/block/floppy.c  |  2 +-
 drivers/block/loop.c    |  2 +-
 drivers/block/swim.c    |  2 +-
 drivers/block/z2ram.c   |  2 +-
 drivers/ide/ide-probe.c |  2 +-
 include/linux/genhd.h   |  2 +-
 10 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 22f4fc340a3a..058cf91f8d32 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -547,7 +547,7 @@ static int exact_lock(dev_t devt, void *data)
 {
 	struct gendisk *p = data;
 
-	if (!get_disk(p))
+	if (!get_disk_and_module(p))
 		return -1;
 	return 0;
 }
@@ -794,7 +794,7 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 
 		spin_lock_bh(&ext_devt_lock);
 		part = idr_find(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		if (part && get_disk(part_to_disk(part))) {
+		if (part && get_disk_and_module(part_to_disk(part))) {
 			*partno = part->partno;
 			disk = part_to_disk(part);
 		}
@@ -1441,7 +1441,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-struct kobject *get_disk(struct gendisk *disk)
+struct kobject *get_disk_and_module(struct gendisk *disk)
 {
 	struct module *owner;
 	struct kobject *kobj;
@@ -1459,15 +1459,13 @@ struct kobject *get_disk(struct gendisk *disk)
 	return kobj;
 
 }
-
-EXPORT_SYMBOL(get_disk);
+EXPORT_SYMBOL(get_disk_and_module);
 
 void put_disk(struct gendisk *disk)
 {
 	if (disk)
 		kobject_put(&disk_to_dev(disk)->kobj);
 }
-
 EXPORT_SYMBOL(put_disk);
 
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index e5aa62fcf5a8..3aaf6af3ec23 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1758,7 +1758,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 	if (unit[drive].type->code == FD_NODRIVE)
 		return NULL;
 	*part = 0;
-	return get_disk(unit[drive].gendisk);
+	return get_disk_and_module(unit[drive].gendisk);
 }
 
 static int __init amiga_floppy_probe(struct platform_device *pdev)
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 8bc3b9fd8dd2..dfb2c2622e5a 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1917,7 +1917,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 	if (drive >= FD_MAX_UNITS || type > NUM_DISK_MINORS)
 		return NULL;
 	*part = 0;
-	return get_disk(unit[drive].disk);
+	return get_disk_and_module(unit[drive].disk);
 }
 
 static int __init atari_floppy_init (void)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 8028a3a7e7fd..deea78e485da 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -456,7 +456,7 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
 
 	mutex_lock(&brd_devices_mutex);
 	brd = brd_init_one(MINOR(dev) / max_part, &new);
-	kobj = brd ? get_disk(brd->brd_disk) : NULL;
+	kobj = brd ? get_disk_and_module(brd->brd_disk) : NULL;
 	mutex_unlock(&brd_devices_mutex);
 
 	if (new)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index eae484acfbbc..8ec7235fc93b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4505,7 +4505,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 	if (((*part >> 2) & 0x1f) >= ARRAY_SIZE(floppy_type))
 		return NULL;
 	*part = 0;
-	return get_disk(disks[drive]);
+	return get_disk_and_module(disks[drive]);
 }
 
 static int __init do_floppy_init(void)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d5fe720cf149..87855b5123a6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1922,7 +1922,7 @@ static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 	if (err < 0)
 		kobj = NULL;
 	else
-		kobj = get_disk(lo->lo_disk);
+		kobj = get_disk_and_module(lo->lo_disk);
 	mutex_unlock(&loop_index_mutex);
 
 	*part = 0;
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 84434d3ea19b..64e066eba72e 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -799,7 +799,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 		return NULL;
 
 	*part = 0;
-	return get_disk(swd->unit[drive].disk);
+	return get_disk_and_module(swd->unit[drive].disk);
 }
 
 static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 41c95c9b2ab4..8f9130ab5887 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -332,7 +332,7 @@ static const struct block_device_operations z2_fops =
 static struct kobject *z2_find(dev_t dev, int *part, void *data)
 {
 	*part = 0;
-	return get_disk(z2ram_gendisk);
+	return get_disk_and_module(z2ram_gendisk);
 }
 
 static struct request_queue *z2_queue;
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 17fd55af4d92..caa20eb5f26b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -928,7 +928,7 @@ static int exact_lock(dev_t dev, void *data)
 {
 	struct gendisk *p = data;
 
-	if (!get_disk(p))
+	if (!get_disk_and_module(p))
 		return -1;
 	return 0;
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5144ebe046c9..12402912a86a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -595,7 +595,7 @@ extern void delete_partition(struct gendisk *, int);
 extern void printk_all_partitions(void);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-extern struct kobject *get_disk(struct gendisk *disk);
+extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
 extern void blk_register_region(dev_t devt, unsigned long range,
 			struct module *module,
-- 
2.13.6


--hjvekzqqbx3hsm5b
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0003-genhd-Add-helper-put_disk_and_module.patch"

>From e5cebe2d7a647a91cb4af3997c45b849dc6a1f6d Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 11 Jan 2018 15:40:52 +0100
Subject: [PATCH 3/6] genhd: Add helper put_disk_and_module()

Add a proper counterpart to get_disk_and_module() -
put_disk_and_module(). Currently it is opencoded in several places.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-cgroup.c    | 11 ++---------
 block/genhd.c         | 20 ++++++++++++++++----
 fs/block_dev.c        | 19 +++++--------------
 include/linux/genhd.h |  1 +
 4 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4117524ca45b..c2033a232a44 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -812,7 +812,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	struct gendisk *disk;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
-	struct module *owner;
 	unsigned int major, minor;
 	int key_len, part, ret;
 	char *body;
@@ -904,9 +903,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
 fail:
-	owner = disk->fops->owner;
-	put_disk(disk);
-	module_put(owner);
+	put_disk_and_module(disk);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
@@ -931,13 +928,9 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 	__releases(ctx->disk->queue->queue_lock) __releases(rcu)
 {
-	struct module *owner;
-
 	spin_unlock_irq(ctx->disk->queue->queue_lock);
 	rcu_read_unlock();
-	owner = ctx->disk->fops->owner;
-	put_disk(ctx->disk);
-	module_put(owner);
+	put_disk_and_module(ctx->disk);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
diff --git a/block/genhd.c b/block/genhd.c
index 058cf91f8d32..64c323549a22 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -802,10 +802,7 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	}
 
 	if (disk && unlikely(disk->flags & GENHD_FL_HIDDEN)) {
-		struct module *owner = disk->fops->owner;
-
-		put_disk(disk);
-		module_put(owner);
+		put_disk_and_module(disk);
 		disk = NULL;
 	}
 	return disk;
@@ -1468,6 +1465,21 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
+/*
+ * This is a counterpart of get_disk_and_module() and thus also of
+ * get_gendisk().
+ */
+void put_disk_and_module(struct gendisk *disk)
+{
+	if (disk) {
+		struct module *owner = disk->fops->owner;
+
+		put_disk(disk);
+		module_put(owner);
+	}
+}
+EXPORT_SYMBOL(put_disk_and_module);
+
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
 	char event[] = "DISK_RO=1";
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fcb5175..1dbbf847911a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1111,8 +1111,7 @@ static struct block_device *bd_start_claiming(struct block_device *bdev,
 	else
 		whole = bdgrab(bdev);
 
-	module_put(disk->fops->owner);
-	put_disk(disk);
+	put_disk_and_module(disk);
 	if (!whole)
 		return ERR_PTR(-ENOMEM);
 
@@ -1407,7 +1406,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 {
 	struct gendisk *disk;
-	struct module *owner;
 	int ret;
 	int partno;
 	int perm = 0;
@@ -1433,7 +1431,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	disk = get_gendisk(bdev->bd_dev, &partno);
 	if (!disk)
 		goto out;
-	owner = disk->fops->owner;
 
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
@@ -1463,8 +1460,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 					bdev->bd_queue = NULL;
 					mutex_unlock(&bdev->bd_mutex);
 					disk_unblock_events(disk);
-					put_disk(disk);
-					module_put(owner);
+					put_disk_and_module(disk);
 					goto restart;
 				}
 			}
@@ -1525,8 +1521,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				goto out_unlock_bdev;
 		}
 		/* only one opener holds refs to the module and disk */
-		put_disk(disk);
-		module_put(owner);
+		put_disk_and_module(disk);
 	}
 	bdev->bd_openers++;
 	if (for_part)
@@ -1546,8 +1541,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  out_unlock_bdev:
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
-	put_disk(disk);
-	module_put(owner);
+	put_disk_and_module(disk);
  out:
 	bdput(bdev);
 
@@ -1770,8 +1764,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 			disk->fops->release(disk, mode);
 	}
 	if (!bdev->bd_openers) {
-		struct module *owner = disk->fops->owner;
-
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
 		bdev->bd_disk = NULL;
@@ -1779,8 +1771,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
 
-		put_disk(disk);
-		module_put(owner);
+		put_disk_and_module(disk);
 	}
 	mutex_unlock(&bdev->bd_mutex);
 	bdput(bdev);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 12402912a86a..07b715cdeb93 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -597,6 +597,7 @@ extern void printk_all_partitions(void);
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
+extern void put_disk_and_module(struct gendisk *disk);
 extern void blk_register_region(dev_t devt, unsigned long range,
 			struct module *module,
 			struct kobject *(*probe)(dev_t, int *, void *),
-- 
2.13.6


--hjvekzqqbx3hsm5b
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0004-genhd-Fix-use-after-free-in-__blkdev_get.patch"

>From 9509768ff6680e280f84e47f7f8438c24aa25c48 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 11 Jan 2018 15:48:46 +0100
Subject: [PATCH 4/6] genhd: Fix use after free in __blkdev_get()

When two blkdev_open() calls race with device removal and recreation,
__blkdev_get() can use looked up gendisk after it is freed:

CPU0				CPU1			CPU2
							del_gendisk(disk);
							  bdev_unhash_inode(inode);
blkdev_open()			blkdev_open()
  bdev = bd_acquire(inode);
    - creates and returns new inode
				  bdev = bd_acquire(inode);
				    - returns the same inode
  __blkdev_get(devt)		  __blkdev_get(devt)
    disk = get_gendisk(devt);
      - got structure of device going away
							<finish device removal>
							<new device gets
							 created under the same
							 device number>
				  disk = get_gendisk(devt);
				    - got new device structure
				  if (!bdev->bd_openers) {
				    does the first open
				  }
    if (!bdev->bd_openers)
      - false
    } else {
      put_disk_and_module(disk)
        - remember this was old device - this was last ref and disk is
          now freed
    }
    disk_unblock_events(disk); -> oops

Fix the problem by making sure we drop reference to disk in
__blkdev_get() only after we are really done with it.

Reported-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 1dbbf847911a..fe41a76769fa 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1409,6 +1409,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int ret;
 	int partno;
 	int perm = 0;
+	bool first_open = false;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1435,6 +1436,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
+		first_open = true;
 		bdev->bd_disk = disk;
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
@@ -1520,14 +1522,15 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (ret)
 				goto out_unlock_bdev;
 		}
-		/* only one opener holds refs to the module and disk */
-		put_disk_and_module(disk);
 	}
 	bdev->bd_openers++;
 	if (for_part)
 		bdev->bd_part_count++;
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
+	/* only one opener holds refs to the module and disk */
+	if (!first_open)
+		put_disk_and_module(disk);
 	return 0;
 
  out_clear:
-- 
2.13.6


--hjvekzqqbx3hsm5b
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0005-genhd-Fix-BUG-in-blkdev_open.patch"

>From 020dd3a183c4fb804a376d53a011f9fb67383866 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 11 Jan 2018 16:49:58 +0100
Subject: [PATCH 5/6] genhd: Fix BUG in blkdev_open()

When two blkdev_open() calls for a partition race with device removal
and recreation, we can hit BUG_ON(!bd_may_claim(bdev, whole, holder)) in
blkdev_open(). The race can happen as follows:

CPU0				CPU1			CPU2
							del_gendisk()
							  bdev_unhash_inode(part1);

blkdev_open(part1, O_EXCL)	blkdev_open(part1, O_EXCL)
  bdev = bd_acquire()		  bdev = bd_acquire()
  blkdev_get(bdev)
    bd_start_claiming(bdev)
      - finds old inode 'whole'
      bd_prepare_to_claim() -> 0
							  bdev_unhash_inode(whole);
							<device removed>
							<new device under same
							 number created>
				  blkdev_get(bdev);
				    bd_start_claiming(bdev)
				      - finds new inode 'whole'
				      bd_prepare_to_claim()
					- this also succeeds as we have
					  different 'whole' here...
					- bad things happen now as we
					  have two exclusive openers of
					  the same bdev

The problem here is that block device opens can see various intermediate
states while gendisk is shutting down and then being recreated.

We fix the problem by introducing new lookup_sem in gendisk that
synchronizes gendisk deletion with get_gendisk() and furthermore by
making sure that get_gendisk() does not return gendisk that is being (or
has been) deleted. This makes sure that once we ever manage to look up
newly created bdev inode, we are also guaranteed that following
get_gendisk() will either return failure (and we fail open) or it
returns gendisk for the new device and following bdget_disk() will
return new bdev inode (i.e., blkdev_open() follows the path as if it is
completely run after new device is created).

Reported-and-analyzed-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c         | 21 ++++++++++++++++++++-
 include/linux/genhd.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 64c323549a22..c6f68c332bfe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -703,6 +703,11 @@ void del_gendisk(struct gendisk *disk)
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
+	/*
+	 * Block lookups of the disk until all bdevs are unhashed and the
+	 * disk is marked as dead (GENHD_FL_UP cleared).
+	 */
+	down_write(&disk->lookup_sem);
 	/* invalidate stuff */
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
@@ -717,6 +722,7 @@ void del_gendisk(struct gendisk *disk)
 	bdev_unhash_inode(disk_devt(disk));
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
+	up_write(&disk->lookup_sem);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -801,9 +807,21 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 		spin_unlock_bh(&ext_devt_lock);
 	}
 
-	if (disk && unlikely(disk->flags & GENHD_FL_HIDDEN)) {
+	if (!disk)
+		return NULL;
+
+	/*
+	 * Synchronize with del_gendisk() to not return disk that is being
+	 * destroyed.
+	 */
+	down_read(&disk->lookup_sem);
+	if (unlikely((disk->flags & GENHD_FL_HIDDEN) ||
+		     !(disk->flags & GENHD_FL_UP))) {
+		up_read(&disk->lookup_sem);
 		put_disk_and_module(disk);
 		disk = NULL;
+	} else {
+		up_read(&disk->lookup_sem);
 	}
 	return disk;
 }
@@ -1403,6 +1421,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 			kfree(disk);
 			return NULL;
 		}
+		init_rwsem(&disk->lookup_sem);
 		disk->node_id = node_id;
 		if (disk_expand_part_tbl(disk, 0)) {
 			free_part_stats(&disk->part0);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 07b715cdeb93..7b548253eaef 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -198,6 +198,7 @@ struct gendisk {
 	void *private_data;
 
 	int flags;
+	struct rw_semaphore lookup_sem;
 	struct kobject *slave_dir;
 
 	struct timer_rand_state *random;
-- 
2.13.6


--hjvekzqqbx3hsm5b
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0006-blockdev-Avoid-two-active-bdev-inodes-for-one-device.patch"

>From f560a27dd0938300a6bb5b16d9164e29b5abf980 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 11 Jan 2018 17:29:03 +0100
Subject: [PATCH 6/6] blockdev: Avoid two active bdev inodes for one device

When blkdev_open() races with device removal and creation it can happen
that unhashed bdev inode gets associated with newly created gendisk
like:

CPU0					CPU1
blkdev_open()
  bdev = bd_acquire()
					del_gendisk()
					  bdev_unhash_inode(bdev);
					remove device
					create new device with the same number
  __blkdev_get()
    disk = get_gendisk()
      - gets reference to gendisk of the new device

Now another blkdev_open() will not find original 'bdev' as it got
unhashed, create a new one and associate it with the same 'disk' at
which point problems start as we have two independent page caches for
one device.

Fix the problem by verifying that the bdev inode didn't get unhashed
before we acquired gendisk reference. That way we make sure gendisk can
get associated only with visible bdev inodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fe41a76769fa..fe09ef9c21f3 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1058,6 +1058,27 @@ static int bd_prepare_to_claim(struct block_device *bdev,
 	return 0;
 }
 
+static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
+{
+	struct gendisk *disk = get_gendisk(bdev->bd_dev, partno);
+
+	if (!disk)
+		return NULL;
+	/*
+	 * Now that we hold gendisk reference we make sure bdev we looked up is
+	 * not stale. If it is, it means device got removed and created before
+	 * we looked up gendisk and we fail open in such case. Associating
+	 * unhashed bdev with newly created gendisk could lead to two bdevs
+	 * (and thus two independent caches) being associated with one device
+	 * which is bad.
+	 */
+	if (inode_unhashed(bdev->bd_inode)) {
+		put_disk_and_module(disk);
+		return NULL;
+	}
+	return disk;
+}
+
 /**
  * bd_start_claiming - start claiming a block device
  * @bdev: block device of interest
@@ -1094,7 +1115,7 @@ static struct block_device *bd_start_claiming(struct block_device *bdev,
 	 * @bdev might not have been initialized properly yet, look up
 	 * and grab the outer block device the hard way.
 	 */
-	disk = get_gendisk(bdev->bd_dev, &partno);
+	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
 		return ERR_PTR(-ENXIO);
 
@@ -1429,7 +1450,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  restart:
 
 	ret = -ENXIO;
-	disk = get_gendisk(bdev->bd_dev, &partno);
+	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
 		goto out;
 
-- 
2.13.6


--hjvekzqqbx3hsm5b--
