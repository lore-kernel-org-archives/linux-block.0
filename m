Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB153363
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745717838; cv=none; b=FBqlHs0+43JUaSQXvVIjkifBvomiL4sVlIFQfJZTY20vs+C872a/v4f4+9sB6l17Hp1wkAo2sKC1syEHWWZqlwtBTddcQoaBLU37qD14JiRCbnic0srGIJGNpoOEkFypZUOTOasUBNdQbWDFk+Tbnd8cFNYXc1eVEJ0R5VDYUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745717838; c=relaxed/simple;
	bh=YiqhXuu0GW/+g3KTLQ3qekuXU016yBPfQY/i5ZiLVT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzWQOO9lMMUoiw6QDSB5WGYJ48abWPQc4Ri/p026Rq/JQELZpyrm+2mHzwnCz4EbuCB1kZKHo7zb674M+iyskIBGayRqN/XPDVHBTGtN41HivAns/I+a1zYcYN/Z+FJ3eJr/rmsuTsgn/l5oR1j1KJ9PWxyj3svht+apzfQCV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6EHfltq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6EHfltq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745717834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kb/FSSpP0Nxh4u8Fxe4NHveWWp43zVYLJzpG9+OKgZo=;
	b=d6EHfltqEphsnx+it/eBlxXZ3HxfffFqd+YVyuGyQK7RNbKcLVgzXW4zfajTY0yGHPEU0Y
	/b6QTKpEa64oNTqGGCw9acmsf0lSueHMmaxVv9fsRWSebrdFmPaX2U8BQ8NbvNnSlcW8GL
	d4h/+kDwc9Q9EwISSa1WHq434QIsI1Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-umw8ShknOnadmxsEdrRCIQ-1; Sat,
 26 Apr 2025 21:37:12 -0400
X-MC-Unique: umw8ShknOnadmxsEdrRCIQ-1
X-Mimecast-MFC-AGG-ID: umw8ShknOnadmxsEdrRCIQ_1745717831
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38B99195608C;
	Sun, 27 Apr 2025 01:37:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1089180047F;
	Sun, 27 Apr 2025 01:37:07 +0000 (UTC)
Date: Sun, 27 Apr 2025 09:37:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 2/4] ublk: enhance check for register/unregister io
 buffer command
Message-ID: <aA2KPuQl1_hTlplG@fedora>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-3-ming.lei@redhat.com>
 <CADUfDZrF71gPfCghE+wNyLXTmtAUprMfpo1XtP1C7kxx-=eP+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrF71gPfCghE+wNyLXTmtAUprMfpo1XtP1C7kxx-=eP+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 26, 2025 at 01:38:14PM -0700, Caleb Sander Mateos wrote:
> On Sat, Apr 26, 2025 at 2:41 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> > register/unregister io buffer easily, so check it before calling
> > starting to register/un-register io buffer.
> >
> > Also only allow io buffer register/unregister uring_cmd in case of
> > UBLK_F_SUPPORT_ZERO_COPY.
> 
> Indeed, both these checks make sense. (Hopefully there aren't any
> applications depending on the ability to use ublk zero-copy without
> setting the flag.) I too was thinking of adding the
> UBLK_IO_FLAG_OWNED_BY_SRV check because it could allow the
> kref_get_unless_zero() to be replaced with the cheaper kref_get(). I
> think the checks could be split into 2 separate commits, but up to
> you.

Let's do it in single patch for making everyone easier.

> 
> >
> > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 40f971a66d3e..347790b3a633 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -609,6 +609,11 @@ static void ublk_apply_params(struct ublk_device *ub)
> >                 ublk_dev_param_zoned_apply(ub);
> >  }
> >
> > +static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> > +{
> > +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > +}
> > +
> >  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> >  {
> >         return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > @@ -1950,9 +1955,16 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> >                                 unsigned int index, unsigned int issue_flags)
> >  {
> >         struct ublk_device *ub = cmd->file->private_data;
> > +       struct ublk_io *io = &ubq->ios[tag];
> 
> I thought you had mentioned in
> https://lore.kernel.org/linux-block/aAmYJxaV1-yWEMRo@fedora/ wanting
> to the ability to offload the ublk zero-copy buffer registration to a
> thread other than ubq_daemon. Are you still planning to do that, or
> does the "auto-register" feature supplant the need for that?

The auto-register idea is actually thought of when I was working on ublk
selftest offload function.

If this auto-register feature is supported, it becomes less important to
relax the ubq_daemon limit for register_io_buffer command, then I jump
on this feature & post put the patch.

But I will continue to work on the offload test code and finally relax
the limit for register/unregister io buffer command, hope it can be
done in next week.

> Accessing
> the ublk_io here only seems safe when on the ubq_daemon thread.

Both ublk_register_io_buf()/ublk_unregister_io_buf() just reads ublk_io or
the request buffer only, so it is just fine for the two to run from other
contexts.

> 
> >         struct request *req;
> >         int ret;
> >
> > +       if (!ublk_support_zero_copy(ubq))
> > +               return -EINVAL;
> > +
> > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > +               return -EINVAL;
> 
> Every opcode except UBLK_IO_FETCH_REQ now checks io->flags &
> UBLK_IO_FLAG_OWNED_BY_SRV. Maybe it would make sense to lift the check
> up to __ublk_ch_uring_cmd() to avoid duplicating it?

Good point.


Thanks, 
Ming

