Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642972D627
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725695959; cv=none; b=WH7TO4duyrV8ZklyXxqOmOnQeWMC4Nz4uY0Jhk+0WBH+DHc4c1zrcBl8S0SwBQGmgcE5aA91keCfIvKAksDHcpiwJ80WMSHapO+mpWKYs6oQ8ctYuwkrbS8I0dbPpkn3go2U/NaW7GYaxXKrPdzdAkHbh/YGYhf6x2r5bHF0fYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725695959; c=relaxed/simple;
	bh=a9AJq1SO6RuTCIfXzD8+WsYb/Gk0mhIZZXNfg2yjfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1fa+PGNvk5w4YfyKk3sjpUuZHD0YDab9N6Ns3T/68nVVu2IhFsvFzk+yX+u2la2yP4eBNGMD5773uPQ0mbI1ykmENcVLE9/5rQPmFgwrL9d+nY0PAJaUr9w90ncJO8HLxelMliSISlgxojF2eMSpzJwUEI5EQSNbkt/PPRgofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gc/pn7vo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc/pn7vo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725695956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9t+w9ZP+W/177rHsNpTimrgWEidK4mmgD4uvY1slRuw=;
	b=Gc/pn7voE8PYxR1J2nw4iK8pCMTEFqlsqOjOH+j7uJqBOiuSUbPBARdBauMUoVq4JHWUwV
	rg5seOmyCW80W+fd4uWyFoVW90jANGKsblUKdUPGn18SE2bnkvdftiN5XaVSe3+NAwz0Um
	3CxJASOIma+ZF3YUJCysgdAwDTIN4gU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-2T1v7SizMYWW36WCgjGKzg-1; Sat,
 07 Sep 2024 03:59:12 -0400
X-MC-Unique: 2T1v7SizMYWW36WCgjGKzg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33AFA19560BF;
	Sat,  7 Sep 2024 07:59:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2543319560AA;
	Sat,  7 Sep 2024 07:59:02 +0000 (UTC)
Date: Sat, 7 Sep 2024 15:58:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <ZtwHwTh6FYn+WnGD@fedora>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907073522.GW1450@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
> > When switching io scheduler via sysfs, 'request_module' may be called
> > if the specified scheduler doesn't exist.
> > 
> > This was has deadlock risk because the module may be stored on FS behind
> > our disk since request queue is frozen before switching its elevator.
> > 
> > Fix it by returning -EDEADLK in case that the disk is claimed, which
> > can be thought as one signal that the disk is mounted.
> > 
> > Some distributions(Fedora) simulates the original kernel command line of
> > 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
> > hang is triggered.
> > 
> > Cc: Richard Jones <rjones@redhat.com>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Jiri Jaburek <jjaburek@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> I'd suggest also:
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> 
> So I have tested this patch and it does fix the issue, at the possible
> cost that now setting the scheduler can fail:
> 
>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
>   + echo noop
>   /init: line 109: echo: write error: Resource deadlock avoided
> 
> (I know I'm setting it to an impossible value here, but this could
> also happen when setting it to a valid one.)

Actually in most of dist, io-schedulers are built-in, so request_module
is just a nop, but meta IO must be started.

> 
> Since almost no one checks the result of 'echo foo > /sys/...'  that
> would probably mean that sometimes a desired setting is silently not
> set.

As I mentioned, io-schedulers are built-in for most of dist, so
request_module isn't called in case of one valid io-sched.

> 
> Also I bisected this bug yesterday and found it was caused by (or,
> more likely, exposed by):
> 
>   commit af2814149883e2c1851866ea2afcd8eadc040f79
>   Author: Christoph Hellwig <hch@lst.de>
>   Date:   Mon Jun 17 08:04:38 2024 +0200
> 
>     block: freeze the queue in queue_attr_store
>     
>     queue_attr_store updates attributes used to control generating I/O, and
>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
>     in common code instead of adding it to almost every attribute.
> 
> Reverting this commit on top of git head also fixes the problem.
> 
> Why did this commit expose the problem?

That is really the 1st bad commit which moves queue freezing before
calling request_module(), originally we won't freeze queue until
we have to do it.

Another candidate fix is to revert it, or at least not do it
for storing elevator attribute.


Thanks,
Ming

