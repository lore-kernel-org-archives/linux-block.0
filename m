Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3D78F59
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459259; cv=none; b=MxerXui2AlYksz6LmUDreINqbR+bPaVnGLAiaZ+eSNN2Ly8hOKdXq3oltwvZDdJYBYdGfpt+UHT+//45PnidT1UD9KoVDJERe9/0LIuCUde1k8Co8G9r6EgZupBd3nCAuy6I5EvIZMxocy7qe8DakccXWUgaSxm9iIV09sWJFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459259; c=relaxed/simple;
	bh=L0e42OsIzo3iQyu+YWZawdC92NXoNz+Xo5RBpfOG4Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arA/VFNEFDf56FNEAUjrN/rEUDaDkz1SmiCzxYXjnBIYEDKATQ2vlpseLGL/C1caPQ9SCdXCyWq/GzTCPACZZtkmfMKCrNl1NyNYuiVKfYfC/XBjCegooEDTgsO/908P+9SqWFb27SsqU9xh8XYe+7USJwvJfbFeAMhfLRlSIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEwkZpO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEwkZpO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745459255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrVSKIZnXAeni235/MemaiC6ULiXJ7BuHLckpopRGG0=;
	b=NEwkZpO08w+7OtCgIRnt3jZEcUHBxH7X258O1JCFYyS/bedbW9RfI3nZrDRXsylZoP0zSm
	yoo9zv1O8974Sc3sDr11tTX74HW1gn9P9b6UcnwyAJW66NrdWSEtVzV35EfB6SU5XjH6rW
	saMJYvhwuLq27gI4H6ScI0AUu7exqn8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-v5PI8UrENNe9DgZQeGGskQ-1; Wed,
 23 Apr 2025 21:47:32 -0400
X-MC-Unique: v5PI8UrENNe9DgZQeGGskQ-1
X-Mimecast-MFC-AGG-ID: v5PI8UrENNe9DgZQeGGskQ_1745459250
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10767180010A;
	Thu, 24 Apr 2025 01:47:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A08F630001A2;
	Thu, 24 Apr 2025 01:47:24 +0000 (UTC)
Date: Thu, 24 Apr 2025 09:47:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH 2/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
Message-ID: <aAmYJxaV1-yWEMRo@fedora>
References: <20250423092405.919195-1-ming.lei@redhat.com>
 <20250423092405.919195-3-ming.lei@redhat.com>
 <CADUfDZp4zMWBjGGsVXSXqvP2aoo2O1-SXCeyzfVj==FfKmAtcg@mail.gmail.com>
 <aAkJrELebhlgX7OZ@fedora>
 <CADUfDZoUohFbisLOrav35kCbLB0pxi1nFWGaki_fFxxVqU6pew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoUohFbisLOrav35kCbLB0pxi1nFWGaki_fFxxVqU6pew@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Apr 23, 2025 at 09:48:55AM -0700, Caleb Sander Mateos wrote:
> On Wed, Apr 23, 2025 at 8:39 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Wed, Apr 23, 2025 at 08:08:17AM -0700, Caleb Sander Mateos wrote:
> > > On Wed, Apr 23, 2025 at 2:24 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
> > > > we may have scheduled task work via io_uring_cmd_complete_in_task() for
> > > > dispatching request, then kernel crash can be triggered.
> > > >
> > > > Fix it by not trying to canceling the command if ublk block request is
> > > > coming to this slot.
> > > >
> > > > Reported-by: Jared Holzman <jholzman@nvidia.com>
> > > > Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242981ef19@nvidia.com/
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 37 +++++++++++++++++++++++++++++++------
> > > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index c4d4be4f6fbd..fbfb5b815c8d 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -1334,6 +1334,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> > > >         if (res != BLK_STS_OK)
> > > >                 return res;
> > > >
> > > > +       /*
> > > > +        * Order writing to rq->state in blk_mq_start_request() and
> > > > +        * reading ubq->canceling, see comment in ublk_cancel_command()
> > > > +        * wrt. the pair barrier.
> > > > +        */
> > > > +       smp_mb();
> > >
> > > Adding an mfence to every ublk I/O would be really unfortunate. Memory
> > > barriers are very expensive in a system with a lot of CPUs. Why can't
> >
> > I believe perf effect from the little smp_mb() may not be observed, actually
> > there are several main contributions for ublk perf per my last profiling:
> 
> I have seen a single mfence instruction in the I/O path account for
> multiple percent of the CPU profile in the past. The cost of a fence
> scales superlinearly with the number of CPUs, so it can be a real
> parallelism bottleneck. I'm not opposed to the memory barrier if it's
> truly necessary for correctness, but I would love to consider any
> alternatives.

Thinking of further, the added barrier is actually useless, because:

- for any new coming request since ublk_start_cancel(), ubq->canceling is
  always observed

- this patch is only for addressing requests TW is scheduled before or
  during quiesce, but not get chance to run yet

The added single check of `req && blk_mq_request_started(req)` should be
enough because:

- either the started request is aborted via __ublk_abort_rq(), so the
uring_cmd is canceled next time

or

- the uring cmd is done in TW function ublk_dispatch_req() because io_uring
guarantees that it is called

> 
> I have been looking at ublk zero-copy CPU profiles recently, and there
> the most expensive instructions there are the atomic
> reference-counting in ublk_get_req_ref()/ublk_put_req_ref(). I have
> some ideas to reduce that overhead.

The two can be observed by perf, but IMO it is still small part compared with
the other ones, not sure you can get obvious IOPS boost in this area,
especially it is hard to avoid the atomic reference.

I am preparing patch to relax the context limit for register_io/un_register_io
command which should have been run from non ublk queue contexts, just need
one offload ublk server implementation.

thanks,
Ming

