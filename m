Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35D1FC8
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728282; cv=none; b=r2pswf2FUoCOH7WwLTrp/15qPX0C6OVvmZhtq7sb15BXrYNdIQLrJGNjt3lZoxYcxM7cDjkUxGvV8+lNfHxCCK5mNAreTqSLHqdzs2MCE4+WYDGiAjkc/APYFCon7JmO+wOrxFrSzFuec+sAyCAxFqQme+/qkT3mS2wu5vWJtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728282; c=relaxed/simple;
	bh=JyD17R4j3n3Sx6p4KK3SlsX83V9knnaRd7bCP2Zok9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMH2JS/utaX/7aUsoXJrNwS2HbWCs4k+0khSkZZunuCJkSjaOFXDK4VYJ8FZ1DZOzj8FkE4tRukoZJcj6HBxlVri8xIiRTf7CD7+D22psWStRZ3JeG4VYdAW/dqpBDXhfXgnKfG9FpKQ7IOdCiXy8uSGojGGJessFkrYCgcoU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEBwZHpq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEBwZHpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750728273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrHEEwv0+tebkv5k5soJflh2K4lofct2hsw/GZZK8Ok=;
	b=BEBwZHpqo6SrwyQYUB94ToA/f4mesFjZToaWjpYOkIVGDIhKO9m/ucBOVuC77h+zv+MfDj
	1UsZoYrTCXSP33g9571q6IGv82L/iIirtgZFu7S1W1FF/rUlLtp1JaWOUd+aIaautG8RzT
	u4hoxuUivS/B0rKcCf7NZe4OY//im84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-VDjjKxqrN0ausbRFIRp9Lg-1; Mon,
 23 Jun 2025 21:24:30 -0400
X-MC-Unique: VDjjKxqrN0ausbRFIRp9Lg-1
X-Mimecast-MFC-AGG-ID: VDjjKxqrN0ausbRFIRp9Lg_1750728269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46871195608E;
	Tue, 24 Jun 2025 01:24:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22C518002B8;
	Tue, 24 Jun 2025 01:24:25 +0000 (UTC)
Date: Tue, 24 Jun 2025 09:24:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 1/2] ublk: build per-io-ring-ctx batch list
Message-ID: <aFn-RNJxWFl5Vz-G@fedora>
References: <20250623011934.741788-1-ming.lei@redhat.com>
 <20250623011934.741788-2-ming.lei@redhat.com>
 <CADUfDZp=69+ZpJ5vc7c9qGmA3zLU+eYdYd2PfeiDwFvxYQ+0nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp=69+ZpJ5vc7c9qGmA3zLU+eYdYd2PfeiDwFvxYQ+0nQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jun 23, 2025 at 10:51:00AM -0700, Caleb Sander Mateos wrote:
> On Sun, Jun 22, 2025 at 6:19 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
> > work via the tail request's io_uring_cmd, this way is fine even though
> > more than one io_ring_ctx are involved for this batch since it is just
> > one running context.
> >
> > However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
> > of tail uring_cmd's io_ring_ctx for completing all commands. This way is
> > wrong if any uring_cmd is issued from different io_ring_ctx.
> >
> > Fixes it by always building per-io-ring-ctx batch list.
> >
> > For typical per-queue or per-io daemon implementation, this way shouldn't
> > make difference from performance viewpoint, because single io_ring_ctx is
> > often taken in each daemon.
> >
> > Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
> > Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c637ea010d34..e79b04e61047 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1336,9 +1336,8 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> >         } while (rq);
> >  }
> >
> > -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> > +static void ublk_queue_cmd_list(struct io_uring_cmd *cmd, struct rq_list *l)
> >  {
> > -       struct io_uring_cmd *cmd = io->cmd;
> >         struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> >
> >         pdu->req_list = rq_list_peek(l);
> > @@ -1420,16 +1419,18 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
> >  {
> >         struct rq_list requeue_list = { };
> >         struct rq_list submit_list = { };
> > -       struct ublk_io *io = NULL;
> > +       struct io_uring_cmd *cmd = NULL;
> >         struct request *req;
> >
> >         while ((req = rq_list_pop(rqlist))) {
> >                 struct ublk_queue *this_q = req->mq_hctx->driver_data;
> > -               struct ublk_io *this_io = &this_q->ios[req->tag];
> > +               struct io_uring_cmd *this_cmd = this_q->ios[req->tag].cmd;
> >
> > -               if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
> > -                       ublk_queue_cmd_list(io, &submit_list);
> > -               io = this_io;
> > +               if (cmd && io_uring_cmd_ctx_handle(cmd) !=
> > +                               io_uring_cmd_ctx_handle(this_cmd) &&
> > +                               !rq_list_empty(&submit_list))
> > +                       ublk_queue_cmd_list(cmd, &submit_list);
> 
> I don't think we can assume that ublk commands submitted to the same
> io_uring have the same daemon task. It's possible for multiple tasks
> to submit to the same io_uring, even though that's not a common or
> performant way to use io_uring. Probably we need to check that both
> the task and io_ring_ctx match.

Here the problem is in 'issue_flags' passed from io_uring, especially for
grabbing io_ring_ctx lock.

If two uring_cmd are issued via same io_ring_ctx from two tasks, it is
fine to share 'issue_flags' from one of tasks, what matters is that the
io_ring_ctx lock is handled correctly when calling io_uring_cmd_done().



Thanks,
Ming

