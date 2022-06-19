Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B67C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiFSGGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiFSGGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE92EE30
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Tayniehqr0bvPVWtE5UkXNYCwSgPOKf+vQyOgD1Q1fg=; b=P0+5NSvvOH/l9ARslFXL2aPu8F
        7Yg7++7tutGQwWVNWMXhRcW2Fm8xMPqqMtVRIyakAgnX3pxQKsyS1JzT7M3ZCPf3BaT0mZL/4sk8Z
        lBG9e26aBDlTf7lRHJ0ZJM+guRcQOCzYH5qsGKkPJj8rCsrbOTVBzSTbGvff6T8N+lDVRpupHFsGI
        H7C4WCdHbyAVwUaWhEiSi+Ch+MFftJTgZi2IKJzreSv3nAijXT7FYn3pzxVECkgP++DwuvMiJK8sV
        bGZbCFKmkKQjYIev+cJc+J2IGt4WGq7Eux968rA4TNemWDXEo8gSdUo90uVMrRvfTradi1EulZwaw
        RRo5BoZw==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4V-00DJnt-RZ; Sun, 19 Jun 2022 06:06:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 5/6] block: simplify disk shutdown
Date:   Sun, 19 Jun 2022 08:05:51 +0200
Message-Id: <20220619060552.1850436-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the queue dying flag and call blk_mq_exit_queue from del_gendisk for
all disks that do not have separately allocated queues, and thus remove
the need to call blk_cleanup_queue for them.

Rename blk_cleanup_disk to blk_mq_destroy_queue to make it clear that
this function is intended only for separately allocated blk-mq queues.

This saves an extra queue freeze for devices without a separately
allocated queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                    | 37 -------------------------
 block/blk-mq.c                      | 43 +++++++++++++++++++++++++++--
 block/blk-sysfs.c                   |  5 ----
 block/blk.h                         |  3 ++
 block/bsg-lib.c                     |  4 +--
 block/genhd.c                       | 23 ++++++++-------
 drivers/block/ataflop.c             |  1 -
 drivers/block/loop.c                |  1 -
 drivers/block/mtip32xx/mtip32xx.c   |  2 --
 drivers/block/rnbd/rnbd-clt.c       |  2 +-
 drivers/block/sx8.c                 |  4 +--
 drivers/block/virtio_blk.c          |  1 -
 drivers/block/z2ram.c               |  1 -
 drivers/cdrom/gdrom.c               |  1 -
 drivers/memstick/core/ms_block.c    |  1 -
 drivers/memstick/core/mspro_block.c |  1 -
 drivers/mmc/core/block.c            |  1 -
 drivers/mmc/core/queue.c            |  1 -
 drivers/nvme/host/apple.c           |  2 +-
 drivers/nvme/host/core.c            |  1 -
 drivers/nvme/host/fc.c              | 12 ++++----
 drivers/nvme/host/pci.c             |  2 +-
 drivers/nvme/host/rdma.c            | 12 ++++----
 drivers/nvme/host/tcp.c             | 12 ++++----
 drivers/nvme/target/loop.c          | 12 ++++----
 drivers/s390/block/dasd.c           |  2 +-
 drivers/s390/block/dasd_genhd.c     |  4 +--
 drivers/scsi/scsi_lib.c             |  6 ++--
 drivers/scsi/scsi_sysfs.c           |  2 +-
 drivers/scsi/sd.c                   |  4 +--
 drivers/scsi/sr.c                   |  4 +--
 drivers/ufs/core/ufshcd.c           |  4 +--
 include/linux/blk-mq.h              |  3 ++
 include/linux/blkdev.h              |  4 +--
 34 files changed, 105 insertions(+), 113 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2f418606e3bd3..409719b852095 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -284,43 +284,6 @@ void blk_queue_start_drain(struct request_queue *q)
 	wake_up_all(&q->mq_freeze_wq);
 }
 
