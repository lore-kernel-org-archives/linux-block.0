Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E2A2D
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729127786; cv=none; b=DbLobi5CXrfHoXW/ScFreOQApNIoSKpLJ52zXGqjWp2mWGgntxCNXIiiCaA2cq6Pj0CSHZt4C5ZxMk1aJ7xYUo8dCZzvzhTgLcumlEk79YFJ+JjB4X44/3EAApkMmeA1GZx2H4TWleKWZ11r2IyZ4gQLD+PxP6k2f/SAMO1LfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729127786; c=relaxed/simple;
	bh=ZEBoGtesNYnAEoX9XWxR8j9uFns+YQYyMkECW9cuKE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIYIgWssraxdRf3VDIMpNDSZOznImzeqFpT+iKHbTqWd0d23nBS5uFvWyIR9bFhXHNAWBy1vzyJ68usYnhClbw/OPywaukxe+s+iMNmL6r+Q19vPyOzbhfweQeZNrYxBLmA3XNnt7SoBr9q7M/2dhZRXvdxm8wTN79MDCOhTSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhXUUJSo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhXUUJSo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729127782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04/zFF68XVVU/AKo0obm1oju/P6UD8HalmEqeh3udI8=;
	b=XhXUUJSoR/EyZTZRw2SN2T9kG8o1AkFD3PQl/qrZyp+fKyQFyOTCNYE5IguJc1GA1XvX1m
	H8JotjpQKWAxzuziqQoN35jqTH/vtbssCoiOtYpf3/5Mi4GtIk8QmU3sNekF2tgqWIMQk9
	cunJP+DhK2rNFyd4PPaWB0ZPVKCrpcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-VOBTIoXUO4CZAMjXnCTRvA-1; Wed,
 16 Oct 2024 21:16:19 -0400
X-MC-Unique: VOBTIoXUO4CZAMjXnCTRvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED31C19560B8;
	Thu, 17 Oct 2024 01:16:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFAB019560A2;
	Thu, 17 Oct 2024 01:16:12 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:16:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	nbd@other.debian.org, eblake@redhat.com, leon@is.currently.online
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
Message-ID: <ZxBlV_qZ54S3sFum@fedora>
References: <Zw5CNDIde6xkq_Sf@redhat.com>
 <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
 <Zw5b1mwk3aG01NTg@fedora>
 <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
 <Zw5nMQoPrSIq9axl@fedora>
 <Zw6S6RoKWzUnNVpu@redhat.com>
 <Zw8i6-DVDsLk3sq9@fedora>
 <Zw_xHyXkl9eUftst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw_xHyXkl9eUftst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Oct 16, 2024 at 07:00:15PM +0200, Kevin Wolf wrote:
> Am 16.10.2024 um 04:20 hat Ming Lei geschrieben:
> > On Tue, Oct 15, 2024 at 06:06:01PM +0200, Kevin Wolf wrote:
> > > Am 15.10.2024 um 14:59 hat Ming Lei geschrieben:
> > > > On Tue, Oct 15, 2024 at 08:15:17PM +0800, Ming Lei wrote:
> > > > > On Tue, Oct 15, 2024 at 8:11 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 15, 2024 at 08:01:43PM +0800, Ming Lei wrote:
> > > > > > > On Tue, Oct 15, 2024 at 6:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > the other day I was running some benchmarks to compare different QEMU
> > > > > > > > block exports, and one of the scenarios I was interested in was
> > > > > > > > exporting NBD from qemu-storage-daemon over a unix socket and attaching
> > > > > > > > it as a block device using the kernel NBD client. I would then run a VM
> > > > > > > > on top of it and fio inside of it.
> > > > > > > >
> > > > > > > > Unfortunately, I couldn't get any numbers because the connection always
> > > > > > > > aborted with messages like "Double reply on req ..." or "Unexpected
> > > > > > > > reply ..." in the host kernel log.
> > > > > > > >
> > > > > > > > Yesterday I found some time to have a closer look why this is happening,
> > > > > > > > and I think I have a rough understanding of what's going on now. Look at
> > > > > > > > these trace events:
> > > > > > > >
> > > > > > > >         qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005a
> > > > > > > > [...]
> > > > > > > >         qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005d
> > > > > > > > [...]
> > > > > > > >    kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_received: nbd transport event: request 00000000b79e7443, handle 0x0000150c0000005a
> > > > > > > >
> > > > > > > > This is the same request, but the handle has changed between
> > > > > > > > nbd_header_sent and nbd_payload_sent! I think this means that we hit one
> > > > > > > > of the cases where the request is requeued, and then the next time it
> > > > > > > > is executed with a different blk-mq tag, which is something the nbd
> > > > > > > > driver doesn't seem to expect.
> > > > > > > >
> > > > > > > > Of course, since the cookie is transmitted in the header, the server
> > > > > > > > replies with the original handle that contains the tag from the first
> > > > > > > > call, while the kernel is only waiting for a handle with the new tag and
> > > > > > > > is confused by the server response.
> > > > > > > >
> > > > > > > > I'm not sure yet which of the following options should be considered the
> > > > > > > > real problem here, so I'm only describing the situation without trying
> > > > > > > > to provide a patch:
> > > > > > > >
> > > > > > > > 1. Is it that blk-mq should always re-run the request with the same tag?
> > > > > > > >    I don't expect so, though in practice I was surprised to see that it
> > > > > > > >    happens quite often after nbd requeues a request that it actually
> > > > > > > >    does end up with the same cookie again.
> > > > > > >
> > > > > > > No.
> > > > > > >
> > > > > > > request->tag will change, but we may take ->internal_tag(sched) or
> > > > > > > ->tag(none), which won't change.
> > > > > > >
> > > > > > > I guess was_interrupted() in nbd_send_cmd() is triggered, then the payload
> > > > > > > is sent with a different tag.
> > > > > > >
> > > > > > > I will try to cook one patch soon.
> > > > > >
> > > > > > Please try the following patch:
> > > > > 
> > > > > Oops, please ignore the patch, it can't work since
> > > > > nbd_handle_reply() doesn't know static tag.
> > > > 
> > > > Please try the v2:
> > > 
> > > It doesn't fully work, though it replaced the bug with a different one.
> > > Now I get "Unexpected request" for the final flush request.
> > 
> > That just shows the approach is working.
> > 
> > Flush request doesn't have static tag, that is why it is failed.
> > It shouldn't be hard to cover it, please try the attached & revised
> > patch.
> 
> Any other request types that are unusual, or is flush the only one?

Flush is the only one.

> 
> > Another solution is to add per-nbd-device map for retrieving nbd_cmd
> > by the stored `index` in cookie, and the cost is one such array for
> > each device.
> 
> Yes, just creating the cookie another way and having an explicit mapping
> back is the obvious naive solution (my option 2). It would be nice to
> avoid this.
> 
> > > 
> > > Anyway, before talking about specific patches, would this even be the
> > > right solution or would it only paper over a bigger issue?
> > > 
> > > Is getting a different tag the only thing that can go wrong if you
> > > handle a request partially and then requeue it?
> > 
> > Strictly speaking it is BLK_STS_RESOURCE.
> > 
> > Not like userspace implementation, kernel nbd call one sock_sendmsg()
> > for sending either request header, or each single data bvec, so
> > partial xmit can't be avoided. This kind of handling is fine, given
> > TCP is just byte stream, nothing difference is observed from nbd
> > server side if data is correct.
> 
> I wasn't questioning the partial submission, but only if it's a good
> idea to return the request to the queue in this case, or if the nbd
> driver should use another mechanism to keep working on the request
> without returning it. But if this is accepted and a common pattern in
> other drivers, too (is it?), I don't have a problem with it.

It is one common pattern to retrieve request with tag in many storage
drivers(scsi, nvme, ...), also it should be the only way.

But userspace implementation needn't it, with async/.await the io
request or whatever can be defined as one local variable.

