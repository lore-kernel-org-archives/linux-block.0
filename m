Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005553C481;
	Sun, 28 Jan 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461153; cv=none; b=BRLNQUjnxvOxk3Y4sjIv/3I/TgfS6JzyEh4VZ0AEqCQyz1npVdmHbfFKw4HugWVLm4eFcQHKW/ULIxYzl0KcJuCS2gqR1ec7ky4M+bR6JBxpMhv3LfyAKYwnVhYfSabK8recOEjmAOId4/wp1FlG5eWbFT0hxA5BLOuTHIZh3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461153; c=relaxed/simple;
	bh=27j2EdjxJX6ZmPdc8ggOL4Jg1Fqdb12WqGHs2211T54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXvmt4K+Nld8HW2NLyZINXO2EDnxB2UkTENyLS3bNaBiquWsGJCB9RtwWkfMTbahcw2aDFr4vN5s6/djMtiO6CKaUfwtx4wmKhh0dQ0SlS344foxpUwuqCEUojNdZKzIkWaN1/ZmNFTdh7PAFdbGBQeHJt83phMbix44BEaGtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eqo362P2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqo362P2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5LXlex7D4Ilf/x8xCjyoSbZw/Izp75TGUeBfRvxcl9A=; b=eqo362P2rV/ZGFA3GEhgyOCgFt
	iBk3aNdgFHdtplnLe3Mqjl/T2zyCsaSCw9MIosaxjdGgbAoBTDsApTqKtkttxqXiUt2uAb7eOb9Tp
	MB7HrtgHRD5zZ5fVJ8QBdJw4FWYxUvUPRZYZhOOl/1bDFRLiDwXvFiV7Y8iw8XIwvkIX2l3SF5ndv
	Xp7mvmJpiib2FCwdEhhvGqrxCgWxC588Ct+eDQfLx9aPpKhVtu7NwDhZTsaWA/wVSyAy3RA39zxd7
	z9Umj4GZENGTQUtctj2jMi50VlYergcJtnokpgXUK3vVr3PSLQJMgMuUy9R3U5yeprBSb8d5yjMOL
	byVfMiVg==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Uq-0000000A2P9-12Nz;
	Sun, 28 Jan 2024 16:59:05 +0000
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
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/14] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Date: Sun, 28 Jan 2024 17:58:10 +0100
Message-Id: <20240128165813.3213508-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Call virtblk_read_limits and most of virtblk_probe_zoned_device before
allocating the gendisk and thus request_queue and make them read into
a queue_limits structure instead.  Pass this initialized queue_limits
to blk_mq_alloc_disk to set the queue up with the right parameters
from the start and only leave a few final touches for zoned devices
to be done just before adding the disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/virtio_blk.c | 130 ++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index dd46ccd9f84c7d..d8b55874cd5950 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -720,16 +720,15 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 	return ret;
 }
 
-static int virtblk_probe_zoned_device(struct virtio_device *vdev,
-				       struct virtio_blk *vblk,
-				       struct request_queue *q)
+static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
+		struct queue_limits *lim)
 {
+	struct virtio_device *vdev = vblk->vdev;
 	u32 v, wg;
 
 	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
 
-	disk_set_zoned(vblk->disk);
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	lim->zoned = true;
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_open_zones, &v);
@@ -747,8 +746,8 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 		dev_warn(&vdev->dev, "zero write granularity reported\n");
 		return -ENODEV;
 	}
-	blk_queue_physical_block_size(q, wg);
-	blk_queue_io_min(q, wg);
+	lim->physical_block_size = wg;
+	lim->io_min = wg;
 
 	dev_dbg(&vdev->dev, "write granularity = %u\n", wg);
 
@@ -764,13 +763,13 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			vblk->zone_sectors);
 		return -ENODEV;
 	}
