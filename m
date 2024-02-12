Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20E10942;
	Mon, 12 Feb 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720416; cv=none; b=tqk4cp6Ft++mWLmhM/mYgvduZv8OiEvUgyM0C6OQ7423pmNqet+dc6sSDGC56MYeU4ee0AA0Fct6OUhxb17FARBJlywjxxp16NZioioGAfBcud350Z1p7qcsjNLgOCWo5dcgcN9kHYrlY0EL9zm3nTjNNtz4TBRklkinEBrjRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720416; c=relaxed/simple;
	bh=d4ne5U8DHDuQIpr8Zbg/P4CjcYusW0dD5Qz+V9iSvT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuiaBfqK12DHa5n6Vu8xzD11HBpxlMRmPBo+X2FTS7rvYRA3TufC4kyTzQ+56vPAVOHQ44r11jSQe+Drk1lOLI/1SZB11Yd2Xqfnj36bh2q8AOUIYgVleM4n2007FPAoCTQ4ieWFSwcxF8Dx7zJdQ50IfTPFIjh1vQjJeq7IJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cTG6uFHW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cTG6uFHW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bcEDlVfeyip1W5NeW0KnLVWghb7lQH/tkeKz0iVdZfk=; b=cTG6uFHW4SSHrXYpARRuWFXkMo
	zYGU55sLRNlskz+o2qaSHGM2vE54inxxZNxaP7V9R8Sp6Eeax4xEhuZTgLq/4fWlU9gz1yrmwJmsx
	umprxfyfE+7gSw7CkXYGMezvA5R3jLuymyqGex2Aub6gWf8irOxFiquyZ0J3cFhNpmBSTAX77WprF
	ncpHTWf57iNyIEUYirkzqxL/T+EWJf1dQU77tChaK1EWCxsPQFUpYOgfSJutO3eorS4ktDB2b5Wg+
	JLs52nTbvEen8DYa+IYrpIDVdLWDzggJulhQc270nJQ+VPFosmAoSY6yP865/j1NYtiAWBPWc4IIw
	mW1NrfJg==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5W-00000004Pou-3Mk2;
	Mon, 12 Feb 2024 06:46:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	John Garry <john.g.garry@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/15] block: pass a queue_limits argument to blk_mq_alloc_disk
Date: Mon, 12 Feb 2024 07:46:04 +0100
Message-Id: <20240212064609.1327143-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass a queue_limits to blk_mq_alloc_disk and apply it if non-NULL.  This
will allow allocating queues with valid queue limits instead of setting
the values one at a time later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 arch/um/drivers/ubd_kern.c          | 2 +-
 block/blk-mq.c                      | 5 +++--
 drivers/block/amiflop.c             | 2 +-
 drivers/block/aoe/aoeblk.c          | 2 +-
 drivers/block/ataflop.c             | 2 +-
 drivers/block/floppy.c              | 2 +-
 drivers/block/loop.c                | 2 +-
 drivers/block/mtip32xx/mtip32xx.c   | 2 +-
 drivers/block/nbd.c                 | 2 +-
 drivers/block/null_blk/main.c       | 2 +-
 drivers/block/ps3disk.c             | 2 +-
 drivers/block/rbd.c                 | 2 +-
 drivers/block/rnbd/rnbd-clt.c       | 2 +-
 drivers/block/sunvdc.c              | 2 +-
 drivers/block/swim.c                | 2 +-
 drivers/block/swim3.c               | 2 +-
 drivers/block/ublk_drv.c            | 2 +-
 drivers/block/virtio_blk.c          | 2 +-
 drivers/block/xen-blkfront.c        | 2 +-
 drivers/block/z2ram.c               | 2 +-
 drivers/cdrom/gdrom.c               | 2 +-
 drivers/memstick/core/ms_block.c    | 2 +-
 drivers/memstick/core/mspro_block.c | 2 +-
 drivers/mmc/core/queue.c            | 2 +-
 drivers/mtd/mtd_blkdevs.c           | 2 +-
 drivers/mtd/ubi/block.c             | 2 +-
 drivers/nvme/host/core.c            | 2 +-
 drivers/s390/block/dasd_genhd.c     | 2 +-
 drivers/s390/block/scm_blk.c        | 2 +-
 include/linux/blk-mq.h              | 7 ++++---
 30 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 92ee2697ff3984..25f1b18ce7d4e9 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -906,7 +906,7 @@ static int ubd_add(int n, char **error_out)
 	if (err)
 		goto out;
 