-/**
- * blk_cleanup_queue - shutdown a request queue
- * @q: request queue to shutdown
- *
- * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
- * put it.  All future requests will be failed immediately with -ENODEV.
- *
- * Context: can sleep
- */
-void blk_cleanup_queue(struct request_queue *q)
-{
-	/* cannot be called from atomic context */
-	might_sleep();
-
-	WARN_ON_ONCE(blk_queue_registered(q));
-
-	/* mark @q DYING, no new request or merges will be allowed afterwards */
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-	blk_queue_start_drain(q);
-
-	/*
-	 * Drain all requests queued before DYING marking. Set DEAD flag to
-	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
-	 * after draining finished.
-	 */
-	blk_freeze_queue(q);
-	blk_sync_queue(q);
-	if (queue_is_mq(q)) {
-		blk_mq_cancel_work_sync(q);
-		blk_mq_exit_queue(q);
-	}
-
-	/* @q is and will stay empty, shutdown and put */
-	blk_put_queue(q);
-}
-EXPORT_SYMBOL(blk_cleanup_queue);
-
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33145ba52c960..784b8f35edca4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3890,7 +3890,7 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	q->queuedata = queuedata;
 	ret = blk_mq_init_allocated_queue(set, q);
 	if (ret) {
-		blk_cleanup_queue(q);
+		blk_put_queue(q);
 		return ERR_PTR(ret);
 	}
 	return q;
@@ -3902,6 +3902,35 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
+/**
+ * blk_mq_destroy_queue - shutdown a request queue
+ * @q: request queue to shutdown
+ *
+ * This shuts down a request queue allocated by blk_mq_init_queue() and drops
+ * the initial reference.  All future requests will failed with -ENODEV.
+ *
+ * Context: can sleep
+ */
+void blk_mq_destroy_queue(struct request_queue *q)
+{
+	WARN_ON_ONCE(!queue_is_mq(q));
+	WARN_ON_ONCE(blk_queue_registered(q));
+
+	might_sleep();
+
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
+	blk_queue_start_drain(q);
+	blk_freeze_queue(q);
+
+	blk_sync_queue(q);
+	blk_mq_cancel_work_sync(q);
+	blk_mq_exit_queue(q);
+
+	/* @q is and will stay empty, shutdown and put */
+	blk_put_queue(q);
+}
+EXPORT_SYMBOL(blk_mq_destroy_queue);
+
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 		struct lock_class_key *lkclass)
 {
@@ -3914,13 +3943,23 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 
 	disk = __alloc_disk_node(q, set->numa_node, lkclass);
 	if (!disk) {
-		blk_cleanup_queue(q);
+		blk_put_queue(q);
 		return ERR_PTR(-ENOMEM);
 	}
+	set_bit(GD_OWNS_QUEUE, &disk->state);
 	return disk;
 }
 EXPORT_SYMBOL(__blk_mq_alloc_disk);
 
+struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
+		struct lock_class_key *lkclass)
+{
+	if (!blk_get_queue(q))
+		return NULL;
+	return __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
+}
+EXPORT_SYMBOL(blk_mq_alloc_disk_for_queue);
+
 static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9b905e9443e49..84d7f87015673 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -748,11 +748,6 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
  * decremented with blk_put_queue(). Once the refcount reaches 0 this function
  * is called.
  *
- * For drivers that have a request_queue on a gendisk and added with
- * __device_add_disk() the refcount to request_queue will reach 0 with
- * the last put_disk() called by the driver. For drivers which don't use
- * __device_add_disk() this happens with blk_cleanup_queue().
- *
  * Drivers exist which depend on the release of the request_queue to be
  * synchronous, it should not be deferred.
  *
diff --git a/block/blk.h b/block/blk.h
index 434017701403f..0d6668663ab5d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -411,6 +411,9 @@ int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
 void blk_drop_partitions(struct gendisk *disk);
 
+struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
+		struct lock_class_key *lkclass);
+
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index acfe1357bf6c4..fd4cd5e682826 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -324,7 +324,7 @@ void bsg_remove_queue(struct request_queue *q)
 			container_of(q->tag_set, struct bsg_set, tag_set);
 
 		bsg_unregister_queue(bset->bd);
-		blk_cleanup_queue(q);
+		blk_mq_destroy_queue(q);
 		blk_mq_free_tag_set(&bset->tag_set);
 		kfree(bset);
 	}
@@ -399,7 +399,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 
 	return q;
 out_cleanup_queue:
-	blk_cleanup_queue(q);
+	blk_mq_destroy_queue(q);
 out_queue:
 	blk_mq_free_tag_set(set);
 out_tag_set:
diff --git a/block/genhd.c b/block/genhd.c
index 278227ba1d531..4d15f828c4498 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -617,6 +617,8 @@ void del_gendisk(struct gendisk *disk)
 	 * Fail any new I/O.
 	 */
 	set_bit(GD_DEAD, &disk->state);
