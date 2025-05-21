Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67E2472B4
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822590; cv=none; b=OjIcVDiCTQNYXV2x5TCFnMWbZgUxniCNkVIZW49TmgOPOAi7ndKGlfiq2cvF6C2o31pKHzU+lBmW1TYUSxZbqqnWUfWDteU/OHQxPwQJTKv/sFDINMNkUOYHAGk1THN2iKYrqByh+4jW+GAWik6XoJIfrNoJ4NAFDsQA3LoVvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822590; c=relaxed/simple;
	bh=XhkOnIFSZzfz8vBD/tR/JxVR+GPcZ8tyc76NnJLwy9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1NpzIpbV//zBqXSlivDoh+7yye71G3bGTKrnTHu1bxJWmsy3kbpwvt6viBk9yXnT1uNcbwGtxZ+3sf07HL5oYe2Ajm7dw6/l4oFNvTYjrfMBGPrX7yufnTauu/jg3n47z33rH1C1xIgDtbdCR8Nqe1wHNcRIkZARiZb4gcvADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrNXa1Ok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrNXa1Ok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747822587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9kkU7Xfk94mr2Cbd+PQ9YPHZhQWHng6qRUMVT0EvtHU=;
	b=XrNXa1OkNjiakkt/D9VlyLW57gUFJr0qWHvYvuN5ebZkZ62Yd4T3kqDufSbdH8PCJl/SJE
	jPIfefVZ3uzDNwpnoQT8DGEDt9gBX+FljZzZPXql9emGgwKYaKc5fo6DBwQI54BZww6Qi7
	NuCw0e3F0H7UxaFP4vJRQKkZtrSKrtU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-eCnMAtvRP_mPt0TCkPo0uA-1; Wed, 21 May 2025 06:16:25 -0400
X-MC-Unique: eCnMAtvRP_mPt0TCkPo0uA-1
X-Mimecast-MFC-AGG-ID: eCnMAtvRP_mPt0TCkPo0uA_1747822584
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a36a4c70b4so1421059f8f.1
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 03:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822584; x=1748427384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kkU7Xfk94mr2Cbd+PQ9YPHZhQWHng6qRUMVT0EvtHU=;
        b=uc9tzkKvC7uBiVBvCTqa2saAjMCVdh55GUazUfFPS2mu3khV8lM7mJN4Z85xUziVar
         sDB1rBAmFtS1EngFAC1ps6hgXGhEtKK47ETxD207Iiy95cf3pdTgrlyskgWSardKh26z
         s60Cit9/J/+SM76ZN7q88EZe9Qvpow+q4rg8jJ0uhVG/kZOXo+m0pWGYgMfkNPjlau9T
         J0alq/8IENCnkkaUVHyUyYI+MB2aEIXhMzcVhngWYGMo1x6gpqxiFnIv3RAAnxirAUYq
         WJ1kyimYoesNVmjsVWAxXIAA5uMVbssi0TZUEQ3FBjmbNGGqvquWO0jUWQtGPPr/7s6t
         35dw==
X-Forwarded-Encrypted: i=1; AJvYcCXEVIwNwdAERbn2HP0mtG6WQqozIfjhF9IbMXA4+qq82nMFHxI8FmykXTdCKetaoBKdKD8EAcxXB8C11g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJx3YPZRO3Ryp9Xg8Tq5xL1eF1vfF8tQlcF01k1DiyHJEnquOA
	0PVb2Ws3+rCwgSTqGhgj/EdOQ9ARz2JsOaoTsSbGbksaUskhAiuneDOPiz7QQsYme2RBoV+RrN3
	5u8LY3KDKZ73JHwrdWbG/VPkxo18p87yuDKW9BZRjSNoh9u/+D3RnU5iIg/PiO5/N
X-Gm-Gg: ASbGnctJ+4m38c10s0QF9bK5Iw5gCmcns3HUKBII2l/FJZVqXTI6EuuwmFHYVzdGx3u
	/u8kHgpSrIf3/t0F9qWVJcd2XP2LuJdqBDfRewhqGu0hf1hB7AtUtnFPMDyC0UsMeGYP0uhe3Vw
	VZ0vLWBja0u/VveRQVDmww4K46Kq7cLy3wh/2YrfKXysRBs6/q4xPpJT6wQU25OW7sOUaIqZo7J
	V1RXFQTPPbLIsQRpdFkvEBavdteKBCo2yQon8KkgXYXHpZ7snILZIQPu/z+36xqwdrjJXoSZUSn
	trTDbw==
X-Received: by 2002:a05:6000:1881:b0:3a2:595:e8cb with SMTP id ffacd0b85a97d-3a35ffd28c6mr16271029f8f.45.1747822583801;
        Wed, 21 May 2025 03:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl5MRnm/anUQ/+Mk3nQZ83R7M1qg6DNqqWQEJvci6mEU3aauLFjKYMXFRTCdchPrjbC/Gz5Q==
X-Received: by 2002:a05:6000:1881:b0:3a2:595:e8cb with SMTP id ffacd0b85a97d-3a35ffd28c6mr16270982f8f.45.1747822583350;
        Wed, 21 May 2025 03:16:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a04csm19026409f8f.23.2025.05.21.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:16:22 -0700 (PDT)
