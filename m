Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01D27465C
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925618; cv=none; b=ADgY5YUcHm+zB8/z/1TqvQ2+dofhCWoZP5Tnt0p1dxffp9u2n50BJwZYyJxnKf1IrZupIi9et5NLrYIeTdj32xsX1BJ763Wo6JIoqfDjr+NFN+b1DzapbBJLG5D3dBfJOy5+EqjxaSFpmh1AzdQF286SNtC9hQsI1iP1kB+f9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925618; c=relaxed/simple;
	bh=Ou8gkELUzGtbSk91OgSLIfIElx+qeO2m6peAKY+McKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnRTbMJibZhCqwrs6RCG3Y1Dk6z0y/uv3U4qNe02KT76fCHbX1l+BDgEKs5t5nzkGgkq9OdroiEHN1gqHhK6bb1dSDb2X7ghj7CtYoNR3YunoNj+qOxnOCwope9ApodYyisu/8sXEXPhKQZaC8aovC5V7a5sQo8QPjuLIplKmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA9IwHVh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA9IwHVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767925615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0looGq8X67/9dv4q7mLD76RWIChf+Df1qIjIE4KgNU=;
	b=EA9IwHVhJKTo+5nc8mjrHPTLZaVqiyCbw7TVF7rzJBw5pn9PHa/wlFXIyrMTdwrGfUftV6
	Lu5CNSLFwCHIi2OCA6OK841fMcLWyERxTDCtWIjV2ulU5+lhEaigOQ7R3GKhH5YV5c/T5a
	F3ZvKNABG2Ypc0ZXMwVONlEts8IxwMk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-l_BSXv3zPa6Hzmz8x-Cgfw-1; Thu,
 08 Jan 2026 21:26:52 -0500
X-MC-Unique: l_BSXv3zPa6Hzmz8x-Cgfw-1
X-Mimecast-MFC-AGG-ID: l_BSXv3zPa6Hzmz8x-Cgfw_1767925611
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6500818003FC;
	Fri,  9 Jan 2026 02:26:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F3FA1800240;
	Fri,  9 Jan 2026 02:26:46 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:26:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs
 reclaim under rq_qos_mutex
Message-ID: <aWBnYbHpxv1ER_wG@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-10-yukuai@fnnas.com>
 <aV5L25KZkM4dvzLD@fedora>
 <e2054693-7100-4bdc-95eb-9e70d9d3231e@fnnas.com>
 <aWBliob1SiDv9NZa@fedora>
 <f1e4273d-707f-4245-a2d0-2ab13857c22e@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1e4273d-707f-4245-a2d0-2ab13857c22e@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jan 09, 2026 at 10:22:27AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2026/1/9 10:18, Ming Lei 写道:
> > On Fri, Jan 09, 2026 at 12:56:33AM +0800, Yu Kuai wrote:
> >> Hi,
> >>
> >> 在 2026/1/7 20:04, Ming Lei 写道:
> >>> On Wed, Dec 31, 2025 at 04:51:19PM +0800, Yu Kuai wrote:
> >>>> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
> >>>> configuration, and fs reclaim can be triggered because GFP_KERNEL is used
> >>>> to allocate memory. This can deadlock because rq_qos_mutex can be held
> >>>> with queue frozen.
> >>>>
> >>>> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
> >>>> useless queue frozen from blk_throtl_init().
> >>>>
> >>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> >>>> ---
> >>> I think this patch goes toward wrong direction by enlarging queue freeze
> >>> scope, and blkg_conf_prep() may run into percpu allocation, then new
> >>> lockdep warning could be triggered.
> >>>
> >>> IMO, we should try to reduce blkg_conf_open_bdev_frozen() uses, instead of
> >>> adding more.
> >> Fortunately, blk_throtl_init() doesn't have percpu allocation, so this is
> >> safe now. Unfortunately, blk-iocost and blk-iolatency do have percpu allocation
> >> and they're already problematic for a long time. The queue is already frozen from
> >> blkcg_activate_policy() and then the pd_alloc_fn() will try percpu allocation.
> >>
> >> To be honest, I feel it's too complicated to move all the percpu allocation out of
> >> queue frozen, will it be possible to fix this the other way by passing another gfp
> >> into pcpu_alloc_noprof() that it'll be atomic to work around the pcpu_alloc_mutex.
> > The first question is why blkg_conf_open_bdev_frozen() is used by io-cost
> > only? I hope it can be removed, then the dependency against percpu
> > allocation can be killed.
> 
> Even if blkg_conf_open_bdev_frozen() is removed, as I said above, blkcg_activate_poilcy()
> still freeze queue, and later pd_alloc_fn() will still run into percpu allocation with
> queue frozen, so I think problem still stands.

That is one local blkcg_activate_poilcy() issue, which can be solved with your approach
by moving pol->pd_alloc_fn() out of queue freeze.

Thanks,
Ming