+	if (test_bit(GD_OWNS_QUEUE, &disk->state))
+		blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	set_capacity(disk, 0);
 
 	/*
@@ -663,11 +665,16 @@ void del_gendisk(struct gendisk *disk)
 	blk_mq_unquiesce_queue(q);
 
 	/*
-	 * Allow using passthrough request again after the queue is torn down.
+	 * If the disk does not own the queue, allow using passthrough requests
+	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
-	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
-	__blk_mq_unfreeze_queue(q, true);
-
+	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
+		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
+		__blk_mq_unfreeze_queue(q, true);
+	} else {
+		if (queue_is_mq(q))
+			blk_mq_exit_queue(q);
+	}
 }
 EXPORT_SYMBOL(del_gendisk);
 
@@ -1338,9 +1345,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 {
 	struct gendisk *disk;
 
-	if (!blk_get_queue(q))
-		return NULL;
-
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (!disk)
 		goto out_put_queue;
@@ -1391,7 +1395,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	blk_put_queue(q);
 	return NULL;
 }
-EXPORT_SYMBOL(__alloc_disk_node);
 
 struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 {
@@ -1404,9 +1407,10 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 
 	disk = __alloc_disk_node(q, node, lkclass);
 	if (!disk) {
-		blk_cleanup_queue(q);
+		blk_put_queue(q);
 		return NULL;
 	}
+	set_bit(GD_OWNS_QUEUE, &disk->state);
 	return disk;
 }
 EXPORT_SYMBOL(__blk_alloc_disk);
@@ -1439,7 +1443,6 @@ EXPORT_SYMBOL(put_disk);
  */
 void blk_cleanup_disk(struct gendisk *disk)
 {
-	blk_cleanup_queue(disk->queue);
 	put_disk(disk);
 }
 EXPORT_SYMBOL(blk_cleanup_disk);
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index e232cc4fd444b..c6e41ee18aaa2 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2045,7 +2045,6 @@ static void atari_floppy_cleanup(void)
 			if (!unit[i].disk[type])
 				continue;
 			del_gendisk(unit[i].disk[type]);
