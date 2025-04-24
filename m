Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902420322
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459650; cv=none; b=ZFAtx6H+ObH5EbDpa4Wdr3PRD5OqmRdYYa8b4nTPyz9Rol3Aeb07PBlPpRyXjOpD04VVS32/Z70eomhL7Zgb9OLDagyd1iP6mU9GGn9BIob2vtmNKmpjOVZ975Up4TTtUXiljOTOH/wtsfkE+6KpyHn0z0k+ZnA0z4TNRwtqyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459650; c=relaxed/simple;
	bh=A+4TRpl4uVyfLxEmUw6gc2R/mxt6IHtcHPcUF0SzGV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfGemWYhf7UsUJEZ/rT3PblYw4A30twFYbiNkd7J5JcVgdGiQVgcXYmAFanrySg8IwoBMaXWUYy5BeajtxIOn4VHsOMKolTiKUkh/eqjd/dVrrc6wX/bw3TlMUk9PN/T06xGea4Cs7dXNfdXf/7QhpZ+gDPFiN09As5/OnjDHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CH3pdFus; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CH3pdFus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745459646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuIsw35HSnvLni7HaK50xc2Kw6jlgdcRYW/pX9/vtJA=;
	b=CH3pdFusz1zNsCwshB1ZznloWlWMrVlZxKoar6PQwMBA4ALesgJZmu0JpS8x6SG7AWK4pA
	1KLMD78oRIPbqSq0Kok6MaKFzaPHPYAQAC/g/vIEGWz/NQ1Yl8vYAXOmvlJ5od6Zdj6YBd
	luaRH/L0pRcvJUjUmu/gFJwGA5c5BUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-63ENfR8JOOWwD4Mj78JY-g-1; Wed,
 23 Apr 2025 21:54:02 -0400
X-MC-Unique: 63ENfR8JOOWwD4Mj78JY-g-1
X-Mimecast-MFC-AGG-ID: 63ENfR8JOOWwD4Mj78JY-g_1745459641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 649E11800360;
	Thu, 24 Apr 2025 01:54:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E27191800374;
	Thu, 24 Apr 2025 01:53:55 +0000 (UTC)
Date: Thu, 24 Apr 2025 09:53:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH 1/2] ublk: call ublk_dispatch_req() for handling
 UBLK_U_IO_NEED_GET_DATA
Message-ID: <aAmZrnruWd6aYS4k@fedora>
References: <20250423092405.919195-1-ming.lei@redhat.com>
 <20250423092405.919195-2-ming.lei@redhat.com>
 <CADUfDZrh6pO6rCXN-QbTY3EX+EyYFvRW96o0Lf_kuEBMQ8ysEQ@mail.gmail.com>
 <CADUfDZohH1b75w6pnNduEpTCUp6RFbWv0HCoNT-d2k9yUvmCuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZohH1b75w6pnNduEpTCUp6RFbWv0HCoNT-d2k9yUvmCuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Apr 23, 2025 at 07:52:19AM -0700, Caleb Sander Mateos wrote:
> On Wed, Apr 23, 2025 at 7:44 AM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Apr 23, 2025 at 2:24 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > The in-tree code calls io_uring_cmd_complete_in_task() to schedule
> > > task_work for dispatching this request to handle
> > > UBLK_U_IO_NEED_GET_DATA.
> > >
> > > This ways is really not necessary because the current context is exactly
> > > the ublk queue context, so call ublk_dispatch_req() directly for handling
> > > UBLK_U_IO_NEED_GET_DATA.
> >
> > Indeed, I was planning to make the same change!
> >
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 14 +++-----------
> > >  1 file changed, 3 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 2de7b2bd409d..c4d4be4f6fbd 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1886,15 +1886,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> > >         }
> > >  }
> > >
> > > -static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> > > -               int tag)
> > > -{
> > > -       struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> > > -       struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
> > > -
> > > -       ublk_queue_cmd(ubq, req);
> > > -}
> >
> > Looks like this will conflict with Uday's patch:
> > https://lore.kernel.org/linux-block/20250421-ublk_constify-v1-3-3371f9e9f73c@purestorage.com/
> > . Since that series already has reviews, I expect it will land first.
> >
> > > -
> > >  static inline int ublk_check_cmd_op(u32 cmd_op)
> > >  {
> > >         u32 ioc_type = _IOC_TYPE(cmd_op);
> > > @@ -2103,8 +2094,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> > >                 if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > >                         goto out;
> > >                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> > > -               ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
> > > -               break;
> > > +               req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
> > > +               ublk_dispatch_req(ubq, req, issue_flags);
> >
> > Maybe it would make sense to factor the UBLK_IO_NEED_GET_DATA handling
> > out of ublk_dispatch_req()? Then ublk_dispatch_req() (called only for
> > incoming ublk requests) could assume the UBLK_IO_FLAG_NEED_GET_DATA
> > flag is not yet set, and this path wouldn't need to pay the cost of
> > re-checking current != ubq->ubq_daemon, ublk_need_get_data(ubq) &&
> > ublk_need_map_req(req), etc.
> >
> > > +               return -EIOCBQUEUED;
> >
> > It's probably possible to return the result here synchronously to
> > avoid the small overhead of io_uring_cmd_done(). That may be easier to
> > do if the UBLK_IO_NEED_GET_DATA path is separated from
> > ublk_dispatch_req().
> 
> And if we can avoid using io_uring_cmd_done(), calling
> ublk_fill_io_cmd() for UBLK_IO_NEED_GET_DATA would no longer be
> necessary. (This was my original motivation to handle
> UBLK_IO_NEED_GET_DATA synchronously; UBLK_IO_NEED_GET_DATA overwriting
> io->cmd is an obstacle to introducing a struct request * field that
> aliases io->cmd.)

All your comments are reasonable.

Here I just want to keep it simple for backport purpose, and we can clean
up them all by one followup.


Thanks,
Ming

