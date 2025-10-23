Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B52D8DCF
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205742; cv=none; b=jReZn/gxDeCA2/XyVp7rAkey+8+qEtodw+HYauNQx5d3DXk5aiYB/AuSrpPXlLqJXzLlrp5f9+KIYmaJw2UgRHM9xz3VnCX63Oggz5mZEL6+TZQ2YBtiQ9nqX4a23TozFx10h66t0KadQS2s4Bg363KWLl3MdEGWWNq6p6AKsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205742; c=relaxed/simple;
	bh=KcXI9QlqtlAsHRUaP+h7UGTtanxkt5hOS0FKyuDy+Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9KHCGsTB+upffeRsEVNbEMk/mV6oGO9tUDJChyG9V51m2bGt+PXsVxwr/nBhZTSDNDCF1Krqhij/Xf1yt7Q5Mgd/7AAuebz5sjKx01k2WgXX7U3eV5rVoSNIlndMQYYNNTeZTv+rloHf5LIhV69ryE/Dy26SeKoxyUBkt3X/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5+RwPc5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5+RwPc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761205738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L/Tisa01p8NO1U82XFoG1Ua8ujfdTXooh2q/tY1oMNY=;
	b=i5+RwPc56L6AUyeaJEIOidnYEJMSdV8LIEl2MbA1hliiNOiuup161DgwSisidER38VbUoO
	H6D452LHZHGsZ0Z6BtVLGerTdomGOst9hU052tVAkbXWXB+FYKCGnKZZkta1bivZEtq9qD
	vlB60P5y/uvAOry1UoC4716dX2n17eQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-X6YqHq10NtasdnqPI28qTw-1; Thu,
 23 Oct 2025 03:48:54 -0400
X-MC-Unique: X6YqHq10NtasdnqPI28qTw-1
X-Mimecast-MFC-AGG-ID: X6YqHq10NtasdnqPI28qTw_1761205733
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 188EE195422C;
	Thu, 23 Oct 2025 07:48:53 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9741F19540E2;
	Thu, 23 Oct 2025 07:48:46 +0000 (UTC)
Date: Thu, 23 Oct 2025 15:48:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
	axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
	gjoyce@ibm.com
Subject: Re: [PATCH 2/3] block: introduce alloc_sched_data and
 free_sched_data elevator methods
Message-ID: <aPnd2WMKE5gjkM0s@fedora>
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-3-nilay@linux.ibm.com>
 <aPhgAMxgG2q0DKcv@fedora>
 <59cf7e0f-1069-4766-9234-cc91985470e4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59cf7e0f-1069-4766-9234-cc91985470e4@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 23, 2025 at 11:27:26AM +0530, Nilay Shroff wrote:
> 
> 
> On 10/22/25 10:09 AM, Ming Lei wrote:
> > On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
> >> The recent lockdep splat [1] highlights a potential deadlock risk
> >> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> >> mutex. The trace shows that the issue occurs when the Kyber scheduler
> >> allocates dynamic memory for its elevator data during initialization.
> >>
> >> To address this, introduce two new elevator operation callbacks:
> >> ->alloc_sched_data and ->free_sched_data.
> > 
> > This way looks good.
> > 
> >>
> >> When an elevator implements these methods, they are invoked during
> >> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
> >> This allows safe allocation and deallocation of per-elevator data
> > 
> > This per-elevator data should be very similar with `struct elevator_tags`
> > from block layer viewpoint: both have same lifetime, and follow same
> > allocation constraint(per-cpu lock).
> > 
> > Can we abstract elevator data structure to cover both? Then I guess the
> > code should be more readable & maintainable, what do you think of this way?
> > 
> > One easiest way could be to add 'void *data' into `struct elevator_tags`,
> > just the naming of `elevator_tags` is not generic enough, but might not
> > a big deal.
> > 
> Hmm, good point! I'd rather suggest if we could instead rename 
> struct elevator_tags to struct elevator_resources and then
> add void *data field to it. Something like this:
> 
> struct elevator_tags {
> 	unsigned int nr_hw_queues;
> 	unsigned int nr_requests;
> 	struct blk_mq_tags *tags[];
>         void *data;

'data' can't follow `tags[]`.

> };
> 
> What do you think?

It is good. The patch may be split into two:

- add data to `struct elevator_tags` for covering the lockdep issue

- renaming

Then it will become easier for review.


Thanks
Ming

