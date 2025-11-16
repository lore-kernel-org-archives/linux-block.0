Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD69F2116F6
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294548; cv=none; b=sruOS318oK1+7Uin76jhrs0u9Qh3U+ZCQMJUUDIuWgukB3EAtfF6mecj9iiD1X+K10F2jFmNMLT00a4kV01Jtkg5CXsnfWM/wgcEZ7lvzoL5P4zyfvnbi6L4jwcGnROaMEWRKR3cf3wyVZ1hqyl91VSP0xd0oRatsIVnvPDeNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294548; c=relaxed/simple;
	bh=yk/yd2s3Ff4yYZWCmcQqcWO9iWTBae9OqRpzDnijYXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JT1xeqxYrQ3SZ68/MXIEL4oxhcpJNPO1lVwpCexZDJKYdosioYidC29al3O1vczJTBYOtKDWLq6rrDb2kqHOxO6N2BrCwdJLsP4iHM70wBEOWYDpHUHbXv802sjTH3a3IuA/HSl/KMMYfw4JMesvFs//805mhn80gyS8RbIo3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pmv1XlBg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmv1XlBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763294545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBFYEHnWFzPtOCWWWn9S9Vwu4rM/sz5MJeEU5Iv8onU=;
	b=Pmv1XlBgDUnjsNYkeRyE3TJ8yHR6TS8hlzNL89/AY1X1lAwmls8L83YxnxEifuU8RXYKP8
	Nsl/Q9vK2cNk5gTMU5FZuZXypiyyTw7+GNCtMca4AltblwnXydWHL6PDkrv7BFejTfIh/Y
	wCGoRAvdokJBF3nRcQwIXVYjejtLbHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-ciyh47kuM2WPZD2g_X4OsQ-1; Sun,
 16 Nov 2025 07:02:22 -0500
X-MC-Unique: ciyh47kuM2WPZD2g_X4OsQ-1
X-Mimecast-MFC-AGG-ID: ciyh47kuM2WPZD2g_X4OsQ_1763294541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2B2E180045C;
	Sun, 16 Nov 2025 12:02:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC2D18002A6;
	Sun, 16 Nov 2025 12:02:15 +0000 (UTC)
Date: Sun, 16 Nov 2025 20:02:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 06/27] ublk: add helper of __ublk_fetch()
Message-ID: <aRm9QLOI5LT9w-HB@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-7-ming.lei@redhat.com>
 <CADUfDZoSiEjY0w7V1j09u1B=quJsizYKjOBQAGW61PcFtog7GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoSiEjY0w7V1j09u1B=quJsizYKjOBQAGW61PcFtog7GA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Nov 14, 2025 at 09:21:53PM -0800, Caleb Sander Mateos wrote:
> On Wed, Nov 12, 2025 at 1:39 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add helper __ublk_fetch() for refactoring ublk_fetch().
> >
> > Meantime move ublk_config_io_buf() out of __ublk_fetch() to make
> > the code structure cleaner.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 46 +++++++++++++++++++++-------------------
> >  1 file changed, 24 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 5e83c1b2a69e..dd9c35758a46 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2234,39 +2234,41 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
> >         return 0;
> >  }
> >
> > -static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> > -                     struct ublk_io *io, __u64 buf_addr)
> > +static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> > +                       struct ublk_io *io)
> >  {
> > -       int ret = 0;
> > -
> > -       /*
> > -        * When handling FETCH command for setting up ublk uring queue,
> > -        * ub->mutex is the innermost lock, and we won't block for handling
> > -        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> > -        */
> > -       mutex_lock(&ub->mutex);
> >         /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
> > -       if (ublk_dev_ready(ub)) {
> > -               ret = -EBUSY;
> > -               goto out;
> > -       }
> > +       if (ublk_dev_ready(ub))
> > +               return -EBUSY;
> >
> >         /* allow each command to be FETCHed at most once */
> > -       if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> > -               ret = -EINVAL;
> > -               goto out;
> > -       }
> > +       if (io->flags & UBLK_IO_FLAG_ACTIVE)
> > +               return -EINVAL;
> >
> >         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
> >
> >         ublk_fill_io_cmd(io, cmd);
> > -       ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
> > -       if (ret)
> > -               goto out;
> >
> >         WRITE_ONCE(io->task, get_task_struct(current));
> >         ublk_mark_io_ready(ub);
> > -out:
> > +
> > +       return 0;
> > +}
> > +
> > +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> > +                     struct ublk_io *io, __u64 buf_addr)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        * When handling FETCH command for setting up ublk uring queue,
> > +        * ub->mutex is the innermost lock, and we won't block for handling
> > +        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> > +        */
> > +       mutex_lock(&ub->mutex);
> > +       ret = __ublk_fetch(cmd, ub, io);
> > +       if (!ret)
> > +               ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
> 
> This changes ublk_config_io_buf() to be called *after*
> ublk_mark_io_ready(). Is that safe? It seems like io->addr could be
> read in ublk_setup_iod() as soon as the ublk device is marked as ready
> for I/O.

disk can't be added unless acquiring ub->mutex, so it is safe.


Thanks,
Ming

