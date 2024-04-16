Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBD12BE8C
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272072; cv=none; b=PKn6y0B1uj93cyVX/x6NYg67AwX8y99piP1FdI9qgV8ePH0w0HJt+CoIIvt9/f0S1apFxpIMqg3q8IaphrR863iCAU3wtjuPmb0z3wOBfVvRiTItiuKA1582nHhzntRevpsy/OKrmmAyksMoZ6QGaHt2S0HC03U8gv2QAfxNsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272072; c=relaxed/simple;
	bh=P3+qmlas8fRVjT1ZmH+9rJgwqzqy31uPS0jgPc1ERjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn3sA+tgoqEsEALqADX1smORuk2KbGH3joky+1mvEK+ZDX143pxAhdzkN84nX1983i/KoU24DbglQKCBlXRLppKzNhoYNv+5ChF9R0fxAOXpwJMbIWPPmqxzp+TuZdNPLGdeCUFeim7gP+oFouidgJra6kb9272D6UbPrkTHoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTrh3j9R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTrh3j9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713272069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5emBDxDcIXVH+QDC5DWTgQCpfaPiPmM6GJyZQ63+mJY=;
	b=LTrh3j9RSB/beqf4aBDwESb3RG+8N22Lm9O46UJTFo2+YM28URkMMMRhU75Pww74H/nilW
	3rq/i0FPAG8DX6MkthCKZ7rw6vOZQQO3rT8eeLBql4LcVjOk2iAoa0rWLEIkvRSpaGZBEf
	2u3O9ylwzU+2wRj7y8V1rcCJudiQMUE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-ErP0xVc9MqKFgrP3fXzHvw-1; Tue,
 16 Apr 2024 08:54:26 -0400
X-MC-Unique: ErP0xVc9MqKFgrP3fXzHvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B35FA1C54460;
	Tue, 16 Apr 2024 12:54:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B18240C6CB2;
	Tue, 16 Apr 2024 12:54:23 +0000 (UTC)
Date: Tue, 16 Apr 2024 20:53:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Changhui Zhong <czhong@redhat.com>,
	Linux Block Devices <linux-block@vger.kernel.org>
Subject: Re: [bug report] WARNING: CPU: 5 PID: 679 at
 io_uring/io_uring.c:2835 io_ring_exit_work+0x2b6/0x2e0
Message-ID: <Zh505790/oufXqMn@fedora>
References: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
 <06b1c052-cbd4-4b8c-bc58-175fe6d41d72@kernel.dk>
 <Zh3TjqD1763LzXUj@fedora>
 <CAGVVp+X81FhOHH0E3BwcsVBYsAAOoAPXpTX5D_BbRH4jqjeTJg@mail.gmail.com>
 <Zh5MSQVk54tN7Xx4@fedora>
 <28cc0bbb-fa85-48f1-9c8a-38d7ecf6c67e@kernel.dk>
 <6db8b3eb-9e66-4df2-bde1-c5c7dde74b3b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db8b3eb-9e66-4df2-bde1-c5c7dde74b3b@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Apr 16, 2024 at 06:35:14AM -0600, Jens Axboe wrote:
> On 4/16/24 5:38 AM, Jens Axboe wrote:
> > On 4/16/24 4:00 AM, Ming Lei wrote:
> >> On Tue, Apr 16, 2024 at 10:26:16AM +0800, Changhui Zhong wrote:
> >>>>>
> >>>>> I can't reproduce this here, fwiw. Ming, something you've seen?
> >>>>
> >>>> I just test against the latest for-next/block(-rc4 based), and still can't
> >>>> reproduce it. There was such RH internal report before, and maybe not
> >>>> ublk related.
> >>>>
> >>>> Changhui, if the issue can be reproduced in your machine, care to share
> >>>> your machine for me to investigate a bit?
> >>>>
> >>>> Thanks,
> >>>> Ming
> >>>>
> >>>
> >>> I still can reproduce this issue on my machine?
> >>> and I shared machine to Ming?he can do more investigation for this issue?
> >>>
> >>> [ 1244.207092] running generic/006
> >>> [ 1246.456896] blk_print_req_error: 77 callbacks suppressed
> >>> [ 1246.456907] I/O error, dev ublkb1, sector 2395864 op 0x1:(WRITE)
> >>> flags 0x8800 phys_seg 1 prio class 0
> >>
> >> The failure is actually triggered in recovering qcow2 target in generic/005,
> >> since ublkb0 isn't removed successfully in generic/005.
> >>
> >> git-bisect shows that the 1st bad commit is cca6571381a0 ("io_uring/rw:
> >> cleanup retry path").
> >>
> >> And not see any issue in uring command side, so the trouble seems
> >> in normal io_uring rw side over XFS file, and not related with block
> >> device.
> > 
> > Indeed, I can reproduce it on XFS as well. I'll take a look.
> 
> Can you try this one?
> 
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 3c9087f37c43..c67ae6e36c4f 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -527,6 +527,19 @@ static void io_queue_iowq(struct io_kiocb *req)
>  		io_queue_linked_timeout(link);
>  }
>  
> +static void io_tw_requeue_iowq(struct io_kiocb *req, struct io_tw_state *ts)
> +{
> +	req->flags &= ~REQ_F_REISSUE;
> +	io_queue_iowq(req);
> +}
> +
> +void io_tw_queue_iowq(struct io_kiocb *req)
> +{
> +	req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
> +	req->io_task_work.func = io_tw_requeue_iowq;
> +	io_req_task_work_add(req);
> +}
> +
>  static __cold void io_queue_deferred(struct io_ring_ctx *ctx)
>  {
>  	while (!list_empty(&ctx->defer_list)) {
> diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
> index 624ca9076a50..b83a719c5443 100644
> --- a/io_uring/io_uring.h
> +++ b/io_uring/io_uring.h
> @@ -75,6 +75,7 @@ struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
>  void __io_req_task_work_add(struct io_kiocb *req, unsigned flags);
>  bool io_alloc_async_data(struct io_kiocb *req);
>  void io_req_task_queue(struct io_kiocb *req);
> +void io_tw_queue_iowq(struct io_kiocb *req);
>  void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts);
>  void io_req_task_queue_fail(struct io_kiocb *req, int ret);
>  void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts);
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 3134a6ece1be..4fed829fe97c 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -455,7 +455,7 @@ static bool __io_complete_rw_common(struct io_kiocb *req, long res)
>  			 * current cycle.
>  			 */
>  			io_req_io_end(req);
> -			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
> +			io_tw_queue_iowq(req);
>  			return true;
>  		}
>  		req_set_fail(req);
> @@ -521,7 +521,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
>  		io_req_end_write(req);
>  	if (unlikely(res != req->cqe.res)) {
>  		if (res == -EAGAIN && io_rw_should_reissue(req)) {
> -			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
> +			io_tw_queue_iowq(req);
>  			return;
>  		}
>  		req->cqe.res = res;
> @@ -839,7 +839,8 @@ static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
>  	ret = io_iter_do_read(rw, &io->iter);
>  
>  	if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
> -		req->flags &= ~REQ_F_REISSUE;
> +		if (req->flags & REQ_F_REISSUE)
> +			return IOU_ISSUE_SKIP_COMPLETE;
>  		/* If we can poll, just do that. */
>  		if (io_file_can_poll(req))
>  			return -EAGAIN;
> @@ -1034,10 +1035,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
>  	else
>  		ret2 = -EINVAL;
>  
> -	if (req->flags & REQ_F_REISSUE) {
> -		req->flags &= ~REQ_F_REISSUE;
> -		ret2 = -EAGAIN;
> -	}
> +	if (req->flags & REQ_F_REISSUE)
> +		return IOU_ISSUE_SKIP_COMPLETE;
>  
>  	/*
>  	 * Raw bdev writes will return -EOPNOTSUPP for IOCB_NOWAIT. Just
> 

With above patch against for-next of block tree, ublksrv 'make test T=generic/005'
can pass now, please feel free to add:

Tested-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

