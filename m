Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5A83A14
	for <linux-block@vger.kernel.org>; Fri, 20 Jun 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432672; cv=none; b=rQEoGVJA+LRSa3qdp1BfKfye7m3b70VFcsg2Gea78c0JMfRmL1Drk/F9dT4aOO93hyqC7T1a5PhhxspdLVApGnOfENVc3+kNwONTsLyR8ARwf+T0OfM9KeI7KX4utFE1S0mj/O2vmLiGhz+lsDPefe3FIpWoyK10K1IqGmxku2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432672; c=relaxed/simple;
	bh=e5ATNsy3jOC4Gu92fK3f80EMuwFDMq1+axycp/lKEr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qey2I7WWRu87iHRnUAySImjRYA9Yo7BENl9Xma31vHYKsZTRPiMdcAIKYtUHkeeoOO0cGrxEnlX0aAAJGhxz8lse2cOQQDS7RPznP6UfYpeiioLdjQp9WmYmH8M7QX6IoOxT/XYOViuJPLHdaxuUylMY2SwDFfxsiUymWAEwJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HV065x+2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV065x+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750432670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXOTvLMRylZK+H/fGvZaqBAySADzncjmEf4USLMDpkc=;
	b=HV065x+2bUCdbzv5e44YXZxiySsPKJtH42ivLTQ5IPtxGe1FY44SejLYIgi7sCDwHujl8H
	rAzh9kQSmtZZUgm0/Z8+sdb20cZJE4xEa5M+e2Y/oNKNM34zamf6Hle9IcPgzfev+bCOJi
	7GoDbwrpaWUmDwvXm7rUKLg3k6fUfgQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-nuqvylJmOOau74u3bXgSyQ-1; Fri,
 20 Jun 2025 11:17:44 -0400
X-MC-Unique: nuqvylJmOOau74u3bXgSyQ-1
X-Mimecast-MFC-AGG-ID: nuqvylJmOOau74u3bXgSyQ_1750432663
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 228DC1828AC3;
	Fri, 20 Jun 2025 15:17:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B888319560A3;
	Fri, 20 Jun 2025 15:17:35 +0000 (UTC)
Date: Fri, 20 Jun 2025 23:17:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 1/2] block: move elevator queue allocation logic into
 blk_mq_init_sched
Message-ID: <aFV7iSUpCdgqX1Sh@fedora>
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
 <20250616173233.3803824-2-nilay@linux.ibm.com>
 <aFGEzN5c0-b5VdcM@fedora>
 <a1644c15-2a9a-4fc1-a762-b153d167cd1f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1644c15-2a9a-4fc1-a762-b153d167cd1f@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jun 20, 2025 at 08:09:01PM +0530, Nilay Shroff wrote:
> 
> 
> On 6/17/25 8:37 PM, Ming Lei wrote:
> > On Mon, Jun 16, 2025 at 11:02:25PM +0530, Nilay Shroff wrote:
> >> In preparation for allocating sched_tags before freezing the request
> >> queue and acquiring ->elevator_lock, move the elevator queue allocation
> >> logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
> >>
> >> This refactoring provides a centralized location for elevator queue
> >> initialization, which makes it easier to store pre-allocated sched_tags
> >> in the struct elevator_queue during later changes.
> >>
> >> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> >> ---
> 
> [...]
> 
> >> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> >> index 55a0fd105147..d914eb9d61a6 100644
> >> --- a/block/blk-mq-sched.c
> >> +++ b/block/blk-mq-sched.c
> >> @@ -475,6 +475,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
> >>  	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
> >>  				   BLKDEV_DEFAULT_RQ);
> >>  
> >> +	eq = elevator_alloc(q, e);
> >> +	if (!eq)
> >> +		return -ENOMEM;
> >> +
> >>  	if (blk_mq_is_shared_tags(flags)) {
> >>  		ret = blk_mq_init_sched_shared_tags(q);
> >>  		if (ret)
> > 
> > The above failure needs to be handled by kobject_put(&eq->kobj).
> 
> I think here the elevator_alloc() failure occurs before we initialize 
> eq->kobj. So we don't need to handle it with kobject_put(&eq->kobj)
> and instead simply returning -ENOMEM should be sufficient. Agree?

I meant the failure from blk_mq_init_sched_shared_tags(), which has to
call kobject_put() for correct cleanup.



Thanks,
Ming

