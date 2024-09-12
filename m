Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE318BB8B
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124249; cv=none; b=WM0Mc8yuctSsCp8Qoz0kFDeww6s1+W6vYU8y9DRKxd1UZo7Fvgq5ys5CSMwYOntcCNrzHpZisljYOJc6k3liDCMBRt58mHSMK5joX+MLeIAwInOgIw4da9imcUBbyUElDsJkJBHEaws7xlxLMJgjw9KxlVH9C1wORWzwNIUrGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124249; c=relaxed/simple;
	bh=c41U737DvIbyS3rQw7wuHXZTvfLKDNamYnqZSCT+gW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59sN5FJrWJ+qkv/XAt00K6XfocBrlllCbqN7Mu0RjDJpnRVY9ZCDiLh5fcmgrmdFlVGxuEAwsr7hJv05K4Ol/q2TrLqx76ti0QsqktKsEY2Xl01joEXUCcWvlO6gcRZNnlL/SuqrbTUrwcM4UMy+StFQmEmsc4kYnGwz84/j6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1K+xSA0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1K+xSA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726124246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPuZRy5RtmH3L7P/pdVOYsdMJ2O6tjAAwnmHh6w1Hw8=;
	b=D1K+xSA0rRTjdtF9nViuBzZ1zn9aRMFpMsDRIb+0SC9NzEjnfPUjjpJSCMJrAYSzQmwkB1
	Eo/+f2DjmXQ5ZFHvQXI3soVeo3fCN1F7/zLDddyS3cUPfB1f6D7uM3BlbVjsR5Lx3WLeY9
	9lcVe/VlgehwA852B7xo3UCblj6zD7o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-gkhy_xM2PeuchJ1yt3bzXw-1; Thu, 12 Sep 2024 02:57:25 -0400
X-MC-Unique: gkhy_xM2PeuchJ1yt3bzXw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb471a230so4080825e9.3
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 23:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124244; x=1726729044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPuZRy5RtmH3L7P/pdVOYsdMJ2O6tjAAwnmHh6w1Hw8=;
        b=rGYsNah5Psu0avCKsDW2TQ3f68r6n+eSbvoAnBillrgr/2LboFLZwJr7YjXw8vafRF
         hrpowveLVAK1I9EI9zFcOH9CNv26E52ZhH8mtBvhDZ+ezkA1YAeR8uYbIkFwRx1cr3c3
         Vb8GIYucBRUZdJK/IZkn7jNURtPgmQB0MAq2z1iNm/Sfvq0xh7hmeU3csAGNaLdl2n1N
         8rP1vb22jjVjUtqx41fKpoh8KX2AcP53JTyx6vcrj0pIbcFvdmSHEaSUhEWSwE3J40mT
         uv7bucoCruplvaO/JRpjdgeoyp/00MwYamRF/W0rmjUr/LjABTpJYxUOWqk6o1GvjzQ7
         HTOw==
X-Forwarded-Encrypted: i=1; AJvYcCXS3nMNTlBSlpHEv6lqDtdQJSksY4+uS8+sqGyLg5IprvBs68HLOB//iphRd0qRsSBzNB035kSbOQBmrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJb1Zq/qh7+H6tDiw+//Hikq8vpDLt2Ok9bR8WHTlqH/Ao4zPF
	JtCVki696SpOw14mAKNc8HkilwsrrpfvsMoVkpu4f1FqH0AGAa3af7xiuCVQ7f2tuYLz4fxS7Qy
	W8SvsgIkV8eUidm6vGtSx/UKYNjfhiJroK7OXoh4K/95rbI79EljbNUs0RRPr
X-Received: by 2002:a05:600c:45cf:b0:42c:a802:540a with SMTP id 5b1f17b1804b1-42cdb511f33mr14269675e9.7.1726124244021;
        Wed, 11 Sep 2024 23:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXqL1cN5bc6oEjTaDawFfKLkvgvogi3g7n3oqVfDLLfZUD5MCgnoC0hHuYgrIgCx12yMiOQA==
