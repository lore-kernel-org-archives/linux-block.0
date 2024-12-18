Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8B1A2396
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529251; cv=none; b=LFtRbdvV9/v2TEDjCLqIouPniwho6ytxuDvKqaH92M+FbELUDAqWBLnu0S8QbBp6eo1k/61/hCyOSeRtBANyWn+ZndT/ROBYp0kj6qY//eJLlpklDNQVI4edFNqdJlEm6fUcYKSFPjtyelmdKDnqGsU/EQSZL705FZxxFgz2pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529251; c=relaxed/simple;
	bh=OFqFqtq68qW71+1R5fMOLX4meRY7mhRN6WIODvBRcU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUlIK6OlKZghB3yvDXe4aIepXGWtnOsrG6rR1msk/WR6p+5OSbM9jhIBJZRJ93zRHQQKeBgoljXYw78JJVoM8mbO3Ueu/KWZGssrwmjFjCtoCFoW0r2zRGw03FUjlzXYywfBxcnafcESgPhStiGuNrIPcOB9CgX8stlde6XWXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0ceTQXz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0ceTQXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734529248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnhROUxmbVticWznK1upo6TrjbXxXzJsPKOyle7xfgs=;
	b=T0ceTQXziZIPtoXsey+kxS6k3z6WRB++rju7d1CRLitNzFxfv5KF6OfH7UvaCcHNEq51M5
	+pmxVI30NBLUDfzFpekR69fO9jCX1PAizSpuDnvJJC6BPTDPEjo3g4Md/B0uFfLdjN+uML
	EnzUsoxs3kk+MA5HrEJlLLAkNOfBKlI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-4nTRuFX4Pbqksi0Ce2N5aA-1; Wed,
 18 Dec 2024 08:40:43 -0500
X-MC-Unique: 4nTRuFX4Pbqksi0Ce2N5aA-1
X-Mimecast-MFC-AGG-ID: 4nTRuFX4Pbqksi0Ce2N5aA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D15F19560B4;
	Wed, 18 Dec 2024 13:40:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AD11300F9B5;
	Wed, 18 Dec 2024 13:40:37 +0000 (UTC)
Date: Wed, 18 Dec 2024 21:40:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
Message-ID: <Z2LQ0PYmt3DYBCi0@fedora>
References: <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de>
 <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de>
 <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de>
 <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org>
 <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 18, 2024 at 05:03:00PM +0530, Nilay Shroff wrote:
> 
> 
> On 12/18/24 07:39, Ming Lei wrote:
> > On Tue, Dec 17, 2024 at 08:07:06AM -0800, Damien Le Moal wrote:
> >> On 2024/12/16 23:30, Ming Lei wrote:
> >>> On Tue, Dec 17, 2024 at 08:19:28AM +0100, Christoph Hellwig wrote:
> >>>> On Tue, Dec 17, 2024 at 03:05:48PM +0800, Ming Lei wrote:
> >>>>> On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
> >>>>>> On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
> >>>>>>> The local copy can be updated in any way with any data, so does another
> >>>>>>> concurrent update on q->limits really matter?
> >>>>>>
> >>>>>> Yes, because that means one of the updates get lost even if it is
> >>>>>> for entirely separate fields.
> >>>>>
> >>>>> Right, but the limits are still valid anytime.
> >>>>>
> >>>>> Any suggestion for fixing this deadlock?
> >>>>
> >>>> What is "this deadlock"?
> >>>
> >>> The commit log provides two reports:
> >>>
> >>> - lockdep warning
> >>>
> >>> https://lore.kernel.org/linux-block/Z1A8fai9_fQFhs1s@hovoldconsulting.com/
> >>>
> >>> - real deadlock report
> >>>
> >>> https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
> >>>
> >>> It is actually one simple ABBA lock:
> >>>
> >>> 1) queue_attr_store()
> >>>
> >>>       blk_mq_freeze_queue(q);					//queue freeze lock
> >>>       res = entry->store(disk, page, length);
> >>> 	  			queue_limits_start_update		//->limits_lock
> >>> 				...
> >>> 				queue_limits_commit_update
> >>>       blk_mq_unfreeze_queue(q);
> >>
> >> The locking + freeze pattern should be:
> >>
> >> 	lim = queue_limits_start_update(q);
> >> 	...
> >> 	blk_mq_freeze_queue(q);
> >> 	ret = queue_limits_commit_update(q, &lim);
> >> 	blk_mq_unfreeze_queue(q);
> >>
> >> This pattern is used in most places and anything that does not use it is likely
> >> susceptible to a similar ABBA deadlock. We should probably look into trying to
> >> integrate the freeze/unfreeze calls directly into queue_limits_commit_update().
> >>
> >> Fixing queue_attr_store() to use this pattern seems simpler than trying to fix
> >> sd_revalidate_disk().
> > 
> > This way looks good, just commit af2814149883 ("block: freeze the queue in
> > queue_attr_store") needs to be reverted, and freeze/unfreeze has to be
> > added to each queue attribute .store() handler.
> > 
> Wouldn't it be feasible to add blk-mq freeze in queue_limits_start_update()
> and blk-mq unfreeze in queue_limits_commit_update()? If we do this then 
> the pattern would be, 
> 
> queue_limits_start_update(): limit-lock + freeze
> queue_limits_commit_update() : unfreeze + limit-unlock  
> 
> Then in queue_attr_store() we shall just remove freeze/unfreeze.
> 
> We also need to fix few call sites where we've code block,
> 
> {
>     blk_mq_freeze_queue()
>     ...
>     queue_limits_start_update()
>     ...    
>     queue_limits_commit_update()
>     ...
>     blk_mq_unfreeze_queue()
>     
> }
> 
> In the above code block, we may then replace blk_mq_freeze_queue() with
> queue_limits_commit_update() and similarly replace blk_mq_unfreeze_queue() 
> with queue_limits_commit_update().
> 
> {
>     queue_limits_start_update()
>     ...
>     ...
>     ...
>     queue_limits_commit_update()

In sd_revalidate_disk(), blk-mq request is allocated under queue_limits_start_update(),
then ABBA deadlock is triggered since blk_queue_enter() implies same lock(freeze lock)
from blk_mq_freeze_queue().


Thanks,
Ming