-	disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
+	disk = blk_mq_alloc_disk(&ubd_dev->tag_set, NULL, ubd_dev);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6499bbd89be90..6abb4ce46baa1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4130,13 +4130,14 @@ void blk_mq_destroy_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_destroy_queue);
 
-struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
+struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
+		struct queue_limits *lim, void *queuedata,
 		struct lock_class_key *lkclass)
 {
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_mq_alloc_queue(set, NULL, queuedata);
+	q = blk_mq_alloc_queue(set, lim, queuedata);
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 2b98114a9fe092..a25414228e4741 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1779,7 +1779,7 @@ static int fd_alloc_disk(int drive, int system)
 	struct gendisk *disk;
 	int err;
 
-	disk = blk_mq_alloc_disk(&unit[drive].tag_set, NULL);
+	disk = blk_mq_alloc_disk(&unit[drive].tag_set, NULL, NULL);
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index b1b47d88f5db44..2ff6e2da8cc41c 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -371,7 +371,7 @@ aoeblk_gdalloc(void *vp)
 		goto err_mempool;
 	}
 
-	gd = blk_mq_alloc_disk(set, d);
+	gd = blk_mq_alloc_disk(set, NULL, d);
 	if (IS_ERR(gd)) {
 		pr_err("aoe: cannot allocate block queue for %ld.%d\n",
 			d->aoemajor, d->aoeminor);
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 50949207798d2a..cacc4ba942a814 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1994,7 +1994,7 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
 {
 	struct gendisk *disk;
 
-	disk = blk_mq_alloc_disk(&unit[drive].tag_set, NULL);
+	disk = blk_mq_alloc_disk(&unit[drive].tag_set, NULL, NULL);
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index d0e41d52d6a9b5..6f765d221b3814 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4515,7 +4515,7 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 {
 	struct gendisk *disk;
 
-	disk = blk_mq_alloc_disk(&tag_sets[drive], NULL);
+	disk = blk_mq_alloc_disk(&tag_sets[drive], NULL, NULL);
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f8145499da38c8..3f855cc79c29f5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2025,7 +2025,7 @@ static int loop_add(int i)
 	if (err)
 		goto out_free_idr;
 
-	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, lo);
+	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, NULL, lo);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index b200950e8fb5f9..ac08dea73552f4 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3431,7 +3431,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 		goto block_queue_alloc_tag_error;
 	}
 