X-Received: by 2002:a05:600c:45cf:b0:42c:a802:540a with SMTP id 5b1f17b1804b1-42cdb511f33mr14269415e9.7.1726124243343;
        Wed, 11 Sep 2024 23:57:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:cf1c:50e8:cd2d:1a0a:6371])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cdf25282bsm8989165e9.33.2024.09.11.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:57:22 -0700 (PDT)
Date: Thu, 12 Sep 2024 02:57:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, stefanha@redhat.com,
	virtualization@lists.linux.dev, axboe@kernel.dk,
	kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
Subject: Re: [PATCH v2] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240912025124-mutt-send-email-mst@kernel.org>
References: <20240807224129.34237-1-mgurtovoy@nvidia.com>
 <CGME20240912064617eucas1p1c3191629f76e04111d4b39b15fea350a@eucas1p1.samsung.com>
 <fb28ea61-4e94-498e-9caa-c8b7786d437a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb28ea61-4e94-498e-9caa-c8b7786d437a@samsung.com>

On Thu, Sep 12, 2024 at 08:46:15AM +0200, Marek Szyprowski wrote:
> Dear All,
> 
> On 08.08.2024 00:41, Max Gurtovoy wrote:
> > Set the driver data of the hardware context (hctx) to point directly to
> > the virtio block queue. This cleanup improves code readability and
> > reduces the number of dereferences in the fast path.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> >   drivers/block/virtio_blk.c | 42 ++++++++++++++++++++------------------
> >   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> This patch landed in recent linux-next as commit 8d04556131c1 
> ("virtio_blk: implement init_hctx MQ operation"). In my tests I found 
> that it introduces a regression in system suspend/resume operation. From 
> time to time system crashes during suspend/resume cycle. Reverting this 
> patch on top of next-20240911 fixes this problem.
> 
> I've even managed to catch a kernel panic log of this problem on QEMU's 
> ARM64 'virt' machine:
> 
> root@target:~# time rtcwake -s10 -mmem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Sep 12 07:11:52 2024
> Unable to handle kernel NULL pointer dereference at virtual address 
> 0000000000000090
> Mem abort info:
>    ESR = 0x0000000096000046
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x06: level 2 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
>    CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046bbb000
> ...
> Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
> Modules linked in: bluetooth ecdh_generic ecc rfkill ipv6
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0H Not tainted 6.11.0-rc6+ #9024
> Hardware name: linux,dummy-virt (DT)
> Workqueue: kblockd blk_mq_requeue_work
> pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : virtqueue_add_split+0x458/0x63c
> lr : virtqueue_add_split+0x1d0/0x63c
> ...
> Call trace:
>   virtqueue_add_split+0x458/0x63c
>   virtqueue_add_sgs+0xc4/0xec
>   virtblk_add_req+0x8c/0xf4
>   virtio_queue_rq+0x6c/0x1bc
>   blk_mq_dispatch_rq_list+0x21c/0x714
>   __blk_mq_sched_dispatch_requests+0xb4/0x58c
>   blk_mq_sched_dispatch_requests+0x30/0x6c
>   blk_mq_run_hw_queue+0x14c/0x40c
>   blk_mq_run_hw_queues+0x64/0x124
>   blk_mq_requeue_work+0x188/0x1bc
>   process_one_work+0x20c/0x608
>   worker_thread+0x238/0x370
>   kthread+0x124/0x128
>   ret_from_fork+0x10/0x20
> Code: f9404282 79401c21 b9004a81 f94047e1 (f8206841)
> ---[ end trace 0000000000000000 ]---
> note: kworker/0:0H[9] exited with irqs disabled
> note: kworker/0:0H[9] exited with preempt_count 1
> 

OK I'll drop from next for now, pls try to debug
and repost.


> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 2351f411fa46..35a7a586f6f5 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -129,14 +129,6 @@ static inline blk_status_t virtblk_result(u8 status)
> >   	}
> >   }
> >   
> > -static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> > -{
> > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > -
> > -	return vq;
> > -}
> > -
> >   static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
> >   {
> >   	struct scatterlist out_hdr, in_hdr, *sgs[3];
> > @@ -377,8 +369,7 @@ static void virtblk_done(struct virtqueue *vq)
> >   
> >   static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >   {
> > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > +	struct virtio_blk_vq *vq = hctx->driver_data;
> >   	bool kick;
> >   
> >   	spin_lock_irq(&vq->lock);
> > @@ -428,10 +419,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >   			   const struct blk_mq_queue_data *bd)
> >   {
> >   	struct virtio_blk *vblk = hctx->queue->queuedata;
> > +	struct virtio_blk_vq *vq = hctx->driver_data;
> >   	struct request *req = bd->rq;
> >   	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> >   	unsigned long flags;
> > -	int qid = hctx->queue_num;
> >   	bool notify = false;
> >   	blk_status_t status;
> >   	int err;
> > @@ -440,26 +431,26 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >   	if (unlikely(status))
> >   		return status;
> >   
> > -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +	err = virtblk_add_req(vq->vq, vbr);
> >   	if (err) {
> > -		virtqueue_kick(vblk->vqs[qid].vq);
> > +		virtqueue_kick(vq->vq);
> >   		/* Don't stop the queue if -ENOMEM: we may have failed to
> >   		 * bounce the buffer due to global resource outage.
> >   		 */
> >   		if (err == -ENOSPC)
> >   			blk_mq_stop_hw_queue(hctx);
> > -		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > +		spin_unlock_irqrestore(&vq->lock, flags);
> >   		virtblk_unmap_data(req, vbr);
> >   		return virtblk_fail_to_queue(req, err);
> >   	}
> >   
> > -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> > +	if (bd->last && virtqueue_kick_prepare(vq->vq))
> >   		notify = true;
> > -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> >   
> >   	if (notify)
> > -		virtqueue_notify(vblk->vqs[qid].vq);
> > +		virtqueue_notify(vq->vq);
> >   	return BLK_STS_OK;
> >   }
> >   
> > @@ -504,7 +495,7 @@ static void virtio_queue_rqs(struct request **rqlist)
> >   	struct request *requeue_list = NULL;
> >   
> >   	rq_list_for_each_safe(rqlist, req, next) {
> > -		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> > +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> >   		bool kick;
> >   
> >   		if (!virtblk_prep_rq_batch(req)) {
> > @@ -1164,6 +1155,16 @@ static const struct attribute_group *virtblk_attr_groups[] = {
> >   	NULL,
> >   };
> >   
> > +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> > +		unsigned int hctx_idx)
> > +{
> > +	struct virtio_blk *vblk = data;
> > +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> > +
> > +	hctx->driver_data = vq;
> > +	return 0;
> > +}
> > +
> >   static void virtblk_map_queues(struct blk_mq_tag_set *set)
> >   {
> >   	struct virtio_blk *vblk = set->driver_data;
> > @@ -1205,7 +1206,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
> >   static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> >   {
> >   	struct virtio_blk *vblk = hctx->queue->queuedata;
> > -	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> > +	struct virtio_blk_vq *vq = hctx->driver_data;
> >   	struct virtblk_req *vbr;
> >   	unsigned long flags;
> >   	unsigned int len;
> > @@ -1236,6 +1237,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >   	.queue_rqs	= virtio_queue_rqs,
> >   	.commit_rqs	= virtio_commit_rqs,
> >   	.complete	= virtblk_request_done,
> > +	.init_hctx	= virtblk_init_hctx,
> >   	.map_queues	= virtblk_map_queues,
> >   	.poll		= virtblk_poll,
> >   };
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland

