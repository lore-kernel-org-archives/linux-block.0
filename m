Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	Bart van Assche <bart.vanassche@wdc.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 3/5] aoe: use device_add_disk_with_groups()
Date: Wed,  5 Sep 2018 09:00:51 +0200
Message-Id: <20180905070053.26239-4-hare@suse.de>
In-Reply-To: <20180905070053.26239-1-hare@suse.de>
References: <20180905070053.26239-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Use device_add_disk_with_groups() to avoid a race condition with
udev during startup.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ed L. Cachin <ed.cashin@acm.org>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/block/aoe/aoe.h    |  1 -
 drivers/block/aoe/aoeblk.c | 21 +++++++--------------
 drivers/block/aoe/aoedev.c |  1 -
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index c0ebda1283cc..015c68017a1c 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -201,7 +201,6 @@ int aoeblk_init(void);
 void aoeblk_exit(void);
 void aoeblk_gdalloc(void *);
 void aoedisk_rm_debugfs(struct aoedev *d);
-void aoedisk_rm_sysfs(struct aoedev *d);
 
 int aoechr_init(void);
 void aoechr_exit(void);
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 429ebb84b592..ff770e7d9e52 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -177,10 +177,15 @@ static struct attribute *aoe_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group attr_group = {
+static const struct attribute_group aoe_attr_group = {
 	.attrs = aoe_attrs,
 };
 
+static const struct attribute_group *aoe_attr_groups[] = {
+	&aoe_attr_group,
+	NULL,
+};
+
 static const struct file_operations aoe_debugfs_fops = {
 	.open = aoe_debugfs_open,
 	.read = seq_read,
@@ -219,17 +224,6 @@ aoedisk_rm_debugfs(struct aoedev *d)
 	d->debugfs = NULL;
 }
 
-static int
-aoedisk_add_sysfs(struct aoedev *d)
-{
-	return sysfs_create_group(&disk_to_dev(d->gd)->kobj, &attr_group);
-}
-void
-aoedisk_rm_sysfs(struct aoedev *d)
-{
-	sysfs_remove_group(&disk_to_dev(d->gd)->kobj, &attr_group);
-}
-
 static int
 aoeblk_open(struct block_device *bdev, fmode_t mode)
 {
@@ -417,8 +411,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	add_disk(gd);
-	aoedisk_add_sysfs(d);
+	device_add_disk(NULL, gd, aoe_attr_groups);
 	aoedisk_add_debugfs(d);
 
 	spin_lock_irqsave(&d->lock, flags);
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 41060e9cedf2..f29a140cdbc1 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -275,7 +275,6 @@ freedev(struct aoedev *d)
 	del_timer_sync(&d->timer);
 	if (d->gd) {
 		aoedisk_rm_debugfs(d);
-		aoedisk_rm_sysfs(d);
 		del_gendisk(d->gd);
 		put_disk(d->gd);
 		blk_cleanup_queue(d->blkq);
-- 
2.16.4
