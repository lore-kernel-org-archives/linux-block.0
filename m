Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FEF9C1
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888162; cv=none; b=S0t1m9fsVMAOJ08m0Zh2btw/flxBiNEx8tWxwWGURRAS4OETLZCTM2XkC0Qi5V7yKBG+R85fEmXbOreobSqPQJpekn+D5yj+PscEwdAOQ3kk5zEKEUdp7UUIVDDiEpdaF1riwsWQ9H41sxSnTK63tkObWhjt4hjeO5K8SHRTHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888162; c=relaxed/simple;
	bh=c+UX+GrIWHen2s/RpYETnSQYeqX2k8+1bfUDhtVvjdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q23RdmvhJXqwcKmKp6yC5nTo/pfZOR6AkETW8Wr7CsxF0dTJRw5dxljqf8aMGF3NqAwrlztu7CnuixihnzGGksbv6fWA3phA0ohBw81pB8YG6NPaolOZnoKGfgyEP2C0AvKl8CwZgbvg1oqIa3J+cCB+5wlh8lqfhrQhKNxoDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kihjysdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kihjysdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745888159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDWllBE+gO3tvponk4l1UyIJSuMJM3BKiZHNfvaXAtk=;
	b=KihjysdnRLuMnR781WwIPgJZMjw8QB8o68/OZEtqnfYHrHiOfshFsPFYioadigQI98pyjd
	jjgBxCSd4hAKlyM7MDNn/tKcUJ+SW9jGVLTnddM6In8voOrb4yAecNygBEeYrGcdHhI+rL
	y7lAiH0ikiq4NNYumRlaGwGzXORLPOk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-WwK_eD8bM2CDN1_U_HEa_g-1; Mon,
 28 Apr 2025 20:55:57 -0400
X-MC-Unique: WwK_eD8bM2CDN1_U_HEa_g-1
X-Mimecast-MFC-AGG-ID: WwK_eD8bM2CDN1_U_HEa_g_1745888156
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4009718004A7;
	Tue, 29 Apr 2025 00:55:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D979B180047F;
	Tue, 29 Apr 2025 00:55:52 +0000 (UTC)
Date: Tue, 29 Apr 2025 08:55:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v6.15 2/3] ublk: decouple zero copy from user copy
Message-ID: <aBAjlJXxz97F4ZOC@fedora>
References: <20250427134932.1480893-1-ming.lei@redhat.com>
 <20250427134932.1480893-3-ming.lei@redhat.com>
 <CADUfDZq4m2ndHPmbWnECXWCYO_o7X-ys37=10gqMMYcO+xEJhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq4m2ndHPmbWnECXWCYO_o7X-ys37=10gqMMYcO+xEJhA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 28, 2025 at 09:01:04AM -0700, Caleb Sander Mateos wrote:
> On Sun, Apr 27, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > UBLK_F_USER_COPY and UBLK_F_SUPPORT_ZERO_COPY are two different
> > features, and shouldn't be coupled together.
> >
> > Commit 1f6540e2aabb ("ublk: zc register/unregister bvec") enables
> > user copy automatically in case of UBLK_F_SUPPORT_ZERO_COPY, this way
> > isn't correct.
> >
> > So decouple zero copy from user copy, and use independent helper to
> > check each one.
> 
> I agree this makes sense.
> 
> >
> > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++------------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 40f971a66d3e..0a3a3c64316d 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -205,11 +205,6 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> >  static inline unsigned int ublk_req_build_flags(struct request *req);
> >  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
> >                                                    int tag);
> > -static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
> > -{
> > -       return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > -}
> > -
> >  static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> >  {
> >         return ub->dev_info.flags & UBLK_F_ZONED;
> > @@ -609,14 +604,19 @@ static void ublk_apply_params(struct ublk_device *ub)
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
> > -       return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > +       return ubq->flags & UBLK_F_USER_COPY;
> >  }
> >
> >  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
> >  {
> > -       return !ublk_support_user_copy(ubq);
> > +       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq);
> >  }
> >
> >  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> > @@ -624,8 +624,11 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> >         /*
> >          * read()/write() is involved in user copy, so request reference
> >          * has to be grabbed
> > +        *
> > +        * for zero copy, request buffer need to be registered to io_uring
> > +        * buffer table, so reference is needed
> >          */
> > -       return ublk_support_user_copy(ubq);
> > +       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq);
> >  }
> >
> >  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> > @@ -2245,6 +2248,9 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
> >         if (!ubq)
> >                 return ERR_PTR(-EINVAL);
> >
> > +       if (!ublk_support_user_copy(ubq))
> > +               return ERR_PTR(-EACCES);
> 
> This partly overlaps with the existing ublk_need_req_ref() check in
> __ublk_check_and_get_req() (although that allows
> UBLK_F_SUPPORT_ZERO_COPY too). Can that check be removed now that the
> callers explicitly check ublk_support_user_copy() or
> ublk_support_zero_copy()?

Yeah, it can be removed.


Thanks, 
Ming

