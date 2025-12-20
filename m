Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6A2D6E67
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766196235; cv=none; b=dZM3UH0cxnwNYA5tgVnr2Mf2euuXRJvcI8a5H+YXbZVNdGx2j0ZfTPfryGTgcGpaBg7opX9hqbp33eOni4fOHr3NJd21LFydXoX6k90p+iCi2SGMlBnrIEU/aQZyHTPPfsXGECmXfn48wKqHSEbleOdoDgNKNBz337DXWyqmDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766196235; c=relaxed/simple;
	bh=2GwD9VO52B2w64n8jhAISzHF3CPrmQe5CfyXg3Ekwjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn6VdTBigo/N8fwwqWnqEpldBmeckd6HWkjKY3tyecX0HTfMWq/shHRJQUNqiNOLPdqH5t2W2dDP1ih0WOnaQnZv6DNEbqAiZ4WGQnCyUN44A3VEhIL0ANTuxJqJtqIqQlyU6V7ckY/sLiojzU/klefQAuzF0tTT22LpOT4t8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5+4zAm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5+4zAm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766196231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgEslDWB8MTMPBuRVFAS4SMPMMLTQ2whnf4ICwEDJ/g=;
	b=B5+4zAm8l3e500HGdGB4+HnbyvJ+XcXi1m8AiyBVawtDfTJZhsh63yizOHYQ3n20Biv9+m
	85fbiqeNeD4tW28yYT2hixb9fYTz8LCLlEOPprTHYS4Nkk6iQSnsbZKS/ZhqJrOsPdPy+d
	yDyOFoO8OZKbQztxU0nitRxJvyNQP2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-vZWAeVpxPxC4zLdPqYzDaQ-1; Fri,
 19 Dec 2025 21:03:48 -0500
X-MC-Unique: vZWAeVpxPxC4zLdPqYzDaQ-1
X-Mimecast-MFC-AGG-ID: vZWAeVpxPxC4zLdPqYzDaQ_1766196227
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5D941956089;
	Sat, 20 Dec 2025 02:03:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BDC819560B4;
	Sat, 20 Dec 2025 02:03:42 +0000 (UTC)
Date: Sat, 20 Dec 2025 10:03:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: clean up user copy references on ublk server exit
Message-ID: <aUYD-ZqgBvCHiLfy@fedora>
References: <20251213001950.2103303-1-csander@purestorage.com>
 <CADUfDZqKLvt+uJXSgkwiE3CSew0C5xc6Ft1OfjPdGVQZs3rG-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqKLvt+uJXSgkwiE3CSew0C5xc6Ft1OfjPdGVQZs3rG-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Dec 19, 2025 at 11:52:23AM -0500, Caleb Sander Mateos wrote:
> Ming, would you mind taking a (hopefully quick) look at this fix? The
> warning reproduces easily with the ublk user copy selftests I recently
> added.

Sure, sorry for missing this fix.

> 
> On Fri, Dec 12, 2025 at 7:19 PM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > If a ublk server process releases a ublk char device file, any requests
> > dispatched to the ublk server but not yet completed will retain a ref
> > value of UBLK_REFCOUNT_INIT. Before commit e63d2228ef83 ("ublk: simplify
> > aborting ublk request"), __ublk_fail_req() would decrement the reference
> > count before completing the failed request. However, that commit
> > optimized __ublk_fail_req() to call __ublk_complete_rq() directly
> > without decrementing the request reference count.
> > The leaked reference count incorrectly allows user copy and zero copy
> > operations on the completed ublk request. It also triggers the
> > WARN_ON_ONCE(refcount_read(&io->ref)) warnings in ublk_queue_reinit()
> > and ublk_deinit_queue().
> > Commit c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk
> > char dev is closed") already fixed the issue for ublk devices using
> > UBLK_F_SUPPORT_ZERO_COPY or UBLK_F_AUTO_BUF_REG. However, the reference
> > count leak also affects UBLK_F_USER_COPY, the other reference-counted
> > data copy mode. Fix the condition in ublk_check_and_reset_active_ref()
> > to include all reference-counted data copy modes. This ensures that any
> > ublk requests still owned by the ublk server when it exits have their
> > reference counts reset to 0.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Fixes: e63d2228ef83 ("ublk: simplify aborting ublk request")
> > ---
> >  drivers/block/ublk_drv.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index df9831783a13..78f3e22151b9 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1581,12 +1581,11 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
> >
> >  static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
> >  {
> >         int i, j;
> >
> > -       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> > -                                       UBLK_F_AUTO_BUF_REG)))
> > +       if (!ublk_dev_need_req_ref(ub))
> >                 return false;
> >
> >         for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> >                 struct ublk_queue *ubq = ublk_get_queue(ub, i);

This patch looks correct for covering user copy:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

