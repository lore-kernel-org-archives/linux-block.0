Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09A17999
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845118; cv=none; b=epn/1cigsQDqvH2V5UIUgmEsgm1z+rikBzNqLN5baLYO3+0lJEbASgrEGfs4Z0futMAS0gm4hZR+7LXv/2Him30szVgqQCa6epdOUwszZiKRfQhNo4EKkqjnhg2RgDK8JOgXhiENzmfowTBUh5nNdnSYnIEGJpya9TaPIViciN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845118; c=relaxed/simple;
	bh=cnMLX1PZIWy291Sx8cqAhW0XGfFmFDjyKUfeMZicaGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw/43bURqwvKSOZOILVWdG/qRiRVisIM9UN0TjjYPctTizVoRj31vXDdOHWJOX0mUpWuwFmomycnij270250qfJMMCS69HBg9Wv5dikAtyeazUgmuB6oBYk8stVjX6Gr3i2p+l3bTLhAo+99TElh+mrSpz3TuhSOv+jyA6nx6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qzz/T4m0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qzz/T4m0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWEupgvvQQLWwChF11q57v4KE5ViSvmDAEl87QUms50=;
	b=Qzz/T4m094p1Mwu9Id5/he/rg8HWQfQuMrVLTYVTIKcOqmMxn0w38IKCUt6tKly2SMjWCn
	ztkfB4vmd2eHtaJACEwnGMi1cvLkAxNgHPGpU/iECSYNi3NeUlZbSKCXehwPltz5FmCgzT
	Dzll46kUtGw4SVdlMIhYan6+6MjGXDs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318--s-VMgZAO_u__uhZjd5vBA-1; Sun,
 08 Sep 2024 21:25:12 -0400
X-MC-Unique: -s-VMgZAO_u__uhZjd5vBA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA1321956096;
	Mon,  9 Sep 2024 01:25:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 967C719560AA;
	Mon,  9 Sep 2024 01:25:01 +0000 (UTC)
Date: Mon, 9 Sep 2024 09:24:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Richard W.M. Jones" <rjones@redhat.com>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <Zt5OaPCvM5XC44vc@fedora>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <c8fd6c9b-67a7-4cc5-b4e5-c615c37f6b4e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8fd6c9b-67a7-4cc5-b4e5-c615c37f6b4e@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Sep 07, 2024 at 07:50:32AM -0600, Jens Axboe wrote:
> On 9/7/24 3:04 AM, Damien Le Moal wrote:
> > On 9/7/24 16:58, Ming Lei wrote:
> >> On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
> >>> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
> >>>> When switching io scheduler via sysfs, 'request_module' may be called
> >>>> if the specified scheduler doesn't exist.
> >>>>
> >>>> This was has deadlock risk because the module may be stored on FS behind
> >>>> our disk since request queue is frozen before switching its elevator.
> >>>>
> >>>> Fix it by returning -EDEADLK in case that the disk is claimed, which
> >>>> can be thought as one signal that the disk is mounted.
> >>>>
> >>>> Some distributions(Fedora) simulates the original kernel command line of
> >>>> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
> >>>> hang is triggered.
> >>>>
> >>>> Cc: Richard Jones <rjones@redhat.com>
> >>>> Cc: Jeff Moyer <jmoyer@redhat.com>
> >>>> Cc: Jiri Jaburek <jjaburek@redhat.com>
> >>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>
> >>> I'd suggest also:
> >>>
> >>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> >>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> >>> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> >>> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> >>>
> >>> So I have tested this patch and it does fix the issue, at the possible
> >>> cost that now setting the scheduler can fail:
> >>>
> >>>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
> >>>   + echo noop
> >>>   /init: line 109: echo: write error: Resource deadlock avoided
> >>>
> >>> (I know I'm setting it to an impossible value here, but this could
> >>> also happen when setting it to a valid one.)
> >>
> >> Actually in most of dist, io-schedulers are built-in, so request_module
> >> is just a nop, but meta IO must be started.
> >>
> >>>
> >>> Since almost no one checks the result of 'echo foo > /sys/...'  that
> >>> would probably mean that sometimes a desired setting is silently not
> >>> set.
> >>
> >> As I mentioned, io-schedulers are built-in for most of dist, so
> >> request_module isn't called in case of one valid io-sched.
> >>
> >>>
> >>> Also I bisected this bug yesterday and found it was caused by (or,
> >>> more likely, exposed by):
> >>>
> >>>   commit af2814149883e2c1851866ea2afcd8eadc040f79
> >>>   Author: Christoph Hellwig <hch@lst.de>
> >>>   Date:   Mon Jun 17 08:04:38 2024 +0200
> >>>
> >>>     block: freeze the queue in queue_attr_store
> >>>     
> >>>     queue_attr_store updates attributes used to control generating I/O, and
> >>>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
> >>>     in common code instead of adding it to almost every attribute.
> >>>
> >>> Reverting this commit on top of git head also fixes the problem.
> >>>
> >>> Why did this commit expose the problem?
> >>
> >> That is really the 1st bad commit which moves queue freezing before
> >> calling request_module(), originally we won't freeze queue until
> >> we have to do it.
> >>
> >> Another candidate fix is to revert it, or at least not do it
> >> for storing elevator attribute.
> > 
> > I do not think that reverting is acceptable. Rather, a proper fix would simply
> > be to do the request_module() before freezing the queue.
> > Something like below should work (totally untested and that may be overkill).
> 
> I like this approach, but let's please call it something descriptive
> like "load_module" or something like that.

But 'load_module' is too specific as interface, and we just only have
one case which need to load module exactly.

I guess there may be same risk in queue_wb_lat_store() which calls into
GFP_KERNEL allocation which implies direct reclaim & IO.

Thanks,
Ming

