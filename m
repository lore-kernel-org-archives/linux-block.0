Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF642049
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527029; cv=none; b=lgm3Ei2gCAhx0IjfrmxKSP0P1J0K7r1jMZWacj/wI4yu9eFQfRL31jDy5JKmW45OLyMy32bfDPbshYmhXH5wE2+Z1lQBa0ZoXm6B1GZwOsjyr15DQckD+GjP09zBimY7ieN1fU2UqrB1NPN/j0zIqIFOGSfRaFjh+NlXxEN9Wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527029; c=relaxed/simple;
	bh=BZ9i+8NFuXU0fBVBcm6x3id6zC3L8UmTGr1Y3AkXqYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PglzCd/BDiv9nN+3VaKkpJmOz9u8cSMFzPNq6Z6q/dp4z7CfPPHUCWdnJVEn9HBzsLIADa/7NpX8U22OErZUEFuKUw5kGWfnj0z4yU3dOHqfDZ2sJq3DXB+bgS3GPcwuESlSR25G4RdRDJ+JrfaCgPSW2F4AgTQ1G3Oua837kRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSvKw9Cz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSvKw9Cz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722527026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWV743yHfsk82BqsRtZjjsq6LNKVmyUam7MSPZXEE0Q=;
	b=BSvKw9CzSuDfT6JIMrJsHNjDZx4pL0AU0eaqJlzLh5SNzn7ckIHO2dLqjqSX0torxf1DA7
	f+FfEJ0Wb/+9+AZmshLvGBxnOC/tmvqdzlIgVHbrQSwn3jnHuraHphl06WNGFj/cJNHteN
	BxAM0rQ8S2mwZ0tN98tne+cA6NyM1Qk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-ZILBBou3PN64RJFYm71rLg-1; Thu, 01 Aug 2024 11:43:45 -0400
X-MC-Unique: ZILBBou3PN64RJFYm71rLg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5b77228abf9so507200a12.3
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2024 08:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527024; x=1723131824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWV743yHfsk82BqsRtZjjsq6LNKVmyUam7MSPZXEE0Q=;
        b=I/GGG5iSXmuX5iRX17v1hfgrR6wPnUmUk6PTkAS36vuRHrXzwhKEF5SmxcTYWrNRX7
         kCyvhnuGUGNi0vO9Q5UmOr2PsElZR1830V+IfQB7TFQkeMuIww400bfFD46SB7QHktnq
         0HQHEKS01z2g2SE6fxUsVebFsRF+5WAIG3AJCfYZKew6ou/iTqCvvcBSqWwN/VZe97WP
         eHHoQtMofbgt05uYu05g2hLH9j3KowV5Ev/6gMuCpKgisVAg7+PtqVcfL2YjMtiZe4uP
         nQPyYkb2X/E7UrXH/3tgeqxqTTZcPz//VLRAZXPIIILFC6OO1menAvpqRHEcB3iMCzxZ
         6h1g==
X-Forwarded-Encrypted: i=1; AJvYcCXi/LeYgUzzSE+fYA6HEWqbpuiOoAWbUtoJ7xLyp319225vbGDQx/VCIqEKhAkKtnSj9MW+2fqMCze93yASWsoUXaMljp85p9ShkQ8=
X-Gm-Message-State: AOJu0YxO5QQiD/6nDZh4jB7Md+H33+vBZ2YecZMv6MFVxkYdusig7WoP
	LTESZl/1NtdBuLdOvbq5NfkJDA+Ekk9m9ySZTnlwMESvzr8zPBG2U1y8MiUjVoo+Wmhjuykt7mh
	kHYcZ2umyKGymz7zdsaHTj+jVJNDuvvZqQ9M0m2GXAE8nvGcJ/qCMYCM0cLOi
X-Received: by 2002:a05:6402:342:b0:5b4:cd20:f13f with SMTP id 4fb4d7f45d1cf-5b7f57f389fmr522124a12.24.1722527023925;
        Thu, 01 Aug 2024 08:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQPAb7JM1Swn8BH2sf5k/RXr6KgjNrD61lJoSq+rGnQPUaMTWeOR8g08SqriQkmqjgCZcPFg==
X-Received: by 2002:a05:6402:342:b0:5b4:cd20:f13f with SMTP id 4fb4d7f45d1cf-5b7f57f389fmr522079a12.24.1722527023112;
        Thu, 01 Aug 2024 08:43:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c86sm10452882a12.42.2024.08.01.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:43:42 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:43:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: stefanha@redhat.com, virtualization@lists.linux.dev, axboe@kernel.dk,
	kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240801114205-mutt-send-email-mst@kernel.org>
References: <20240801151137.14430-1-mgurtovoy@nvidia.com>
 <20240801111337-mutt-send-email-mst@kernel.org>
 <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
 <20240801112843-mutt-send-email-mst@kernel.org>
 <9400fb28-47c2-4629-af17-df2a95f2d3d8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9400fb28-47c2-4629-af17-df2a95f2d3d8@nvidia.com>

