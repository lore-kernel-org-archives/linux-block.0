Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96ED41D131
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970479; cv=none; b=X/1FGkTb4YtxNfMaQPF/bj8UB+uPfA3KP4EKOfL7sV4UK5h8OTSJA9jPx+/jv5+VNsIeXLKFbIMS/h6bKQaer/eQKfhOrjKg2OKdiEy2dbhBbzWN7+aqmUzwjbNURzbeNAgZg0Cz8JIwSf9tTirjPf08nT96OUQv4QJ3c70Ank4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970479; c=relaxed/simple;
	bh=XpzDSGLqZ8oshW6QLL6AkRrKripZJSM32hTiHlFT9Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxm7kyIvgleXTLVlCSGe6C5zMhWYK69WI7kiNfOaSxQqu6ZgQ2FyD8ZQK+0cqFs9e7iqVncNEysGhnmhUnp84rqEYaiTpzyrhSX1dunM60CUya4w49IjBP+G2D7/b/vq+ytrz662peerP4RZMaEW60mFduSWGM92ZuMJQRLokPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxuG8ZgH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sKYeVYIr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxuG8ZgH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sKYeVYIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786970476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QT5P0FjYJIXNb5bpOKh/Iv+72OmLL9osWf81HjiuK1Q=;
	b=JxuG8ZgHGXpsHdmrotCIQ6eur1DwcGpEV5k1ZUxagZXbovEqEHGDK7orSXr9tnwfAY1w/t
	Qnxc4f/oIa7J6zXOcXVPaTVRLkzTXc0ZZKCh4FNquvz51uFUqYfkcikRowkY1Pv3vJkn22
	EdYBUv8rQs5nWqaPcOAh4REtmXHds40=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-v2fDp1VDN3ynNzp5uvDkVg-1; Mon, 17 Aug 2026 08:41:15 -0400
X-MC-Unique: v2fDp1VDN3ynNzp5uvDkVg-1
X-Mimecast-MFC-AGG-ID: v2fDp1VDN3ynNzp5uvDkVg_1786970474
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c232fa136so141815866b.0
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786970474; x=1787575274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QT5P0FjYJIXNb5bpOKh/Iv+72OmLL9osWf81HjiuK1Q=;
        b=sKYeVYIrjtMcI5xs5IGArgQmAHbt2bokS4xDVGYi18daNd0m6c/hAQ/TJTGspkJN9A
         xPxZUAyL2IGcKnrQm/873hv2Wz/Y3NEDr6V0CUpIh1/7LKPSL1TEhubPA28XllWHhzJw
         u4BrtAG8C7KHcu0JpFBjrdm+iKBcn+T/P2cfUd7QjZHMXXU5GlYGzYQ8RFl+O4FRdUb6
         ls/19QP19K6LE6B93oD2ZxVXWwxbAIsSOHvsIj0TVhHtoYLSlcAzGBPSMlbXlUp7hKoZ
         s3XT/dELtLz+J+wc49ENv4OCvD3oYf6LzUKz6to0pKNLtqNIZfsRyrS/LZn8uZgjujq1
         E24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970474; x=1787575274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QT5P0FjYJIXNb5bpOKh/Iv+72OmLL9osWf81HjiuK1Q=;
        b=SVZSJ/Y4ys5Idge1ebpLfl4ogW7kKH9uecsKdoSYRTk6XOv/u1KF2gkyPAIbbuK8K5
         w0sfDyCsJlaDYCV0EBYLILW47+6WDL9bwTPY4MAcyEqVK0etzM/aVEqMRNG6+jaUXgX/
         5t7rBQmVRxOGV9sgWmixPpgmgC96rZhExk+BfofRf1oLLbqVSo1o4nOumbbgQ4mU1Rdv
         s0bJ3GyJjeRR4GUeG3IklC08zGFlB5wW9L+Sf2IoLH8YFIdRMecXzxx0BI/ifDM3tcBV
         azxHDEatEDiIVlami1hDpsGHVYKFKSC1SzNYsMTyc5e0rjGBDgzYqMWabBhOScPSnQiC
         yVeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzhRdw+1VKe6ggMrc3SKctI6QWfrCZ8UtBRTC3j6Z67gNEmMD+023BZPLKxJNFPqrFQVlsg1/Tt6kuTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxb37EEOo+ZzhOIYL/IBxBEbBCpWSeX7GENlyyvBy30ulWnHzk
	dtWS7nvzoOQQClo+pfu3punDL4iJ+LO80k5Q58avCHaeZm4ysG2OpnDOHiqTSh7TKr1ajM7kSXQ
	0n4ENfspupAY5JROVM+QmhWXmlk28e2/GZyS5jtqrF/60srhnDCS1JqByypOm0Tbw
