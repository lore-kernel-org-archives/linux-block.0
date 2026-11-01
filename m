Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552006;
	b=iHyaBFx14foa1El/dLMAMBio+UOiiQBLuAaA9cVF+c1hrT+Xlg/um0gCTlgMLonQ2RFt
	 loIAGGleh5frOvg22SFw3CTXr1pIv0J9aj5JSP2nqYcDd26rQ0YqUwj3hK48bVMdf94vt
	 YYS4TFzTKpVxSOrZbR1mSaQ0iQJxo+XtcknuwqbXOIyNFD9GwrkjK12h4KkAVBHyzN4ZT
	 MgN6U/6idBJjRYQ8qK4//MEADlJgMvPwvZmKgbijJQkohJvcO1Aljr2EznCmprlJqaCrR
	 R5pGA+2/CbfN/WyWqwK3asxDTkYHiSI/rBwy7GGITmU33vxD9+Aer3b0AZrUCk6/v9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YRHZXduhT/aAWrLeGZjblkuPs/VioNEprpmzptkEp3Q=;
	b=QW0yow7GUGCd25gpAdUcvivL9KEts7ArTSZHO1KSWDWXoeTFvMUe+cU+mPi5aQLy5eYz
	 myYauuEZv5MKk3fYF7HbxElhBNvhTNl5ALzCVabYPzg1ubFVWQJ20FQz2Xf47sw1tZXdg
	 jyLvMZ1FrEWhymOeMcjw2wXYfQEeZGrizJ/TTjso4kkkO2r5ksQgXN7zxyhLQdtdPyDjL
	 YwYho4OMSnrHBt8ihCCLxaiFFoDJ8DqvrVkWzTPFQGYE3ZvbBRL/pZDpy2Qdnq+Zs9Ztq
	 ASxRzyLCtWlmTQWuTHJXSrvDI8XFxPdZZHZzqklIuGIQFD9xgh/+nvB584TfXHItE7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LDSgamjc;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76204606A339
	for <linux-block@vger.kernel.org>; Sun,  1 Nov 2026 16:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76204606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LDSgamjc
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a210470b49so17654175e9.2
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 08:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552004; x=1794156804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRHZXduhT/aAWrLeGZjblkuPs/VioNEprpmzptkEp3Q=;
        b=LDSgamjcpwVNv/gIkufzRcd4VM2jIoSB+9Caj1CjGaSFO2i5pDXvrZQSzmSQHIeBST
         0+IATN5IwNuQxz+zWhOxnkDBjLrcMsE0GJH1jKT5HhRYBdWlVP5Y+uAnDGTTMbsegfim
         h/e+3c/pjlGB69sB9WaUE1qP2eEfJMTuQwsXbnQLUPyXJ1Tf3h7msYsgBPqpnCaPZITc
         ffvwmNta/m+x7hN/1oVaDIJ9SdiiCU1tWs0P0otUrAfQYXfS9aQekfu6dbPoUmYsMcWK
         1cK3/F8gldbwICZuAibKuEaH6r7NRfJejTd6caRvJoIl4QUihOrdnaqnBm9w3ZzbklRD
         Lmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552004; x=1794156804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRHZXduhT/aAWrLeGZjblkuPs/VioNEprpmzptkEp3Q=;
        b=dsCwivNrl7HGJQeShjPRM0icyL66MeoiEhDuqe/nWQYhJFMpWP2e0/aabODwGkE+up
         4ciRjsIc63877/bhCNhcnSqBZCnWhV471lCn2prFJRxAjHzE9HZIsXI8Rz26DL5ZYrLO
         zVlpRId3ZYWIjYx4LLcoWleWfNB/dSBSHBWb4Zh+hBfK731TLe6HrtCk+hUfT/P5hnWo
         pk2QafYGBurtU9vhJax/vtrp6bmsckTzIs2LUZAqH3RZ3o0kPfUEbwjG319WgjvSH/nt
         CPp8y0hBGbLce7XAvmhFdfWCkicNHa/YIUiaQS3lX8nLHZmeTpBw8akIJa4VFbT0jflJ
         jszg==
X-Forwarded-Encrypted: i=1; AKwUvBxCDWXrVEK3YigqAgkUPoyArFD7cUW/GxZOjlQyjQH+ZrABKmhyFxk/TyWV7mTIFkcU29u1bTUcqTl2wQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLpRWkeRjOO7VA9VOoS1gTRt8do4z4XtQZ5ip+2JngxNgHKDnJ
	NVMY38MoENFcMetEtGMxy6HjbVglctwGzmXgl9JbBXQXo0CdA+TeYgwL
