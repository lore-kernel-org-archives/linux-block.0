Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76494CDDD2
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731260; cv=none; b=bMHAZDbZNZnxBVyTl1jNVOtUZ/ebKXuY1iQg5a/AzSgZfyCxmd19KGXIH0VcLSH8De28FSsQewzyV1Hd6GrKqv5XMjlOmfE2+XlRDwH03bZCbX8NoQK+FyRWgIOJvtLPytnH0QTh5Y+NgBKkavhAiaTaWyczlMczquDTboW4uP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731260; c=relaxed/simple;
	bh=8H5MyjlK2AL2Bv9fk7I0TbvUKrUtHPSXQo5h+sAgxHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5OL3RhWMlraHKCwzlGpbFo7tzH/FQsqAarl8v4z0bPA4viaROCFUAbGF1WgLRLpkpQ9oL62nF6okI8iKs5UbcLc+d+kkwkD0TbGFsfsX9FxeFwAuUGgEgL8kFYfj87U3bESbG0/bATzRT9sLmK2mrNCg1LLaWEfpFB3FEVx1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NshfTxor; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NshfTxor"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso8666775e9.1
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789731255; x=1790336055; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HX03nxUB7ZTBqV9qtTTNGX+Qc5LsyZzPMEY3auZITOg=;
        b=NshfTxorbp9vrVqGlRM9+lPkstrI434+KvSUaQok6tktbjSQyo+iBv9tDZUpUIYgGN
         ydHB9MZ+e6bgDco8vpNKTTwgcoaxiG4fdYKqsvJUcJ47IJ1t8HnX4UGl1OYExq1n8l0K
         1g0YZvMvf063WELK2Cq4+osQvJZV+N1A0cPoUWLFYTUVMmNLGbrjin+/CDIa6TsjE1EB
         iewMRe1fjgdmVVEtcfps2Zh2St8eJlq75C9VS/PMQtebymeY3mOZwWhOS2lE0mSSfJog
         gqoHDbGUKm6WRX1+dB3oN0PIK95CeftCrUJLTyrxpqlHW+SUQ/Jx+q/ETIIVEXy/Pwf8
         vqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731255; x=1790336055;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HX03nxUB7ZTBqV9qtTTNGX+Qc5LsyZzPMEY3auZITOg=;
        b=NvDJABfJ1COrzymQF4m+R9F/PLJrrIUvq41msoMQrUem5axRH5EyWG6+5mICKi9nHM
         62ymIRsnPr7FMBNxR3wBWQHOaZaNFYmU7b13D5+o3qN98BITbTSSw6OMflSqegr5Wj+2
         Q9ShhBls1WKsHWUDT2CyV8kpP6BCyt0cv2v55w+c9gB72rzXgzULgwKRg3uXw/vKjNM2
         RtHE21MpLe9zLbTUEEbk1Q4UBzxOW13t7Q5vQrPrtFT3JTMI5ys6wLVKl0fQ/iGMs9/e
         rX4aI5DXVErPJmjk/FUV2+pRscz/gnl73oiXz8upF9YaV2ORCtVt902r65ljOI62B6It
         4TrA==
X-Forwarded-Encrypted: i=1; AKwUvBzOlz4SJrB22+CW53gYvdCpiHZ7zeiuAlhW0GCpRWPsyUDiOicuYg0TnRPxQF4bg/whA17XKXjdE4cM2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++natmZ93CCsJg7y85ywjQRgEnf10A9NNrqKthcl06I9IE9qCz5i
	m9k4IHCbwoiCjGPrAOP/C+9WG3C/OhTHwu46iOMvleNpi2o3gquGFRAZZ8QgnoiTWLv08Xjut4w
	JwutSEkqelp6+njy+iIh+AlFX1PiFAuJS/A==
X-Received: from wrbck15.prod.google.com ([2002:a5d:5e8f:0:b0:460:2d58:857f])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b8b:b0:49e:663c:c69f with SMTP id 5b1f17b1804b1-49fc56d170dmr23642905e9.15.1789731255238;
 Fri, 18 Sep 2026 04:34:15 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:34:12 +0200
In-Reply-To: <20260916104218-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916104218-mutt-send-email-mst@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918113412.1142493-1-sergiiushakov@google.com>
Subject: [PATCH v3] virtio-blk: clamp max_segments to virtqueue ring size
From: Sergii Ushakov <sergiiushakov@google.com>
To: mst@redhat.com, axboe@kernel.dk
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, hch@infradead.org, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	pbonzini@redhat.com, Sergii Ushakov <sergiiushakov@google.com>
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

Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
---
Hi Michael,

Thank you for the detailed review!

I logged the values in virtblk_read_limits() on the QNX Hypervisor guest:
  virtio_blk virtio0: 1/0/0 default/read/poll queues
  virtio_blk virtio0: F_SEG_MAX=1 seg_max=1024 F_INDIRECT=0 vring_size=1024 max_segments=1024

  dev_info(&vdev->dev,
           "virtio_blk debug: F_SEG_MAX=%d seg_max=%u F_INDIRECT=%d vring_size=%u max_segments=%u\n",
           virtio_has_feature(vdev, VIRTIO_BLK_F_SEG_MAX),
           sg_elems,
           virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC),
           virtqueue_get_vring_size(vblk->vqs[0].vq),
           lim->max_segments);

So what actually happens:
1. The host *does* advertise VIRTIO_BLK_F_SEG_MAX=1 with seg_max=1024 (setting
   seg_max equal to the virtqueue size vring_size=1024), and does *not*
   offer VIRTIO_RING_F_INDIRECT_DESC (F_INDIRECT=0).
2. Because seg_max (1024) <= VIRTIO_BLK_MAX_SG_ELEMS - 2 (32766),
   virtblk_read_limits() sets lim->max_segments = 1024.
3. The block layer submits requests with 1023 or 1024 data segments.
   virtblk_add_req() adds 2 extra descriptors (out_hdr and in_hdr),
   resulting in total_sg > 1024.
4. Since total_sg > vq->split.vring.num and !vq->indirect,
   virtqueue_add_split() triggers:
     WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);

In v3, I drop the !virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)
condition and clamp sg_elems to (ring_size - 2) unconditionally across all
virtqueues.

Also, init_vq() checks all virtqueues:
- At initial probe (!vblk->disk), it enforces ring_size >= 3.
- On resume/recovery, it enforces
  ring_size >= queue_max_segments(vblk->disk->queue) + 2.

Logs after the v3 patch:
  virtio_blk virtio0: F_SEG_MAX=1 seg_max=1022 F_INDIRECT=0 vring_size=1024 max_segments=1022

 drivers/block/virtio_blk.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..c263d0e3db95 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1021,6 +1021,21 @@ static int init_vq(struct virtio_blk *vblk)
 		goto out;
 
 	for (i = 0; i < num_vqs; i++) {
+		unsigned int ring_size = virtqueue_get_vring_size(vqs[i]);
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
@@ -1253,7 +1268,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	size_t max_dma_size;
-	int err;
+	int err, i;
 
 	/* We need to know how many segments before we allocate. */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
@@ -1267,6 +1282,23 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
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
 
@@ -1466,6 +1498,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	mutex_init(&vblk->vdev_mutex);
 
 	vblk->vdev = vdev;
+	vblk->disk = NULL;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

