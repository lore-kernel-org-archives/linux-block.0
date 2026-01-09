Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CB3090FD
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925147; cv=none; b=EXO3zrRbhrnGvy5RVo1HDsQhLZdZfZaEBtbguCGuTr/hK06m/ik6FwKEe8ksS5AX7QaG4njAyOici/CSCHmd8gWjgVAWqNacU7fhaRk60fWHcnRn3k88uCpnSjT2X3XOc+OUHCDn9OgbcPh36IqdNtUw4yx8zpUOOc2FeSCs6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925147; c=relaxed/simple;
	bh=ILwir8yw/IkWiMLd4RhvrLT8ludjRL93YtRjprT7fMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvgRZEEzuanFj9ZhzVSfFf4lZBqMMj5Z+OSS2xtFpTSHu53mu/KfZQtsEA85NK3qAYdyCTYQ2LFSQbuSeJuBdTTy0NB/EdLe1E+OuN+b+dYFo1N4ob3N7NKHl9sD20QQaL5vpJaWXzyqI8dPY9y/pPtFKys6j/4lx4dJabhVUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzl8lKG/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzl8lKG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767925142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRAFeO73kaC87mI3neGDo+GrIngNFgtEKT39iZIsfwE=;
	b=gzl8lKG/3MBbWsD2j5PR7cwQeFCuJFOfe+IlqDCJVGD7egYdumrglIEeCMS3/5+OiIDJTt
	WDnO98JaaLc2lQFRmKwTcw6fwJvV2tMx5tg2MgWKLXXsqZ2WOHbxGkNQPftanCHNMCc1uj
	shHkxv0Fzy89QsF4Uc9LSaWB7APZW+g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-I-keGp_AMIugQMlJ5exzSQ-1; Thu,
 08 Jan 2026 21:19:01 -0500
X-MC-Unique: I-keGp_AMIugQMlJ5exzSQ-1
X-Mimecast-MFC-AGG-ID: I-keGp_AMIugQMlJ5exzSQ_1767925140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCC211956080;
	Fri,  9 Jan 2026 02:18:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.172])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B13C019560B4;
	Fri,  9 Jan 2026 02:18:55 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:18:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs
 reclaim under rq_qos_mutex
Message-ID: <aWBliob1SiDv9NZa@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-10-yukuai@fnnas.com>
 <aV5L25KZkM4dvzLD@fedora>
 <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jan 09, 2026 at 12:56:33AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2026/1/7 20:04, Ming Lei 写道:
> > On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
> >> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
> >> configuration, and fs reclaim can be triggered because GFP_KERNEL is used
> >> to allocate memory. This can deadlock because rq_qos_mutex can be held
> >> with queue frozen.
> >>
> >> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
> >> useless queue frozen from blk_throtl_init().
> >>
> >> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> >> ---
> > I think this patch goes toward wrong direction by enlarging queue freeze
> > scope, and blkg_conf_prep() may run into percpu allocation, then new
> > lockdep warning could be triggered.
> >
> > IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead of
> > adding more.
> 
> Fortunately, blk_throtl_init() doesn't have percpu allocation, so this is
> safe now. Unfortunately, blk-iocost and blk-iolatency do have percpu allocation
> and they're already problematic for a long time. The queue is already frozen from
> blkcg_activate_policy() and then the pd_alloc_fn() will try percpu allocation.
> 
> To be honest, I feel it's too complicated to move all the percpu allocation out of
> queue frozen, will it be possible to fix this the other way by passing another gfp
> into pcpu_alloc_noprof() that it'll be atomic to work around the pcpu_alloc_mutex.

The first question is why blkg_conf_open_bdev_frozen() is used by io-cost
only? I hope it can be removed, then the dependency against percpu
allocation can be killed.

Thanks,
Ming

