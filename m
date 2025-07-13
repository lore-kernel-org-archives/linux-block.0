Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB535947
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374117; cv=none; b=TafgU+OJij8VL790zMDpgJZJ+mhhG/P4qj0l8cTch59KGQP/uEsY3QPM6QOPC/Nf4X/PnmVFNicoriH9Ndqu4rLOblUlFLj3xaYsPhBt8t0lGWo5S0hyXocajUCgUOCh4mui2u4pGqyybDvgM7nTMY+P1xEkaVFCqZv8Xomr1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374117; c=relaxed/simple;
	bh=Jd7t1ZAOq0Qf6sEbCX8kYB1CpMNH4PsSEi7AI76Qnlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY7pnSyGufSSuzGkO7uuvFZGQ96EtPmxsdpPYzK2tNYV92eMwEnleBFqPaIe+A9yE1/vjECA6Tn+fZ14is5ZfkgRBU2onm+GjeIuK9h0RvaLxGfEJGvwLCfCgKufvZ6BiyYsVvNevGtPFJCVLBhpnIqCEBAcIrMklgIXqFfMwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9hGcLkG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9hGcLkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752374110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWQfUuY0azCuYewE8XZx6M+W5JkvjMoqmNH+oECmjMc=;
	b=P9hGcLkGeWcugB1r183SIClUqKSwsp1BrriXVu1w4u4XjhCiA+KRkv11TXjNNKpZOo9IiY
	8936W2iMidJd8D6IgZLdGN9qEtnioipxX3peSV0ITre/LnNTJa7kMUo/kavlN8/X5CpbH0
	MlhRRQ69BgK/IQrU1SDKkbH7i/YxH4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-NSKUaIzNN6u6i5CXji9O9g-1; Sat,
 12 Jul 2025 22:35:07 -0400
X-MC-Unique: NSKUaIzNN6u6i5CXji9O9g-1
X-Mimecast-MFC-AGG-ID: NSKUaIzNN6u6i5CXji9O9g_1752374104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 506961800343;
	Sun, 13 Jul 2025 02:35:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE77E180035E;
	Sun, 13 Jul 2025 02:35:00 +0000 (UTC)
Date: Sun, 13 Jul 2025 10:34:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2 03/16] ublk: let ublk_fill_io_cmd() cover more things
Message-ID: <aHMbT0OUBEoiy7AY@fedora>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
 <20250708011746.2193389-4-ming.lei@redhat.com>
 <CADUfDZrW3NsusYmYo4gsRCDv8Yb3oWZYrVfhDUe219xqFTue=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrW3NsusYmYo4gsRCDv8Yb3oWZYrVfhDUe219xqFTue=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jul 11, 2025 at 09:25:27AM -0400, Caleb Sander Mateos wrote:
> On Mon, Jul 7, 2025 at 9:18 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Let ublk_fill_io_cmd() cover more things:
> >
> > - store io command result
> >
> > - clear UBLK_IO_FLAG_OWNED_BY_SRV
> >
> > It is fine to do above for ublk_fetch(), ublk_commit_and_fetch() and
> > handling UBLK_IO_NEED_GET_DATA.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index d7b5ee96978a..1ab2dc74424f 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2003,11 +2003,16 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
> >  }
> >
> >  static inline void ublk_fill_io_cmd(struct ublk_io *io,
> > -               struct io_uring_cmd *cmd, unsigned long buf_addr)
> > +               struct io_uring_cmd *cmd, unsigned long buf_addr,
> > +               int result)
> >  {
> >         io->cmd = cmd;
> >         io->flags |= UBLK_IO_FLAG_ACTIVE;
> >         io->addr = buf_addr;
> > +       io->res = result;
> 
> Hmm, only a single caller (ublk_commit_and_fetch()) needs to set
> io->res. It seems a bit weird to move it here.

OK, it can be kept outside ublk_fill_io_cmd() for ublk_commit_and_fetch()
only.

> 
> > +
> > +       /* now this cmd slot is owned by ublk driver */
> > +       io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
> 
> I would have a slight preference for keeping the two updates of
> io->flags next to each other. The compiler may be able to optimize
> that better.

OK.


thanks,
Ming

