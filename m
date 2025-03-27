Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21048383A2
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040198; cv=none; b=kiNAyftGhVrFhuwYMbB9z2PeerBRrqmU6I3ZNZcLEp9dKMXn1upC5l69ff1p9xJ6Nu8rJiTe8zYMcLreGbzfBxUAHWJR6zTgCDaTOOYgBBSfM5tQc60asEK6VgycjjEvH/PWvUIz7t51KmCbCJOyIjuT5mXymEjC4bbOH5yWSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040198; c=relaxed/simple;
	bh=M/LIqimfCWAFon7+TkETzyTSD2ibTT457L57piMUOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX7p/i/e6ERGa6otwcJo7NR7Grq8yNNiA+LBiwLCywcKxsRAd1wCeyZLV/imrXuudY1xk6rNqsKVoYbSseKpbHTywz3zAUVnPNVIFhi2v88WqAHAT48H8bs4n4PVsrX71coH5/G6uRwsIbLkYLMC3njHRcRvTBi8IiEChFsPs6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6Rw52ik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6Rw52ik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743040194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMMyfhFz4NYFdoLSXreULW/0+U8/08rph0JimTm7UHA=;
	b=W6Rw52ik9V0l820NiZjpoKW7suVzBhSOKaud/KGIvr+EX9XKs5SYfflDVxf9KQQ65BUabk
	3DH0rjC982thLvv17riMJ3Cvthw8FFjn5ifJVOwRXd/+iOCBI0ymhhZv+KJ4OyYH8fqa+V
	xwZZtrdQ/RAfrH4aB80BeS4a5kle/UQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-plQgOVqaM2ONbHP5apBjJw-1; Wed,
 26 Mar 2025 21:49:51 -0400
X-MC-Unique: plQgOVqaM2ONbHP5apBjJw-1
X-Mimecast-MFC-AGG-ID: plQgOVqaM2ONbHP5apBjJw_1743040190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0A161903081;
	Thu, 27 Mar 2025 01:49:49 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A57E1801762;
	Thu, 27 Mar 2025 01:49:44 +0000 (UTC)
Date: Thu, 27 Mar 2025 09:49:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 4/8] ublk: add segment parameter
Message-ID: <Z-SusxWoRQ4W2c99@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-5-ming.lei@redhat.com>
 <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com>
 <Z-IDwx3mv6I90hhg@fedora>
 <CADUfDZpv-EmJy+GZcWL=q5MHg4ovae_kg8k+ewcdrwNTQ_zK9g@mail.gmail.com>
 <Z-NjqBgCc0qduUmd@fedora>
 <CADUfDZrHUbpRPkZ2UafmET7dd_0aex8o01fB4tiLkzDz5p0phw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrHUbpRPkZ2UafmET7dd_0aex8o01fB4tiLkzDz5p0phw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Mar 26, 2025 at 09:43:13AM -0700, Caleb Sander Mateos wrote:
> On Tue, Mar 25, 2025 at 7:17 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Mar 25, 2025 at 12:43:26PM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Mar 24, 2025 at 6:16 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Mon, Mar 24, 2025 at 03:26:06PM -0700, Caleb Sander Mateos wrote:
> > > > > On Mon, Mar 24, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > IO split is usually bad in io_uring world, since -EAGAIN is caused and
> > > > > > IO handling may have to fallback to io-wq, this way does hurt performance.
> > > > > >
> > > > > > ublk starts to support zero copy recently, for avoiding unnecessary IO
> > > > > > split, ublk driver's segment limit should be aligned with backend
> > > > > > device's segment limit.
> > > > > >
> > > > > > Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
> > > > > > which number is aligned with ublk request segment number, so that big
> > > > > > memory allocation can be avoided by setting reasonable max_segments limit.
> > > > > >
> > > > > > So add segment parameter for providing ublk server chance to align
> > > > > > segment limit with backend, and keep it reasonable from implementation
> > > > > > viewpoint.
> > > > > >
> > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > ---
> > > > > >  drivers/block/ublk_drv.c      | 15 ++++++++++++++-
> > > > > >  include/uapi/linux/ublk_cmd.h |  9 +++++++++
> > > > > >  2 files changed, 23 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > > index acb6aed7be75..53a463681a41 100644
> > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > @@ -74,7 +74,7 @@
> > > > > >  #define UBLK_PARAM_TYPE_ALL                                \
> > > > > >         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > > > > >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > > > > -        UBLK_PARAM_TYPE_DMA_ALIGN)
> > > > > > +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > > > >
> > > > > >  struct ublk_rq_data {
> > > > > >         struct kref ref;
> > > > > > @@ -580,6 +580,13 @@ static int ublk_validate_params(const struct ublk_device *ub)
> > > > > >                         return -EINVAL;
> > > > > >         }
> > > > > >
> > > > > > +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> > > > > > +               const struct ublk_param_segment *p = &ub->params.seg;
> > > > > > +
> > > > > > +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> > > > > > +                       return -EINVAL;
> > > > >
> > > > > Looking at blk_validate_limits(), it seems like there are some
> > > > > additional requirements? Looks like seg_boundary_mask has to be at
> > > > > least PAGE_SIZE - 1
> > > >
> > > > Yeah, it isn't done in ublk because block layer runs the check, and it
> > > > will be failed when starting the device. That said we take block layer's
> > > > default setting, which isn't good from UAPI viewpoint, since block
> > > > layer may change the default setting.
> > >
> > > Even though blk_validate_limits() rejects it, it appears to log a
> > > warning. That seems undesirable for something controllable from
> > > userspace.
> > > /*
> > >  * By default there is no limit on the segment boundary alignment,
> > >  * but if there is one it can't be smaller than the page size as
> > >  * that would break all the normal I/O patterns.
> > >  */
> > > if (!lim->seg_boundary_mask)
> > >         lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> > > if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
> > >         return -EINVAL;
> >
> > Yes, it has been addressed in my local version, and we need to make it
> > a hw/sw interface.
> >
> > >
> > > >
> > > > Also it is bad to associate device property with PAGE_SIZE which is
> > > > a variable actually. The latest kernel has replaced PAGE_SIZE with 4096
> > > > for segment limits.
> > > >
> > > > I think we can take 4096 for validation here.
> > > >
> > > > > and max_segment_size has to be at least PAGE_SIZE
> > > > > if virt_boundary_mask is set?
> > > >
> > > > If virt_boundary_mask is set, max_segment_size will be ignored usually
> > > > except for some stacking devices.
> > >
> > > Sorry, I had it backwards. The requirement is if virt_boundary_mask is
> > > *not* set:
> > > /*
> > >  * Stacking device may have both virtual boundary and max segment
> > >  * size limit, so allow this setting now, and long-term the two
> > >  * might need to move out of stacking limits since we have immutable
> > >  * bvec and lower layer bio splitting is supposed to handle the two
> > >  * correctly.
> > >  */
> > > if (lim->virt_boundary_mask) {
> > >         if (!lim->max_segment_size)
> > >                 lim->max_segment_size = UINT_MAX;
> > > } else {
> > >         /*
> > >          * The maximum segment size has an odd historic 64k default that
> > >          * drivers probably should override.  Just like the I/O size we
> > >          * require drivers to at least handle a full page per segment.
> > >          */
> > >         if (!lim->max_segment_size)
> > >                 lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> > >         if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
> > >                 return -EINVAL;
> > > }
> >
> > Right.
> >
> > Please feel free to see if the revised patch is good:
> >
> >
> > From 0718b9f130b3bc9b9b06907c687fb5b9eea172f7 Mon Sep 17 00:00:00 2001
> > From: Ming Lei <ming.lei@redhat.com>
> > Date: Mon, 24 Mar 2025 12:33:59 +0000
> > Subject: [PATCH V2 3/8] ublk: add segment parameter
> >
> > IO split is usually bad in io_uring world, since -EAGAIN is caused and
> > IO handling may have to fallback to io-wq, this way does hurt performance.
> >
> > ublk starts to support zero copy recently, for avoiding unnecessary IO
> > split, ublk driver's segment limit should be aligned with backend
> > device's segment limit.
> >
> > Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
> > which number is aligned with ublk request segment number, so that big
> > memory allocation can be avoided by setting reasonable max_segments limit.
> >
> > So add segment parameter for providing ublk server chance to align
> > segment limit with backend, and keep it reasonable from implementation
> > viewpoint.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 20 +++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h | 21 +++++++++++++++++++++
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 6fa1384c6436..6367476cef2b 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -74,7 +74,7 @@
> >  #define UBLK_PARAM_TYPE_ALL                                \
> >         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > -        UBLK_PARAM_TYPE_DMA_ALIGN)
> > +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> >
> >  struct ublk_rq_data {
> >         struct kref ref;
> > @@ -580,6 +580,18 @@ static int ublk_validate_params(const struct ublk_device *ub)
> >                         return -EINVAL;
> >         }
> >
> > +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> > +               const struct ublk_param_segment *p = &ub->params.seg;
> > +
> > +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> > +                       return -EINVAL;
> > +
> > +               if (p->seg_boundary_mask + 1 < UBLK_MIN_SEGMENT_SIZE)
> > +                       return -EINVAL;
> > +               if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
> > +                       return -EINVAL;
> 
> These checks look good, except they don't allow omitting
> seg_boundary_mask or max_segment_size. I can imagine a ublk server
> might want to set only some of the segment limits and leave the others
> as 0?

Any unset field in `ublk_param_segment` should be undefined behavior(or either
rejected or one default value is taken), we can document it.

Thanks for raising the issue.

`seg_boundary_mask` is very similar with `max_segment_size`, so if either
one of the two are set, the other one should get one default value if it is unset.

If either one of the above two are set, 'max_segments' can't be zero.


Thanks,
Ming