-	blk_queue_chunk_sectors(q, vblk->zone_sectors);
+	lim->chunk_sectors = vblk->zone_sectors;
 	dev_dbg(&vdev->dev, "zone sectors = %u\n", vblk->zone_sectors);
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
 		dev_warn(&vblk->vdev->dev,
 			 "ignoring negotiated F_DISCARD for zoned device\n");
-		blk_queue_max_discard_sectors(q, 0);
+		lim->max_hw_discard_sectors = 0;
 	}
 
 	virtio_cread(vdev, struct virtio_blk_config,
@@ -785,25 +784,21 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			wg, v);
 		return -ENODEV;
 	}
-	blk_queue_max_zone_append_sectors(q, v);
+	lim->max_zone_append_sectors = v;
 	dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
 
-	return blk_revalidate_disk_zones(vblk->disk, NULL);
+	return 0;
 }
-
 #else
-
 /*
- * Zoned block device support is not configured in this kernel.
- * Host-managed zoned devices can't be supported, but others are
- * good to go as regular block devices.
+ * Zoned block device support is not configured in this kernel, host-managed
+ * zoned devices can't be supported.
  */
 #define virtblk_report_zones       NULL
-
-static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
-			struct virtio_blk *vblk, struct request_queue *q)
+static inline int virtblk_read_zoned_limits(struct virtio_blk *vblk,
+		struct queue_limits *lim)
 {
-	dev_err(&vdev->dev,
+	dev_err(&vblk->vdev->dev,
 		"virtio_blk: zoned devices are not supported");
 	return -EOPNOTSUPP;
 }
@@ -1248,9 +1243,9 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
-static int virtblk_read_limits(struct virtio_blk *vblk)
+static int virtblk_read_limits(struct virtio_blk *vblk,
+		struct queue_limits *lim)
 {
-	struct request_queue *q = vblk->disk->queue;
 	struct virtio_device *vdev = vblk->vdev;
 	u32 v, blk_size, max_size, sg_elems, opt_io_size;
 	u32 max_discard_segs = 0;
@@ -1273,10 +1268,10 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
 	/* We can handle whatever the host told us to handle. */
-	blk_queue_max_segments(q, sg_elems);
+	lim->max_segments = sg_elems;
 
 	/* No real sector limit. */
-	blk_queue_max_hw_sectors(q, UINT_MAX);
+	lim->max_hw_sectors = UINT_MAX;
 
 	max_dma_size = virtio_max_dma_size(vdev);
 	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
@@ -1288,7 +1283,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 	if (!err)
 		max_size = min(max_size, v);
 
-	blk_queue_max_segment_size(q, max_size);
+	lim->max_segment_size = max_size;
 
 	/* Host can optionally specify the block size of the device */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
@@ -1303,35 +1298,34 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 			return err;
 		}
 
-		blk_queue_logical_block_size(q, blk_size);
+		lim->logical_block_size = blk_size;
 	} else
-		blk_size = queue_logical_block_size(q);
+		blk_size = lim->logical_block_size;
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, physical_block_exp,
 				   &physical_block_exp);
 	if (!err && physical_block_exp)
-		blk_queue_physical_block_size(q,
-				blk_size * (1 << physical_block_exp));
+		lim->physical_block_size = blk_size * (1 << physical_block_exp);
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, alignment_offset,
 				   &alignment_offset);
 	if (!err && alignment_offset)
-		blk_queue_alignment_offset(q, blk_size * alignment_offset);
+		lim->alignment_offset = blk_size * alignment_offset;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, min_io_size,
 				   &min_io_size);
 	if (!err && min_io_size)
-		blk_queue_io_min(q, blk_size * min_io_size);
+		lim->io_min = blk_size * min_io_size;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, opt_io_size,
 				   &opt_io_size);
 	if (!err && opt_io_size)
-		blk_queue_io_opt(q, blk_size * opt_io_size);
+		lim->io_opt = blk_size * opt_io_size;
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
 		virtio_cread(vdev, struct virtio_blk_config,
@@ -1339,7 +1333,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 
 		virtio_cread(vdev, struct virtio_blk_config,
 			     max_discard_sectors, &v);
-		blk_queue_max_discard_sectors(q, v ? v : UINT_MAX);
+		lim->max_hw_discard_sectors = v ? v : UINT_MAX;
 
 		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
 			     &max_discard_segs);
