Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49017084F
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430998; cv=none; b=PNR765b1Ul4o8iBnTTfVBmwrR2QOj3rDrQKZsxR2Fcj7bsEMd6ldjRJQAuQuD/vgW3YEdtAXTLW9tFSUVruvZw37MvR+mlSy1fNPakctrmCSji3u3t70LZdesTKLMUGnq92kPOSBe6EujsL/mRt1VFySAGEq0JvYsbQUeOJgCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430998; c=relaxed/simple;
	bh=//OiUEZ/X3sjEzyvVlXMOA2Qq03xThrZHJgCXBrnqBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9useTQOUj5DDZ3uPHshRFgczTCX6nER3h/8MJBpCxfe+gc5UB6ZW+PARPMQaDZAo9Kuf/+5vcuxd3oZqF3zJNAUYm3ohpxtdFnFcTBoDZJJNqBzEBWXUGFj1XEntLXvLr530JIRDJNij9jJUM5LqYi+bGuglhKfs9xaUd8QL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4QrTnn7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4QrTnn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740430995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjdPdlDxUaWDLsqY/y3GlKK8NuQp7ebfGK8Kn9MiIrU=;
	b=J4QrTnn7WCAilqCyJycyML/n9caa2t0ATXwhxd5FuFY0h1BhmR1zgQidHkx1lMmWFd+q4F
	REGT9YWtmBw8SfMJhjE16KP7vNIPdxqJPp4HaHl42LjyeVq/3k4N4keUWfs9PQ9fW0cw2E
	P+xjngIvNLrcqgxmFOTDikarlaoLvgU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-we2kPy1BMB6BAH7ehRUl5g-1; Mon, 24 Feb 2025 16:03:13 -0500
X-MC-Unique: we2kPy1BMB6BAH7ehRUl5g-1
X-Mimecast-MFC-AGG-ID: we2kPy1BMB6BAH7ehRUl5g_1740430993
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abbae81829fso549221966b.3
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740430993; x=1741035793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjdPdlDxUaWDLsqY/y3GlKK8NuQp7ebfGK8Kn9MiIrU=;
        b=Eb9fvlpUPrK+ZZ/elD8ykiI9Yzh2cXUdieigZPqOS3cetmNJSJymMdmx+LjSQik0tT
         8U2H/jDtt3skbSKsCE5hj8ak2Y/VSNJVzxgBkzpse6qf2mzxdHi9j4tE3OwgfZwIyPY7
         Oi129x10zny5y9NlKb2t4586DanFDD3EqNUZBjcPbuo2dRI4Co/eOsN/pXzHljq5mxkG
         dCByiHQ74jScFSQAywhXM7K4qrr89s/RltCDpR0ZNyOtu/zk/R0cjigdb2JqmT/uAYjX
         Mcq/sMEnHLXsW+zkzCauKlO20qp95rAOs1K2I4XEZYXskzahCoFpCpzEC2OIQubnj0j4
         hr/g==
X-Forwarded-Encrypted: i=1; AJvYcCWNNCT/DUnoyNS/3i4aQ7fvqpKXUWd1/GCHdLbSRFkWxK7AXEdMAfbFBRoL8ZXCp0Vh4/OyCFvcew9ArA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJuv7/Qh3uLqRRIwG/Xk+jFwm42D67z78TUut6GdGEml/x21q
	cASMPPYujbW2/KsGuzPm4RaYHN8GBMHIVBWd+oITH0nTLiiHRi5t3FCUUgXbo2KsZcA5nnAgSvp
	+PmvUxI4YnLuoNL1k570HtVmTtgLEoecuzp0W8ext6rJKcg3vrAI0fjNiRyjv
X-Gm-Gg: ASbGncvmWEiqKDuWie1n7R9YmQNTvLvup4DtbONMR0m1kHVywg1T81KrWgov3yNYz8M
	sjO4rZToXmOVLLV5+bn25nMr2LKMikMrUD4GzGpTLZIKF9BT6Uhqt95zS4sTBiVjPeI6mV8PrP8
	wjTAMn7bsyG9OIIAV4Wy2xjayt5Mn3eYsLwPTZd2msZpzuFSMQWU5CZu3H7zhBssEk2NJ14nFw6
	7YTIAQwwNiGhnQZYUAbS0Mmz0eupRlol27UKm0Mclxcj2wWCKB6xH1Wvvl+5BuctZQBRlAQieN0
	UawcPpJ1mg==
X-Received: by 2002:a17:907:72d6:b0:ab6:dace:e763 with SMTP id a640c23a62f3a-abed100fee4mr65181466b.38.1740430992708;
        Mon, 24 Feb 2025 13:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNHu1uQVxpwWyvs9fUXZ7i+eEr8RS9n4WkZiFY7UxnzH8miFb2ujF0374rCn8fkM/IBKiHYQ==
X-Received: by 2002:a17:907:72d6:b0:ab6:dace:e763 with SMTP id a640c23a62f3a-abed100fee4mr65179466b.38.1740430992316;
        Mon, 24 Feb 2025 13:03:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd5f9asm22617566b.34.2025.02.24.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:03:11 -0800 (PST)
Date: Mon, 24 Feb 2025 16:03:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "Boyer, Andrew" <Andrew.Boyer@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>,
	"Hubbe, Allen" <Allen.Hubbe@amd.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250224160208-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <5952f58f-9b80-4706-adb4-555f1489f2cf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5952f58f-9b80-4706-adb4-555f1489f2cf@linux.ibm.com>

On Thu, Jan 23, 2025 at 09:39:44AM +0100, Christian Borntraeger wrote:
> 
> Am 22.01.25 um 23:07 schrieb Michael S. Tsirkin:
> > On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> > > Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> > > [...]
> > > 
> > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > > > > > >   {
> > > > > > >     struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > > > >     struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > > > > > -   bool kick;
> > > > > > >     spin_lock_irq(&vq->lock);
> > > > > > > -   kick = virtqueue_kick_prepare(vq->vq);
> > > > > > > +   virtqueue_kick(vq->vq);
> > > > > > >     spin_unlock_irq(&vq->lock);
> > > > > > > -
> > > > > > > -   if (kick)
> > > > > > > -           virtqueue_notify(vq->vq);
> > > > > > >   }
> > > > > > 
> > > > > > I would assume this will be a performance nightmare for normal IO.
> > > > > 
> > > > 
> > > > Hello Michael and Christian and Jason,
> > > > Thank you for taking a look.
> > > > 
> > > > Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> > > 
> > > The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> > > Really, dont do it.
> > 
> > 
> > The issue is with hardware that wants a copy of an index sent to
> > it in a notification. Now, you have a race:
> > 
> > 
> > thread 1:
> > 
> > 	index = 1
> > 		-> 			-> send 1 to hardware
> > 
> > thread 2:
> > 
> > 	index = 2
> > 		-> send 2 to hardware
> > 
> > 
> > 
> > 
> > the spec unfortunately does not say whether that is legal.
> > 
> > As far as I could tell, the device can easily use the
> > wrap counter inside the notification to detect this
> > and simply discard the "1" notification.
> > 
> > 
> > If not, I'd like to understand why.
> 
> Yes I agree with you here.
> I just want to emphasize that holding a lock during notify is not a workable solution.


Andrew, what do you say?

-- 
MST

