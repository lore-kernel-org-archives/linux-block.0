Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB144AB70
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705209; cv=none; b=uM+wAEuqZpyvY9Uk3wCo6sqheWf0+sq/ou/uySDWFnP231RY2t6UJOWDSY71Jys/4h7egXo3PizYnY5r43V4U4fq/4cqry9w0IkI48RCL3k5AadaYX4k/USnIlKifx38Y6ZnNUABSwYQe3o8HAAkZRRUjqPYj3AFyatUSBn+dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705209; c=relaxed/simple;
	bh=9SCpO0d8EKOJ2fr8CJ50K5qiM4hnZYiFEoEwSLVYjgw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M0QYZT3DoHsK+U7ZCl4f+VROU/qkwgXg254bjBPvOXPhnZWMO4GNVjvEW76mcsYfUUOaCE6r3xgID/2v+PQVqhvEzkOZApet7PBlhwa6nqsanoOISAqDKrvW5PdkEoSAiWuJPPnYryPcBe2/UXxaD9JvtDA9A6v3dlO16j6crMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQdPp7Pp; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQdPp7Pp"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15e6109f9aso73019666b.2
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786705200; x=1787310000; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gog9zqUQ9ehoNQDgtaX5umKqholrbFjpKFs4tfUqxtw=;
        b=tQdPp7PpRAUGArBUVgDNt/JeO/nQrrCK3P3DZpCk8OLXuNx5JP8RZC6u8iiRDHN+zb
         /80mCMFIBjGFG/vpRNRo8sQ41UWAq2VnAEaV0RAToXLlVvevD8j/n4Jw89DeP4u9lGcg
         PUrreg60pDxemQ4jtFicn7wwe8wEslpARCIPlViK+lPTuEe0zDwav8+ElOKyuRdBEiah
         E6Wl0BRyY257H+0wux6uTBIOrvYhoVczq3BVgieV+UTGdUixX8qYtToKX4bOmIDO8zT8
         aMLLBEThIayNAyEM+D9yJU9cEVfd2P8vO43/Ov/xsn/U/d9YFBWw87EWta53Dq25hf4y
         R8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705200; x=1787310000;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gog9zqUQ9ehoNQDgtaX5umKqholrbFjpKFs4tfUqxtw=;
        b=l7nokKFwd6DLy9XUhLvndTaQzC/qAwuzqDls7cMWA5haUaZyUdxBtJcJras2pi8B/C
         UUmgRy9VuL9en7WNue8XaMmVUrwH/mpxJT95yr1RP1AKVQ8vZ9imyfzEzmDzWAX1RgqQ
         ddFpxjAmpt9XTdQBSnlk8MNF5oH3OAQy1tfgXjg1nlDH3hAxoM4dWfj5l291OvZcdnRW
         B6MoqPsQzHjJoXrBVsIX33ZzEHRDdGS8B+3EgCifGwBHhQ8KZIgId+kBIig9/iP3Ln71
         b//LUTy74rj+XSLyvwYRGXDE8oY6VReiOpSS1PydyOgT+qyThKb6rNvBYfquYufkoEPy
         FePw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5oT6MUIaPoZIJwDcCGvRuyy/9MVTaWlsdO789D9guQiK41DE4UxwSaxGWLkGq0S+LU68LYXQdxUUaFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxclKoNL9uKwa8O6ZWAjXyo8fDUoFzn0VObZmuSvZL0JbozOmz
	LlX0snqk8W93Q7kc8DVxm88U5hpiKYioNADIu1i52WXruOfUR31VzSXlmWyA/k3S+XafetD1oJQ
	LgoT7jgEWc3iYFsO/pctXSTU7HfWHedG8MA==
X-Received: from ejta11.prod.google.com ([2002:a17:906:6d4b:b0:c1c:22c5:732])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:478f:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c212a11e26bmr211761966b.11.1786705199904;
 Fri, 14 Aug 2026 03:59:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:59:54 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814105954.4060627-1-sergiiushakov@google.com>
Subject: [PATCH] virtio-blk: clamp max_segments when indirect descriptors are disabled
From: Sergii Ushakov <sergiiushakov@google.com>
To: virtualization@lists.linux.dev, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Sergii Ushakov <sergiiushakov@google.com>
Content-Type: text/plain; charset="UTF-8"

When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
scatter-gather segment in a request must consume a physical slot in
the virtqueue ring.

If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
compound bio arrives from the page cache, virtqueue_add_split() rejects
the request with -ENOSPC and triggers:

  WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
  WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);

This permanently wedges the blk-mq queue and blocks all subsequent disk
I/O in uninterruptible sleep (D state).

Add a virtio_blk.max_segments module parameter to allow runtime cmdline
overrides, and automatically clamp sg_elems to
(virtqueue_get_vring_size - 2) when indirect descriptors are disabled.

Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
---
 drivers/block/virtio_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..082acd90a02d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -41,6 +41,10 @@ static unsigned int poll_queues;
 module_param(poll_queues, uint, 0644);
 MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
 
+static unsigned int max_segments;
+module_param(max_segments, uint, 0644);
+MODULE_PARM_DESC(max_segments, "Override maximum number of segments per request");
+
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
@@ -1267,6 +1271,12 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
+	if (max_segments)
+		sg_elems = min_t(u32, sg_elems, max_segments);
+	else if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
+		sg_elems = min_t(u32, sg_elems,
+				 virtqueue_get_vring_size(vblk->vqs[0].vq) - 2);
+
 	/* We can handle whatever the host told us to handle. */
 	lim->max_segments = sg_elems;
 
-- 
2.55.0.691.gc56d675ccc-goog

