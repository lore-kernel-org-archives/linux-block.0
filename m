Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1928314E
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572751; cv=none; b=ZmC7qOkvH3D7pZw3kspfcLy44tpDcDXWNNsaTtUBxDR1Fed84fuRzIxkveqo8eGQme8KHj0q5wrnSCwUEQPY7fHrMCXS31bsBaUJE4HNLlcxFzt94GBiWYJfqZBgxfCVzyKyCIO8NQptCQD7cZkKb4N8kd4csx7C2lSeBhbJepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572751; c=relaxed/simple;
	bh=gsLPr8dKYPf7NWuWlNCr3/2scj+WHmbPzE4Toym4BdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEIzkMlCU8fv2LXH/HxMjMhN0/2s/xAkVfsC3Eyl72Hu9N2d60VuG5A8HK87Zu7kLx7ZPKQyuRm29LPEG4qucBU2aToHh7G8mMQ1oHnpuYURGd7baVpxrMJikHdtBFN0IZX4qGP9cKj7bFFhPGCeng6Ulv5Vwm3noRhzBqMS8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BH2KeEe7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BH2KeEe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774572749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n850yrbkXqGj0VzAFTCnffBvSnCsQGYqvfR/HpQepn4=;
	b=BH2KeEe7EwNVOW4Z9FG8QfpRAG3NbOKdRbe6zq193ySb8AgOmI3itmPzNNPZ14sRJUhlRZ
	XNpcWDjHmcLFLlc7954fm//kMP4uX1VIT8SDmPrzs9icG78jS4M+YkEVkM7H+RvLb6+zot
	DapDRQ7Qjmg8YmlrnAYtHYZtXXUiCpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-rsy6Dq8IOsyH4KT9DwqkGA-1; Thu,
 26 Mar 2026 20:52:25 -0400
X-MC-Unique: rsy6Dq8IOsyH4KT9DwqkGA-1
X-Mimecast-MFC-AGG-ID: rsy6Dq8IOsyH4KT9DwqkGA_1774572744
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56D12180034E;
	Fri, 27 Mar 2026 00:52:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 496FD18001FE;
	Fri, 27 Mar 2026 00:52:17 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:52:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 3/5] block: Remove a DMA segment boundary mask check
Message-ID: <acXUvfopQqMm4Qov@fedora>
References: <20260325213719.2850619-1-bvanassche@acm.org>
 <20260325213719.2850619-4-bvanassche@acm.org>
 <acVIDQp5WWerx3lA@fedora>
 <8c956003-e652-4dd0-a4d1-438d82cb543e@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c956003-e652-4dd0-a4d1-438d82cb543e@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Mar 26, 2026 at 08:51:46AM -0700, Bart Van Assche wrote:
> On 3/26/26 7:51 AM, Ming Lei wrote:
> > On Wed, Mar 25, 2026 at 02:37:13PM -0700, Bart Van Assche wrote:
> > > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > > index 13f5457f9f4e..8538e50afe2c 100644
> > > --- a/block/blk-settings.c
> > > +++ b/block/blk-settings.c
> > > @@ -447,15 +447,9 @@ int blk_validate_limits(struct queue_limits *lim)
> > >   	if (!lim->max_discard_segments)
> > >   		lim->max_discard_segments = 1;
> > > -	/*
> > > -	 * By default there is no limit on the segment boundary alignment,
> > > -	 * but if there is one it can't be smaller than the page size as
> > > -	 * that would break all the normal I/O patterns.
> > > -	 */
> > > +	/* By default there is no limit on the segment boundary alignment. */
> > >   	if (!lim->seg_boundary_mask)
> > >   		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> > > -	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
> > > -		return -EINVAL;
> > 
> > Please fold this change into the real code for reducing
> > BLK_MIN_SEGMENT_SIZE, then it provides consistent handling/view about
> > ->seg_boundary_mask and BLK_MIN_SEGMENT_SIZE.
> 
> Hmm ... wouldn't combining these two patches into a single patch violate
> the "one change per patch" rule?

OK, looks it is two things.

But why do you remove the check? Looks you just encourage driver to use insane
lim->seg_boundary_mask. IMO, it is just fragile.

Thanks,
Ming

