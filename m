Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B21F12FD
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675771; cv=none; b=aibaTDXtDi8scBfK+GnrZdJmichmlYTB7ofIJXCYiXNzA1aNMRChu/vRLyN55/fss4z6eP3+mHmsaCrc+zJULplnxu8SYCKplJDgbuqR5EwTecwmzHj8VfTHpQJnyyHvnMF0xsqZf9iLooqUFtpgnf6DUdx1I0NGR60QCVbLkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675771; c=relaxed/simple;
	bh=799zBkTkkIWWT9SrKD1M6Eo+aAgp0cwd/FDRsN6Yg90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STo/uB3WSFfBwkCwKt2uKFVcDd7m3bwgWgtd6T0GzBI/7XFboAO7esFA2f5ewGned1yJ0cfJP0bjhD5y4uJvBJgWNrZB1fz4o6KQEpNLqU1Q5Khm/WwRgJ3Y0D4oak4U5ewZtN2USeXqRw/kEFLuUvIv5P+w2BsWWi7QPF2Ln4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+esvqz6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+esvqz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743675767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MmDKYKBuQXiMXyQ/vKHj8tE2zeAfLJQ75wQghYrd60=;
	b=O+esvqz6uvSeCkLOQXjjJ5saN7U1JQhjNtPFNu1XrcC50iUwSNsz0DcY81uL/jb3l1m8AO
	02onP7PXbxKByyKPAl4fBfkQKH2amKFD/l8AZpf0OgJ3Ep+KnCDHW/jgZRyRjCaaO/XM6D
	/trgbszi2s15bUzUzY0w3RVTk+nEtLk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-zUYLnpZxOHizV1GMDSxqWg-1; Thu,
 03 Apr 2025 06:22:44 -0400
X-MC-Unique: zUYLnpZxOHizV1GMDSxqWg-1
X-Mimecast-MFC-AGG-ID: zUYLnpZxOHizV1GMDSxqWg_1743675763
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F31019560B6;
	Thu,  3 Apr 2025 10:22:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE7CE19792DC;
	Thu,  3 Apr 2025 10:22:38 +0000 (UTC)
Date: Thu, 3 Apr 2025 18:22:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH V2 1/3] block: add blk_mq_enter_no_io() and
 blk_mq_exit_no_io()
Message-ID: <Z-5haMsgIIGrfZSn@fedora>
References: <20250403025214.1274650-1-ming.lei@redhat.com>
 <20250403025214.1274650-2-ming.lei@redhat.com>
 <20250403054427.GB24133@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403054427.GB24133@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Apr 03, 2025 at 07:44:27AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 10:52:08AM +0800, Ming Lei wrote:
> > Add blk_mq_enter_no_io() and blk_mq_exit_no_io() for preventing queue
> > from handling any FS or passthrough IO, meantime the queue is kept in
> > non-freeze state.
> 
> How does that differ from the actual freeze?  Please document that
> clearly in the commit log and in kerneldoc comments, and do an analysis
> of which callers should do the full freeze and which the limited I/O
> freeze.
> 
> Also the name is really unfortunate - no_io has a very clear connotation
> for memory allocations, so this should be using something else.
> 
> > Also add two variants of memsave version, since no fs_reclaim is allowed
> > in case of blk_mq_enter_no_io().
> 
> Please explain why.
> 
> 
> > index ae8494d88897..d117fa18b394 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -222,8 +222,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
> >  	bool unfreeze;
> >  
> >  	mutex_lock(&q->mq_freeze_lock);
> > -	if (force_atomic)
> > -		q->q_usage_counter.data->force_atomic = true;
> > +	q->q_usage_counter.data->force_atomic = force_atomic;
> >  	q->mq_freeze_depth--;
> >  	WARN_ON_ONCE(q->mq_freeze_depth < 0);
> >  	if (!q->mq_freeze_depth) {
> 
> This is a completely unrelated cleanup.
> 
> > +void blk_mq_enter_no_io(struct request_queue *q)
> > +{
> > +	blk_mq_freeze_queue_nomemsave(q);
> > +	q->no_io = true;
> > +	if (__blk_mq_unfreeze_queue(q, true))
> > +		blk_unfreeze_release_lock(q);
> 
> So this freezes the queue, sets a flag to not do I/O then unfreezes
> it.   So AFAIK it just is a freeze without the automatic recursion.
> 
> But maybe I'm missing something?

Yeah, looks lockdep modeling for blk_mq_enter_no_io() is wrong, and the
part in bio_enter_queue() is missed.

So this approach doesn't work.

Now the dependency between freeze lock and elevator lock looks one trouble,
such as [1], which is one real deadlock risk.

And there should be more.

[1] https://lore.kernel.org/linux-block/7755.1743228130@turing-police/#tReviewed-by


Thanks,
Ming

