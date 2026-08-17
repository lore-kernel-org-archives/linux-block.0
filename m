Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A16439F9B
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974133; cv=none; b=VOsLnpNJ2TgsLGJvHUxy7Na5ZiHFxFNqjXBj9hlpAFByBmETMIHw1vw6GPsz6LtQX1UgKugaUTu7FniZaJFbVEfN9zJ/yuaU2ryapUMAJu8tvS60YtBuTdy+VzcAq10XTLs2xFllMwp21hOf92HcDaA6CgwtLwC2PVVZij1kscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974133; c=relaxed/simple;
	bh=O/bTkpfxDK7wgp8C77ivdtmEVT3RkPujsiRjYOIdbTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mwBIKnLgpE5p36G3h3OUXdB35V35Ba3B8blNvJ1eWDfaICY7WA4cRtOhnSgMWGMuUnuNfKmzYRHrM90VRgmX0cb9QeFF0WUgvR/YoSDx5maPfyFCk9tF8IJxYxbfwJzva+Nj77IKeDkOnlBiWJVBbPUEoo+hq3/PznE+sKSl4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNcX1XWv; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNcX1XWv"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499900c9d99so16213085e9.0
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974130; x=1787578930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+a64Ot6/PzSxx+bPX9pOVSI6enVUF78QeyJyJScORM8=;
        b=hNcX1XWvdiq5zZuWJ0mZuv2FhIbTsh3IAiZyVp/WJ/2BAfn+NvgujeDbj2YTk8i/Xj
         m7e4eMVopaL+WJeRXyYrlam6ScAqJkfd4N9fwIcaU0NMcArfC00p+PN5BM3r9onKo1ik
         AnSbYQWdwBzRoGPllK3o6l705FWqhTm0d9Li6prC2m4PuM73KSLAivHb5CQj0m9qQkJB
         kXnLlG92RxmJ0SyFSpqAJxyoHVCI/Nk8L2Wx6uodAqL0pnNdDUqo9HtMHUttkmefoQB2
         ujRU2cY1ZV1AGn2LqF8qzxWoDDxEta/XUygzQY/ZmiTEqYVB7UfjjRy5Q/OnpTQz31fC
         OBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974130; x=1787578930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+a64Ot6/PzSxx+bPX9pOVSI6enVUF78QeyJyJScORM8=;
        b=LE636S0tNQ94HWqtjYi7Jg/4R5bAHoduJMX0N6XdvB4pWw8uGbxFUkwEIJLBlTJmQO
         3IBJZtT48AeRFuZ5JJhp+UOQOPA1PbcSi5GAKhrV2AYOVHrG2nfWjP+hoxQ3wH/1JzUA
         8EpfIkBsxrIZykyQBuEcPqxLFUDvn9dWy8UNgzRUJhoa2+MJpgqKY5J9zMDqW5l7rz9+
         k49Sr5h/nca8y5DWhoVAUMTNTFdOn70JtdNiC6ENT4nF7XBAflEhhD3oPfEC943hnUpz
         YUcxt57rkG6fowIdCGRToO9M52+NVHVCWbk03/h1OydgFlXyNlk7ZFiA7eTJa5z8g59w
         2x9A==
X-Forwarded-Encrypted: i=1; AHgh+RrmE64Ojtnz3ZaYOz5YBpL23/ftOnrN30+b6AT3Sr1nOgDG7GxMxY5JYGsARYSY09x7Po0BWxg780oyZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00rj5gH1Ic2OMJEqQgWJnDzQxo9dWzF8GH5wPbWNMsywb/vo0
	DmoZJZQuJibHHGEVWrbx8DyRHXC2Lnbc39/wERzpJweGCjZJKR+alukd0zTzSVd3n9kx6TorjcQ
	KQU7DS/UrWQkReUXjExl37dTEAr5anQKDDg==
X-Received: from wmbes12.prod.google.com ([2002:a05:600c:810c:b0:495:713d:cc69])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4003:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4998798db40mr336981795e9.16.1786974129626;
 Mon, 17 Aug 2026 06:42:09 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:42:02 +0200
In-Reply-To: <20260814105954.4060627-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814105954.4060627-1-sergiiushakov@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817134202.160669-1-sergiiushakov@google.com>
Subject: [PATCH v2] virtio-blk: clamp max_segments when indirect descriptors
 are disabled
From: Sergii Ushakov <sergiiushakov@google.com>
To: virtualization@lists.linux.dev, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
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

Automatically clamp sg_elems to (ring_size - 2) when indirect
descriptors are disabled.

Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
---
v1 -> v2:
- Drop max_segments module parameter and rely solely on automatic clamping
  when indirect descriptors are disabled (suggested by Christoph Hellwig).
- Guard (ring_size - 2) calculation with ring_size > 2 to prevent underflow.
- Update commit description accordingly.

 drivers/block/virtio_blk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..8f5a2d5323a6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1267,6 +1267,13 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
+	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[0].vq);
+
+		if (ring_size > 2)
+			sg_elems = min(sg_elems, ring_size - 2);
+	}
+
 	/* We can handle whatever the host told us to handle. */
 	lim->max_segments = sg_elems;
 
-- 
2.55.0.691.gc56d675ccc-goog