-	dd->disk = blk_mq_alloc_disk(&dd->tags, dd);
+	dd->disk = blk_mq_alloc_disk(&dd->tags, NULL, dd);
 	if (IS_ERR(dd->disk)) {
 		dev_err(&dd->pdev->dev,
 			"Unable to allocate request queue\n");
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 33a8f37bb6a1f5..30ae3cc12e7787 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1823,7 +1823,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	if (err < 0)
 		goto out_free_tags;
 
-	disk = blk_mq_alloc_disk(&nbd->tag_set, NULL);
+	disk = blk_mq_alloc_disk(&nbd->tag_set, NULL, NULL);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_free_idr;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4281371c81fed1..eeb895ec6f34ae 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2147,7 +2147,7 @@ static int null_add_dev(struct nullb_device *dev)
 			goto out_cleanup_queues;
 
 		nullb->tag_set->timeout = 5 * HZ;
-		nullb->disk = blk_mq_alloc_disk(nullb->tag_set, nullb);
+		nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
 		if (IS_ERR(nullb->disk)) {
 			rv = PTR_ERR(nullb->disk);
 			goto out_cleanup_tags;
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 36d7b36c60c76b..dfd3860df4f880 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -431,7 +431,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	if (error)
 		goto fail_teardown;
 
-	gendisk = blk_mq_alloc_disk(&priv->tag_set, dev);
+	gendisk = blk_mq_alloc_disk(&priv->tag_set, NULL, dev);
 	if (IS_ERR(gendisk)) {
 		dev_err(&dev->sbd.core, "%s:%u: blk_mq_alloc_disk failed\n",
 			__func__, __LINE__);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 00ca8a1d8c46ff..6b4f1898a722a3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4966,7 +4966,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	if (err)
 		return err;
 
-	disk = blk_mq_alloc_disk(&rbd_dev->tag_set, rbd_dev);
+	disk = blk_mq_alloc_disk(&rbd_dev->tag_set, NULL, rbd_dev);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_tag_set;
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 4044c369d22a5f..d51be4f2df61a3 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1408,7 +1408,7 @@ static int rnbd_client_setup_device(struct rnbd_clt_dev *dev,
 	dev->size = le64_to_cpu(rsp->nsectors) *
 			le16_to_cpu(rsp->logical_block_size);
 
-	dev->gd = blk_mq_alloc_disk(&dev->sess->tag_set, dev);
+	dev->gd = blk_mq_alloc_disk(&dev->sess->tag_set, NULL, dev);
 	if (IS_ERR(dev->gd))
 		return PTR_ERR(dev->gd);
 	dev->queue = dev->gd->queue;
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 7bf4b48e2282e7..a1f74dd1eae5d5 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -824,7 +824,7 @@ static int probe_disk(struct vdc_port *port)
 	if (err)
 		return err;
 
-	g = blk_mq_alloc_disk(&port->tag_set, port);
+	g = blk_mq_alloc_disk(&port->tag_set, NULL, port);
 	if (IS_ERR(g)) {
 		printk(KERN_ERR PFX "%s: Could not allocate gendisk.\n",
 		       port->vio.name);
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index f85b6af414b431..16bdf62067d8b1 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -820,7 +820,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 			goto exit_put_disks;
 
 		swd->unit[drive].disk =
-			blk_mq_alloc_disk(&swd->unit[drive].tag_set,
+			blk_mq_alloc_disk(&swd->unit[drive].tag_set, NULL,
 					  &swd->unit[drive]);
 		if (IS_ERR(swd->unit[drive].disk)) {
 			blk_mq_free_tag_set(&swd->unit[drive].tag_set);
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index c2bc85826358e9..a04756ac778ee8 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1210,7 +1210,7 @@ static int swim3_attach(struct macio_dev *mdev,
 	if (rc)
 		goto out_unregister;
 
-	disk = blk_mq_alloc_disk(&fs->tag_set, fs);
+	disk = blk_mq_alloc_disk(&fs->tag_set, NULL, fs);
 	if (IS_ERR(disk)) {
 		rc = PTR_ERR(disk);
 		goto out_free_tag_set;
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1dfb2e77898ba6..c5b6552707984b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2222,7 +2222,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 		goto out_unlock;
 	}
 
-	disk = blk_mq_alloc_disk(&ub->tag_set, NULL);
+	disk = blk_mq_alloc_disk(&ub->tag_set, NULL, NULL);
 	if (IS_ERR(disk)) {
 		ret = PTR_ERR(disk);
 		goto out_unlock;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5bf98fd6a651a5..a23fce4eca4408 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1330,7 +1330,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vq;
 
-	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
+	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, NULL, vblk);
 	if (IS_ERR(vblk->disk)) {
 		err = PTR_ERR(vblk->disk);
 		goto out_free_tags;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 434fab30677743..4cc2884e748463 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1136,7 +1136,7 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	if (err)
 		goto out_release_minors;
 
-	gd = blk_mq_alloc_disk(&info->tag_set, info);
+	gd = blk_mq_alloc_disk(&info->tag_set, NULL, info);
 	if (IS_ERR(gd)) {
 		err = PTR_ERR(gd);
 		goto out_free_tag_set;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 11493167b0a848..7c5f4e4d9b5037 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -318,7 +318,7 @@ static int z2ram_register_disk(int minor)
 	struct gendisk *disk;
 	int err;
 
-	disk = blk_mq_alloc_disk(&tag_set, NULL);
+	disk = blk_mq_alloc_disk(&tag_set, NULL, NULL);
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index d668b174ace92f..1d044779f5e42a 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -778,7 +778,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	if (err)
 		goto probe_fail_free_cd_info;
 
-	gd.disk = blk_mq_alloc_disk(&gd.tag_set, NULL);
+	gd.disk = blk_mq_alloc_disk(&gd.tag_set, NULL, NULL);
 	if (IS_ERR(gd.disk)) {
 		err = PTR_ERR(gd.disk);
 		goto probe_fail_free_tag_set;
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 04115cd92433bf..d3277c901d16bb 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2093,7 +2093,7 @@ static int msb_init_disk(struct memstick_dev *card)
 	if (rc)
 		goto out_release_id;
 
-	msb->disk = blk_mq_alloc_disk(&msb->tag_set, card);
+	msb->disk = blk_mq_alloc_disk(&msb->tag_set, NULL, card);
 	if (IS_ERR(msb->disk)) {
 		rc = PTR_ERR(msb->disk);
 		goto out_free_tag_set;
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 5a69ed33999b4c..db0e2a42ca3c32 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1138,7 +1138,7 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	if (rc)
 		goto out_release_id;
 
-	msb->disk = blk_mq_alloc_disk(&msb->tag_set, card);
+	msb->disk = blk_mq_alloc_disk(&msb->tag_set, NULL, card);
 	if (IS_ERR(msb->disk)) {
 		rc = PTR_ERR(msb->disk);
 		goto out_free_tag_set;
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index a0a2412f62a730..67ad186d132a69 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -447,7 +447,7 @@ struct gendisk *mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
 		return ERR_PTR(ret);
 		
 
-	disk = blk_mq_alloc_disk(&mq->tag_set, mq);
+	disk = blk_mq_alloc_disk(&mq->tag_set, NULL, mq);
 	if (IS_ERR(disk)) {
 		blk_mq_free_tag_set(&mq->tag_set);
 		return disk;
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index f0526dcc216276..b8878a2457afa7 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -333,7 +333,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 		goto out_kfree_tag_set;
 
 	/* Create gendisk */
-	gd = blk_mq_alloc_disk(new->tag_set, new);
+	gd = blk_mq_alloc_disk(new->tag_set, NULL, new);
 	if (IS_ERR(gd)) {
 		ret = PTR_ERR(gd);
 		goto out_free_tag_set;
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 654bd7372cd8c0..9be87c231a2eba 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -393,7 +393,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 
 
 	/* Initialize the gendisk of this ubiblock device */
-	gd = blk_mq_alloc_disk(&dev->tag_set, dev);
+	gd = blk_mq_alloc_disk(&dev->tag_set, NULL, dev);
 	if (IS_ERR(gd)) {
 		ret = PTR_ERR(gd);
 		goto out_free_tags;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3afd449f0ead4e..7a70170ac08613 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3688,7 +3688,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (!ns)
 		return;
 
-	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
+	disk = blk_mq_alloc_disk(ctrl->tagset, NULL, ns);
 	if (IS_ERR(disk))
 		goto out_free_ns;
 	disk->fops = &nvme_bdev_ops;
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 30e8ee583e980e..0465b706745f64 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -53,7 +53,7 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	if (rc)
 		return rc;
 
-	gdp = blk_mq_alloc_disk(&block->tag_set, block);
+	gdp = blk_mq_alloc_disk(&block->tag_set, NULL, block);
 	if (IS_ERR(gdp)) {
 		blk_mq_free_tag_set(&block->tag_set);
 		return PTR_ERR(gdp);
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index ade95e91b3c8db..d05b2e2799a47a 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -462,7 +462,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	if (ret)
 		goto out;
 
-	bdev->gendisk = blk_mq_alloc_disk(&bdev->tag_set, scmdev);
+	bdev->gendisk = blk_mq_alloc_disk(&bdev->tag_set, NULL, scmdev);
 	if (IS_ERR(bdev->gendisk)) {
 		ret = PTR_ERR(bdev->gendisk);
 		goto out_tag;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7d42c359e2ab28..390d35fa003295 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -682,13 +682,14 @@ enum {
 
 #define BLK_MQ_NO_HCTX_IDX	(-1U)
 
-struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
+struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
+		struct queue_limits *lim, void *queuedata,
 		struct lock_class_key *lkclass);
-#define blk_mq_alloc_disk(set, queuedata)				\
+#define blk_mq_alloc_disk(set, lim, queuedata)				\
 ({									\
 	static struct lock_class_key __key;				\
 									\
-	__blk_mq_alloc_disk(set, queuedata, &__key);			\
+	__blk_mq_alloc_disk(set, lim, queuedata, &__key);		\
 })
 struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
 		struct lock_class_key *lkclass);
-- 
2.39.2

