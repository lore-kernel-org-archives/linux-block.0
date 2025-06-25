Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248728E0F
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750814555; cv=none; b=LHYJP6pXzL2upjjsC6RniPNE/wnJUB6LtM1C4WkZNwz36/NWOJBRVTViehxrnN13W0D47feRCRqK6bdA1/5XykhmYOotCdX5RynaPYVhxbfQ/MqK88mKHoAggspg+3Mgtc5xUG369mvm84C1CHNRpoyOMwIs08TQDPc9JwsGxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750814555; c=relaxed/simple;
	bh=toOMgkGt2CwZmHE8QVg3kJLitx0X+8a5XK6xzWKFiyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2tSZk0w6Rf52n0vhaijaWkZbzx7swyhx2gPEHNmKwWU92qrSiftLgSwxSgVgADY2IJ/LYJNHELprUTO/WgJRLmtyE8DYmcDnjRS5wkSzwynKuD6P9IBmdCVVWlwplE+WTwZMvImJLezua8haYE4rqKB4JESlr0I8sl6O8VgIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dsb8wXfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dsb8wXfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750814552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ifd/CRK6UIAKhCvOkErAfayxeflkdU4xkSnaN9983Zg=;
	b=Dsb8wXfCzyBPJH6ADore/njC3xJ7fWveyzkHv3XPFBpiMRO8W+niJ9Pl+lScY6GsR9UH3S
	baK5PgtRVVc/gpPCPnfum2BSLRuStkCTqXKVDUWL00cxk4n6iyvmT0dgF11AIEizWgZfzE
	CA2wbJzzXPjaKaR2Bd3ksXbhey3aqcY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-iBCCQzQ3PHykJlee3kMXCg-1; Tue,
 24 Jun 2025 21:22:28 -0400
X-MC-Unique: iBCCQzQ3PHykJlee3kMXCg-1
X-Mimecast-MFC-AGG-ID: iBCCQzQ3PHykJlee3kMXCg_1750814547
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE82B195608E;
	Wed, 25 Jun 2025 01:22:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8399519560B0;
	Wed, 25 Jun 2025 01:22:24 +0000 (UTC)
Date: Wed, 25 Jun 2025 09:22:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 1/2] ublk: build per-io-ring-ctx batch list
Message-ID: <aFtPShUlUwGLWvqF@fedora>
References: <20250623011934.741788-1-ming.lei@redhat.com>
 <20250623011934.741788-2-ming.lei@redhat.com>
 <CADUfDZp=69+ZpJ5vc7c9qGmA3zLU+eYdYd2PfeiDwFvxYQ+0nQ@mail.gmail.com>
 <aFn-RNJxWFl5Vz-G@fedora>
 <CADUfDZq3CN+i2d9sX+79n-Si4UWad-2n2_9E+-vkj0vfb7pVGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq3CN+i2d9sX+79n-Si4UWad-2n2_9E+-vkj0vfb7pVGg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Jun 24, 2025 at 08:26:51AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 23, 2025 at 6:24 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Jun 23, 2025 at 10:51:00AM -0700, Caleb Sander Mateos wrote:
> > > On Sun, Jun 22, 2025 at 6:19 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
> > > > work via the tail request's io_uring_cmd, this way is fine even though
> > > > more than one io_ring_ctx are involved for this batch since it is just
> > > > one running context.
> > > >
> > > > However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
> > > > of tail uring_cmd's io_ring_ctx for completing all commands. This way is
> > > > wrong if any uring_cmd is issued from different io_ring_ctx.
> > > >
> > > > Fixes it by always building per-io-ring-ctx batch list.
> > > >
> > > > For typical per-queue or per-io daemon implementation, this way shouldn't
> > > > make difference from performance viewpoint, because single io_ring_ctx is
> > > > often taken in each daemon.
> > > >
> > > > Fixes: d796cea7b9f3 ("ublk: implement ->queue_rqs()")
> > > > Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 17 +++++++++--------
> > > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index c637ea010d34..e79b04e61047 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -1336,9 +1336,8 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> > > >         } while (rq);
> > > >  }
> > > >
> > > > -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> > > > +static void ublk_queue_cmd_list(struct io_uring_cmd *cmd, struct rq_list *l)
> > > >  {
> > > > -       struct io_uring_cmd *cmd = io->cmd;
> > > >         struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > > >
> > > >         pdu->req_list = rq_list_peek(l);
> > > > @@ -1420,16 +1419,18 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
> > > >  {
> > > >         struct rq_list requeue_list = { };
> > > >         struct rq_list submit_list = { };
> > > > -       struct ublk_io *io = NULL;
> > > > +       struct io_uring_cmd *cmd = NULL;
> > > >         struct request *req;
> > > >
> > > >         while ((req = rq_list_pop(rqlist))) {
> > > >                 struct ublk_queue *this_q = req->mq_hctx->driver_data;
> > > > -               struct ublk_io *this_io = &this_q->ios[req->tag];
> > > > +               struct io_uring_cmd *this_cmd = this_q->ios[req->tag].cmd;
> > > >
> > > > -               if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
> > > > -                       ublk_queue_cmd_list(io, &submit_list);
> > > > -               io = this_io;
> > > > +               if (cmd && io_uring_cmd_ctx_handle(cmd) !=
> > > > +                               io_uring_cmd_ctx_handle(this_cmd) &&
> > > > +                               !rq_list_empty(&submit_list))
> > > > +                       ublk_queue_cmd_list(cmd, &submit_list);
> > >
> > > I don't think we can assume that ublk commands submitted to the same
> > > io_uring have the same daemon task. It's possible for multiple tasks
> > > to submit to the same io_uring, even though that's not a common or
> > > performant way to use io_uring. Probably we need to check that both
> > > the task and io_ring_ctx match.
> >
> > Here the problem is in 'issue_flags' passed from io_uring, especially for
> > grabbing io_ring_ctx lock.
> >
> > If two uring_cmd are issued via same io_ring_ctx from two tasks, it is
> > fine to share 'issue_flags' from one of tasks, what matters is that the
> > io_ring_ctx lock is handled correctly when calling io_uring_cmd_done().
> 
> Right, I understand the issue you are trying to solve. I agree it's a
> problem for submit_list to contain commands from multiple
> io_ring_ctxs. But it's also a problem if it contains commands with
> different daemon tasks, because ublk_queue_cmd_list() will schedule
> ublk_cmd_list_tw_cb() to be called in the *last command's task*. But
> ublk_cmd_list_tw_cb() will call ublk_dispatch_req() for all the
> commands in the list. So if submit_list contains commands with
> multiple daemon tasks, ublk_dispatch_req() will fail on the current !=
> io->task check. So I still feel we need to call
> ublk_queue_cmd_list(io, &submit_list) if io->task != this_io->task (as
> well as if the io_ring_ctxs differ).

Indeed, I will send a V2 for covering different task case.

Jens, can you drop this patch?

Thanks,
Ming

