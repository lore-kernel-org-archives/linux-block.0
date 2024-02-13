Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6317BA8;
	Tue, 13 Feb 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809753; cv=none; b=fTYV+EDaVyxkIPJt7vWN8rYUw3UEtqEpIjA6rMyMuRV0XteRjRL26R/K7HA/ZRpxsiJr4YwPxhHoEK8WZfop2J62c8gZ7ouadaYo+oVo/oTUr64lW2hafZZRY/oFIJJqfMgMhtbZEwUe2zl2RaLbmrF7hrq5r7JCJcfc7jnQutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809753; c=relaxed/simple;
	bh=sEN4fPiEJ6hAk+ClVFufkYSqdnT71JlYg6BcPH+D0Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5/w8JaemyJG0FyebabbqZQjvLag6mLgktkHqmL6FWa/PyeCpu5zcWNZ4B574GCg53nCgg5ZhBDFKY+ZGvtguizTjQ3jmAHf17CRJboXP0NB+aQVQfvLpO7uKXVjf3SHLio8AmE5fWwq6ybXiWCXubfSk/AWhdG2PNKu4eLpRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SL/pcwWM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SL/pcwWM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3aRHg94Th0EjMFWzx6moF5w0CKmedg+rnDtdYVGdct0=; b=SL/pcwWMSG+GWNtTNUSBiq2QqW
	QXsGlaxG5+fmC1xBxuP1PBLpxUGbr2E9EoYB2Jyuzh1w+qD+wqXEjvQ6jqXGCEV/ej1SKYld2BsVo
	b/YteaTa9Uov1+CCQXJKt+6UOa/gK3pRbEwp9ug++R5dWv9ovAFVj3RBbyrBFx38Xg7kPl7FuInSy
	qSLgelEvQKO/R6iYZzNmJD63qLa4/a+LAx8BBoC3NlG5XLwObmxqgmZGpnTmUnE1J+g4FuKjKKT1B
	P7t67tZLck7iWLQgqRsinM3GQE04nVtDZn/V4zghlp5j8w3uprp72I08x2DXLDlumF/iok/Or1Pig
	6nykiO9Q==;
Received: from [2001:4bb8:190:6eab:b680:8f97:4b38:866d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZnKU-00000008Gp8-0UIt;
	Tue, 13 Feb 2024 07:35:46 +0000
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/15] virtio_blk: split virtblk_probe
Date: Tue, 13 Feb 2024 08:34:21 +0100
Message-Id: <20240213073425.1621680-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split out a virtblk_read_limits helper that just reads the various
queue limits to separate it from the higher level probing logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/virtio_blk.c | 193 +++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 92 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a23fce4eca4408..dd46ccd9f84c7d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1248,31 +1248,17 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
-static int virtblk_probe(struct virtio_device *vdev)
+static int virtblk_read_limits(struct virtio_blk *vblk)
 {
-	struct virtio_blk *vblk;
-	struct request_queue *q;
-	int err, index;
-
+	struct request_queue *q = vblk->disk->queue;
+	struct virtio_device *vdev = vblk->vdev;
 	u32 v, blk_size, max_size, sg_elems, opt_io_size;
 	u32 max_discard_segs = 0;
 	u32 discard_granularity = 0;
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
-	unsigned int queue_depth;
 	size_t max_dma_size;
-
-	if (!vdev->config->get) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	err = ida_alloc_range(&vd_index_ida, 0,
-			      minor_to_index(1 << MINORBITS) - 1, GFP_KERNEL);
-	if (err < 0)
-		goto out;
-	index = err;
+	int err;
 
 	/* We need to know how many segments before we allocate. */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
@@ -1286,73 +1272,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
-	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
-	if (!vblk) {
-		err = -ENOMEM;
-		goto out_free_index;
-	}
-
-	mutex_init(&vblk->vdev_mutex);
-
-	vblk->vdev = vdev;
-
-	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
-
-	err = init_vq(vblk);
-	if (err)
-		goto out_free_vblk;
-
-	/* Default queue sizing is to fill the ring. */
-	if (!virtblk_queue_depth) {
-		queue_depth = vblk->vqs[0].vq->num_free;
-		/* ... but without indirect descs, we use 2 descs per req */
-		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
-			queue_depth /= 2;
-	} else {
-		queue_depth = virtblk_queue_depth;
-	}
-
-	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
-	vblk->tag_set.ops = &virtio_mq_ops;
-	vblk->tag_set.queue_depth = queue_depth;
-	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	vblk->tag_set.cmd_size =
-		sizeof(struct virtblk_req) +
-		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-	vblk->tag_set.driver_data = vblk;
-	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
-	vblk->tag_set.nr_maps = 1;
-	if (vblk->io_queues[HCTX_TYPE_POLL])
-		vblk->tag_set.nr_maps = 3;
-
-	err = blk_mq_alloc_tag_set(&vblk->tag_set);
-	if (err)
-		goto out_free_vq;
-
-	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, NULL, vblk);
-	if (IS_ERR(vblk->disk)) {
-		err = PTR_ERR(vblk->disk);
-		goto out_free_tags;
-	}
-	q = vblk->disk->queue;
-
-	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
-
-	vblk->disk->major = major;
-	vblk->disk->first_minor = index_to_minor(index);
-	vblk->disk->minors = 1 << PART_BITS;
-	vblk->disk->private_data = vblk;
-	vblk->disk->fops = &virtblk_fops;
-	vblk->index = index;
-
-	/* configure queue flush support */
-	virtblk_update_cache_mode(vdev);
-
-	/* If disk is read-only in the host, the guest should obey */
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
-		set_disk_ro(vblk->disk, 1);
-
 	/* We can handle whatever the host told us to handle. */
 	blk_queue_max_segments(q, sg_elems);
 