X-Gm-Gg: AYBFou1/hDf4KdnX+ixid7xFrJP0W+1j9H8j7xbC2jrhBOA81+vUCr2IFPR4jYZs5Jd
	tuVmU96nlNmXMJJjEO4BRtVdBKEvzPZA7Y6MPqhas4ijxmjewdgGOL+RvIYOBgbMQdtE/sFfsdi
	3slpFgwZLxFVOn1CiNVkcXVMza9kvq06wPn39wnt/ab0rhMXJnZK55YYTIrJDh/4TaopT11x17/
	Og5lpi2Gt+K+JG7iHW6qZ11lu/pp+PQT9C+XXUOrWb5RFTz1ENN7HPU2vg6tfnmLuHT3l68LazW
	oXGzqUIRLdwhNerd6XjUeozzJkodgHbRtnVdHuCbaSerXH8HuACVYsOkdJtV1PZwo1LPBeHz8WJ
	GUuPp0i8PcAn7WIru0XXskGS9vQqfSYI8CQ5EmLhF0aMcs+siSOxzGzE3c/7JY8ul1kkwaaqvll
	DIaAqUtHcqpocMH0KhYzgOnHyuR3PlfnJJykl+RmRlZ/kf92Q8RIkjXYWj35cxISTrOGPbf3QKx
	Lo2MqEBn8gEytIgyaDUUVhGWq57fl0WMyrhnotUUbLS22LxZ+8oKNvIjoth9kRTqdUNAQsCCG6m
	RKMIEHh20tQ1SSSGj7PVWHJnFC7hdNPAXV2lhvw9LdCTQ0EYmitRat6iyUX2tOy811Zc20eUjZc
	C
X-Received: by 2002:a05:600c:818e:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4ac1932aa2amr179580105e9.34.1793552003842;
        Sun, 01 Nov 2026 08:53:23 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:5058:2b49:7a78:eb6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm223903095e9.10.2026.11.01.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:53:23 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio_blk: fail the probe when a virtqueue is too small for a request
Date: Sun,  1 Nov 2026 17:53:06 +0100
Message-ID: <20261101165307.2557421-2-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without VIRTIO_RING_F_INDIRECT_DESC a request takes at least three ring
descriptors: the header, one segment and the status. Nothing checks
that the virtqueues hold that many, and a smaller one fails in a way
that depends on the queue depth. With the default depth, num_free / 2,
a virtqueue of one descriptor gives a depth of 0, which
blk_mq_alloc_tag_set() refuses, and the probe fails without saying why:

  virtio_blk virtio0: probe with driver virtio_blk failed with error -22

With a depth of at least one, from a virtqueue of two or from
virtio_blk.queue_depth, the probe succeeds and the first request never
fits: virtqueue_add_split() warns and returns -ENOSPC, and the hardware
queue is stopped to wait for descriptors that even an empty ring does
not have.

Check the virtqueue sizes right after the virtqueues are set up, before
the queue depth is derived from them, and fail the probe with a reason
when the smallest one cannot hold a request:

  virtio_blk virtio0: virtqueue size 1 is too small for a request

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
 drivers/block/virtio_blk.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c8bfbf8435ac..0a2af22f2365 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1244,6 +1244,18 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
+/* The size of the smallest virtqueue, which every request has to fit. */
+static unsigned int virtblk_min_vring_size(struct virtio_blk *vblk)
+{
+	unsigned int vring_size = UINT_MAX;
+	int i;
+
+	for (i = 0; i < vblk->num_vqs; i++)
+		vring_size = min(vring_size,
+				 virtqueue_get_vring_size(vblk->vqs[i].vq));
+	return vring_size;
+}
+
 static int virtblk_read_limits(struct virtio_blk *vblk,
 		struct queue_limits *lim)
 {
@@ -1474,6 +1486,21 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vblk;
 
+	/*
+	 * Without indirect descriptors the smallest request, a header, one
+	 * segment and the status, takes three descriptors. Check before the
+	 * queue depth is derived from the ring, which would come out as 0
+	 * for a ring of one and fail without saying why.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+	    virtblk_min_vring_size(vblk) < 3) {
+		dev_err(&vdev->dev,
+			"virtqueue size %u is too small for a request\n",
+			virtblk_min_vring_size(vblk));
+		err = -EINVAL;
+		goto out_free_vq;
+	}
+
 	/* Default queue sizing is to fill the ring. */
 	if (!virtblk_queue_depth) {
 		queue_depth = vblk->vqs[0].vq->num_free;
-- 
2.53.0