X-Gm-Gg: AR+sD1323flgkILLR2SBMji5x+5nQDXCxJ30YEiuApSG/YSf909SM4BQRhlcUG+9OPD
	mUV8iDU0UZeuTFr89fWuWxMPktJ+vqiVD+jmsdZChUj7e/QtRstTwBjW9sKmJvrkos4x0rDx8B6
	d2MbHs1Vx1ZN1WAsyHIvJmwswMRrzTjRaNDbmgd00oVESdU3mIFaP+8li+ZOzwjEFQYdWe9GgB8
	j56CW/dHN0AfH2X8efIoQdD/eOaesgNwzu1kq+4q0n7x+oHKaGaLfhVHRM+UUipv3FXh+iz2Inr
	8AM+dI7lohpHAEcysfQbf+jms4IMbCvcpGPSbBHb20elyJjRXrQSW2zQbq558t07nS3mNw1w/yn
	Rvd6ayC5Tovo1bXgmqWRSLfOq
X-Received: by 2002:a17:907:d0f:b0:c08:580e:899a with SMTP id a640c23a62f3a-c212aa1d477mr1206731866b.10.1786970474042;
        Mon, 17 Aug 2026 05:41:14 -0700 (PDT)
X-Received: by 2002:a17:907:d0f:b0:c08:580e:899a with SMTP id a640c23a62f3a-c212aa1d477mr1206726566b.10.1786970473289;
        Mon, 17 Aug 2026 05:41:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea2cdcsm52972566b.18.2026.08.17.05.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:41:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:41:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-blk: clamp max_segments when indirect descriptors
 are disabled
Message-ID: <20260817084042-mutt-send-email-mst@kernel.org>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <aoK8fF27_nu1ux9s@infradead.org>
 <CADhvd_MfDwX=Ebwt3XQJrzYkvACGCdAq1VYT585Bv2v37Zu2rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADhvd_MfDwX=Ebwt3XQJrzYkvACGCdAq1VYT585Bv2v37Zu2rg@mail.gmail.com>

On Mon, Aug 17, 2026 at 10:08:21AM +0200, Sergii Ushakov wrote:
> On Mon, 17 Aug 2026 at 09:47, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Aug 14, 2026 at 12:59:54PM +0200, Sergii Ushakov wrote:
> > > When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> > > scatter-gather segment in a request must consume a physical slot in
> > > the virtqueue ring.
> > >
> > > If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> > > virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> > > defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> > > compound bio arrives from the page cache, virtqueue_add_split() rejects
> > > the request with -ENOSPC and triggers:
> > >
> > >   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
> > >   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> > >
> > > This permanently wedges the blk-mq queue and blocks all subsequent disk
> > > I/O in uninterruptible sleep (D state).
> > >
> > > Add a virtio_blk.max_segments module parameter to allow runtime cmdline
> > > overrides, and automatically clamp sg_elems to
> > > (virtqueue_get_vring_size - 2) when indirect descriptors are disabled.
> >
> > What is the reason for the override?
> 
> The module parameter was intended for two main reasons:
> 1. A safety fallback for non-compliant/buggy hypervisors that may have
>    internal segment limits lower than the advertised ring size without
>    advertising VIRTIO_BLK_F_SEG_MAX.
> 2. Debugging and performance benchmarking of smaller scatter-gather lists
>    without needing kernel rebuilds.
> That said, the automatic clamping to (vring_size - 2) resolves the
> hang and panic out-of-the-box. If the preference is to avoid adding a new
> module parameter, we may drop it and keep only the automatic
> clamping.

sounds better to me.