-			blk_cleanup_queue(unit[i].disk[type]->queue);
 			put_disk(unit[i].disk[type]);
 		}
 		blk_mq_free_tag_set(&unit[i].tag_set);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 084f9b8a0ba3c..cc608226c8c78 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2057,7 +2057,6 @@ static void loop_remove(struct loop_device *lo)
 {
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
-	blk_cleanup_queue(lo->lo_disk->queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 
 	mutex_lock(&loop_ctl_mutex);
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e7604b3bf8a75..1d0e0a9fdd7c2 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3565,7 +3565,6 @@ static int mtip_block_shutdown(struct driver_data *dd)
 	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
 		del_gendisk(dd->disk);
 
-	blk_cleanup_queue(dd->queue);
 	blk_mq_free_tag_set(&dd->tags);
 	put_disk(dd->disk);
 	return 0;
@@ -3914,7 +3913,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 		dev_info(&dd->pdev->dev, "device %s surprise removal\n",
 						dd->disk->disk_name);
 
-	blk_cleanup_queue(dd->queue);
 	blk_mq_free_tag_set(&dd->tags);
 
 	/* De-initialize the protocol layer. */
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 409c76b81aed4..a4470374f54fc 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1755,7 +1755,7 @@ static void rnbd_destroy_sessions(void)
 		list_for_each_entry_safe(dev, tn, &sess->devs_list, list) {
 			/*
 			 * Here unmap happens in parallel for only one reason:
-			 * blk_cleanup_queue() takes around half a second, so
+			 * del_gendisk() takes around half a second, so
 			 * on huge amount of devices the whole module unload
 			 * procedure takes minutes.
 			 */
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 63b4f6431d2e6..75057dbbcfbea 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1536,7 +1536,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		clear_bit(0, &carm_major_alloc);
 	else if (host->major == 161)
 		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
+	blk_mq_destroy_queue(host->oob_q);
 	blk_mq_free_tag_set(&host->tag_set);
 err_out_dma_free:
 	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
@@ -1570,7 +1570,7 @@ static void carm_remove_one (struct pci_dev *pdev)
 		clear_bit(0, &carm_major_alloc);
 	else if (host->major == 161)
 		clear_bit(1, &carm_major_alloc);
-	blk_cleanup_queue(host->oob_q);
+	blk_mq_destroy_queue(host->oob_q);
 	blk_mq_free_tag_set(&host->tag_set);
 	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
 	iounmap(host->mmio);
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6fc7850c2b0a0..cff1b6f6b0548 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1111,7 +1111,6 @@ static void virtblk_remove(struct virtio_device *vdev)
 	flush_work(&vblk->config_work);
 
 	del_gendisk(vblk->disk);
-	blk_cleanup_queue(vblk->disk->queue);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
 	mutex_lock(&vblk->vdev_mutex);
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 7a6ed83481b8d..18ad43d9933ec 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -384,7 +384,6 @@ static void __exit z2_exit(void)
 
 	for (i = 0; i < Z2MINOR_COUNT; i++) {
 		del_gendisk(z2ram_gendisk[i]);
-		blk_cleanup_queue(z2ram_gendisk[i]->queue);
 		put_disk(z2ram_gendisk[i]);
 	}
 	blk_mq_free_tag_set(&tag_set);
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 8e78b37d0f6a4..f4cc90ea6198e 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -831,7 +831,6 @@ static int probe_gdrom(struct platform_device *devptr)
 
 static int remove_gdrom(struct platform_device *devptr)
 {
-	blk_cleanup_queue(gd.gdrom_rq);
 	blk_mq_free_tag_set(&gd.tag_set);
 	free_irq(HW_EVENT_GDROM_CMD, &gd);
 	free_irq(HW_EVENT_GDROM_DMA, &gd);
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 3993bdd4b519c..ba7e7249a3db4 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2187,7 +2187,6 @@ static void msb_remove(struct memstick_dev *card)
 
 	/* Remove the disk */
 	del_gendisk(msb->disk);
-	blk_cleanup_queue(msb->queue);
 	blk_mq_free_tag_set(&msb->tag_set);
 	msb->queue = NULL;
 
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 725ba74ded308..72e91c06c618b 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1294,7 +1294,6 @@ static void mspro_block_remove(struct memstick_dev *card)
 	del_gendisk(msb->disk);
 	dev_dbg(&card->dev, "mspro block remove\n");
 
-	blk_cleanup_queue(msb->queue);
 	blk_mq_free_tag_set(&msb->tag_set);
 	msb->queue = NULL;
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f4a1281658db0..bda6c67ce93f4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2509,7 +2509,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	return md;
 
  err_cleanup_queue:
-	blk_cleanup_queue(md->disk->queue);
 	blk_mq_free_tag_set(&md->queue.tag_set);
  err_kfree:
 	kfree(md);
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index fa5324ceeebe4..f824cfdab75ac 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -494,7 +494,6 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	if (blk_queue_quiesced(q))
 		blk_mq_unquiesce_queue(q);
 
-	blk_cleanup_queue(q);
 	blk_mq_free_tag_set(&mq->tag_set);
 
 	/*
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index d702d7d60235d..2d23b7d41f7e6 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1502,7 +1502,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 
 	if (!blk_get_queue(anv->ctrl.admin_q)) {
 		nvme_start_admin_queue(&anv->ctrl);
-		blk_cleanup_queue(anv->ctrl.admin_q);
+		blk_mq_destroy_queue(anv->ctrl.admin_q);
 		anv->ctrl.admin_q = NULL;
 		ret = -ENODEV;
 		goto put_dev;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ab2cfd254a44..697af049b49d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4089,7 +4089,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
-	blk_cleanup_queue(ns->queue);
 
 	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3c778bb0c2944..a96aa831684c3 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2392,7 +2392,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	unsigned long flags;
 
 	if (ctrl->ctrl.tagset) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(&ctrl->tag_set);
 	}
 
@@ -2402,8 +2402,8 @@ nvme_fc_ctrl_free(struct kref *ref)
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
 	nvme_start_admin_queue(&ctrl->ctrl);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
+	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
+	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 
 	kfree(ctrl->queues);
@@ -2953,7 +2953,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 out_delete_hw_queues:
 	nvme_fc_delete_hw_io_queues(ctrl);
 out_cleanup_blk_queue:
-	blk_cleanup_queue(ctrl->ctrl.connect_q);
+	blk_mq_destroy_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	blk_mq_free_tag_set(&ctrl->tag_set);
 	nvme_fc_free_io_queues(ctrl);
@@ -3642,9 +3642,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	return ERR_PTR(-EIO);
 
 out_cleanup_admin_q:
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
+	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
 out_cleanup_fabrics_q:
-	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
+	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
 out_free_admin_tag_set:
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 out_free_queues:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c7012e85d035d..69c8b47b52274 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1760,7 +1760,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 * queue to flush these to completion.
 		 */
 		nvme_start_admin_queue(&dev->ctrl);
-		blk_cleanup_queue(dev->ctrl.admin_q);
+		blk_mq_destroy_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
 }
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f2a5e1ea508a7..0fb7c8e7ab0be 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -840,8 +840,8 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		blk_cleanup_queue(ctrl->ctrl.fabrics_q);
+		blk_mq_destroy_queue(ctrl->ctrl.admin_q);
+		blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 	}
 	if (ctrl->async_event_sqe.data) {
@@ -935,10 +935,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 out_cleanup_queue:
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
+		blk_mq_destroy_queue(ctrl->ctrl.admin_q);
 out_cleanup_fabrics_q:
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.fabrics_q);
+		blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
 out_free_tagset:
 	if (new)
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
@@ -957,7 +957,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(ctrl->ctrl.tagset);
 	}
 	nvme_rdma_free_io_queues(ctrl);
@@ -1012,7 +1012,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 out_cleanup_connect_q:
 	nvme_cancel_tagset(&ctrl->ctrl);
 	if (new)
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	if (new)
 		blk_mq_free_tag_set(ctrl->ctrl.tagset);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb67538d241b6..b81942fa5f959 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1885,7 +1885,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_io_queues(ctrl);
 	if (remove) {
-		blk_cleanup_queue(ctrl->connect_q);
+		blk_mq_destroy_queue(ctrl->connect_q);
 		blk_mq_free_tag_set(ctrl->tagset);
 	}
 	nvme_tcp_free_io_queues(ctrl);
@@ -1940,7 +1940,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 out_cleanup_connect_q:
 	nvme_cancel_tagset(ctrl);
 	if (new)
-		blk_cleanup_queue(ctrl->connect_q);
+		blk_mq_destroy_queue(ctrl->connect_q);
 out_free_tag_set:
 	if (new)
 		blk_mq_free_tag_set(ctrl->tagset);
@@ -1953,8 +1953,8 @@ static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (remove) {
-		blk_cleanup_queue(ctrl->admin_q);
-		blk_cleanup_queue(ctrl->fabrics_q);
+		blk_mq_destroy_queue(ctrl->admin_q);
+		blk_mq_destroy_queue(ctrl->fabrics_q);
 		blk_mq_free_tag_set(ctrl->admin_tagset);
 	}
 	nvme_tcp_free_admin_queue(ctrl);
@@ -2012,10 +2012,10 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_queue:
 	if (new)
-		blk_cleanup_queue(ctrl->admin_q);
+		blk_mq_destroy_queue(ctrl->admin_q);
 out_cleanup_fabrics_q:
 	if (new)
-		blk_cleanup_queue(ctrl->fabrics_q);
+		blk_mq_destroy_queue(ctrl->fabrics_q);
 out_free_tagset:
 	if (new)
 		blk_mq_free_tag_set(ctrl->admin_tagset);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 59024af2da2e3..0f5c77e22a0a9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -266,8 +266,8 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (!test_and_clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags))
 		return;
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
+	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
+	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 }
 
