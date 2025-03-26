Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457B2904
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955452; cv=none; b=RxsJXH8ktERJ78w2rp54LrQUQgfQvOMKg8xwY8gX3Bz0tuRAz+IoYBh+9U+Cf0dpWJNM6Ri2f3vvFaCM0eHull+2n6RD93OMDEa29LVL/wFW6nrEOhOkagQKGN49HbRuMw+Jw4rNZniurr7vmAh6FeRrsE6TdLhsA0wjjWJME+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955452; c=relaxed/simple;
	bh=lqJid3/NyecA7UT65osy2u+IzmTyK6s5wrVXbaZTBkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYQ53eS1PGWO/vkwZsfUZpNFCD5kDaVGa4U2QXnTinT/bWQdy/q+fnBqbRNGljno+YuszXZwAGttPHHCjd1X/Ur5dES19HWy29cshWrejL0B9mjuNAbFOE4YSBQpSqGpxaFKnxYAOgtuhurAMK5o6Qo9YKTlyWZ69TegVgoF3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP409Z43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP409Z43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742955448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OHG7LwMSkw6boYcbWQRhJRiL8tV84BzCIPX4PzCp4w=;
	b=iP409Z43OgQCyiM8tjK2BdAN5vUVFsKueSDAOk/psWKlVVHWIdylidCjdR3WjrbDiK9TqM
	jggzIQkcjmu8aH5UfcWPSugsJVE9HF5gO3hZrYbBmK0st18DqpguQxjXtPhsedMEDyEgs8
	IMl6oOCmbGKGwj4iGym+2Hhn1POTJE0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-xU7JWYvvPvuO0nQFrHAzmQ-1; Tue,
 25 Mar 2025 22:17:25 -0400
X-MC-Unique: xU7JWYvvPvuO0nQFrHAzmQ-1
X-Mimecast-MFC-AGG-ID: xU7JWYvvPvuO0nQFrHAzmQ_1742955444
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 881DE190308B;
	Wed, 26 Mar 2025 02:17:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C47B119560AB;
	Wed, 26 Mar 2025 02:17:18 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:17:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 4/8] ublk: add segment parameter
Message-ID: <Z-NjqBgCc0qduUmd@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-5-ming.lei@redhat.com>
 <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com>
 <Z-IDwx3mv6I90hhg@fedora>
 <CADUfDZpv-EmJy+GZcWL=q5MHg4ovae_kg8k+ewcdrwNTQ_zK9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpv-EmJy+GZcWL=q5MHg4ovae_kg8k+ewcdrwNTQ_zK9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Mar 25, 2025 at 12:43:26PM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 24, 2025 at 6:16 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 03:26:06PM -0700, Caleb Sander Mateos wrote:
> > > On Mon, Mar 24, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > IO split is usually bad in io_uring world, since -EAGAIN is caused and
> > > > IO handling may have to fallback to io-wq, this way does hurt performance.
> > > >
> > > > ublk starts to support zero copy recently, for avoiding unnecessary IO
> > > > split, ublk driver's segment limit should be aligned with backend
> > > > device's segment limit.
> > > >
> > > > Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
> > > > which number is aligned with ublk request segment number, so that big
> > > > memory allocation can be avoided by setting reasonable max_segments limit.
> > > >
> > > > So add segment parameter for providing ublk server chance to align
> > > > segment limit with backend, and keep it reasonable from implementation
> > > > viewpoint.
> > > >
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 15 ++++++++++++++-
> > > >  include/uapi/linux/ublk_cmd.h |  9 +++++++++
> > > >  2 files changed, 23 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index acb6aed7be75..53a463681a41 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -74,7 +74,7 @@
> > > >  #define UBLK_PARAM_TYPE_ALL                                \
> > > >         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> > > >          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > > > -        UBLK_PARAM_TYPE_DMA_ALIGN)
> > > > +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > > >
> > > >  struct ublk_rq_data {
> > > >         struct kref ref;
> > > > @@ -580,6 +580,13 @@ static int ublk_validate_params(const struct ublk_device *ub)
> > > >                         return -EINVAL;
> > > >         }
> > > >
> > > > +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> > > > +               const struct ublk_param_segment *p = &ub->params.seg;
> > > > +
> > > > +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> > > > +                       return -EINVAL;
> > >
> > > Looking at blk_validate_limits(), it seems like there are some
> > > additional requirements? Looks like seg_boundary_mask has to be at
> > > least PAGE_SIZE - 1
> >
> > Yeah, it isn't done in ublk because block layer runs the check, and it
> > will be failed when starting the device. That said we take block layer's
> > default setting, which isn't good from UAPI viewpoint, since block
> > layer may change the default setting.
> 
> Even though blk_validate_limits() rejects it, it appears to log a
> warning. That seems undesirable for something controllable from
> userspace.
> /*
>  * By default there is no limit on the segment boundary alignment,
>  * but if there is one it can't be smaller than the page size as
>  * that would break all the normal I/O patterns.
>  */
> if (!lim->seg_boundary_mask)
>         lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
>         return -EINVAL;

