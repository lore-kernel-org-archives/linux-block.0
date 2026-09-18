Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFA502774
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739486; cv=none; b=ViKzozhq53NdogUIpOFyVIUh/db1as1IiLlX3EIrBUOCXsld6BBXLDLWkzFOK8vuwHwtRNrAdc6RKl7h2c2Un90R80RU7/leMIqqxTbzZDSLZP5NlnOQ1SRvtNP/RU+EQDkopwJqvDu0Y8M/Cj8rbeBgt7O1uXZsMENwA9p1X4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739486; c=relaxed/simple;
	bh=nhO0uCJLmHjyjirxMOVm/JMihRC8hJvWPltGRHbYrN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6Q4jPzISpbFWE9sWabLdbyP0VJ77MubSNbxjXYhdXhNP6BKLfGXs+dm8JIbgNodba6H7cQZFOY4uQjDIYNUtEwaPkN3/c7cN9Zxi8lZfJiAbsyTjqnrjX0FBkxVaGhRXGsa33yOHOBGcs8jhZwykIeQJoSvhE3ScEnOwptuYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/jdf/iW; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/jdf/iW"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso5486845e9.1
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789739483; x=1790344283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eReSrbiKW9Bm7tiCx6GP2jpAQfD5imbh5NHzgm8A6aU=;
        b=D/jdf/iWyIUH+O5QSc683eZiz6ZRRgVV15LGzUNFpW31NEP0dUKDFlxUlZh4q313CC
         a9cfDUUFLeTNHB4Z0uAY2K4j9QVZxli4zaq+azA8t14gMgTGGNOqVIPYIbfr9AEHbmwp
         5x2ymSZ/PDripbl1wponxS41GoDYSGIlyDAqWgD81P0NTePYpk9HDHzzw7ZPZ7ESx353
         yUQtABjVOQGd4d1XIVu9al4rmgyH48WTFX+vgpSQ1qbJK9YG6HW+IjiAl9GnWFe2BHt0
         Qyw5YIrZ5BqtwQGfUm5m9LymTd7ghXukcxJA5z83lYPmyfyUw5JYxo33NLByf/5L+g2o
         KTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739483; x=1790344283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eReSrbiKW9Bm7tiCx6GP2jpAQfD5imbh5NHzgm8A6aU=;
        b=2ITI6dTa9zBxJZngxolz87NFOLMvHbkvwoxVxfgVf2SkjmLsx4UTuZCYDD6+t1UuF3
         aggaeWB2PHI0diiwj2lbNPpTh+VAk4W4jtZ4zfXNXfkceNe1W6BI8xHMvqaGWkhPJSsH
         t8xjZIk8H7HC82g5TlAt/1Ymate3cUdcdxaed776035wJEnTJUP0AJigJiON9v8NWfAf
         2hBQ3HiCtjVjzr3tYVSDG3nNtziqvQabz4zBmkFZnoPRtgb+UmMq9rCqmZ+xJfTTTtZa
         s0DPIfZttnpkGqYsVucOW90Cbd2p4S98r7G8GBxDVcjqJwH8/W9QZrC6kY1KJDwjmXx6
         n23Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7w0CMp/MQ/j8nqHASJsI/vohwBA0eiDXhPowwXfro0K/YJHRMSME8VNijSyGUN87wYewuLUwVwHe9lw==@vger.kernel.org
X-Gm-Message-State: AFuF++lEdu8GgHkrKN2hi2CFdG3l4QhIzuRWk4WCz1up1qfVXWveXzCl
	dvo9BkFYnPHlCi4a2a6eziEBW9Mu9Pm+6sO6iGGFj/hvtPZ8MzbDi/S3AEZE+BzMRMzR8lWKFLR
	7jNn35/E4sYb8I2lmx7JSU80IcGL6b/jM7A==
X-Received: from wmxe3-n1.prod.google.com ([2002:a05:600d:6503:10b0:49e:6c0c:b61c])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr30776365e9.23.1789739482636;
 Fri, 18 Sep 2026 06:51:22 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:51:20 +0200
