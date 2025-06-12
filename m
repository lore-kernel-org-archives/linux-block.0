Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A318BC3D
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702355; cv=none; b=g+DMHQXzKz9kYAPLWpzmCY7MYTWhaiX+KNeJDqYZH1/aKQMZwuk2Iaw7KiI0JmxzVxErtW5lzCJsyQ/9ZAbAJ9QFTnTcn09OUz8kZYz8YRtmzvps/38uQvQqu5LaIvigxtHPJycSPFOLByNEcX0cnSHtP4w0j44j1pFFe8zcnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702355; c=relaxed/simple;
	bh=fG+1Q/BvwL0HJYeoFfqeLkElPZ4aSmr5fSQr7xw3hO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9VrBCqetpaQvcj/26lAqNTMCT8IxVg9qZYEAqqpqr12DB9twwLb6fWy8BSCf7j4gu+NkYmOOoTKBgS8CVEzTHtPv6zsZQklRWs88FC1bKMoEQ8+3zHTDRJGjb1CB36AgB0110CmWapQKIGqGtas4OI2psETKlKPqq2wnPNwZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKMIx38O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKMIx38O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749702351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Osrp06+lg+9Vr9GhYHyBJIMRZ4584eRhuJgsw96QW60=;
	b=aKMIx38OEB79/9g6Sz3B1spxCCBhVY6SXxalMC2VjaYvTckkflnjTIgRAXxQpEnm0fTkif
	o1Lr5sz77GCq5bHecGtEI9VO1jgzhIVqymgERvSTlFbAn291BFnfPSRunBCMRDKyydWtsO
	aKYGj331IZiU21DGGBdtYGYHBiSQ7Nk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-xOpfVHE2PwuDXbj0LV7tmQ-1; Thu,
 12 Jun 2025 00:25:46 -0400
X-MC-Unique: xOpfVHE2PwuDXbj0LV7tmQ-1
X-Mimecast-MFC-AGG-ID: xOpfVHE2PwuDXbj0LV7tmQ_1749702345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62AA01956089;
	Thu, 12 Jun 2025 04:25:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B5DC18003FC;
	Thu, 12 Jun 2025 04:25:42 +0000 (UTC)
Date: Thu, 12 Jun 2025 12:25:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
Message-ID: <aEpWwUBH_7UavIwc@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-8-csander@purestorage.com>
 <aEajMYnOJ2h82A1-@fedora>
 <CADUfDZpUwCDXGOfo4RGzqre4AC_nR2jkYwQETbD7jLPwP5cVow@mail.gmail.com>
 <aEeI1LoMQKgatFuk@fedora>
 <CADUfDZp20khCoF7r8BFO4RC66cSz4jUcL9LbVjf1wpYj8scLTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp20khCoF7r8BFO4RC66cSz4jUcL9LbVjf1wpYj8scLTQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jun 11, 2025 at 08:36:43AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 9, 2025 at 6:22 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jun 09, 2025 at 10:14:21AM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Jun 9, 2025 at 2:02 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Fri, Jun 06, 2025 at 03:40:10PM -0600, Caleb Sander Mateos wrote:
