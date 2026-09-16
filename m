Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F237AA8B
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570837; cv=none; b=f6863m3czeuQZ+zEKqmDyFRqHTLTpzTSl2m800AzMROfQYI8EKWGZ2rnrfk7URa8PFUy7EsJDnr8MEa94621CJdsLlODbrkZac44cQHDMnZmNbo7TBuTnNATkjjUCMZ5eP8aBiOMbk4FW+st7BRu2zkRx6Gjq6agZxgKuzDIdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570837; c=relaxed/simple;
	bh=9tI4U4sigauxv7+vSOHtv7WRiUpJF6qwzNnTtt4QssI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh4Lq756PBX2Jo95wzTm2xEVPhZe+FLZ9lqETTzJkDqrKIgzjMID0yoJ0Qy2DfmdEak9syhfA/LDvTU+gw9kSI9Y2nqqaS/koizo2vcXvOr/IQXg182r8jXqCz6Mk01YAqz0uFsn6C5GIIsO4oB2oAozWNVK0bG3NNwkNbnGRys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wqu+5gFQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXxQs8FJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wqu+5gFQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXxQs8FJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789570832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vErMH5Jpyy8oa53cLRlOD7zEIY+iQEIFyTm7guhxWj0=;
	b=Wqu+5gFQi9zgCXhlgpnOVok3EhljVRDmaAck6I/Mu86Dq8F3v3HarT/CRxtCf+WS6F0/qo
	Ym9M66QQnvgOHi0gbJiio0vag22QWmNfHmb09blHrOjrNd7q8QMnhXzPpNC/lgbfnLNyuk
	RESSonSDvihEmvQd8v/Fr9o14HNTPjo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-twJKCwqVOxyoagc5zjqfYw-1; Wed, 16 Sep 2026 11:00:31 -0400
X-MC-Unique: twJKCwqVOxyoagc5zjqfYw-1
X-Mimecast-MFC-AGG-ID: twJKCwqVOxyoagc5zjqfYw_1789570829
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c252a2ae8e1so672850166b.1
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789570829; x=1790175629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vErMH5Jpyy8oa53cLRlOD7zEIY+iQEIFyTm7guhxWj0=;
        b=QXxQs8FJqTyJvR5kv52QhSTaXZnBKG9DBQAuiQMfti8jJV5Z+Fgm5RAEJLFqtd2eZT
         CksvnKr5W+wSuhMzsljmCbYLig2fwtH/S7cJ06ospmIirW4vpC5sLfPvHgIt86ICTPW2
         4JfupdNoHynDFOHEoMjo/AtaVyobJycXeV8QCPfZMl/pRGOM1hkImai5Jgcspx/DPih6
         ypbx4N3ylfp/z28IpBejNd0ZptvxGCByB1hXzYf/DUvGlXtYf6Bh9bHCt2HDX4ly6epR
         IevFLejeBOF7wLxGBx4HkJqEfz/omMiprnG4Qp2KqaQEFCwTJSBjR/9Gk0MQzWT2LQCx
         c8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570829; x=1790175629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vErMH5Jpyy8oa53cLRlOD7zEIY+iQEIFyTm7guhxWj0=;
        b=0xzD19ge81cjkrVlXAUF3/cDp4SZtxo4w4tyXoxWff5hyBnW8/hJrtb2aOWInmCLkV
         ndG+nPBTH6/yENWnrx6wCEBlFta8rltD/UVCOEoy82By6ywRexHKj7VC9pPPKcrFBKif
         aYN0/eroAm2zxHICUjRkqs8UnBOGq+494fVzRjmQWApBgNT/ajRZ4EOrQgfysX+f78bN
         Mtsm+wpajcIYznh3tBUeI+bsvSxzlIi5Erf35AJoTx2lwrFZKS9boaYSagUPqJPmpM3K
         fEFryKnq5msoTzBNGhfHXuiueFem+8/sq3+dyCwI14AGleaqwIKfjq2rZk4qm/yp1WQ9
         Myog==
