Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE1FC6379D
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134F82222A
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgKSQtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:49:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgKSQtd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 11:49:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B9CEAC2D;
        Thu, 19 Nov 2020 16:49:31 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] dm_interposer - blk_interposer for device-mapper
Date:   Thu, 19 Nov 2020 17:49:24 +0100
Message-Id: <20201119164924.74401-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201119164924.74401-1-hare@suse.de>
References: <20201119164924.74401-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sergei Shtepa <sergei.shtepa@veeam.com>

Implement a block interposer for device-mapper to
attach to an existing block layer stack.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm-table.c |  59 +++++++++++++++++++++
 drivers/md/dm.c       | 140 ++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/md/dm.h       |   4 +-
 3 files changed, 191 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ce543b761be7..56923d0795b2 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1809,6 +1809,65 @@ static bool dm_table_requires_stable_pages(struct dm_table *t)
 	return false;
 }
 
+static char *_dm_interposer_claim_ptr = "device-mapper interposer";
+
+static int device_activate_interposer(struct dm_target *ti,
+				      struct dm_dev *dev, sector_t start,
+				      sector_t len, void *data)
+{
+	struct blk_interposer *blk_ip = dev->bdev->bd_disk->interposer;
+	struct mapped_device *md = data;
+
+	if (!blk_ip)
+		return false;
+	if (md) {
+		struct block_device *bdev;
+
+		bdev = blkdev_get_by_dev(md->bdev->bd_dev,
+					     dev->mode | FMODE_EXCL,
+					     _dm_interposer_claim_ptr);
+		if (!bdev)
+			return false;
+		blk_ip->ip_private = md;
+	} else if (blk_ip->ip_private) {
+		md = blk_ip->ip_private;
+		blkdev_put(md->bdev, dev->mode | FMODE_EXCL);
+		blk_ip->ip_private = NULL;
+	}
+	return true;
+}
+
+bool dm_table_activate_interposer(struct dm_table *t, struct mapped_device *md)
+{
+	struct dm_target *ti;
+
+	if (t->num_targets) {
+		ti = t->targets;
+
+		if (!ti->type->iterate_devices ||
+		    !ti->type->iterate_devices(ti,
+				device_activate_interposer, md))
+			return false;
+		DMINFO("%s: activated interposer", dm_device_name(md));
+	}
+	return true;
+}
+
+bool dm_table_deactivate_interposer(struct dm_table *t)
+{
+	struct dm_target *ti;
+
+	if (t->num_targets) {
+		ti = t->targets;
+
+		if (!ti->type->iterate_devices ||
+		    !ti->type->iterate_devices(ti,
+				device_activate_interposer, NULL))
+			return false;
+	}
+	return true;
+}
+
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			       struct queue_limits *limits)
 {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c18fc2548518..ec6df4ad4c85 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -48,6 +48,7 @@ static DEFINE_IDR(_minor_idr);
 static DEFINE_SPINLOCK(_minor_lock);
 
 static void do_deferred_remove(struct work_struct *w);
+static blk_qc_t dm_submit_bio_interposed(struct blk_interposer *ip, struct bio *bio);
 
 static DECLARE_WORK(deferred_remove_work, do_deferred_remove);
 
@@ -730,6 +731,38 @@ static void dm_put_live_table_fast(struct mapped_device *md) __releases(RCU)
 	rcu_read_unlock();
 }
 
