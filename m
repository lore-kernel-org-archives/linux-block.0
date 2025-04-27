Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A679E1
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 03:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745725766; cv=none; b=es6TNV3slat4cwd18gZVhlI1aFfFNfASrgdD6uLjrNaf+KWymXDQkUwXmcDlSjJ9KiVC0Hz4FVNBju2ezb3reWkxwDDFsaYdiw+ARjJprDO9gLB3BtCi2toxkqpa9W4YJR+0xHTLy3w9yb9WzBMURGlT/ysXuw5fPNQWu4c9kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745725766; c=relaxed/simple;
	bh=E1BPr3GtuwYh8FkFUKd7erSIvmQhHcf0eLSF3NEKN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nrdkje9yXAr/k4ie+Y5lKIUVNK2Y+BryIZmqNjklqKsOK4wLEzs5HR7g2ktxoDe+ZILTLaprbD5h7CTsj+iLHDuBhy8LIj0ER1vixkPY5Cp/iK9FiPfr9kLn6KMu6JlrhNNN4GIolhukaTewzWADEEcl+33YYW03SLMpJGfsSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MH9vEOI1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MH9vEOI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745725762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhfD+j2G2AHOQvkmnOjWOYdRZ85utLbedsLhVDg6iB0=;
	b=MH9vEOI1V5FqS03HibCij0Op0laLiLJpo43VCNRMJybR6R2TrxUALNqQ4t3t1ZmlRfGiZW
	jbYxB69RDy63xKhBZ10a2CV1SOkdi3v2vKDX165prGeh9WW4ZsxZ2O4R71gBzPe70tfkPZ
	6PvP7xGZGTKeQLPQczPZJ8jf+0SdoVI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-6YgAeruOPku_5mXStTcfyA-1; Sat,
 26 Apr 2025 23:49:19 -0400
X-MC-Unique: 6YgAeruOPku_5mXStTcfyA-1
X-Mimecast-MFC-AGG-ID: 6YgAeruOPku_5mXStTcfyA_1745725758
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D72D1800876;
	Sun, 27 Apr 2025 03:49:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E4D3195608D;
	Sun, 27 Apr 2025 03:49:14 +0000 (UTC)
Date: Sun, 27 Apr 2025 11:49:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 2/4] ublk: enhance check for register/unregister io
 buffer command
Message-ID: <aA2pNRkBhgKsofRP@fedora>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-3-ming.lei@redhat.com>
 <CADUfDZrF71gPfCghE+wNyLXTmtAUprMfpo1XtP1C7kxx-=eP+w@mail.gmail.com>
 <aA2KPuQl1_hTlplG@fedora>
 <CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBhCbzNuNsc9kJTmX2sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBhCbzNuNsc9kJTmX2sA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Apr 26, 2025 at 08:14:18PM -0700, Caleb Sander Mateos wrote:
> On Sat, Apr 26, 2025 at 6:37 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Sat, Apr 26, 2025 at 01:38:14PM -0700, Caleb Sander Mateos wrote:
> > > On Sat, Apr 26, 2025 at 2:41 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> > > > register/unregister io buffer easily, so check it before calling
> > > > starting to register/un-register io buffer.
> > > >
> > > > Also only allow io buffer register/unregister uring_cmd in case of
> > > > UBLK_F_SUPPORT_ZERO_COPY.
> > >
> > > Indeed, both these checks make sense. (Hopefully there aren't any
> > > applications depending on the ability to use ublk zero-copy without
> > > setting the flag.) I too was thinking of adding the
> > > UBLK_IO_FLAG_OWNED_BY_SRV check because it could allow the
> > > kref_get_unless_zero() to be replaced with the cheaper kref_get(). I
> > > think the checks could be split into 2 separate commits, but up to
> > > you.
> >
> > Let's do it in single patch for making everyone easier.
> >
> > >
> > > >
> > > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 23 ++++++++++++++++++++++-
> > > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 40f971a66d3e..347790b3a633 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -609,6 +609,11 @@ static void ublk_apply_params(struct ublk_device *ub)
> > > >                 ublk_dev_param_zoned_apply(ub);
> > > >  }
> > > >
> > > > +static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> > > > +{
> > > > +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > > > +}
> > > > +
> > > >  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> > > >  {
> > > >         return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > > > @@ -1950,9 +1955,16 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > > >                                 unsigned int index, unsigned int issue_flags)
> > > >  {
> > > >         struct ublk_device *ub = cmd->file->private_data;
> > > > +       struct ublk_io *io = &ubq->ios[tag];
> > >
> > > I thought you had mentioned in
> > > https://lore.kernel.org/linux-block/aAmYJxaV1-yWEMRo@fedora/ wanting
> > > to the ability to offload the ublk zero-copy buffer registration to a
> > > thread other than ubq_daemon. Are you still planning to do that, or
> > > does the "auto-register" feature supplant the need for that?
> >
> > The auto-register idea is actually thought of when I was working on ublk
> > selftest offload function.
> >
> > If this auto-register feature is supported, it becomes less important to
> > relax the ubq_daemon limit for register_io_buffer command, then I jump
> > on this feature & post put the patch.
> >
> > But I will continue to work on the offload test code and finally relax
> > the limit for register/unregister io buffer command, hope it can be
> > done in next week.
> >
> > > Accessing
> > > the ublk_io here only seems safe when on the ubq_daemon thread.
> >
> > Both ublk_register_io_buf()/ublk_unregister_io_buf() just reads ublk_io or
> > the request buffer only, so it is just fine for the two to run from other
> > contexts.
> 
> Isn't it racy to check io->flags when it could be concurrently
> modified by another thread (the ubq_daemon)?

Good question!

Yeah, it becomes tricky if registering buffer from other pthread, such as:

- one io handler thread is registering buffer for tag 0 from cpu 0

- UBLK_IO_COMMIT_AND_FETCH_REQ comes on tag 0 from one bad ublk daemon

Then the io handler thread may observe UBLK_IO_FLAG_OWNED_BY_SRV, but
meantime UBLK_IO_COMMIT_AND_FETCH_REQ clears it and completes the request,
and this request may be freed or recycled immediately.  Then the io handler
pthread sees wrong request data.


The approach I mentioned in the following link may help to support 'offload':

https://lore.kernel.org/linux-block/aAscRPVcTBiBHNe7@fedora/

The nice thing is that one batch of commands can be delivered via single or
multiple READ_MULTISHOT, and per-queue spin lock can be used. Same with io
command completion side. And it becomes easier to remove the ubq_daemon
constraint with the per-queue lock.

Thanks,
Ming

