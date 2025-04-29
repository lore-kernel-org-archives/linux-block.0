Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096327470
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899559; cv=none; b=q+QhOmMy3bz9S1aC5/siCsFO4rK2RP1h8ef0kHPhsZgOhvIwc2VnjNqkEuawc1ejIWMZ4cG6woACMQ03JHkdfMOVrV9zJfM25QKXKUGa7uM4RNBWIQcTn/4x3uak8B1JhzenxBkreAAd7LEcOThif6OLCWzTGamOm50oVTGuofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899559; c=relaxed/simple;
	bh=mC064HA8cxmc5ppK0VWh3u7DcKPWkvHvnlU7CKsJHgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsZmEf+goi2daogLWQFaAJOzKcM73POnCdUXqrDjbXn3SfEtRAzJY9EUbmPPYU9fOAdqPO0nC4JehnOnbNXrte2p1PX/rDCb5GRroFvNi/UGsvNIZjA8KWsVoyqKdc0ml0gDndFuJxbi4KHRX1m/FbQ+0BwDd2JRv6dT/7sTRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOnHQXSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOnHQXSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745899556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T35C5vWq4hYFn/I8gNZPS9eGF+vOp3+hGnioAT17dSw=;
	b=DOnHQXSx1Is/WB7S9uEOJa8N0lNf20ADWsxTTUDhtXZ8YWHwv4p1zdTrJ2VCZlP6KTMTkq
	C/fR6bQlJBidVC6idXvEFzG78Vn6m+5gukJgmN3yoHsG3ZLnk1/8L6b3pWydbeoVv21qUp
	Mj8Al0x68FEFZU25H5luPYGV6Q344Jk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-i0h5bgxMMbShf-Hlnf_5MQ-1; Tue,
 29 Apr 2025 00:05:50 -0400
X-MC-Unique: i0h5bgxMMbShf-Hlnf_5MQ-1
X-Mimecast-MFC-AGG-ID: i0h5bgxMMbShf-Hlnf_5MQ_1745899542
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 815081800264;
	Tue, 29 Apr 2025 04:05:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B8319560AB;
	Tue, 29 Apr 2025 04:05:38 +0000 (UTC)
Date: Tue, 29 Apr 2025 12:05:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] ublk: factor out ublk_start_io() helper
Message-ID: <aBBQDjLDkGWE63vT@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-6-csander@purestorage.com>
 <aA4rqcpC01SzUn_g@fedora>
 <CADUfDZpEGVLzEZJtPiScWgf6PVroQvKKhGed1cb8AJiyUr_RYg@mail.gmail.com>
 <CADUfDZqqeeBTbgvCfHa8sr7Y7BetGbPzHYA1hMoN83kz+Bi54A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqqeeBTbgvCfHa8sr7Y7BetGbPzHYA1hMoN83kz+Bi54A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Apr 28, 2025 at 08:12:52AM -0700, Caleb Sander Mateos wrote:
> On Mon, Apr 28, 2025 at 7:28 AM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Sun, Apr 27, 2025 at 6:05 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Sat, Apr 26, 2025 at 10:58:00PM -0600, Caleb Sander Mateos wrote:
> > > > In preparation for calling it from outside ublk_dispatch_req(), factor
> > > > out the code responsible for setting up an incoming ublk I/O request.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++------------------
> > > >  1 file changed, 29 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 01fc92051754..90a38a82f8cc 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
> > > >               blk_mq_requeue_request(rq, false);
> > > >       else
> > > >               blk_mq_end_request(rq, BLK_STS_IOERR);
> > > >  }
> > > >
> > > > +static void ublk_start_io(struct ublk_queue *ubq, struct request *req,
> > > > +                       struct ublk_io *io)
> > > > +{
> > > > +     unsigned mapped_bytes = ublk_map_io(ubq, req, io);
> > > > +
> > > > +     /* partially mapped, update io descriptor */
> > > > +     if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
> > > > +             /*
> > > > +              * Nothing mapped, retry until we succeed.
> > > > +              *
> > > > +              * We may never succeed in mapping any bytes here because
> > > > +              * of OOM. TODO: reserve one buffer with single page pinned
> > > > +              * for providing forward progress guarantee.
> > > > +              */
> > > > +             if (unlikely(!mapped_bytes)) {
> > > > +                     blk_mq_requeue_request(req, false);
> > > > +                     blk_mq_delay_kick_requeue_list(req->q,
> > > > +                                     UBLK_REQUEUE_DELAY_MS);
> > > > +                     return;
> > > > +             }
> > > > +
> > > > +             ublk_get_iod(ubq, req->tag)->nr_sectors =
> > > > +                     mapped_bytes >> 9;
> > > > +     }
> > > > +
> > > > +     ublk_init_req_ref(ubq, req);
> > > > +}
> > > > +
> > > >  static void ublk_dispatch_req(struct ublk_queue *ubq,
> > > >                             struct request *req,
> > > >                             unsigned int issue_flags)
> > > >  {
> > > >       int tag = req->tag;
> > > >       struct ublk_io *io = &ubq->ios[tag];
> > > > -     unsigned int mapped_bytes;
> > > >
> > > >       pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
> > > >                       __func__, ubq->q_id, req->tag, io->flags,
> > > >                       ublk_get_iod(ubq, req->tag)->addr);
> > > >
> > > > @@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
> > > >               pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
> > > >                               __func__, ubq->q_id, req->tag, io->flags,
> > > >                               ublk_get_iod(ubq, req->tag)->addr);
> > > >       }
> > > >
> > > > -     mapped_bytes = ublk_map_io(ubq, req, io);
> > > > -
> > > > -     /* partially mapped, update io descriptor */
> > > > -     if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
> > > > -             /*
> > > > -              * Nothing mapped, retry until we succeed.
> > > > -              *
> > > > -              * We may never succeed in mapping any bytes here because
> > > > -              * of OOM. TODO: reserve one buffer with single page pinned
> > > > -              * for providing forward progress guarantee.
> > > > -              */
> > > > -             if (unlikely(!mapped_bytes)) {
> > > > -                     blk_mq_requeue_request(req, false);
> > > > -                     blk_mq_delay_kick_requeue_list(req->q,
> > > > -                                     UBLK_REQUEUE_DELAY_MS);
> > > > -                     return;
> > > > -             }
> > >
> > > Here it needs to break ublk_dispatch_req() for not completing the
> > > uring_cmd, however ublk_start_io() can't support it.
> >
> > Good catch. How about I change ublk_start_io() to return a bool
> > indicating whether the I/O was successfully started?

That is doable.

> 
> Thinking a bit more about this, is the existing behavior of returning
> early from ublk_dispatch_req() correct for UBLK_IO_NEED_GET_DATA? It

The requeue isn't related with UBLK_IO_NEED_GET_DATA actually, when
UBLK_IO_FLAG_NEED_GET_DATA is cleared.

It is usually caused by running out of pages, so we have to requeue until
ublk_map_io() can make progress.

> makes sense for the initial ublk_dispatch_req() because the req will
> be requeued without consuming the ublk fetch request, allowing it to
> be reused for a subsequent I/O. But for UBLK_IO_NEED_GET_DATA, doesn't
> it mean the io_uring_cmd will never complete? I would think it would
> be better to return an error code in this case.

The same request will be requeued and re-dispatched to ublk driver after
a short delay, so the uring_cmd won't be never complete.

Anyway, it isn't another story, which shouldn't be added into this
cleanup patch.

Thanks,
Ming

