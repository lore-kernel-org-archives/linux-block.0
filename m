Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E864149E17
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583666; cv=none; b=Oam9GRvQ+yMdEbtQBTIlPf1HYwBLdyCxRki+muLjgd9mX6OX9RTjMgQEsr+HxNMtdDiRDnwkBdYqvv05E0ibLR2RUNNF/KaIpgrQsDVq/LGmUM4MWoUpv6sIZxpDSotcLCfzDrdSJYJ5q2SZgLZqyKHlHvkTUcbPma43jylLKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583666; c=relaxed/simple;
	bh=74wRxD2l9NYLAbB9LebrUEkWa4OpLYkBLpC76xxkA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtFHHCdzndFw3bkQ4nOusC1tG0rjaUEMZh74bRxOkxiZcLXyCUDPSF1O9/O7hiuQXRehg9R6MhGsaaWLKl24CGbfUt2IWieEeBj2vSm+VAouxqS1Byp4I+x2NNSxjpHru5u/8Rcr/F7lj3ZlJCf9OMQO9O7rjBqJW5ZAqrDbQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WN6zGm2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WN6zGm2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737583664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjdmbjBOcMVmlf2psJyAfY3tW761wBaRxSZPkXVWANY=;
	b=WN6zGm2nT7WY30RGXSj0RhjdLo4e09xe775NkokbmDDW+nvhKWtYqMj8nc5yU87HmIs3Dt
	ytRgx4suvZ0o5z+8ImFhFbuJ2aC7FVfGk7S5VzujnOl/A6m77UGFFGxDLBieRQxWldRIr1
	eBHvmex4uQOcofA1hP8ympxMaQ8GM0A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-2-tN2JepPViVEQ7vysyjJw-1; Wed, 22 Jan 2025 17:07:42 -0500
X-MC-Unique: 2-tN2JepPViVEQ7vysyjJw-1
X-Mimecast-MFC-AGG-ID: 2-tN2JepPViVEQ7vysyjJw
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3bf8874dbso349483a12.2
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 14:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583662; x=1738188462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjdmbjBOcMVmlf2psJyAfY3tW761wBaRxSZPkXVWANY=;
        b=jWLAAZxMvFbBlWsR6tBHHYYJtkHCAUrYJVnVu1UGV1jyWaBGf+hD/3z5L1vyPBj/C6
         Wn7JxvtlzrbDfYPWUqi3KPJk+CAy3zgsTkxGyPH3cI4Xo5Uc0CrLbXdgv03bcYMFqodm
         tUdDe7AWZ4b40lrKh4weoCBZ8OUgwevU3CiX35NjSnTFQ8TohyRcHRV1+Szf/0NPO8Y+
         ToWf3g7wznivxgf+eAb1Ux8E7cFuqL5/auZ07sYM0VxBwniI2I/pZJKPwyy91KPa0LqB
         YSLkKZYattOdozbLo3wzCQgsdJp7UDN0ryKOmmGSwvDB3WUi+srWD6piHar02qO2hbKs
         XmWg==
X-Forwarded-Encrypted: i=1; AJvYcCVQgfljD8xfaKdI2Kc3FI76Lc1LZvrsxAZzf7W3+kzm5TeuG+r1xbcaXkqcRlL3HEuYl9v8gX5KXcah9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHYPCBhZf8Co/Q1khjlzCmec+BJQ2LqztloqdNvOcy+fedC7H
	99JmrmXlgUEmEzz7H5XQAKIT0bN7qfR3KrH4G+LF+Mn04SqwClR8grwrBCiSMIrIKydVHMcvrA3
	Ku4PRihkaZyNGWx//L4ZGBDa0HlnC2fnnad6QPuwYaLKAWOv3m/CCTwPCFmu5
X-Gm-Gg: ASbGnctFG+6YrLxEIcee4zJwsK44ekgSjTOxHXLw9OkNaVuwAgEvgB1/41xUL7REFWF
	zSZSJbLY1NqLVF2x3l3XRHooC+9tBWO1Tuy7eBQEpcnRBtorzUhD1eOj5qdFenv3/cK0Crt+hHc
	raaej7Fmv23UPcT40Rpn4GfzWRorJazcHXCrhb/JmK3FSrB4kG/3LmLtcHASMjWmVc6D+ZN07vL
	UWS/cXWpmKBHxbu4oYtPO3XyPWavqU/kav1VPcfPprrm6UtQjilbvT9Z/ghaucC9g==
X-Received: by 2002:a05:6402:849:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5db7db06f81mr20073885a12.32.1737583661643;
        Wed, 22 Jan 2025 14:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+VdiTrhSWqrbzQ+FfBJ/MkrLYio8KHyB6V6/BJIlVFbB7omc0W4ZRr8xC2O258A5DQTwKzQ==
X-Received: by 2002:a05:6402:849:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5db7db06f81mr20073870a12.32.1737583661282;
        Wed, 22 Jan 2025 14:07:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb769dsm8921797a12.50.2025.01.22.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:07:39 -0800 (PST)
Date: Wed, 22 Jan 2025 17:07:34 -0500
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
Message-ID: <20250122165854-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>

On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> [...]
> 
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > > > >  {
> > > > >    struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > >    struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > > > -   bool kick;
> > > > >    spin_lock_irq(&vq->lock);
> > > > > -   kick = virtqueue_kick_prepare(vq->vq);
> > > > > +   virtqueue_kick(vq->vq);
> > > > >    spin_unlock_irq(&vq->lock);
> > > > > -
> > > > > -   if (kick)
> > > > > -           virtqueue_notify(vq->vq);
> > > > >  }
> > > > 
> > > > I would assume this will be a performance nightmare for normal IO.
> > > 
> > 
> > Hello Michael and Christian and Jason,
> > Thank you for taking a look.
> > 
> > Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> 
> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> Really, dont do it.


The issue is with hardware that wants a copy of an index sent to
it in a notification. Now, you have a race:


thread 1:

	index = 1
		-> 			-> send 1 to hardware
           

thread 2:

	index = 2
		-> send 2 to hardware




the spec unfortunately does not say whether that is legal.

As far as I could tell, the device can easily use the
wrap counter inside the notification to detect this
and simply discard the "1" notification.


If not, I'd like to understand why.

Thanks!


-- 
MST

