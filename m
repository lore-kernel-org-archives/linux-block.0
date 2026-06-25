Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D7361DB8
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368917; cv=none; b=iXI7JuTlznwsZyqONT9evQXzl423GR00qfdYSauxc81aRCBygytoPMaH2gjHC8jyQNoBShhU7dC7jjgkulvQdZFk/s3Wekg5MMqvimakeuw5nDpB3Jx3+OSYv+wYgDSbKXBBq1y1t/nb/e0Vsjk/1MwGs+7OWYjBBSa2LDjRHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368917; c=relaxed/simple;
	bh=weA2LuMovSjALg3d/e8Ous4vUMMaJRDM7wu6fOJlfaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKH6m43UJim3lkrM8or2lP8H8j2nJ5wvEWZ365+F1cdzQDNCa7+0wNAMhDDSM9y3KXbVY/W+TWQbqpXZw/sRQbxviWzRKg4WBdT4tV9M0xUOdv/QElHKqxIV3nAhSvniSTpySXvGMHCsFhfcNpcg2MhElvdSNit69hOBIIVHSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0AjBNiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0AjBNiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653C41F000E9;
	Thu, 25 Jun 2026 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368915;
	bh=Mpm1vBe/X/KrMUhOUQKcILpXvyLxHuF8R/Qa1fsWDCU=;
	h=From:To:Cc:Subject:Date;
	b=D0AjBNiuUQEvjRp8qDdGPf/jhb89824y0F0lzD/6LgW+gfqlccAOAkwYzw3JPU3S8
	 6ZoQ0wUWrXbU+3CuFUHWm21zskMRC9a00QKnxFlgOggAV0GmeC/wyUVkP6gpgguRer
	 dYyknrWSnHRpmNUaIZj6brvpU+++dbkRBo3m9s9XnGBUdB0CKPGkXYVkX3Ao9cDKaR
	 i+BzBcirZlEuBJ3KV9DBabXblTTAfXAO2v5hjfn1wG9zcIBfhbYJJtzOhgYzXQhcIJ
	 QxFnOPS4GUK9/SeLg3Q/PYU4iHbXF8AL6dowNRaLEIjUW/oOgV/D95ay122lzOV231
	 GC0cOL26kH34w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: avoid potential deadlock on zone revalidation failure
Date: Thu, 25 Jun 2026 15:28:24 +0900
Message-ID: <20260625062824.2013244-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If revalidating the zones of a zoned block device with
blk_revalidate_disk_zones() fails during a SCSI disk rescan, the following
lockdep splat is thrown:

[  347.251859] [  T11230] sda: failed to revalidate zones

[  347.261380] [  T11230] ======================================================
[  347.263882] [  T11230] WARNING: possible circular locking dependency detected
[  347.266353] [  T11230] 7.1.0+ #1194 Not tainted
[  347.268052] [  T11230] ------------------------------------------------------
[  347.270537] [  T11230] tcsh/11230 is trying to acquire lock:
[  347.272555] [  T11230] ffffffff8f91d400 (wq_pool_mutex){+.+.}-{4:4}, at: destroy_workqueue+0x15d/0x8d0
[  347.275914] [  T11230]
                          but task is already holding lock:
[  347.278646] [  T11230] ffff88812fa1bcc0 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x16/0x30
[  347.282503] [  T11230]
                          which lock already depends on the new lock.

[  347.286239] [  T11230]
                          the existing dependency chain (in reverse order) is:
[  347.289408] [  T11230]
                          -> #2 (&q->q_usage_counter(io)#5){++++}-{0:0}:
[  347.292437] [  T11230]        blk_alloc_queue+0x5ca/0x750
[  347.294379] [  T11230]        blk_mq_alloc_queue+0x14c/0x240
[  347.296375] [  T11230]        scsi_alloc_sdev+0x871/0xd10 [scsi_mod]
[  347.298619] [  T11230]        scsi_probe_and_add_lun+0x600/0xc50 [scsi_mod]
[  347.301056] [  T11230]        __scsi_scan_target+0x187/0x3b0 [scsi_mod]
[  347.303385] [  T11230]        scsi_scan_channel+0xf2/0x180 [scsi_mod]
[  347.305651] [  T11230]        scsi_scan_host_selected+0x20b/0x2d0 [scsi_mod]
[  347.308119] [  T11230]        do_scan_async+0x42/0x420 [scsi_mod]
[  347.310276] [  T11230]        async_run_entry_fn+0x94/0x5a0
[  347.312284] [  T11230]        process_one_work+0x8da/0x1690
[  347.314287] [  T11230]        worker_thread+0x5fe/0x1010
[  347.316216] [  T11230]        kthread+0x358/0x450
[  347.317675] [  T11230]        ret_from_fork+0x5b9/0x8e0
[  347.319181] [  T11230]        ret_from_fork_asm+0x11/0x20
[  347.320778] [  T11230]
                          -> #1 (fs_reclaim){+.+.}-{0:0}:
[  347.322890] [  T11230]        fs_reclaim_acquire+0xd5/0x120
[  347.324464] [  T11230]        __kmalloc_cache_node_noprof+0x39/0x620
[  347.326223] [  T11230]        init_rescuer+0x19b/0x560
[  347.327697] [  T11230]        workqueue_init+0x33b/0x6a0
[  347.329224] [  T11230]        kernel_init_freeable+0x2eb/0x600
[  347.330881] [  T11230]        kernel_init+0x1c/0x140
[  347.332334] [  T11230]        ret_from_fork+0x5b9/0x8e0
[  347.333847] [  T11230]        ret_from_fork_asm+0x11/0x20
[  347.335360] [  T11230]
                          -> #0 (wq_pool_mutex){+.+.}-{4:4}:
[  347.337510] [  T11230]        __lock_acquire+0xdea/0x2260
[  347.339030] [  T11230]        lock_acquire+0x187/0x2f0
[  347.340495] [  T11230]        __mutex_lock+0x1ab/0x2600
[  347.341464] [  T11230]        destroy_workqueue+0x15d/0x8d0
[  347.342485] [  T11230]        disk_free_zone_resources+0xd5/0x560
[  347.343577] [  T11230]        blk_revalidate_disk_zones+0x620/0xac7
[  347.344723] [  T11230]        sd_zbc_revalidate_zones+0x1dd/0x790 [sd_mod]
[  347.345938] [  T11230]        sd_revalidate_disk+0xc66/0x8e60 [sd_mod]
[  347.347112] [  T11230]        scsi_rescan_device+0x1f9/0x310 [scsi_mod]
[  347.348318] [  T11230]        store_rescan_field+0x19/0x20 [scsi_mod]
[  347.349507] [  T11230]        kernfs_fop_write_iter+0x3d2/0x5e0
[  347.350565] [  T11230]        vfs_write+0x469/0x1000
[  347.351484] [  T11230]        ksys_write+0x116/0x250
[  347.352403] [  T11230]        do_syscall_64+0xf0/0x6e0
[  347.353361] [  T11230]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  347.354533] [  T11230]
                          other info that might help us debug this:

[  347.356432] [  T11230] Chain exists of:
                            wq_pool_mutex --> fs_reclaim --> &q->q_usage_counter(io)#5

[  347.358919] [  T11230]  Possible unsafe locking scenario:

[  347.360307] [  T11230]        CPU0                    CPU1
[  347.361327] [  T11230]        ----                    ----
[  347.362340] [  T11230]   lock(&q->q_usage_counter(io)#5);
[  347.363344] [  T11230]                                lock(fs_reclaim);
[  347.364526] [  T11230]                                lock(&q->q_usage_counter(io)#5);
[  347.365968] [  T11230]   lock(wq_pool_mutex);
[  347.366811] [  T11230]
                           *** DEADLOCK ***

This happens because SCSI disk rescan is executed from a work context
and a failure of blk_revalidate_disk_zones() causes a call to
disk_free_zone_resources() which will free the disk zone write plug
workqueue.

Avoid this by delaying the destruction of the disk zone write plug
workqueue to disk_release(). Do this by introducing the function
disk_release_zone_resources() and using this new function from
disk_release(). This new function calls disk_free_zone_resources() and
destroys the zone write plugs workqueue, thus allowing to remove the
call to destroy_workqueue() from disk_free_zone_resources().
disk_alloc_zone_resources() is modified to not create the disk zone
write plug work queue if it already exists.

Fixes: a8f59e5a5dea ("block: use a per disk workqueue for zone write plugging")
Cc: stable@vger.kernek.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 40 +++++++++++++++++++++++++---------------
 block/blk.h       |  4 ++--
 block/genhd.c     |  2 +-
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bea817f3de56..133600ebe05c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1923,11 +1923,20 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	if (!disk->zone_wplugs_pool)
 		goto free_hash;
 
-	disk->zone_wplugs_wq =
-		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
-				pool_size, disk->disk_name);
-	if (!disk->zone_wplugs_wq)
-		goto destroy_pool;
+	/*
+	 * We may already have a zone write plug workqueue as this function may
+	 * be called after disk_free_zone_resources(), which does not destroy
+	 * the workqueue (the zone write plugs workqueue is destroyed at
+	 * disk_release() time).
+	 */
+	if (!disk->zone_wplugs_wq) {
+		disk->zone_wplugs_wq =
+			alloc_workqueue("%s_zwplugs",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					pool_size, disk->disk_name);
+		if (!disk->zone_wplugs_wq)
+			goto destroy_pool;
+	}
 
 	disk->zone_wplugs_worker =
 		kthread_create(disk_zone_wplugs_worker, disk,
@@ -1935,15 +1944,12 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	if (IS_ERR(disk->zone_wplugs_worker)) {
 		ret = PTR_ERR(disk->zone_wplugs_worker);
 		disk->zone_wplugs_worker = NULL;
-		goto destroy_wq;
+		goto destroy_pool;
 	}
 	wake_up_process(disk->zone_wplugs_worker);
 
 	return 0;
 
-destroy_wq:
-	destroy_workqueue(disk->zone_wplugs_wq);
-	disk->zone_wplugs_wq = NULL;
 destroy_pool:
 	mempool_destroy(disk->zone_wplugs_pool);
 	disk->zone_wplugs_pool = NULL;
@@ -1999,7 +2005,7 @@ static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
 	kfree_rcu_mightsleep(zones_cond);
 }
 
-void disk_free_zone_resources(struct gendisk *disk)
+static void disk_free_zone_resources(struct gendisk *disk)
 {
 	if (disk->zone_wplugs_worker) {
 		kthread_stop(disk->zone_wplugs_worker);
@@ -2007,11 +2013,6 @@ void disk_free_zone_resources(struct gendisk *disk)
 	}
 	WARN_ON_ONCE(!list_empty(&disk->zone_wplugs_list));
 
-	if (disk->zone_wplugs_wq) {
-		destroy_workqueue(disk->zone_wplugs_wq);
-		disk->zone_wplugs_wq = NULL;
-	}
-
 	disk_destroy_zone_wplugs_hash_table(disk);
 
 	disk_set_zones_cond_array(disk, NULL);
@@ -2020,6 +2021,15 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
+void disk_release_zone_resources(struct gendisk *disk)
+{
+	disk_free_zone_resources(disk);
+	if (disk->zone_wplugs_wq) {
+		destroy_workqueue(disk->zone_wplugs_wq);
+		disk->zone_wplugs_wq = NULL;
+	}
+}
+
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
 	u8		*zones_cond;
diff --git a/block/blk.h b/block/blk.h
index 25af8ac5ef0f..fb95d3c58950 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -528,7 +528,7 @@ static inline void ioc_clear_queue(struct request_queue *q)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_init_zone_resources(struct gendisk *disk);
-void disk_free_zone_resources(struct gendisk *disk);
+void disk_release_zone_resources(struct gendisk *disk);
 static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
@@ -581,7 +581,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
 }
-static inline void disk_free_zone_resources(struct gendisk *disk)
+static inline void disk_release_zone_resources(struct gendisk *disk)
 {
 }
 static inline bool bio_zone_write_plugging(struct bio *bio)
diff --git a/block/genhd.c b/block/genhd.c
index f84b6a355b57..30ac0ffe6517 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1300,7 +1300,7 @@ static void disk_release(struct device *dev)
 
 	disk_release_events(disk);
 	kfree(disk->random);
-	disk_free_zone_resources(disk);
+	disk_release_zone_resources(disk);
 	xa_destroy(&disk->part_tbl);
 
 	kobject_put(&disk->queue_kobj);
-- 
2.54.0

