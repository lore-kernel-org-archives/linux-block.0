Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2642F3E
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747874571; cv=none; b=JZZ3T7do164gSReaIff0+kv3+9XPhYy6fQiXx+ORISynjdx9rc/l5s5O3T3+sdA2T/2cABierMOfzyxvkFSg6FWovsOhJf9K9fi3sezfwpq8yCYER0B7NcNDjsh2JQ1SnE9LkhsjQdRh4RiQtZ636OYi5oT+eV4hctd1ilVtWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747874571; c=relaxed/simple;
	bh=zH52IWYTLY5aqvf+9YdYMp/fhhTmdgK/Gy/R5eWd7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWaCM1T8BtTOzBBIUf8e8tagP7+JN36HgBcMwmh7+iErSIx/XFB3ZUA4xMVmjBMPfqtPFyovjnfksYI42358bIlC8f4tshcrvUdT/Antnblpf/JrDE7G/UudwLpRsj/friTf7XF2Ipjnyufa26PcBsBTWFQ0NRBh40/ZGnvVWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdCUXWTP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdCUXWTP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747874567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPyvzXW9V6KDvCqj6P0ysG4H/HA2c9ZB0yWATfvWb9I=;
	b=hdCUXWTPNKqfyL/6dFigZvOxsb22pOiYYZf47/DKe9FEq3myJXr/Fu4dz9DtDpjWd4mtTN
	AgDAZR5EJCzIDglZmjwDeFqUSoLHW9GUMmPUJzJYgOLPrXtx905lufbmAKaInIVld6Ne5l
	WQxaXJNCDASZmOgenCl+wKl5zs1Yh60=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-TdQ91-jGO3-cCmv3_O9Hnw-1; Wed,
 21 May 2025 20:42:46 -0400
X-MC-Unique: TdQ91-jGO3-cCmv3_O9Hnw-1
X-Mimecast-MFC-AGG-ID: TdQ91-jGO3-cCmv3_O9Hnw_1747874565
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DA281956080;
	Thu, 22 May 2025 00:42:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B629195608F;
	Thu, 22 May 2025 00:42:41 +0000 (UTC)
Date: Thu, 22 May 2025 08:42:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 2/2] ublk: run auto buf unregisgering in same io_ring_ctx
 with register
Message-ID: <aC5y_FVe4KQoIsJo@fedora>
References: <20250521025502.71041-1-ming.lei@redhat.com>
 <20250521025502.71041-3-ming.lei@redhat.com>
 <CADUfDZrh+FYHgPjmF1=RRQiZFx=uYZEBJ+mJGsX-C9jM5dVi9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrh+FYHgPjmF1=RRQiZFx=uYZEBJ+mJGsX-C9jM5dVi9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, May 21, 2025 at 08:58:20AM -0700, Caleb Sander Mateos wrote:
> On Tue, May 20, 2025 at 7:55 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > UBLK_F_AUTO_BUF_REG requires that the buffer registered automatically
> > is unregistered in same `io_ring_ctx`, so check it explicitly.
> >
> > Meantime return the failure code if io_buffer_unregister_bvec() fails,
> > then ublk server can handle the failure in consistent way.
> >
> > Also force to clear UBLK_IO_FLAG_AUTO_BUF_REG in ublk_io_release()
> > because ublk_io_release() may be triggered not from handling
> > UBLK_IO_COMMIT_AND_FETCH_REQ, and from releasing the `io_ring_ctx`
> > for registering the buffer.
> >
> > Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG")
> > Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 35 +++++++++++++++++++++++++++++++----
> >  include/uapi/linux/ublk_cmd.h |  3 ++-
> >  2 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index fcf568b89370..2af6422d6a89 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -84,6 +84,7 @@ struct ublk_rq_data {
> >
> >         /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
> >         u16 buf_index;
> > +       unsigned long buf_ctx_id;
> >  };
> >
> >  struct ublk_uring_cmd_pdu {
> > @@ -1192,6 +1193,11 @@ static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_io *io)
> >         refcount_set(&data->ref, 1);
> >  }
> >
> > +static unsigned long ublk_uring_cmd_ctx_id(struct io_uring_cmd *cmd)
> > +{
> > +       return (unsigned long)(cmd_to_io_kiocb(cmd)->ctx);
> 
> Is the fact that a struct io_uring_cmd * can be passed to
> cmd_to_io_kiocb() an io_uring internal implementation detail? Maybe it
> would be good to add a helper in include/linux/io_uring/cmd.h so ublk
> isn't depending on io_uring internals.

All this definition is defined in kernel public header, not sure if it is
big deal to add the helper, especially there is just single user.

But I will do it.

> 
> Also, storing buf_ctx_id as a void * instead would allow this cast to
> be avoided, but not a big deal.
> 
> > +}
> > +
> >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> >                               unsigned int issue_flags)
> >  {
> > @@ -1211,6 +1217,8 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> >         }
> >         /* one extra reference is dropped by ublk_io_release */
> >         refcount_set(&data->ref, 2);
> > +
> > +       data->buf_ctx_id = ublk_uring_cmd_ctx_id(io->cmd);
> >         /* store buffer index in request payload */
> >         data->buf_index = pdu->buf.index;
> >         io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
> > @@ -1994,6 +2002,21 @@ static void ublk_io_release(void *priv)
> >  {
> >         struct request *rq = priv;
> >         struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > +       struct ublk_io *io = &ubq->ios[rq->tag];
> > +
> > +       /*
> > +        * In case of UBLK_F_AUTO_BUF_REG, the `io_uring_ctx` for registering
> > +        * this buffer may be released, so we reach here not from handling
> > +        * `UBLK_IO_COMMIT_AND_FETCH_REQ`.
> 
> What do you mean by this? That the io_uring was closed while a ublk
> I/O owned by the server still had a registered buffer?

The buffer is registered to `io_ring_ctx A`, which is closed and the buffer
is used up and un-registered on `io_ring_ctx A`, so this callback is
triggered, but the io command isn't completed yet, which can be run from
`io_ring_ctx B`

> 
> > +        *
> > +        * Force to clear UBLK_IO_FLAG_AUTO_BUF_REG, so that ublk server
> > +        * still may complete this IO request by issuing uring_cmd from
> > +        * another `io_uring_ctx` in case that the `io_ring_ctx` for
> > +        * registering the buffer is gone
> > +        */
> > +       if (ublk_support_auto_buf_reg(ubq) &&
> > +                       (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG))
> > +               io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
> 
> This is racy, since ublk_io_release() can be called on a thread other
> than the ubq_daemon.

Yeah, it can be true.

> Could we avoid touching io->flags here and
> instead have ublk_commit_and_fetch() check whether the reference count
> is already 1?

It is still a little racy because the buffer unregister from another thread
can happen just after the check immediately.

Adding one spinlock should cover it.

And it shouldn't be one big thing, because anyway the buffer can only be
released once.

> 
> Also, the ublk_support_auto_buf_reg(ubq) check seems redundant, since
> UBLK_IO_FLAG_AUTO_BUF_REG is set in ublk_auto_buf_reg(), which is only
> called if ublk_support_auto_buf_reg(ubq).

It has document benefit at least, so I'd suggest to keep it.


Thanks
Ming