@@ -283,7 +283,7 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
 	if (nctrl->tagset) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(&ctrl->tag_set);
 	}
 	kfree(ctrl->queues);
@@ -410,9 +410,9 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 out_cleanup_queue:
 	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
+	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
 out_cleanup_fabrics_q:
-	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
+	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
 out_free_tagset:
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
 out_free_sq:
@@ -554,7 +554,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	return 0;
 
 out_cleanup_connect_q:
-	blk_cleanup_queue(ctrl->ctrl.connect_q);
+	blk_mq_destroy_queue(ctrl->ctrl.connect_q);
 out_free_tagset:
 	blk_mq_free_tag_set(&ctrl->tag_set);
 out_destroy_queues:
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ba6d787896606..e8489331f12b8 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3280,7 +3280,7 @@ static int dasd_alloc_queue(struct dasd_block *block)
 static void dasd_free_queue(struct dasd_block *block)
 {
 	if (block->request_queue) {
-		blk_cleanup_queue(block->request_queue);
+		blk_mq_destroy_queue(block->request_queue);
 		blk_mq_free_tag_set(&block->tag_set);
 		block->request_queue = NULL;
 	}
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index a7a33ebf4bbe9..5a83f0a39901b 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -41,8 +41,8 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
-	gdp = __alloc_disk_node(block->request_queue, NUMA_NO_NODE,
-				&dasd_bio_compl_lkclass);
+	gdp = blk_mq_alloc_disk_for_queue(block->request_queue,
+					  &dasd_bio_compl_lkclass);
 	if (!gdp)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a80..cdf0056582d5f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -163,7 +163,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 * Requeue this command.  It will go before all other commands
 	 * that are already in the queue. Schedule requeue work under
 	 * lock such that the kblockd_schedule_work() call happens
-	 * before blk_cleanup_queue() finishes.
+	 * before blk_mq_destroy_queue() finishes.
 	 */
 	cmd->result = 0;
 
@@ -424,9 +424,9 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
 		 * it and the queue.  Mitigate by taking a reference to the
 		 * queue and never touching the sdev again after we drop the
 		 * host lock.  Note: if __scsi_remove_device() invokes
-		 * blk_cleanup_queue() before the queue is run from this
+		 * blk_mq_destroy_queue() before the queue is run from this
 		 * function then blk_run_queue() will return immediately since
-		 * blk_cleanup_queue() marks the queue with QUEUE_FLAG_DYING.
+		 * blk_mq_destroy_queue() marks the queue with QUEUE_FLAG_DYING.
 		 */
 		slq = sdev->request_queue;
 		if (!blk_get_queue(slq))
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 43949798a2e47..aa70d9282161d 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1475,7 +1475,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	scsi_device_set_state(sdev, SDEV_DEL);
 	mutex_unlock(&sdev->state_mutex);
 
-	blk_cleanup_queue(sdev->request_queue);
+	blk_mq_destroy_queue(sdev->request_queue);
 	cancel_work_sync(&sdev->requeue_work);
 
 	if (sdev->host->hostt->slave_destroy)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a1a2ac09066fd..cb587e488601c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3440,8 +3440,8 @@ static int sd_probe(struct device *dev)
 	if (!sdkp)
 		goto out;
 
-	gd = __alloc_disk_node(sdp->request_queue, NUMA_NO_NODE,
-			       &sd_bio_compl_lkclass);
+	gd = blk_mq_alloc_disk_for_queue(sdp->request_queue,
+					 &sd_bio_compl_lkclass);
 	if (!gd)
 		goto out_free;
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 32d3b8274f148..a278b739d0c5f 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -624,8 +624,8 @@ static int sr_probe(struct device *dev)
 	if (!cd)
 		goto fail;
 
-	disk = __alloc_disk_node(sdev->request_queue, NUMA_NO_NODE,
-				 &sr_bio_compl_lkclass);
+	disk = blk_mq_alloc_disk_for_queue(sdev->request_queue,
+					   &sr_bio_compl_lkclass);
 	if (!disk)
 		goto fail_free;
 	mutex_init(&cd->lock);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 01fb4bad86be8..a46330f9f973a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9467,7 +9467,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufs_bsg_remove(hba);
 	ufshpb_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
-	blk_cleanup_queue(hba->tmf_queue);
+	blk_mq_destroy_queue(hba->tmf_queue);
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
 	scsi_remove_host(hba->host);
 	/* disable interrupts */
@@ -9763,7 +9763,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	return 0;
 
 free_tmf_queue:
-	blk_cleanup_queue(hba->tmf_queue);
+	blk_mq_destroy_queue(hba->tmf_queue);
 free_tmf_tag_set:
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
 out_remove_scsi_host:
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd0..0fd96e92c6c65 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -686,10 +686,13 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 									\
 	__blk_mq_alloc_disk(set, queuedata, &__key);			\
 })
+struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
+		struct lock_class_key *lkclass);
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
+void blk_mq_destroy_queue(struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c77ed4dcf561b..b9bf092531bc7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -148,6 +148,7 @@ struct gendisk {
 #define GD_NATIVE_CAPACITY		3
 #define GD_ADDED			4
 #define GD_SUPPRESS_PART_SCAN		5
+#define GD_OWNS_QUEUE			6
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
@@ -811,8 +812,6 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 
-struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
-		struct lock_class_key *lkclass);
 void put_disk(struct gendisk *disk);
 struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
 
@@ -954,7 +953,6 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 /*
  * Access functions for manipulating queue properties
  */
-extern void blk_cleanup_queue(struct request_queue *);
 void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce limit);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
-- 
2.30.2