@@ -1381,7 +1300,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 			dev_err(&vdev->dev,
 				"virtio_blk: invalid block size: 0x%x\n",
 				blk_size);
-			goto out_cleanup_disk;
+			return err;
 		}
 
 		blk_queue_logical_block_size(q, blk_size);
@@ -1455,8 +1374,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		if (!v) {
 			dev_err(&vdev->dev,
 				"virtio_blk: secure_erase_sector_alignment can't be 0\n");
-			err = -EINVAL;
-			goto out_cleanup_disk;
+			return -EINVAL;
 		}
 
 		discard_granularity = min_not_zero(discard_granularity, v);
@@ -1470,8 +1388,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		if (!v) {
 			dev_err(&vdev->dev,
 				"virtio_blk: max_secure_erase_sectors can't be 0\n");
-			err = -EINVAL;
-			goto out_cleanup_disk;
+			return -EINVAL;
 		}
 
 		blk_queue_max_secure_erase_sectors(q, v);
@@ -1485,8 +1402,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		if (!v) {
 			dev_err(&vdev->dev,
 				"virtio_blk: max_secure_erase_seg can't be 0\n");
-			err = -EINVAL;
-			goto out_cleanup_disk;
+			return -EINVAL;
 		}
 
 		max_discard_segs = min_not_zero(max_discard_segs, v);
@@ -1511,6 +1427,99 @@ static int virtblk_probe(struct virtio_device *vdev)
 			q->limits.discard_granularity = blk_size;
 	}
 
+	return 0;
+}
+
+static int virtblk_probe(struct virtio_device *vdev)
+{
+	struct virtio_blk *vblk;
+	struct request_queue *q;
+	int err, index;
+	unsigned int queue_depth;
+
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	err = ida_alloc_range(&vd_index_ida, 0,
+			      minor_to_index(1 << MINORBITS) - 1, GFP_KERNEL);
+	if (err < 0)
+		goto out;
+	index = err;
+
+	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
+	if (!vblk) {
+		err = -ENOMEM;
+		goto out_free_index;
+	}
+
+	mutex_init(&vblk->vdev_mutex);
+
+	vblk->vdev = vdev;
+
+	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
+
+	err = init_vq(vblk);
+	if (err)
+		goto out_free_vblk;
+
+	/* Default queue sizing is to fill the ring. */
+	if (!virtblk_queue_depth) {
+		queue_depth = vblk->vqs[0].vq->num_free;
+		/* ... but without indirect descs, we use 2 descs per req */
+		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
+			queue_depth /= 2;
+	} else {
+		queue_depth = virtblk_queue_depth;
+	}
+
+	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
+	vblk->tag_set.ops = &virtio_mq_ops;
+	vblk->tag_set.queue_depth = queue_depth;
+	vblk->tag_set.numa_node = NUMA_NO_NODE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.cmd_size =
+		sizeof(struct virtblk_req) +
+		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
+	vblk->tag_set.driver_data = vblk;
+	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
+	vblk->tag_set.nr_maps = 1;
+	if (vblk->io_queues[HCTX_TYPE_POLL])
+		vblk->tag_set.nr_maps = 3;
+
+	err = blk_mq_alloc_tag_set(&vblk->tag_set);
+	if (err)
+		goto out_free_vq;
+
+	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, NULL, vblk);
+	if (IS_ERR(vblk->disk)) {
+		err = PTR_ERR(vblk->disk);
+		goto out_free_tags;
+	}
+	q = vblk->disk->queue;
+
+	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
+
+	vblk->disk->major = major;
+	vblk->disk->first_minor = index_to_minor(index);
+	vblk->disk->minors = 1 << PART_BITS;
+	vblk->disk->private_data = vblk;
+	vblk->disk->fops = &virtblk_fops;
+	vblk->index = index;
+
+	/* configure queue flush support */
+	virtblk_update_cache_mode(vdev);
+
+	/* If disk is read-only in the host, the guest should obey */
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
+		set_disk_ro(vblk->disk, 1);
+
+	err = virtblk_read_limits(vblk);
+	if (err)
+		goto out_cleanup_disk;
+
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-- 
2.39.2