In-Reply-To: <20260918083557-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918083557-mutt-send-email-mst@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918135120.1261150-1-sergiiushakov@google.com>
Subject: [PATCH v4] virtio-blk: clamp max_segments to virtqueue ring size
From: Sergii Ushakov <sergiiushakov@google.com>
To: mst@redhat.com, axboe@kernel.dk, stefanha@redhat.com, hch@lst.de
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pbonzini@redhat.com, sergiiushakov@google.com
Content-Type: text/plain; charset="UTF-8"

In virtblk_add_req(), each request consumes 2 extra descriptors (out_hdr
and in_hdr) in addition to the data scatter-gather segments.

When a hypervisor (e.g. QNX Hypervisor) advertises VIRTIO_BLK_F_SEG_MAX
with seg_max = 1024 alongside a 1024-entry split ring (vring.num = 1024)
and VIRTIO_RING_F_INDIRECT_DESC disabled, lim->max_segments is set to
1024. When the block layer submits requests with 1023 or 1024 data
segments, total_sg reaches 1025 or 1026. This exceeds vring.num (1024),
causing virtqueue_add_split() to return -ENOSPC and permanently wedge
the blk-mq queue.

Furthermore, the Virtio specification (2.7.5.3.1) requires that a
descriptor chain never exceed the Queue Size, and virtqueue_add_split()
falls back to direct descriptors if indirect table allocation fails.

Fix this by:
1. Rejecting queues with ring_size < 3 at probe, or
   ring_size < (queue_max_segments + 2) during resume/reset recovery in
   init_vq().
2. Unconditionally clamping sg_elems to (ring_size - 2) across all
   virtqueues in virtblk_read_limits().

Fixes: 0864b79a1533 ("virtio: block: dynamic maximum segments")
Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
---
Changes in v4:
- Add Fixes tag.
- Add code comments in init_vq() documenting the constants 3 and + 2.

 drivers/block/virtio_blk.c | 44 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..cafca309b4d0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1021,6 +1021,30 @@ static int init_vq(struct virtio_blk *vblk)
 		goto out;
 
 	for (i = 0; i < num_vqs; i++) {
+		unsigned int ring_size = virtqueue_get_vring_size(vqs[i]);
+		/*
+		 * Each request consumes 2 extra descriptors (out_hdr and
+		 * in_hdr) in addition to the data segments.
+		 *
+		 * At initial probe (!vblk->disk), each virtqueue must fit at
+		 * least 1 data segment + 2 header descriptors (3).
+		 * On resume/recovery (vblk->disk), each virtqueue must fit the
+		 * existing queue_max_segments() + 2 header descriptors.
+		 */
+		unsigned int min_ring_size = 3;
+
+		if (vblk->disk)
+			min_ring_size = queue_max_segments(vblk->disk->queue) + 2;
+
+		if (ring_size < min_ring_size) {
+			dev_err(&vdev->dev,
+				"virtqueue %u ring size %u is smaller than minimum %u\n",
+				i, ring_size, min_ring_size);
+			vdev->config->del_vqs(vdev);
+			err = -EINVAL;
+			goto out;
+		}
+
 		spin_lock_init(&vblk->vqs[i].lock);
 		vblk->vqs[i].vq = vqs[i];
 	}
@@ -1253,7 +1277,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	size_t max_dma_size;
-	int err;
+	int err, i;
 
 	/* We need to know how many segments before we allocate. */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
@@ -1267,6 +1291,23 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
+	/*
+	 * virtblk_add_req() uses separate outgoing and incoming header
+	 * descriptors (out_hdr and in_hdr), consuming 2 extra descriptors
+	 * per request in addition to the data segments.
+	 *
+	 * Per virtio specification (2.7.5.3.1), a driver MUST NOT create a
+	 * descriptor chain longer than the Queue Size of the device.
+	 *
+	 * Clamp max_segments to (ring_size - 2) across all virtqueues so
+	 * that a request never exceeds the ring size of any queue.
+	 */
+	for (i = 0; i < vblk->num_vqs; i++) {
+		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[i].vq);
+
+		sg_elems = min_t(u32, sg_elems, ring_size - 2);
+	}
+
 	/* We can handle whatever the host told us to handle. */
 	lim->max_segments = sg_elems;
 
@@ -1466,6 +1507,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	mutex_init(&vblk->vdev_mutex);
 
 	vblk->vdev = vdev;
+	vblk->disk = NULL;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