Date: Wed, 21 May 2025 06:16:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521061236-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 09:32:30AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 21, 2025 2:49 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: stefanha@redhat.com; axboe@kernel.dk; virtualization@lists.linux.dev;
> > linux-block@vger.kernel.or; stable@vger.kernel.org; NBU-Contact-Li Rongqing
> > (EXTERNAL) <lirongqing@baidu.com>; Chaitanya Kulkarni
> > <chaitanyak@nvidia.com>; xuanzhuo@linux.alibaba.com;
> > pbonzini@redhat.com; jasowang@redhat.com; Max Gurtovoy
> > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
> > removal
> > 
> > On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, May 21, 2025 1:48 PM
> > > >
> > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > When the PCI device is surprise removed, requests may not complete
> > > > > the device as the VQ is marked as broken. Due to this, the disk
> > > > > deletion hangs.
> > > > >
> > > > > Fix it by aborting the requests when the VQ is broken.
> > > > >
> > > > > With this fix now fio completes swiftly.
> > > > > An alternative of IO timeout has been considered, however when the
> > > > > driver knows about unresponsive block device, swiftly clearing
> > > > > them enables users and upper layers to react quickly.
> > > > >
> > > > > Verified with multiple device unplug iterations with pending
> > > > > requests in virtio used ring and some pending with the device.
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: lirongqing@baidu.com
> > > > > Closes:
> > > > >
> > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4
> > > > 74
> > > > > 1@baidu.com/
> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > ---
> > > > > changelog:
> > > > > v0->v1:
> > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > - Improved logic for handling any outstanding requests
> > > > >   in bio layer
> > > > > - improved cancel callback to sync with ongoing done()
> > > >
> > > > thanks for the patch!
> > > > questions:
> > > >
> > > >
> > > > > ---
> > > > >  drivers/block/virtio_blk.c | 95
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 95 insertions(+)
> > > > >
> > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > > 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > > >  	blk_status_t status;
> > > > >  	int err;
> > > > >
> > > > > +	/* Immediately fail all incoming requests if the vq is broken.
> > > > > +	 * Once the queue is unquiesced, upper block layer flushes any
> > > > pending
> > > > > +	 * queued requests; fail them right away.
> > > > > +	 */
> > > > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > +		return BLK_STS_IOERR;
> > > > > +
> > > > >  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > >  	if (unlikely(status))
> > > > >  		return status;
> > > >
> > > > just below this:
> > > >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > >         err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > >         if (err) {
> > > >
> > > >
> > > > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a broken vq.
> > > >
> > > > Why do we need to check it one extra time here?
> > > >
> > > It may work, but for some reason if the hw queue is stopped in this flow, it
> > can hang the IOs flushing.
> > 
> > > I considered it risky to rely on the error code ENOSPC returned by non virtio-
> > blk driver.
> > > In other words, if lower layer changed for some reason, we may end up in
> > stopping the hw queue when broken, and requests would hang.
> > >
> > > Compared to that one-time entry check seems more robust.
> > 
> > I don't get it.
> > Checking twice in a row is more robust?
> No. I am not confident on the relying on the error code -ENOSPC from layers outside of virtio-blk driver.

You can rely on virtio core to return an error on a broken vq.
The error won't be -ENOSPC though, why would it?

> If for a broken VQ, ENOSPC arrives, then hw queue is stopped and requests could be stuck.

Can you describe the scenario in more detail pls?
where does ENOSPC arrive from? when is the vq get broken ...


> > What am I missing?
> > Can you describe the scenario in more detail?
> > 
> > >
> > > >
> > > >
> > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list
> > *rqlist)
> > > > >  	while ((req = rq_list_pop(rqlist))) {
> > > > >  		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req-
> > > > >mq_hctx);
> > > > >
> > > > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > +			rq_list_add_tail(&requeue_list, req);
> > > > > +			continue;
> > > > > +		}
> > > > > +
> > > > >  		if (vq && vq != this_vq)
> > > > >  			virtblk_add_req_batch(vq, &submit_list);
> > > > >  		vq = this_vq;
> > > >
> > > > similarly
> > > >
> > > The error code is not surfacing up here from virtblk_add_req().
> > 
> > 
> > but wait a sec:
> > 
> > static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> >                 struct rq_list *rqlist)
> > {
> >         struct request *req;
> >         unsigned long flags;
> >         bool kick;
> > 
> >         spin_lock_irqsave(&vq->lock, flags);
> > 
> >         while ((req = rq_list_pop(rqlist))) {
> >                 struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> >                 int err;
> > 
> >                 err = virtblk_add_req(vq->vq, vbr);
> >                 if (err) {
> >                         virtblk_unmap_data(req, vbr);
> >                         virtblk_cleanup_cmd(req);
> >                         blk_mq_requeue_request(req, true);
> >                 }
> >         }
> > 
> >         kick = virtqueue_kick_prepare(vq->vq);
> >         spin_unlock_irqrestore(&vq->lock, flags);
> > 
> >         if (kick)
> >                 virtqueue_notify(vq->vq); }
> > 
> > 
> > it actually handles the error internally?
> > 
> For all the errors it requeues the request here.

ok and they will not prevent removal will they?


> > 
> > 
> > 
> > > It would end up adding checking for special error code here as well to abort
> > by translating broken VQ -> EIO to break the loop in virtblk_add_req_batch().
> > >
> > > Weighing on specific error code-based data path that may require audit from
> > lower layers now and future, an explicit check of broken in this layer could be
> > better.
> > >
> > > [..]
> > 
> > 
> > Checking add was successful is preferred because it has to be done
> > *anyway* - device can get broken after you check before add.
> > 
> > So I would like to understand why are we also checking explicitly and I do not
> > get it so far.
> 
> checking explicitly to not depend on specific error code-based logic.


I do not understand. You must handle vq add errors anyway.

-- 
MST

