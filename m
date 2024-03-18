Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3824CB20
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772513; cv=none; b=auHD/REk4NnRDBDspPiZWcY81inuOY9VGtx6G3WHde2F6dZVmihcnnI1Uv8Hpfvxr27F4MRCMsZTYTst7UoDYfN73dYFEk2Ug5BHCc2tlWYmuk4UrnnqK83PIHCO6kCc9M4Ph8zEL4n0QZSWkA8kU48s0tc67vlMkn7H1WmtlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772513; c=relaxed/simple;
	bh=DWsGDsilpsB7OVc3DBXx9nV3z8G6A8wSq7jeNYcHrWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APROSjY6YeN2eR4tVf1bsMRESmqdUVCwpMfhC/gcw6+7YQW+97o/uLEv1Vc13DwRtme3xOhKXIGuHMEf9klxpVWR/MF25UOh6ejS9xHC83o9CSYo9pvc8xmttiPTuxEdpZY64XAzpfO7vY1xX7Es3YW+r1cXT7fVOPYq9XSy1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyML18aj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyML18aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710772510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/7iwzO+X4o5+R1Cd7AlsgeYIc41kqOdQsUYovr84YI=;
	b=eyML18ajVAhkECLcF3VTc+iGZ1Pf0QPWeHUzPaxsu+gmUOtuwSuVj2+PW0UFauqTsH1Oao
	7WNrR53z2ZQJ0wFMP504pYNdL6WR5gK/vgdZqdbTXw8v4IBfI1u1T1bbzPlhtUfenHpgG0
	W3dV5UmT7zDfcN5OhNcLpZsE3z7dWdA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-a3JquK-SPuyQ95mN5oLtOA-1; Mon,
 18 Mar 2024 10:35:05 -0400
X-MC-Unique: a3JquK-SPuyQ95mN5oLtOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 094373C0D1AD;
	Mon, 18 Mar 2024 14:35:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F298D10F53;
	Mon, 18 Mar 2024 14:35:00 +0000 (UTC)
Date: Mon, 18 Mar 2024 22:34:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 05/14] ublk: don't hard code IO_URING_F_UNLOCKED
Message-ID: <ZfhRDL/3z98bo91y@fedora>
References: <cover.1710720150.git.asml.silence@gmail.com>
 <a3928d3de14d2569efc2edd7fb654a4795ae7f86.1710720150.git.asml.silence@gmail.com>
 <Zff4ShMEcL1WKZ1Q@fedora>
 <61b29658-e6a9-449f-a850-1881af1ecbee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b29658-e6a9-449f-a850-1881af1ecbee@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Mon, Mar 18, 2024 at 12:52:33PM +0000, Pavel Begunkov wrote:
> On 3/18/24 08:16, Ming Lei wrote:
> > On Mon, Mar 18, 2024 at 12:41:50AM +0000, Pavel Begunkov wrote:
> > > uring_cmd implementations should not try to guess issue_flags, just use
> > > a newly added io_uring_cmd_complete(). We're loosing an optimisation in
> > > the cancellation path in ublk_uring_cmd_cancel_fn(), but the assumption
> > > is that we don't care that much about it.
> > > 
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Link: https://lore.kernel.org/r/2f7bc9fbc98b11412d10b8fd88e58e35614e3147.1710514702.git.asml.silence@gmail.com
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > ---
> > >   drivers/block/ublk_drv.c | 18 ++++++++----------
> > >   1 file changed, 8 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index bea3d5cf8a83..97dceecadab2 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1417,8 +1417,7 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
> > >   	return true;
> > >   }
> > > -static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
> > > -		unsigned int issue_flags)
> > > +static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io)
> > >   {
> > >   	bool done;
> > > @@ -1432,15 +1431,14 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
> > >   	spin_unlock(&ubq->cancel_lock);
> > >   	if (!done)
> > > -		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
> > > +		io_uring_cmd_complete(io->cmd, UBLK_IO_RES_ABORT, 0);
> > >   }
> > >   /*
> > >    * The ublk char device won't be closed when calling cancel fn, so both
> > >    * ublk device and queue are guaranteed to be live
> > >    */
> > > -static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
> > > -		unsigned int issue_flags)
> > > +static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd)
> > >   {
> > >   	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > >   	struct ublk_queue *ubq = pdu->ubq;
> > > @@ -1464,7 +1462,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
> > >   	io = &ubq->ios[pdu->tag];
> > >   	WARN_ON_ONCE(io->cmd != cmd);
> > > -	ublk_cancel_cmd(ubq, io, issue_flags);
> > > +	ublk_cancel_cmd(ubq, io);
> > 
> > .cancel_fn is always called with .uring_lock held, so this 'issue_flags' can't
> > be removed, otherwise double task run is caused because .cancel_fn
> > can be called multiple times if the request stays in ctx->cancelable_uring_cmd.
> 
> I see, that's exactly why I was asking whether it can be deferred
> to tw. Let me see if I can get by without that patch, but honestly
> it's a horrible abuse of the ring state. Any ideas how that can be
> cleaned up?

Simply deferring io_uring_cmd_done() in ublk_cancel_cmd() to tw still triggers
warning in  __put_task_struct(), so I'd suggest to add the patch until
it is root-cause & fixed.



Thanks,
Ming