+static inline int dm_install_interposer(struct gendisk *disk,
+					struct mapped_device *md)
+{
+	struct blk_interposer *blk_ip;
+	int ret;
+
+	blk_ip = kzalloc(sizeof(struct blk_interposer), GFP_KERNEL);
+	if (!blk_ip)
+		return -ENOMEM;
+
+	blk_ip->ip_submit_bio = dm_submit_bio_interposed;
+	blk_ip->ip_disk = disk;
+	blk_ip->ip_private = md;
+
+	ret = blk_interposer_attach(disk, blk_ip);
+	if (ret) {
+		kfree(blk_ip);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline void dm_uninstall_interposer(struct gendisk *disk)
+{
+	struct blk_interposer *blk_ip;
+
+	blk_ip = blk_interposer_detach(disk);
+	if (blk_ip)
+		kfree(blk_ip);
+}
+
 static char *_dm_claim_ptr = "I belong to device-mapper";
 
 /*
@@ -739,19 +772,38 @@ static int open_table_device(struct table_device *td, dev_t dev,
 			     struct mapped_device *md)
 {
 	struct block_device *bdev;
-
-	int r;
+	fmode_t fmode = td->dm_dev.mode | FMODE_EXCL;
+	int ret;
 
 	BUG_ON(td->dm_dev.bdev);
 
-	bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	bdev = blkdev_get_by_dev(dev, fmode, _dm_claim_ptr);
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
+		if (ret != -EBUSY)
+			return ret;
 
-	r = bd_link_disk_holder(bdev, dm_disk(md));
-	if (r) {
-		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
-		return r;
+		/*
+		 * If device cannot be opened in exclusive mode,
+		 * then try to use blk_interpose.
+		 */
+		fmode = td->dm_dev.mode;
+		bdev = blkdev_get_by_dev(dev, fmode, NULL);
+		if (IS_ERR(bdev))
+			return PTR_ERR(bdev);
+
+		ret = dm_install_interposer(bdev->bd_disk, md);
+		if (ret) {
+			blkdev_put(bdev, fmode);
+			return ret;
+		}
+	}
+
+	ret = bd_link_disk_holder(bdev, dm_disk(md));
+	if (ret) {
+		dm_uninstall_interposer(bdev->bd_disk);
+		blkdev_put(bdev, fmode);
+		return ret;
 	}
 
 	td->dm_dev.bdev = bdev;
@@ -764,11 +816,18 @@ static int open_table_device(struct table_device *td, dev_t dev,
  */
 static void close_table_device(struct table_device *td, struct mapped_device *md)
 {
+	fmode_t fmode = td->dm_dev.mode | FMODE_EXCL;
+
 	if (!td->dm_dev.bdev)
 		return;
 
 	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
-	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	if (blk_has_interposer(td->dm_dev.bdev->bd_disk)) {
+		dm_uninstall_interposer(td->dm_dev.bdev->bd_disk);
+		fmode = td->dm_dev.mode;
+	}
+	blkdev_put(td->dm_dev.bdev, fmode);
+
 	put_dax(td->dm_dev.dax_dev);
 	td->dm_dev.bdev = NULL;
 	td->dm_dev.dax_dev = NULL;
@@ -1666,6 +1725,62 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	return ret;
 }
 
+static void dm_interposed_endio(struct bio *clone)
+{
+	struct bio *bio = clone->bi_private;
+
+	bio->bi_status = clone->bi_status;
+	bio_endio(bio);
+	bio_put(bio);
+
+	bio_put(clone);
+}
+
+static blk_qc_t dm_submit_bio_interposed(struct blk_interposer *interposer,
+					 struct bio *bio)
+{
+	struct mapped_device *md = interposer->ip_private;
+	blk_qc_t ret = BLK_QC_T_NONE;
+	int srcu_idx;
+	struct dm_table *map;
+	struct bio *clone;
+
+	if (unlikely(!md))
+		return submit_bio_noacct(bio);
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (unlikely(!map)) {
+		DMERR_LIMIT("%s: mapping table unavailable, erroring io",
+			    dm_device_name(md));
+		goto out;
+	}
+
+	clone = bio_clone_fast(bio, GFP_NOIO, NULL);
+	if (unlikely(!clone)) {
+		DMERR_LIMIT("%s: failed to clone bio",
+			    dm_device_name(md));
+		goto out;
+	}
+
+	bio_get(bio);
+	bio_set_flag(clone, BIO_INTERPOSED);
+	clone->bi_private = bio;
+	clone->bi_disk = dm_disk(md);
+	clone->bi_end_io = dm_interposed_endio;
+
+	trace_block_bio_remap(clone->bi_disk->queue, bio, bio_dev(bio),
+			      bio->bi_iter.bi_sector);
+
+	ret = submit_bio_noacct(clone);
+	dm_put_live_table(md, srcu_idx);
+	return  ret;
+
+out:
+	bio_io_error(bio);
+	dm_put_live_table(md, srcu_idx);
+	return ret;
+}
+
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -2005,8 +2120,11 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	md->immutable_target_type = dm_table_get_immutable_target_type(t);
 
 	dm_table_set_restrictions(t, q, limits);
-	if (old_map)
+	if (old_map) {
+		dm_table_deactivate_interposer(old_map);
 		dm_sync_table(md);
+	}
+	dm_table_activate_interposer(t, md);
 
 out:
 	return old_map;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index fffe1e289c53..51b98e10e9bb 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -75,7 +75,9 @@ bool dm_table_supports_dax(struct dm_table *t, iterate_devices_callout_fn fn,
 			   int *blocksize);
 int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 			   sector_t start, sector_t len, void *data);
-
+bool dm_table_activate_interposer(struct dm_table *t,
+				  struct mapped_device *md);
+bool dm_table_deactivate_interposer(struct dm_table *t);
 void dm_lock_md_type(struct mapped_device *md);
 void dm_unlock_md_type(struct mapped_device *md);
 void dm_set_md_type(struct mapped_device *md, enum dm_queue_mode type);
-- 
2.16.4

