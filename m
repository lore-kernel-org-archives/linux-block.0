Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC3247DF9
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416031; cv=none; b=MWVs0Ny9Z5jwxLt+nKRSDZk9Dp5ZXlGFsjjfQY4pO2HMbzZZxJxKhLxm3LQqRIZPIHuxRDFC0prC4ooFtpSi48Y+5YiMsXCj3ziSLT1d9cTu/w78kvXC2pNEGWXBd1uq+WU2giZuiCpM7Br5+Ghi+4hjOp2rWJV2ebJcOMHqKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416031; c=relaxed/simple;
	bh=IsyHVr+oNPWhKs37WYyOsu5eYAFphhoa7rLwLZOjktk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFEPBbSX2RwhjMoyJAz5syFfgB+ZVI/0Yk3iKmQGanSmBVfYqmZlyVVgpZmhqBEep38q+axvicAJK/CVRfZ2iLxVFNbqWWjkJjS/3rnmf3T1QYdAQHJD00upHntNo1pZlyBKRre1N2cggthAGE7OmoTP1KjJm44CiQ62gqoP2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dA4nkU5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA4nkU5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752416027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/KY95ixncqz5SSiiUhsPqSzMiJxbxFR9F4vzB4sWlA=;
	b=dA4nkU5yTln8eUoPts8q4Fc6b5UV3FB+UjEb/k4F6grpd587FQm/9YFQw44Msi/e39kAAm
	kjBksp7uJoUL+7aDOoMu9o+q4PP9EWvcBQhUiyJ/uJpdAbO1Q6a0Q107kW9JH8Q/Hpi3/4
	cBVveABZbgS2wJzZXYtz7S1WDMoPpvM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-O7qkJHF7Ph-Zc50J6EbNcA-1; Sun,
 13 Jul 2025 10:13:44 -0400
X-MC-Unique: O7qkJHF7Ph-Zc50J6EbNcA-1
X-Mimecast-MFC-AGG-ID: O7qkJHF7Ph-Zc50J6EbNcA_1752416023
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA5C18001D6;
	Sun, 13 Jul 2025 14:13:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7AAC30001A1;
	Sun, 13 Jul 2025 14:13:36 +0000 (UTC)
Date: Sun, 13 Jul 2025 22:13:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 07/16] ublk: add helper ublk_check_fetch_buf()
Message-ID: <aHO_BLnBB9RAalrO@fedora>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
 <20250702040344.1544077-8-ming.lei@redhat.com>
 <CADUfDZrY0H4w1PNjGiSvE0jr4dGu=UjC3nq+6ejze7kut22KLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrY0H4w1PNjGiSvE0jr4dGu=UjC3nq+6ejze7kut22KLw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jul 08, 2025 at 08:31:05AM -0400, Caleb Sander Mateos wrote:
> On Wed, Jul 2, 2025 at 12:04 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add helper ublk_check_fetch_buf() for checking buffer only.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> The commit message seems a bit sparse. How about something like:
> Add a helper ublk_check_fetch_buf() to validate UBLK_IO_FETCH_REQ's
> addr. This doesn't require access to the ublk_io, so it can be done
> before taking the ublk_device mutex.

OK, looks much better.

> 
> > ---
> >  drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 6d3aa08eef22..7fd2fa493d6a 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2146,6 +2146,22 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> >         return io_buffer_unregister_bvec(cmd, index, issue_flags);
> >  }
> >
> > +static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_addr)
> > +{
> > +       if (ublk_need_map_io(ubq)) {
> > +               /*
> > +                * FETCH_RQ has to provide IO buffer if NEED GET
> > +                * DATA is not enabled
> > +                */
> > +               if (!buf_addr && !ublk_need_get_data(ubq))
> > +                       return -EINVAL;
> > +       } else if (buf_addr) {
> > +               /* User copy requires addr to be unset */
> > +               return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> > +
> >  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> >                       struct ublk_io *io, __u64 buf_addr)
> >  {
> > @@ -2172,19 +2188,6 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> >
> >         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
> >
> > -       if (ublk_need_map_io(ubq)) {
> > -               /*
> > -                * FETCH_RQ has to provide IO buffer if NEED GET
> > -                * DATA is not enabled
> > -                */
> > -               if (!buf_addr && !ublk_need_get_data(ubq))
> > -                       goto out;
> 
> Was it a bug that this didn't set ret = -EINVAL before jumping to out?
> Looks like ublk_fetch() would incorrectly skip initializing the
> ublk_io and return 0 in this case. So probably this needs a Fixes tag.
> Looks like the bug was introduced by the code movement in b69b8edfb27d
> ("ublk: properly serialize all FETCH_REQs").

Good catch!


Thanks, 
Ming

