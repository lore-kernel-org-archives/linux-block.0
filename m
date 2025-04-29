Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127A2FB2
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745890610; cv=none; b=BDiZEUGWrc1yiEDghRL/LAoLO4lc3DwpQU8CusAIY+xXzlS6FoH2Mu2pR+8reQUHdWJKyZ0p6YIa+AqmVbdYt7L+H//Nzk1POoXzfV7SKR6fA+zhWgpqEM07FFCD+n97tTCUj3BV+63sXvv3NpbjdCFnGG9sJyMt1fpX13/a8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745890610; c=relaxed/simple;
	bh=nJKacFpU1WSa+/Jl/F+L1fpik1X7EwRizCAZhU7Akew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVgB2bnR/W4aetsS/oX6dWAUGl8fri5wJM8Vh+45DsoD7vfrvPg8a8Qz/x9srmhsjHzLzhi7DZ70NsuUyivm0Km95aNFy/dhd5XpzL9LExTuEihGOnHW5W5P92+sW3zH/TdwiyrjtCfpeuuHx7bBClfvzCMaVptGE2rnpE/5+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRaDQqBU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRaDQqBU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745890607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaECNEITXR8YE73AoCrpiKvZypWzmz8xCsvjNKxtt08=;
	b=MRaDQqBUVefyiVmby/6EEYf1COXvsW/5yImAqzGZfrv5W0LC0eC0vq4dIQkzawmtFPAB6R
	2j8mqu6jSVPVYp2+aEsh+ZK1xjd1bIAR0BrJATUgUOZcqw4K2yrUsOdvQtJenU/gJslgV0
	bQAhvb/+HnP54B/SuHbxr8x6YTIHbCw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-ol9o-WRiMG2lSmqdoUOz7g-1; Mon,
 28 Apr 2025 21:36:44 -0400
X-MC-Unique: ol9o-WRiMG2lSmqdoUOz7g-1
X-Mimecast-MFC-AGG-ID: ol9o-WRiMG2lSmqdoUOz7g_1745890603
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CC101956048;
	Tue, 29 Apr 2025 01:36:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CBA01956094;
	Tue, 29 Apr 2025 01:36:38 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:36:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v6.15 2/3] ublk: decouple zero copy from user copy
Message-ID: <aBAtIf4cvR_Xd9Hb@fedora>
References: <20250427134932.1480893-1-ming.lei@redhat.com>
 <20250427134932.1480893-3-ming.lei@redhat.com>
 <CADUfDZq4m2ndHPmbWnECXWCYO_o7X-ys37=10gqMMYcO+xEJhA@mail.gmail.com>
 <aBAjlJXxz97F4ZOC@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBAjlJXxz97F4ZOC@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 29, 2025 at 08:55:48AM +0800, Ming Lei wrote:
> On Mon, Apr 28, 2025 at 09:01:04AM -0700, Caleb Sander Mateos wrote:
> > On Sun, Apr 27, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > UBLK_F_USER_COPY and UBLK_F_SUPPORT_ZERO_COPY are two different
> > > features, and shouldn't be coupled together.
> > >
> > > Commit 1f6540e2aabb ("ublk: zc register/unregister bvec") enables
> > > user copy automatically in case of UBLK_F_SUPPORT_ZERO_COPY, this way
> > > isn't correct.
> > >
> > > So decouple zero copy from user copy, and use independent helper to
> > > check each one.
> > 
> > I agree this makes sense.
> > 
> > >
> > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++------------
> > >  1 file changed, 23 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 40f971a66d3e..0a3a3c64316d 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -205,11 +205,6 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> > >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > >  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
> > >                                                    int tag);
> > > -static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
> > > -{
> > > -       return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > > -}
> > > -
> > >  static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> > >  {
> > >         return ub->dev_info.flags & UBLK_F_ZONED;
> > > @@ -609,14 +604,19 @@ static void ublk_apply_params(struct ublk_device *ub)
> > >                 ublk_dev_param_zoned_apply(ub);
> > >  }
> > >
> > > +static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> > > +{
> > > +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > > +}
> > > +
> > >  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> > >  {
> > > -       return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > > +       return ubq->flags & UBLK_F_USER_COPY;
> > >  }
> > >
> > >  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
> > >  {
> > > -       return !ublk_support_user_copy(ubq);
> > > +       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
> > >  }
> > >
> > >  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> > > @@ -624,8 +624,11 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> > >         /*
> > >          * read()/write() is involved in user copy, so request reference
> > >          * has to be grabbed
> > > +        *
> > > +        * for zero copy, request buffer need to be registered to io_uring
> > > +        * buffer table, so reference is needed
> > >          */
> > > -       return ublk_support_user_copy(ubq);
> > > +       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq);
> > >  }
> > >
> > >  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> > > @@ -2245,6 +2248,9 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
> > >         if (!ubq)
> > >                 return ERR_PTR(-EINVAL);
> > >
> > > +       if (!ublk_support_user_copy(ubq))
> > > +               return ERR_PTR(-EACCES);
> > 
> > This partly overlaps with the existing ublk_need_req_ref() check in
> > __ublk_check_and_get_req() (although that allows
> > UBLK_F_SUPPORT_ZERO_COPY too). Can that check be removed now that the
> > callers explicitly check ublk_support_user_copy() or
> > ublk_support_zero_copy()?
> 
> Yeah, it can be removed.

Actually the removal can only be done after the 3rd patch is applied with
zero copy check is added.



Thanks,
Ming