@@ -1348,7 +1342,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
 		virtio_cread(vdev, struct virtio_blk_config,
 			     max_write_zeroes_sectors, &v);
-		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
+		lim->max_write_zeroes_sectors = v ? v : UINT_MAX;
 	}
 
 	/* The discard and secure erase limits are combined since the Linux
@@ -1391,7 +1385,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 			return -EINVAL;
 		}
 
-		blk_queue_max_secure_erase_sectors(q, v);
+		lim->max_secure_erase_sectors = v;
 
 		virtio_cread(vdev, struct virtio_blk_config,
 			     max_secure_erase_seg, &v);
@@ -1418,13 +1412,34 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 		if (!max_discard_segs)
 			max_discard_segs = sg_elems;
 
-		blk_queue_max_discard_segments(q,
-					       min(max_discard_segs, MAX_DISCARD_SEGMENTS));
+		lim->max_discard_segments =
+			min(max_discard_segs, MAX_DISCARD_SEGMENTS);
 
 		if (discard_granularity)
-			q->limits.discard_granularity = discard_granularity << SECTOR_SHIFT;
+			lim->discard_granularity =
+				discard_granularity << SECTOR_SHIFT;
 		else
-			q->limits.discard_granularity = blk_size;
+			lim->discard_granularity = blk_size;
+	}
+
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+		u8 model;
+
+		virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
+		switch (model) {
+		case VIRTIO_BLK_Z_NONE:
+		case VIRTIO_BLK_Z_HA:
+			/* treat host-aware devices as non-zoned */
+			return 0;
+		case VIRTIO_BLK_Z_HM:
+			err = virtblk_read_zoned_limits(vblk, lim);
+			if (err)
+				return err;
+			break;
+		default:
+			dev_err(&vdev->dev, "unsupported zone model %d\n", model);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -1433,7 +1448,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk)
 static int virtblk_probe(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk;
-	struct request_queue *q;
+	struct queue_limits lim = { };
 	int err, index;
 	unsigned int queue_depth;
 
@@ -1493,12 +1508,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vq;
 
-	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, NULL, vblk);
+	err = virtblk_read_limits(vblk, &lim);
+	if (err)
+		goto out_free_tags;
+
+	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
 	if (IS_ERR(vblk->disk)) {
 		err = PTR_ERR(vblk->disk);
 		goto out_free_tags;
 	}
-	q = vblk->disk->queue;
 
 	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
 
@@ -1516,10 +1534,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
 		set_disk_ro(vblk->disk, 1);
 
-	err = virtblk_read_limits(vblk);
-	if (err)
-		goto out_cleanup_disk;
-
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
@@ -1527,27 +1541,11 @@ static int virtblk_probe(struct virtio_device *vdev)
 	 * All steps that follow use the VQs therefore they need to be
 	 * placed after the virtio_device_ready() call above.
 	 */
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
-		u8 model;
-
-		virtio_cread(vdev, struct virtio_blk_config, zoned.model,
-				&model);
-		switch (model) {
-		case VIRTIO_BLK_Z_NONE:
-		case VIRTIO_BLK_Z_HA:
-			/* Present the host-aware device as non-zoned */
-			break;
-		case VIRTIO_BLK_Z_HM:
-			err = virtblk_probe_zoned_device(vdev, vblk, q);
-			if (err)
-				goto out_cleanup_disk;
-			break;
-		default:
-			dev_err(&vdev->dev, "unsupported zone model %d\n",
-				model);
-			err = -EINVAL;
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && lim.zoned) {
+		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, vblk->disk->queue);
+		err = blk_revalidate_disk_zones(vblk->disk, NULL);
+		if (err)
 			goto out_cleanup_disk;
-		}
 	}
 
 	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
-- 
2.39.2