> 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 2cafcf11ee8b..3cc14fc76546 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -682,3 +682,51 @@ u32 blk_mq_unique_tag(struct request *rq)
> >  		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
> >  }
> >  EXPORT_SYMBOL(blk_mq_unique_tag);
> > +
> > +/* Same with blk_mq_unique_tag, but one persistent tag is included */
> > +u32 blk_mq_unique_static_tag(struct request *rq)
> > +{
> > +	bool use_sched = rq->q->elevator;
> > +	u32 tag;
> > +
> > +	if (rq == rq->mq_hctx->fq->flush_rq) {
> > +		if (use_sched)
> > +			tag = rq->mq_hctx->sched_tags->nr_tags;
> > +		else
> > +			tag = rq->mq_hctx->tags->nr_tags;
> > +	} else {
> > +		tag = use_sched ? rq->internal_tag : rq->tag;
> > +	}
> > +
> > +	return (rq->mq_hctx->queue_num << BLK_MQ_UNIQUE_TAG_BITS) |
> > +		(tag & BLK_MQ_UNIQUE_TAG_MASK);
> > +}
> > +EXPORT_SYMBOL(blk_mq_unique_static_tag);
> > +
> > +static struct request *
> > +__blk_mq_static_tag_to_rq(const struct blk_mq_hw_ctx *hctx,
> > +		const struct blk_mq_tags *tags, u32 tag)
> > +{
> > +	if (tag < tags->nr_tags)
> > +		return tags->static_rqs[tag];
> > +	else if (tag == tags->nr_tags)
> > +		return hctx->fq->flush_rq;
> > +	else
> > +		return NULL;
> > +}
> 
> There is probably little reason to have this as a separate function. It
> will be more readable if you inline it and make tags just a local
> variable in blk_mq_static_tag_to_req().

Looks doable.

> 
> > +struct request *blk_mq_static_tag_to_req(struct request_queue *q, u32 uniq_tag)
> > +{
> > +	unsigned long hwq = blk_mq_unique_tag_to_hwq(uniq_tag);
> > +	u32 tag = blk_mq_unique_tag_to_tag(uniq_tag);
> > +	const struct blk_mq_hw_ctx *hctx= xa_load(&q->hctx_table, hwq);
> > +
> > +	if (!hctx)
> > +		return NULL;
> > +
> > +	if (q->elevator)
> > +		return __blk_mq_static_tag_to_rq(hctx, hctx->sched_tags, tag);
> > +
> > +	return __blk_mq_static_tag_to_rq(hctx, hctx->tags, tag);
> > +}
> > +EXPORT_SYMBOL(blk_mq_static_tag_to_req);
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index b852050d8a96..5be324233c9f 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -201,7 +201,7 @@ static void nbd_requeue_cmd(struct nbd_cmd *cmd)
> >  static u64 nbd_cmd_handle(struct nbd_cmd *cmd)
> >  {
> >  	struct request *req = blk_mq_rq_from_pdu(cmd);
> > -	u32 tag = blk_mq_unique_tag(req);
> > +	u32 tag = blk_mq_unique_static_tag(req);
> >  	u64 cookie = cmd->cmd_cookie;
> >  
> >  	return (cookie << NBD_COOKIE_BITS) | tag;
> > @@ -818,10 +818,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
> >  
> >  	handle = be64_to_cpu(reply->cookie);
> >  	tag = nbd_handle_to_tag(handle);
> > -	hwq = blk_mq_unique_tag_to_hwq(tag);
> 
> hwq is now unused and can be removed.

OK, will kill it.

> 
> > -	if (hwq < nbd->tag_set.nr_hw_queues)
> > -		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
> > -				       blk_mq_unique_tag_to_tag(tag));
> > +	req = blk_mq_static_tag_to_req(nbd->disk->queue, tag);
> >  	if (!req || !blk_mq_request_started(req)) {
> >  		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
> >  			tag, req);
> 
> This version of the patch survives the reproducer I used for debugging
> this. I'll try to give it some more testing later.

Ok, thanks for the test.


Thanks,
Ming