On Thu, Aug 01, 2024 at 06:39:16PM +0300, Max Gurtovoy wrote:
> 
> On 01/08/2024 18:29, Michael S. Tsirkin wrote:
> > On Thu, Aug 01, 2024 at 06:17:21PM +0300, Max Gurtovoy wrote:
> > > On 01/08/2024 18:13, Michael S. Tsirkin wrote:
> > > > On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy wrote:
> > > > > In this operation set the driver data of the hctx to point to the virtio
> > > > > block queue. By doing so, we can use this reference in the and reduce
> > > > in the .... ?
> > > sorry for the type.
> > > 
> > > should be :
> > > 
> > > "By doing so, we can use this reference and reduce the number of operations in the fast path."
> > ok. what kind of benefit do you see with this patch?
> 
> As mentioned. This is a micro optimization that reduce the number of
> instructions/dereferences in the fast path.

By how much? How random code tweaks affect object code is unpredictable.
Pls show results of objdump to prove it does anything
useful.

> 
> > 
> > > > > the number of operations in the fast path.
> > > > > 
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > >    drivers/block/virtio_blk.c | 42 ++++++++++++++++++++------------------
> > > > >    1 file changed, 22 insertions(+), 20 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > index 2351f411fa46..35a7a586f6f5 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -129,14 +129,6 @@ static inline blk_status_t virtblk_result(u8 status)
> > > > >    	}
> > > > >    }
> > > > > -static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> > > > > -{
> > > > > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > > > -
> > > > > -	return vq;
> > > > > -}
> > > > > -
> > > > >    static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
> > > > >    {
> > > > >    	struct scatterlist out_hdr, in_hdr, *sgs[3];
> > > > > @@ -377,8 +369,7 @@ static void virtblk_done(struct virtqueue *vq)
> > > > >    static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > > > >    {
> > > > > -	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > > > > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > > > >    	bool kick;
> > > > >    	spin_lock_irq(&vq->lock);
> > > > > @@ -428,10 +419,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > > > >    			   const struct blk_mq_queue_data *bd)
> > > > >    {
> > > > >    	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > > > >    	struct request *req = bd->rq;
> > > > >    	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> > > > >    	unsigned long flags;
> > > > > -	int qid = hctx->queue_num;
> > > > >    	bool notify = false;
> > > > >    	blk_status_t status;
> > > > >    	int err;
> > > > > @@ -440,26 +431,26 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > > > >    	if (unlikely(status))
> > > > >    		return status;
> > > > > -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > > > -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > +	err = virtblk_add_req(vq->vq, vbr);
> > > > >    	if (err) {
> > > > > -		virtqueue_kick(vblk->vqs[qid].vq);
> > > > > +		virtqueue_kick(vq->vq);
> > > > >    		/* Don't stop the queue if -ENOMEM: we may have failed to
> > > > >    		 * bounce the buffer due to global resource outage.
> > > > >    		 */
> > > > >    		if (err == -ENOSPC)
> > > > >    			blk_mq_stop_hw_queue(hctx);
> > > > > -		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > > > > +		spin_unlock_irqrestore(&vq->lock, flags);
> > > > >    		virtblk_unmap_data(req, vbr);
> > > > >    		return virtblk_fail_to_queue(req, err);
> > > > >    	}
> > > > > -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> > > > > +	if (bd->last && virtqueue_kick_prepare(vq->vq))
> > > > >    		notify = true;
> > > > > -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > >    	if (notify)
> > > > > -		virtqueue_notify(vblk->vqs[qid].vq);
> > > > > +		virtqueue_notify(vq->vq);
> > > > >    	return BLK_STS_OK;
> > > > >    }
> > > > > @@ -504,7 +495,7 @@ static void virtio_queue_rqs(struct request **rqlist)
> > > > >    	struct request *requeue_list = NULL;
> > > > >    	rq_list_for_each_safe(rqlist, req, next) {
> > > > > -		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> > > > > +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > > > >    		bool kick;
> > > > >    		if (!virtblk_prep_rq_batch(req)) {
> > > > > @@ -1164,6 +1155,16 @@ static const struct attribute_group *virtblk_attr_groups[] = {
> > > > >    	NULL,
> > > > >    };
> > > > > +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> > > > > +		unsigned int hctx_idx)
> > > > > +{
> > > > > +	struct virtio_blk *vblk = data;
> > > > > +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> > > > > +
> > > > > +	hctx->driver_data = vq;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >    static void virtblk_map_queues(struct blk_mq_tag_set *set)
> > > > >    {
> > > > >    	struct virtio_blk *vblk = set->driver_data;
> > > > > @@ -1205,7 +1206,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
> > > > >    static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> > > > >    {
> > > > >    	struct virtio_blk *vblk = hctx->queue->queuedata;
> > > > > -	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> > > > > +	struct virtio_blk_vq *vq = hctx->driver_data;
> > > > >    	struct virtblk_req *vbr;
> > > > >    	unsigned long flags;
> > > > >    	unsigned int len;
> > > > > @@ -1236,6 +1237,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
> > > > >    	.queue_rqs	= virtio_queue_rqs,
> > > > >    	.commit_rqs	= virtio_commit_rqs,
> > > > >    	.complete	= virtblk_request_done,
> > > > > +	.init_hctx	= virtblk_init_hctx,
> > > > >    	.map_queues	= virtblk_map_queues,
> > > > >    	.poll		= virtblk_poll,
> > > > >    };
> > > > > -- 
> > > > > 2.18.1

