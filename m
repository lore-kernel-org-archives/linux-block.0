Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CF2DECBF
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474350; cv=none; b=hOrwF3lVY9N761EWPr+Gm7IwSJksLA6GskCATvhoccN2BYtwY0Lb815co6j9q7nTLbit2FgShjVYCO4z+zxAZudAh9ZfWyn5BnzI2TWwQay0rCTDvOmZLmUl6XRVnP807GT4te7kD5+TMuwUvzU5Xr+D3b/wDk6gTXgI0vAmmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474350; c=relaxed/simple;
	bh=0fTE5hJ4OmvSYvMfbM5i2+wX1Cp2WMJNiJRgIOYue+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYTzVWC/aa34Q8teWjzQKTWMV99/Yg9LkWzWxSCxJhkvxghPWuGP4thWh5IZlAj/dSGRHweZhncos3imWwt/0SVxxV09y+hXX6l+koPqyC7rE8Td+8ezKmm54UlP9qXB6+0AQ9evYpYrv6DNqJk3R/BwVZIOYQhERuLC6dya4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UX9fTMFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UX9fTMFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775474347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3lNXgeF8NTfQx7RPDea3gZ7bhNGXxc/SPzuLtgX7QI=;
	b=UX9fTMFq1YLj7srpPadem79apFn9lgLV38TDTneh9Z4gWdO7keGbmfK32yJoZDELXLjIrU
	Nq69Jx4CiyfPaaFZiltmKEouYFip6HjTq6H6nHK8XmNEon1z8uuP0ghtE/EVKRaCXV71jz
	MGTo93diu/pSMZQkDSLwn9aroln/fjo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-MYsPR_L0P9GYcUm9yIL8OA-1; Mon,
 06 Apr 2026 07:19:01 -0400
X-MC-Unique: MYsPR_L0P9GYcUm9yIL8OA-1
X-Mimecast-MFC-AGG-ID: MYsPR_L0P9GYcUm9yIL8OA_1775474340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50E821800283;
	Mon,  6 Apr 2026 11:19:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39DE5300019F;
	Mon,  6 Apr 2026 11:18:53 +0000 (UTC)
Date: Mon, 6 Apr 2026 19:18:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Uday Shankar <ushankar@purestorage.com>,
	"zhang, the-essence-of-life" <zhangweize9@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ublk: reset per-IO canceled flag on each fetch
Message-ID: <adOWmG2fGLM-43cl@fedora>
References: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
 <20260405-cancel-v2-1-02d711e643c2@purestorage.com>
 <53aec093-5494-4b4b-a103-bc166381f236@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53aec093-5494-4b4b-a103-bc166381f236@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Apr 06, 2026 at 09:22:13AM +0200, Hannes Reinecke wrote:
> On 4/6/26 06:25, Uday Shankar wrote:
> > If a ublk server starts recovering devices but dies before issuing fetch
> > commands for all IOs, cancellation of the fetch commands that were
> > successfully issued may never complete. This is because the per-IO
> > canceled flag can remain set even after the fetch for that IO has been
> > submitted - the per-IO canceled flags for all IOs in a queue are reset
> > together only once all IOs for that queue have been fetched. So if a
> > nonempty proper subset of the IOs for a queue are fetched when the ublk
> > server dies, the IOs in that subset will never successfully be canceled,
> > as their canceled flags remain set, and this prevents ublk_cancel_cmd
> > from actually calling io_uring_cmd_done on the commands, despite the
> > fact that they are outstanding.
> > 
> > Fix this by resetting the per-IO cancel flags immediately when each IO
> > is fetched instead of waiting for all IOs for the queue (which may never
> > happen).
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > Reviewed-by: zhang, the-essence-of-life <zhangweize9@gmail.com>
> > ---
> >   drivers/block/ublk_drv.c | 21 +++++++++++++--------
> >   1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 3ba7da94d31499590a06a8b307ed151919a027cb..92dabeb820344107c9fadfae94396082b933d84e 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2916,22 +2916,26 @@ static void ublk_stop_dev(struct ublk_device *ub)
> >   	ublk_cancel_dev(ub);
> >   }
> > +static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
> > +{
> > +	/* UBLK_IO_FLAG_CANCELED can be cleared now */
> > +	spin_lock(&ubq->cancel_lock);
> > +	io->flags &= ~UBLK_IO_FLAG_CANCELED;
> > +	spin_unlock(&ubq->cancel_lock);
> > +}
> > +
> One wonders why we can't use 'set_bit' here, or, rather,
> convert 'flags' usage to set_bit().

It isn't necessary, because UBLK_F_PER_IO_DAEMON is enabled.

> The spinlock feels a bit silly as it's now per-io, and one would think
> that we don't have concurrent accesses to the same io...

UBLK_IO_FLAG_CANCELED is only used in slow path, yes, it is supposed to be
accessed concurrently.

It could be moved out of io->flags, but we do want to make `struct ublk_io`
held in single cache line.

> 
> >   /* reset per-queue io flags */
> >   static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
> >   {
> > -	int j;
> > -
> > -	/* UBLK_IO_FLAG_CANCELED can be cleared now */
> >   	spin_lock(&ubq->cancel_lock);
> > -	for (j = 0; j < ubq->q_depth; j++)
> > -		ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
> >   	ubq->canceling = false;
> >   	spin_unlock(&ubq->cancel_lock);
> >   	ubq->fail_io = false;
> >   }
> Similar here; as we don't loop anymore, why do we need the spinlock?
> Isn't WRITE_ONCE() sufficient here?

WRITE_ONCE() isn't enough, because we have to make sure that io->cmd is
only completed once, please see ublk_cancel_cmd().

Anyway, all these comments should belong to improvement or new issue,
not a blocker for current bug fix.


Thanks,
Ming