X-Forwarded-Encrypted: i=1; AKwUvByw8n6OpuUf2kcZ1EjcrL/WB1Tx/jUlHdwG1I9HxVIhM6+c/5oCgzGRNpKLdYByGKNrXeFHPD1kUg0Fiw==@vger.kernel.org
X-Gm-Message-State: AFuF++l0sXumrpEz9mwQgpmcidWupAB80mgw34nH457+uZ8Gem3madc/
	2UGzINI/RYuMMnRFAuD/GcNNa3eYE9DSpnB2YDMu8SLDaTeUdjHwTAyMW5rzj0GKwloUozOe628
	XVTap95zsuIDptwoldGacVEPg1EenvXmwg0x530cICN10rikpMt9Ybe54cPzktrS9
X-Gm-Gg: AYBFou2nf2Zr3I9rYVgZ3AT/FWj8DiuZEaRDKSjUyXLN/8DoMKUqZnevMxmhYqhDsb1
	pUNKmvHTwqP0jXsg9v2yYV0FWm1dWccWFYgGOQkD+DJpZm31vhTlT4VtwoB0r1CwqphU9R/rl50
	WmkY/II9dEMY2YqrPsBhqh81jQl0DEXqgnpY0ueX7WzQNo3d97TKTy2PqWDB21b6Nlp+2exYtXq
	+/JnbngKwM6/9uuQPYK/hhoj+RT4oqoiUeNRVVkYKzLXTepctAP+C8X+lvN6XlYTI3hVG33p/bz
	LfYS25KRanDGJaM5J1u78dZGN+CGj7qqJ5xGi8J2aLk6InKNUqLeOwzsnv4vq28votWORMtff52
	lLHKVSOOhuPiVTQ7toUiw/d8=
X-Received: by 2002:a17:907:7287:b0:c26:19de:912c with SMTP id a640c23a62f3a-c29e530a4c5mr215296766b.31.1789570829136;
        Wed, 16 Sep 2026 08:00:29 -0700 (PDT)
X-Received: by 2002:a17:907:7287:b0:c26:19de:912c with SMTP id a640c23a62f3a-c29e530a4c5mr215291666b.31.1789570828446;
        Wed, 16 Sep 2026 08:00:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de4893aasm153542566b.30.2026.09.16.08.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:00:27 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:00:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: clamp max_segments when indirect
 descriptors are disabled
Message-ID: <20260916104218-mutt-send-email-mst@kernel.org>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <20260817134202.160669-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817134202.160669-1-sergiiushakov@google.com>

On Mon, Aug 17, 2026 at 03:42:02PM +0200, Sergii Ushakov wrote:
> When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> scatter-gather segment in a request must consume a physical slot in
> the virtqueue ring.
> 
> If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> compound bio arrives from the page cache, virtqueue_add_split() rejects
> the request with -ENOSPC and triggers:
> 
>   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
>   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> 
> This permanently wedges the blk-mq queue and blocks all subsequent disk
> I/O in uninterruptible sleep (D state).
> 
> Automatically clamp sg_elems to (ring_size - 2) when indirect
> descriptors are disabled.
> 
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
> ---
> v1 -> v2:
> - Drop max_segments module parameter and rely solely on automatic clamping
>   when indirect descriptors are disabled (suggested by Christoph Hellwig).
> - Guard (ring_size - 2) calculation with ring_size > 2 to prevent underflow.
> - Update commit description accordingly.
> 
>  drivers/block/virtio_blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..8f5a2d5323a6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1267,6 +1267,13 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> +	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> +		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[0].vq);
> +
> +		if (ring_size > 2)
> +			sg_elems = min(sg_elems, ring_size - 2);
> +	}
> +
>  	/* We can handle whatever the host told us to handle. */
>  	lim->max_segments = sg_elems;


