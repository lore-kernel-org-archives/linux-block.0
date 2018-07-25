Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728337AbeGYHiy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jul 2018 03:38:54 -0400
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Martin Wilck <martin.wilck@suse.com>,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 4/5] aoe: use device_add_disk_with_groups()
Date: Wed, 25 Jul 2018 08:28:39 +0200
Message-Id: <20180725062840.94114-5-hare@suse.de>
In-Reply-To: <20180725062840.94114-1-hare@suse.de>
References: <20180725062840.94114-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use device_add_disk_with_groups() to avoid a race condition with
udev during startup.

Signed-off-by: Hannes Reinecke <hare@suse.com>
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
index 429ebb84b592..b9d30150ce20 100644
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
@@ -220,17 +225,6 @@ aoedisk_rm_debugfs(struct aoedev *d)
 }
 
 static int
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
-static int
 aoeblk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct aoedev *d = bdev->bd_disk->private_data;
@@ -417,8 +411,7 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	add_disk(gd);
-	aoedisk_add_sysfs(d);
+	device_add_disk_with_groups(NULL, gd, aoe_attr_groups);
 	aoedisk_add_debugfs(d);
 
 	spin_lock_irqsave(&d->lock, flags);
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 697f735b07a4..d92fa1fe3580 100644
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
2.12.3