> > > > > ublk_register_io_buf() performs an expensive atomic refcount increment,
> > > > > as well as a lot of pointer chasing to look up the struct request.
> > > > >
> > > > > Create a separate ublk_daemon_register_io_buf() for the daemon task to
> > > > > call. Initialize ublk_rq_data's reference count to a large number, count
> > > > > the number of buffers registered on the daemon task nonatomically, and
> > > > > atomically subtract the large number minus the number of registered
> > > > > buffers in ublk_commit_and_fetch().
> > > > >
> > > > > Also obtain the struct request directly from ublk_io's req field instead
> > > > > of looking it up on the tagset.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c | 59 ++++++++++++++++++++++++++++++++++------
> > > > >  1 file changed, 50 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 2084bbdd2cbb..ec9e0fd21b0e 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -81,12 +81,20 @@
> > > > >  #define UBLK_PARAM_TYPE_ALL                                \
> > > > >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > > > >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > > >        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > > >
> > > > > +/*
> > > > > + * Initialize refcount to a large number to include any registered buffers.
> > > > > + * UBLK_IO_COMMIT_AND_FETCH_REQ will release these references minus those for
> > > > > + * any buffers registered on the io daemon task.
> > > > > + */
> > > > > +#define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> > > > > +
> > > > >  struct ublk_rq_data {
> > > > >       refcount_t ref;
> > > > > +     unsigned buffers_registered;
> > > > >
> > > > >       /* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
> > > > >       u16 buf_index;
> > > > >       void *buf_ctx_handle;
> > > > >  };
> > > > > @@ -677,11 +685,12 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> > > > >               struct request *req)
> > > > >  {
> > > > >       if (ublk_need_req_ref(ubq)) {
> > > > >               struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > > > >
> > > > > -             refcount_set(&data->ref, 1);
> > > > > +             refcount_set(&data->ref, UBLK_REFCOUNT_INIT);
> > > > > +             data->buffers_registered = 0;
> > > > >       }
> > > > >  }
> > > > >
> > > > >  static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
> > > > >               struct request *req)
> > > > > @@ -706,10 +715,19 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
> > > > >       } else {
> > > > >               __ublk_complete_rq(req);
> > > > >       }
> > > > >  }
> > > > >
> > > > > +static inline void ublk_sub_req_ref(struct request *req)
> > > > > +{
> > > > > +     struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > > > > +     unsigned sub_refs = UBLK_REFCOUNT_INIT - data->buffers_registered;
> > > > > +
> > > > > +     if (refcount_sub_and_test(sub_refs, &data->ref))
> > > > > +             __ublk_complete_rq(req);
> > > > > +}
> > > > > +
> > > > >  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> > > > >  {
> > > > >       return ubq->flags & UBLK_F_NEED_GET_DATA;
> > > > >  }
> > > > >
> > > > > @@ -1184,14 +1202,12 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> > > > >
> > > > >  static void ublk_auto_buf_reg_fallback(struct request *req)
> > > > >  {
> > > > >       const struct ublk_queue *ubq = req->mq_hctx->driver_data;
> > > > >       struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
> > > > > -     struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > > > >
> > > > >       iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
> > > > > -     refcount_set(&data->ref, 1);
> > > > >  }
> > > > >
> > > > >  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> > > > >                             unsigned int issue_flags)
> > > > >  {
> > > > > @@ -1207,13 +1223,12 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> > > > >                       return true;
> > > > >               }
> > > > >               blk_mq_end_request(req, BLK_STS_IOERR);
> > > > >               return false;
> > > > >       }
> > > > > -     /* one extra reference is dropped by ublk_io_release */
> > > > > -     refcount_set(&data->ref, 2);
> > > > >
> > > > > +     data->buffers_registered = 1;
> > > > >       data->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
> > > > >       /* store buffer index in request payload */
> > > > >       data->buf_index = pdu->buf.index;
> > > > >       io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
> > > > >       return true;
> > > > > @@ -1221,14 +1236,14 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
> > > > >
> > > > >  static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
> > > > >                                  struct request *req, struct ublk_io *io,
> > > > >                                  unsigned int issue_flags)
> > > > >  {
> > > > > +     ublk_init_req_ref(ubq, req);
> > > > >       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > > > >               return ublk_auto_buf_reg(req, io, issue_flags);
> > > > >
> > > > > -     ublk_init_req_ref(ubq, req);
> > > > >       return true;
> > > > >  }
> > > > >
> > > > >  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
> > > > >                         struct ublk_io *io)
> > > > > @@ -2019,10 +2034,31 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > > > >       }
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static int ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
> > > > > +                                    const struct ublk_queue *ubq,
> > > > > +                                    const struct ublk_io *io,
> > > > > +                                    unsigned index, unsigned issue_flags)
> > > > > +{
> > > > > +     struct request *req = io->req;
> > > > > +     struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > > > > +     int ret;
> > > > > +
> > > > > +     if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
> > > > > +                                   issue_flags);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     data->buffers_registered++;
> > > >
> > > > This optimization replaces one ublk_get_req_ref()/refcount_inc_not_zero()
> > > > with data->buffers_registered++ in case of registering io buffer from
> > > > daemon context.
> > > >
> > > > And in typical implementation, the unregistering io buffer should be done
> > > > in daemon context too, then I am wondering if any user-visible improvement
> > > > can be observed in this more complicated & fragile way:
> > >
> > > Yes, generally I would expect the unregister to happen on the daemon
> > > task too. But it's possible (with patch "ublk: allow
> > > UBLK_IO_(UN)REGISTER_IO_BUF on any task") for the
> > > UBLK_IO_UNREGISTER_IO_BUF to be issued on another task. And even if
> > > the unregister happens on the daemon task, it's up to the io_uring
> > > layer to actually call ublk_io_release() once all requests using the
> > > registered buffer have completed. Assuming only the daemon task issues
> > > io_uring requests using the buffer, I believe ublk_io_release() will
> > > always currently be called on that task. But I'd rather not make
> > > assumptions about the io_uring layer. It's also possible in principle
> > > for ublk_io_release() whether it's called on the daemon task and have
> > > a fast path in that case (similar to UBLK_IO_REGISTER_IO_BUF).
> >
> > Yes, my point is that optimization should focus on common case.
> 
> Of course, I agree. I think the common case is for both register and
> unregister to be issued on the daemon task. I only optimized the
> register so far because it appears significantly more expensive (due
> to the request lookup on the tagset and the CAS loop to increment the
> refcount). I can test optimizing the unregister as well and see if
> it's a net win.