I do not get why it does not clamp with VIRTIO_RING_F_INDIRECT_DESC.
Spec says:

 A driver MUST NOT create a descriptor chain longer than the Queue Size of the device.

Also, pls add a comment explaining where does this 2 come from.

What about ring size 2? I guess



> When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> scatter-gather segment in a request must consume a physical slot in
> the virtqueue ring.
> 
> If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> defaults max_segments to BLK_MAX_SEGMENTS

Does it?

        err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
                                   struct virtio_blk_config, seg_max,
                                   &sg_elems);
                 
        /* We need at least one SG element, whatever they say. */
        if (err || !sg_elems)
                sg_elems = 1;

so set to 1 without VIRTIO_BLK_F_SEG_MAX


        /* Prevent integer overflows and honor max vq size */
        sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);

unchanged here

        /* We can handle whatever the host told us to handle. */
        lim->max_segments = sg_elems;

assigned to max_segments here


> BLK_MAX_SEGMENTS (1024).

In which tree does BLK_MAX_SEGMENTS equal 1024?

git show next-20260915:include/linux/blkdev.h | grep -n 'BLK_MAX_SEGMENTS'
1234:      BLK_MAX_SEGMENTS        = 128,




> When a multi-page
> compound bio arrives from the page cache, virtqueue_add_split() rejects
> the request with -ENOSPC and triggers:
> 
>   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
>   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> 
> This permanently wedges the blk-mq queue and blocks all subsequent disk
> I/O in uninterruptible sleep (D state).

Please clarify the reproducer, including the negotiated features,
max_segments, actual ring sizes, and total_sg at the failure. As
described, it should not trigger and I do not see how
the patch is supposed to change the failing configuration.

> 
> Automatically clamp sg_elems to (ring_size - 2) when indirect
> descriptors are disabled.
> 
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
> ---
> v1 -> v2:
> - Drop max_segments module parameter and rely solely on automatic clamping
>   when indirect descriptors are disabled (suggested by Christoph Hellwig).
> - Guard (ring_size - 2) calculation with ring_size > 2 to prevent underflow.
> - Update commit description accordingly.
> 
>  drivers/block/virtio_blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..8f5a2d5323a6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1267,6 +1267,13 @@ static int virtblk_read_limits(struct virtio_blk *vblk,

Well we only set the limit at probe. virtblk_restore_priv() recreates
the queues on resume and reset recovery, then resumes dispatch without
checking their sizes against the existing limit. ring allocation
can reduce the size under memory pressure, including during recovery.

Since you are now (correctly) tying request size to vq size,
this needs to be resolved.



>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> +	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {

Why exempt indirect descriptors? The virtio spec says:

	A driver MUST NOT create a descriptor chain longer than the Queue Size
	of the device.

Even on devices ignoring that -
there is a failure path even when indirect descriptors are
negotiated: virtqueue_add_split() falls back to direct descriptors if
the indirect-table allocation fails. So if the request exceeds the ring
size, it returns -ENOSPC even on an empty ring. virtio_queue_rq() then
stops the hardware queue, with no outstanding completion to restart it.


> +		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[0].vq);

Why 0? VQ 0 is not necessarily the smallest queue. The transport specifies
sizes per queue, and Linux can reduce individual split-ring sizes
during allocation.

> +
> +		if (ring_size > 2)
> +			sg_elems = min(sg_elems, ring_size - 2);

The subtraction is correct: virtblk_add_req() uses separate outgoing
and incoming header descriptors, including for zone append.
However, we really should have a comment explaining that, here.

And, ring_size <= 2 must be rejected rather than bypassing the clamp:
A two-entry direct ring can pass probe, yet even one data segment
needs three descriptors and hits the same permanent -ENOSPC condition.

> +	}
> +
>  	/* We can handle whatever the host told us to handle. */
>  	lim->max_segments = sg_elems;
>  
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 

>  
> -- 
> 2.55.0.691.gc56d675ccc-goog

