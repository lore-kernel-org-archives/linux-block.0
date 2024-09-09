Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB31758F
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725848234; cv=none; b=YahTNn5OSr31SEfgPtxbozLm8wXLAgi95J/zOGqQ7wcMxl72u0YcXIk72ZffbLmkYbjaBlQs3Mz0M+outs0ua2q1ylmEs9O6ngA8PiPUWPEiXvD47IqKaUVggqwNOgBIy86V3ZBvVp3Dt3fZUJIQ1Po/6eEh8F2950D7+3tIIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725848234; c=relaxed/simple;
	bh=Epa/L8EtnlgtA1tNSHRMsE8oijC2zMRtRrdUcbV/yx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCx95bNsjDC+RIN0Yb3xLL28mi9goWhregwLrGCsHxqAINRbLDCZhI1YwOCGCPAzwDhK2V86SrewN2EELMmqco3xhkKd9jcJZit/i73MRISw3l+8pyP7YStx0Wa16WgXUzpPVrYYkRvpfNzD63h4/hotuPGo+PEnryCy0nC5rL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBKEd/3E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBKEd/3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725848231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0LuzNRzUK7M26cPxAf3j3bHWGlRglXIiD7qPYaAhxk=;
	b=GBKEd/3EqI8UYgWn10fQE0sEkuQU7T58jNgxsf2MIf7KqdWjnXHP5G/XpziCk1UvrG7Maf
	ZsbQMDRbV7y6qF+KlZXuJS7TT44hOfGX+BjoiMyJVSZ4t+d/tcMd1hIFMB+rQVYNaykwlx
	rp0Uyjwov586P5hk5LP3Tb6XxnF5nyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-stKuWUIZPAO6WNwQbmP1qQ-1; Sun,
 08 Sep 2024 22:17:08 -0400
X-MC-Unique: stKuWUIZPAO6WNwQbmP1qQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5468E19560AB;
	Mon,  9 Sep 2024 02:17:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 642951956086;
	Mon,  9 Sep 2024 02:16:57 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:16:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Richard W.M. Jones" <rjones@redhat.com>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <Zt5alBvaxHdTU2l+@fedora>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <c8fd6c9b-67a7-4cc5-b4e5-c615c37f6b4e@kernel.dk>
 <Zt5OaPCvM5XC44vc@fedora>
 <013397bc-1c1c-40ba-a505-40d60d547caa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013397bc-1c1c-40ba-a505-40d60d547caa@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Sep 09, 2024 at 10:59:00AM +0900, Damien Le Moal wrote:
> On 9/9/24 10:24, Ming Lei wrote:
> > On Sat, Sep 07, 2024 at 07:50:32AM -0600, Jens Axboe wrote:
> >> On 9/7/24 3:04 AM, Damien Le Moal wrote:
> >>> On 9/7/24 16:58, Ming Lei wrote:
> >>>> On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
> >>>>> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
> >>>>>> When switching io scheduler via sysfs, 'request_module' may be called
> >>>>>> if the specified scheduler doesn't exist.
> >>>>>>
> >>>>>> This was has deadlock risk because the module may be stored on FS behind
> >>>>>> our disk since request queue is frozen before switching its elevator.
> >>>>>>
> >>>>>> Fix it by returning -EDEADLK in case that the disk is claimed, which
> >>>>>> can be thought as one signal that the disk is mounted.
> >>>>>>
> >>>>>> Some distributions(Fedora) simulates the original kernel command line of
> >>>>>> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
> >>>>>> hang is triggered.
> >>>>>>
> >>>>>> Cc: Richard Jones <rjones@redhat.com>
> >>>>>> Cc: Jeff Moyer <jmoyer@redhat.com>
> >>>>>> Cc: Jiri Jaburek <jjaburek@redhat.com>
> >>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>>
> >>>>> I'd suggest also:
> >>>>>
> >>>>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> >>>>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> >>>>> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> >>>>> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> >>>>>
> >>>>> So I have tested this patch and it does fix the issue, at the possible
> >>>>> cost that now setting the scheduler can fail:
> >>>>>
> >>>>>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
> >>>>>   + echo noop
> >>>>>   /init: line 109: echo: write error: Resource deadlock avoided
> >>>>>
> >>>>> (I know I'm setting it to an impossible value here, but this could
> >>>>> also happen when setting it to a valid one.)
> >>>>
> >>>> Actually in most of dist, io-schedulers are built-in, so request_module
> >>>> is just a nop, but meta IO must be started.
> >>>>
> >>>>>
> >>>>> Since almost no one checks the result of 'echo foo > /sys/...'  that
> >>>>> would probably mean that sometimes a desired setting is silently not
> >>>>> set.
> >>>>
> >>>> As I mentioned, io-schedulers are built-in for most of dist, so
> >>>> request_module isn't called in case of one valid io-sched.
> >>>>
> >>>>>
> >>>>> Also I bisected this bug yesterday and found it was caused by (or,
> >>>>> more likely, exposed by):
> >>>>>
> >>>>>   commit af2814149883e2c1851866ea2afcd8eadc040f79
> >>>>>   Author: Christoph Hellwig <hch@lst.de>
> >>>>>   Date:   Mon Jun 17 08:04:38 2024 +0200
> >>>>>
> >>>>>     block: freeze the queue in queue_attr_store
> >>>>>     
> >>>>>     queue_attr_store updates attributes used to control generating I/O, and
> >>>>>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
> >>>>>     in common code instead of adding it to almost every attribute.
> >>>>>
> >>>>> Reverting this commit on top of git head also fixes the problem.
> >>>>>
> >>>>> Why did this commit expose the problem?
> >>>>
> >>>> That is really the 1st bad commit which moves queue freezing before
> >>>> calling request_module(), originally we won't freeze queue until
> >>>> we have to do it.
> >>>>
> >>>> Another candidate fix is to revert it, or at least not do it
> >>>> for storing elevator attribute.
> >>>
> >>> I do not think that reverting is acceptable. Rather, a proper fix would simply
> >>> be to do the request_module() before freezing the queue.
> >>> Something like below should work (totally untested and that may be overkill).
> >>
> >> I like this approach, but let's please call it something descriptive
> >> like "load_module" or something like that.
> > 
> > But 'load_module' is too specific as interface, and we just only have
> > one case which need to load module exactly.
> 
> If another attr needs to do some prep work before freezing the queue and calling
> attr->store(), we can rename the load_module attribute method to something like
> "prepare_store" to be more generic.

'interface' is supposed to be generic from beginning, and I don't think
we will have another 'load_module' case here.


Thanks,
Ming