Yes, it has been addressed in my local version, and we need to make it
a hw/sw interface.

> 
> >
> > Also it is bad to associate device property with PAGE_SIZE which is
> > a variable actually. The latest kernel has replaced PAGE_SIZE with 4096
> > for segment limits.
> >
> > I think we can take 4096 for validation here.
> >
> > > and max_segment_size has to be at least PAGE_SIZE
> > > if virt_boundary_mask is set?
> >
> > If virt_boundary_mask is set, max_segment_size will be ignored usually
> > except for some stacking devices.
> 
> Sorry, I had it backwards. The requirement is if virt_boundary_mask is
> *not* set:
> /*
>  * Stacking device may have both virtual boundary and max segment
>  * size limit, so allow this setting now, and long-term the two
>  * might need to move out of stacking limits since we have immutable
>  * bvec and lower layer bio splitting is supposed to handle the two
>  * correctly.
>  */
> if (lim->virt_boundary_mask) {
>         if (!lim->max_segment_size)
>                 lim->max_segment_size = UINT_MAX;
> } else {
>         /*
>          * The maximum segment size has an odd historic 64k default that
>          * drivers probably should override.  Just like the I/O size we
>          * require drivers to at least handle a full page per segment.
>          */
>         if (!lim->max_segment_size)
>                 lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
>         if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
>                 return -EINVAL;
> }

Right.

Please feel free to see if the revised patch is good:


From 0718b9f130b3bc9b9b06907c687fb5b9eea172f7 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 24 Mar 2025 12:33:59 +0000
Subject: [PATCH V2 3/8] ublk: add segment parameter

IO split is usually bad in io_uring world, since -EAGAIN is caused and
IO handling may have to fallback to io-wq, this way does hurt performance.

ublk starts to support zero copy recently, for avoiding unnecessary IO
split, ublk driver's segment limit should be aligned with backend
device's segment limit.

Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
which number is aligned with ublk request segment number, so that big
memory allocation can be avoided by setting reasonable max_segments limit.

So add segment parameter for providing ublk server chance to align
segment limit with backend, and keep it reasonable from implementation
viewpoint.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 20 +++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h | 21 +++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6fa1384c6436..6367476cef2b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -74,7 +74,7 @@
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
-	 UBLK_PARAM_TYPE_DMA_ALIGN)
+	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
 struct ublk_rq_data {
 	struct kref ref;
@@ -580,6 +580,18 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
+		const struct ublk_param_segment *p = &ub->params.seg;
+
+		if (!is_power_of_2(p->seg_boundary_mask + 1))
+			return -EINVAL;
+
+		if (p->seg_boundary_mask + 1 < UBLK_MIN_SEGMENT_SIZE)
+			return -EINVAL;
+		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -2346,6 +2358,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN)
 		lim.dma_alignment = ub->params.dma.alignment;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
+		lim.seg_boundary_mask = ub->params.seg.seg_boundary_mask;
+		lim.max_segment_size = ub->params.seg.max_segment_size;
+		lim.max_segments = ub->params.seg.max_segments;
+	}
+
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 7255b36b5cf6..ffa805b05141 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -410,6 +410,25 @@ struct ublk_param_dma_align {
 	__u8	pad[4];
 };
 
+#define UBLK_MIN_SEGMENT_SIZE   4096
+struct ublk_param_segment {
+	/*
+	 * seg_boundary_mask + 1 needs to be power_of_2(), and the sum has
+	 * to be >= UBLK_MIN_SEGMENT_SIZE(4096)
+	 */
+	__u64 	seg_boundary_mask;
+
+	/*
+	 * max_segment_size could be override by virt_boundary_mask, so be
+	 * careful when setting both.
+	 *
+	 * max_segment_size has to be >= UBLK_MIN_SEGMENT_SIZE(4096)
+	 */
+	__u32 	max_segment_size;
+	__u16 	max_segments;
+	__u8	pad[2];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -423,6 +442,7 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
+#define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
@@ -430,6 +450,7 @@ struct ublk_params {
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
 	struct ublk_param_dma_align	dma;
+	struct ublk_param_segment	seg;
 };
 
 #endif
-- 
2.47.0



Thanks,
Ming

