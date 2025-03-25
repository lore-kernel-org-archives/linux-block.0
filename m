Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57BBE46
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742865363; cv=none; b=aCl6a3A6yMYPqAedLxlqpt3kv5up9FUk3P/Zv2iydY+Ig2xuGbF3vNd9uVAJywoAW3FCyPCnPp1hV1vvqasxRMq3ZVWNmD5HOW9I9F4s0zLfpnZrSKsyIBERL6CMQdnN/WyABJgzrQzOwK24ezP2VTeC/S/kYqPWrvhviP+T5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742865363; c=relaxed/simple;
	bh=q05H6Yi7GqkoXd+Ap5e7r1lu8iZLBIP9AYS9WAzcXZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHW6iLElLK8VXuASlLf3YSFGR+W/OxAu9VmeQVtEO72t1H9uamwhI9QT6rCU2Sv/dfrFFNyKRPurcll5+oSZU54CsfkK7jbx3pvzZbVhlzQYXpmU1vCv9hWy0M4biKnBLwWtAX2IxxCTr0azh3+nzRnZkBhQS5jo9QlutRGJBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzrBFr6o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzrBFr6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742865360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWhy7OQZ9/dAt5XhDJ5uI3VBXgmVv5BFFNnPNIxGfQo=;
	b=LzrBFr6oHvwwqEijYLPyxstDnXNkBwnR5paGaiAfJrWQB6JO6Wxk6+RKZXUuYPzM3NKm9q
	3Ruhp0HnJQZ/w4sAvQAOQoWCS2I5FLnXQRBppyhUmtknoK3JG3SDCttZcpYtC9j2J7yI0C
	y0f9gUEbMO/ZaAHyoIwxFoyVLmWFNjE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-cOD8YaBFNByP3kiSbGtf9g-1; Mon,
 24 Mar 2025 21:15:58 -0400
X-MC-Unique: cOD8YaBFNByP3kiSbGtf9g-1
X-Mimecast-MFC-AGG-ID: cOD8YaBFNByP3kiSbGtf9g_1742865357
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 320331800259;
	Tue, 25 Mar 2025 01:15:57 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1647419541A5;
	Tue, 25 Mar 2025 01:15:52 +0000 (UTC)
Date: Tue, 25 Mar 2025 09:15:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 4/8] ublk: add segment parameter
Message-ID: <Z-IDwx3mv6I90hhg@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-5-ming.lei@redhat.com>
 <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Mar 24, 2025 at 03:26:06PM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 24, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
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
> >  drivers/block/ublk_drv.c      | 15 ++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |  9 +++++++++
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index acb6aed7be75..53a463681a41 100644
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
> > @@ -580,6 +580,13 @@ static int ublk_validate_params(const struct ublk_device *ub)
> >                         return -EINVAL;
> >         }
> >
> > +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> > +               const struct ublk_param_segment *p = &ub->params.seg;
> > +
> > +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> > +                       return -EINVAL;
> 
> Looking at blk_validate_limits(), it seems like there are some
> additional requirements? Looks like seg_boundary_mask has to be at
> least PAGE_SIZE - 1

Yeah, it isn't done in ublk because block layer runs the check, and it
will be failed when starting the device. That said we take block layer's
default setting, which isn't good from UAPI viewpoint, since block
layer may change the default setting.

Also it is bad to associate device property with PAGE_SIZE which is
a variable actually. The latest kernel has replaced PAGE_SIZE with 4096
for segment limits.

I think we can take 4096 for validation here.

> and max_segment_size has to be at least PAGE_SIZE
> if virt_boundary_mask is set?

If virt_boundary_mask is set, max_segment_size will be ignored usually
except for some stacking devices.


Thanks,
Ming

