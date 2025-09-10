Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754C22D793
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471441; cv=none; b=Q95yp8dQKgEsBJDTowpvQuaHmcVSYPtk3ntEbaLDLdCchfegHECTYVsPTtnt4IP4SOZ/zEEKBcz/gIe+P3fXXj6fB1vuEjGVfecri7WGnbDsjIzKfAn4r5NlKnDYkSg/ouC0VTdfgdnepuE3PLVfOKyTwBcoRuPN/aN9+9Ccl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471441; c=relaxed/simple;
	bh=dlL/gxLNojoRpALze1qtEFw8qfU0X7yRORgOBbz8sHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acTmPRsHgxsUw6fgdMmSOWWjyX9gSwWyOiM9x76DCmFCYn6M45NSxGI/qlRgEpvcffZCiMNRbU/89rOVQjdKKtkca69OQSHPqihIaKCLgfHdCpt/2+BqfXToPf5fJYVMeqgRX6SgQvH2bpm7sgLBg+rHakBbDhIVAdPabj1PM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkvgoGyd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkvgoGyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757471437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKceB4Km5PSY7rzISV2LcPrjU5QiA/LhNSTkkSmwZm8=;
	b=hkvgoGydCaRNGz2jGk11SVeW13RI4NfQ8gjFeHQZVhXQI6Z2d+lsBF5PLTT1sWTgxmDYRn
	suZHwL4n+jSuTEm1vsaImO5qGqPSiPkMtJ7eQUxrzZotk5tPSAEOVCBhvQwVWAp3WpiIMS
	dkgLNyKeiw1r9otxxwe/QlKHg8tJo+M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-cs3PkxyKOuWvmp4dlmetjw-1; Tue,
 09 Sep 2025 22:30:32 -0400
X-MC-Unique: cs3PkxyKOuWvmp4dlmetjw-1
X-Mimecast-MFC-AGG-ID: cs3PkxyKOuWvmp4dlmetjw_1757471432
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85BC819560AF;
	Wed, 10 Sep 2025 02:30:31 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4068E300018D;
	Wed, 10 Sep 2025 02:30:26 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:30:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 04/23] ublk: add helper of __ublk_fetch()
Message-ID: <aMDivQQcp9AsRnrM@fedora>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
 <20250901100242.3231000-5-ming.lei@redhat.com>
 <CADUfDZrBPyPRbRmiYRXU945zG6w9pFF-4Rvu8B1rJ1WBO3tHaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrBPyPRbRmiYRXU945zG6w9pFF-4Rvu8B1rJ1WBO3tHaw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 02, 2025 at 09:42:37PM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 1, 2025 at 3:03 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add helper __ublk_fetch() for the coming batch io feature.
> >
> > Meantime move ublk_config_io_buf() out of __ublk_fetch() because batch
> > io has new interface for configuring buffer.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index e53f623b0efe..f265795a8d57 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2206,18 +2206,12 @@ static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_addr)
> >         return 0;
> >  }
> >
> > -static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> > -                     struct ublk_io *io, __u64 buf_addr)
> > +static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> > +                       struct ublk_io *io)
> >  {
> >         struct ublk_device *ub = ubq->dev;
> >         int ret = 0;
> >
> > -       /*
> > -        * When handling FETCH command for setting up ublk uring queue,
> > -        * ub->mutex is the innermost lock, and we won't block for handling
> > -        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> > -        */
> > -       mutex_lock(&ub->mutex);
> >         /* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
> >         if (ublk_queue_ready(ubq)) {
> >                 ret = -EBUSY;
> > @@ -2233,13 +2227,28 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> >         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
> >
> >         ublk_fill_io_cmd(io, cmd);
> > -       ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
> > -       if (ret)
> > -               goto out;
> >
> >         WRITE_ONCE(io->task, get_task_struct(current));
> >         ublk_mark_io_ready(ub, ubq);
> >  out:
> > +       return ret;
> 
> If the out: section no longer releases any resources, can we replace
> the "goto out" with just "return ret"?

OK.

> 
> > +}
> > +
> > +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> > +                     struct ublk_io *io, __u64 buf_addr)
> > +{
> > +       struct ublk_device *ub = ubq->dev;
> > +       int ret;
> > +
> > +       /*
> > +        * When handling FETCH command for setting up ublk uring queue,
> > +        * ub->mutex is the innermost lock, and we won't block for handling
> > +        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> > +        */
> > +       mutex_lock(&ub->mutex);
> > +       ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
> > +       if (!ret)
> > +               ret = __ublk_fetch(cmd, ubq, io);
> 
> How come the order of operations was switched here? ublk_fetch()
> previously checked ublk_queue_ready(ubq) and io->flags &
> UBLK_IO_FLAG_ACTIVE first, which seems necessary to prevent
> overwriting a ublk_io that has already been fetched.

Good point, that is actually what ublk_batch_prep_io() is doing: commit the
buffer descriptor into io slot only after __ublk_fetch() runs successfully.

I will fix the order.


Thanks,
Ming