Looks good!

> 
> >
> > > But I'm not sure it's worth the cost of an additional ubq/io lookup.
> > >
> > > >
> > > > - __ublk_check_and_get_req() is bypassed.
> > > >
> > > > - buggy application may overflow ->buffers_registered
> > >
> > > Isn't it already possible in principle for a ublk server to overflow
> > > ublk_rq_data's refcount_t by registering the same ublk request with
> > > lots of buffers? But sure, if you're concerned about this overflow, I
> > > can easily add a check for it.
> >
> > At least refcount_inc_not_zero() will warn if it happens.
> >
> > >
> > > >
> > > > So can you share any data about this optimization on workload with local
> > > > registering & remote un-registering io buffer? Also is this usage
> > > > really one common case?
> > >
> > > Sure, I can provide some performance measurements for this
> > > optimization. From looking at CPU profiles in the past, the reference
> > > counting and request lookup accounted for around 2% of the ublk server
> > > CPU time. To be clear, in our use case, both the register and
> > > unregister happen on the daemon task. I just haven't bothered
> > > optimizing the reference-counting for the unregister yet because it
> > > doesn't appear nearly as expensive.
> >
> > If you are talking about per-io-task, I guess it may not make a difference
> > from user viewpoint from both iops and cpu utilization since the counter is
> > basically per-task variable, and atomic cost shouldn't mean something for us.
> 
> Atomic RMW operations are more expensive than non-atomic ones even
> when the cache line isn't contended (at least in my experience on
> x86). The effect is greater in systems with large numbers of CPUs (and
> especially with multiple NUMA nodes). Let me collect some precise
> performance numbers, but I recall it being a significant hotspot.

Yes, as micro benchmark, RMW is much slower than plain inc.

I just compare the following two in my laptop by running the counting
until the counter reaches 2G.

1) plain inc

- (*(volatile unsigned int *)&val)++;

- 1640M/sec

2) atomic inc:

- atomic_fetch_add(&aval, 1)

- 231M/sec

So looks the optimization makes sense for millions level IOPS.


Thanks,
Ming

