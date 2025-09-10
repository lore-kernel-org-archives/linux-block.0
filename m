Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7F18E1F
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471769; cv=none; b=M3fjmvXiH1Ias0t86FYh9kfiKVW+V5/1PpNvGh/IBsNhwqfGVxUy4EmxA3xEoKSd9Hj2KabVm2aqhmqEjI/o2ZvOjjhvmVdUN20sL/05SLoeeeENbLVDAtIwrcuMslISql7GdNa3HkUKtiydgTLrSC44uQJx80dVC9ICCPEKPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471769; c=relaxed/simple;
	bh=h1opsgLucBJdZIIzXifGnY0dxwVVJn2DYo/mwB9ZTGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A44wxDB3UAiXkJ/DA8uisTmDrpoPMVdMME2hu+0Vdmy4An6hfsWtGpzPg+0Mj97LJ5gNWOAz3E7aQC7zZqjVCDcxNmzlDFQKnWXEa+9I3HLuOzWNsYDnI4Xjkr6VkD35m1fPxzf1xtgZbDDpeOWzZ4VeyATi80Gtcp80Z6tUIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7VFFHjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7VFFHjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757471765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEbjlqbx36VQMLtjKCJMmP5SIKcdUE895SlVyijdx2A=;
	b=E7VFFHjPIps9ardvze/SG7LxH0EK1GI8z6rSV3b4H6yBSArzUAjTOukyY/k23J+gdSFZ1K
	wM4wrp/bv5rd6vRf4maciuHntqy3IOmQpSX/24CGjx24UdfL7nYWlSVuFAx0iH+26a5E54
	WJJL4o8ypXrksZjTXf73hMM1SBAuokE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-dpz7NIgZMCisunNxRY_bPw-1; Tue,
 09 Sep 2025 22:36:04 -0400
X-MC-Unique: dpz7NIgZMCisunNxRY_bPw-1
X-Mimecast-MFC-AGG-ID: dpz7NIgZMCisunNxRY_bPw_1757471763
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CC3F1956095;
	Wed, 10 Sep 2025 02:36:03 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99ED9300018D;
	Wed, 10 Sep 2025 02:35:59 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:35:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 06/23] ublk: prepare for not tracking task context for
 command batch
Message-ID: <aMDkCaU_kewRU-c3@fedora>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
 <20250901100242.3231000-7-ming.lei@redhat.com>
 <CADUfDZrQF+VS8U8Z923qfj+jHsLDjNVsoy=dMxdDMW+2JcpMdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrQF+VS8U8Z923qfj+jHsLDjNVsoy=dMxdDMW+2JcpMdg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Sep 06, 2025 at 11:48:08AM -0700, Caleb Sander Mateos wrote:
> On Mon, Sep 1, 2025 at 3:03 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > batch io is designed to be independent of task context, and we will not
> > track task context for batch io feature.
> >
> > So warn on non-batch-io code paths.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index a0dfad8a56f0..46be5b656f22 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -261,6 +261,11 @@ static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
> >         return false;
> >  }
> >
> > +static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline struct ublksrv_io_desc *
> >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> >  {
> > @@ -1309,6 +1314,8 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
> >                         __func__, ubq->q_id, req->tag, io->flags,
> >                         ublk_get_iod(ubq, req->tag)->addr);
> >
> > +       WARN_ON_ONCE(ublk_support_batch_io(ubq));
> 
> Hmm, not a huge fan of extra checks in the I/O path. It seems fairly
> easy to verify from the code that these functions won't be called for
> batch commands. Do we really need the assertion?

It is just a safety guard, and can be removed, but ubq->flag is really in
hot cache.

> 
> > +
> >         /*
> >          * Task is exiting if either:
> >          *
> > @@ -1868,6 +1875,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
> >         if (WARN_ON_ONCE(pdu->tag >= ubq->q_depth))
> >                 return;
> >
> > +       WARN_ON_ONCE(ublk_support_batch_io(ubq));
> > +
> >         task = io_uring_cmd_get_task(cmd);
> >         io = &ubq->ios[pdu->tag];
> >         if (WARN_ON_ONCE(task && task != io->task))
> > @@ -2233,7 +2242,10 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> >
> >         ublk_fill_io_cmd(io, cmd);
> >
> > -       WRITE_ONCE(io->task, get_task_struct(current));
> > +       if (ublk_support_batch_io(ubq))
> > +               WRITE_ONCE(io->task, NULL);
> 
> Don't see a need to explicitly write NULL here since the ublk_io
> memory is zero-initialized.

You are right, but ublk_fetch() is in slow path.


Thanks,
Ming

