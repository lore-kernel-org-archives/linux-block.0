Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5812B169
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823696; cv=none; b=mDt6xPTBgt0x3PRB838D+j4hR1dyPwiIK1Ym93MrHq6MORrHVv6ZhPTliOlppQ+Ji5WBF17pEcATaAka9RAIHuwQywDy4Gsp2RPp+hudhniCpZNhn+vBJydzXLX2Gb8BegMnu+UOb8krMdWRS37LN+0b3FvLT9JHylHb0tDYYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823696; c=relaxed/simple;
	bh=f/0CcCB2v0UkKx+lN5yiNSElD+lLRGi9ioBz5ep3KLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfaa0XKpdvf7v32iFomkOfGB5Ta6oneds3YMBsli3OaMv4V6qttxU4Za8g4NoNDKar4g2wvFHDAdBDUJNkJx6juuXGtJXFvANAytd3psnORBKDa+VlJ07IX0LiHBA/jQIE9XZSD0VYjJIaS7pi9FijJSTprgz5qUyYubSiC36b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjqtu7IM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjqtu7IM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDtWWIDoqguko+pUdjQLfQBznPwiHSC95eDCujomuVM=;
	b=cjqtu7IMHcEwiBmMgGQzgJS1n+pSO/rgvVLTHoWW9ttKBPsy1oXOj4oByeLRjRrDo3WISY
	BWzyBf56BwIlRh90aK/BJoc3kPHEAQZWLZfgMpDrUx4h7KICinDpdtzwO9C3cSkS7sKrw6
	gzrtDeUmLmnv2kBZ02gF8LyhQDtpWyU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-Rj5SFsdSMl6F9fBBv64G1Q-1; Mon,
 01 Jul 2024 04:48:06 -0400
X-MC-Unique: Rj5SFsdSMl6F9fBBv64G1Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E9FC1944D39;
	Mon,  1 Jul 2024 08:48:04 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C1921956053;
	Mon,  1 Jul 2024 08:47:53 +0000 (UTC)
Date: Mon, 1 Jul 2024 16:47:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <ZoJtNMUBWlJapUfb@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
 <pmnqhamoec7u7ibtt4vccjfecp3ixgdlxzgncelvgczfbt74x5@26rjmpubji6s>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmnqhamoec7u7ibtt4vccjfecp3ixgdlxzgncelvgczfbt74x5@26rjmpubji6s>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jul 01, 2024 at 10:19:25AM +0200, Daniel Wagner wrote:
> On Mon, Jul 01, 2024 at 03:21:13PM GMT, Ming Lei wrote:
> > On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
> > > On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > > > > Make group_cpus_evenly aware of isolcpus configuration and use the
> > > > > housekeeping CPU mask as base for distributing the available CPUs into
> > > > > groups.
> > > > > 
> > > > > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> > > > 
> > > > isolated CPUs are actually handled when figuring out irq effective mask,
> > > > so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> > > > patch from user viewpoint?
> > > 
> > > IO queues are allocated/spread on the isolated CPUs and if there is an
> > > thread submitting IOs from an isolated CPU it will cause noise on the
> > > isolated CPUs. The question is this a use case you need/want to support?
> > 
> > I have talked RH Openshift team weeks ago and they have such usage.
> > 
> > userspace is free to run any application from isolated CPUs via 'taskset
> > -c' even though 'isolcpus=' is passed from command line.
> >
> > Kernel can not add such new constraint on userspace.
> 
> Okay, that is why I asked if we need an additional HK type.
> 
> > > We have customers who are complaining that even with isolcpus provided
> > > they still see IO noise on the isolated CPUs.
> > 
> > That is another issue, which has been fixed by the following patch:
> > 
> > a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs
> 
> I've checked our downstream kernels and we don't have this one yet. I'll
> ask our customer to test if this patch addressed their issue.

BTW, you need the following one too:

7b815817aa58 blk-mq: add helper for checking if one CPU is mapped to specified hctx

Thanks,
Ming

