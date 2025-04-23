Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54E2C1094
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422785; cv=none; b=P4i+RvLhMx1uW09HUqpApMwU+njo3RGkXQwXGQxAPTFYLMfrPRIjaL01oh1QxiiBL/pT6P7G/Bzeqab+XI/meP/LMZpIom34NcWAVM6O0hYLoO+jVOGOAAxbnmc9HoWi/xB46rTZvqabwd0VDyTZxpA3nzEt5s32Rtcjovti8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422785; c=relaxed/simple;
	bh=3ytYkVA9UFFzIlpfybet7b1QTvou5uN7RfXaDO9khmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJR556mpJMDwUKgCR0nxkl8Afib01QAsBoB8T4PyNdxYITFinjyExEpkjNS1pRhiw7Q29WqVSEV18sEejV4Wepjqn8WXxYCmUXvXKnglP7zp1ekvYfmz/58aoHHzCqMGwLkCaIEwjlL4eCFj72TknLgQZfxJfTxHG14ZIZUdIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqbvN9VR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqbvN9VR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745422780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQtuSOM4VnT6pAdz/cmGTlh92noXKPxKuaRqzoQYykU=;
	b=FqbvN9VRyX5NI2JRQVK7AsYi1qkAMkS29mUtT1Zcre1+i5Q0WP+heBQZ12G9aqRACh5F0o
	9W4tJvSIZYzi+lzNcLWYD647tAjjh6JWx/U6/9NW/krAqcF7J6GhliJvARbcmpqnDRMm/h
	NoD1MJ2ZlY/vK+lFjP568+Vgxm+LhwY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-eySQjvefOgSIbRYjxmse4Q-1; Wed,
 23 Apr 2025 11:39:37 -0400
X-MC-Unique: eySQjvefOgSIbRYjxmse4Q-1
X-Mimecast-MFC-AGG-ID: eySQjvefOgSIbRYjxmse4Q_1745422776
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB0F019560A6;
	Wed, 23 Apr 2025 15:39:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D7E51800378;
	Wed, 23 Apr 2025 15:39:29 +0000 (UTC)
Date: Wed, 23 Apr 2025 23:39:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH 2/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
Message-ID: <aAkJrELebhlgX7OZ@fedora>
References: <20250423092405.919195-1-ming.lei@redhat.com>
 <20250423092405.919195-3-ming.lei@redhat.com>
 <CADUfDZp4zMWBjGGsVXSXqvP2aoo2O1-SXCeyzfVj==FfKmAtcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp4zMWBjGGsVXSXqvP2aoo2O1-SXCeyzfVj==FfKmAtcg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Apr 23, 2025 at 08:08:17AM -0700, Caleb Sander Mateos wrote:
> On Wed, Apr 23, 2025 at 2:24 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
> > we may have scheduled task work via io_uring_cmd_complete_in_task() for
> > dispatching request, then kernel crash can be triggered.
> >
> > Fix it by not trying to canceling the command if ublk block request is
> > coming to this slot.
> >
> > Reported-by: Jared Holzman <jholzman@nvidia.com>
> > Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242981ef19@nvidia.com/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 37 +++++++++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c4d4be4f6fbd..fbfb5b815c8d 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1334,6 +1334,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> >         if (res != BLK_STS_OK)
> >                 return res;
> >
> > +       /*
> > +        * Order writing to rq->state in blk_mq_start_request() and
> > +        * reading ubq->canceling, see comment in ublk_cancel_command()
> > +        * wrt. the pair barrier.
> > +        */
> > +       smp_mb();
> 
> Adding an mfence to every ublk I/O would be really unfortunate. Memory
> barriers are very expensive in a system with a lot of CPUs. Why can't

I believe perf effect from the little smp_mb() may not be observed, actually
there are several main contributions for ublk perf per my last profiling:

- security_uring_cmd()

With removing security_uring_cmd(), ublk/loop over fast nvme is close to
kernel loop.

- bio allocation & freeing

ublk bio is allocated from one cpu, and usually freed on another CPU

- generic io_uring or block layer handling

which should be same with other io_uring application

And ublk cost is usually pretty small compared with above when running
workload with batched IOs.

> we rely on blk_mq_quiesce_queue() to prevent new requests from being
> queued? Is the bug that ublk_uring_cmd_cancel_fn() alls
> ublk_start_cancel() (which calls blk_mq_quiesce_queue()), but
> ublk_cancel_dev() does not?

I guess it is because we just mark ->canceling for one ubq with queue
quiesced. If all queues' ->canceling is set in ublk_start_cancel(), the
issue may be avoided too without this change.


Thanks
Ming

