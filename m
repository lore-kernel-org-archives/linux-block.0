Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AF1F472B
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300389; cv=none; b=crJlOWy6o19LuI/dL8OM6NQ5QrHGwMWgIlh6SPUzQ0PBKDJHCKD/J3PUTi69sCU1ePypjyUFANx2/EtNe0Rex16ay2Xp8M/MmXbPFjpXo/PUmFxkQXBDUZjCWQGozVDrF3OKrCEUwkcH2RIN+6ludNi0ILX6h2SLYI9R4sligWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300389; c=relaxed/simple;
	bh=PiwFTDmYuAuOie08sDG5BfKL2b3U8NN0ERrE1pzWuXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/M+Lx/F0teq1dwEbG0cgapG10d6DoiEq0QuSY2Vzwm+z4XGBjhNncujX0jmnCRx+18xmIO6njSqg85zdQVrFiHK9FMvXc5A8Zp/mAoP2+WNzRAu/I38R6BxOH6NJ5PNM3jhoehLds+gGSnnW+79xCTlsJOOXiQqVzRbAa1nEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chi80B4N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chi80B4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730300386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wG3ZzKXhpEUvZUoj4lQ4U/g9AJMijcNampLA+jgKhzE=;
	b=chi80B4N1nNGa+qfpauFGLaZ7OpU5QSrBdZFnn6PilQTvKqJKJUJAxQZF+KFYgqa6Fn5vt
	4iVwCE5bjs1JnRUIWPGXrN82V5/cNRRkzt7orgNzO6jE0MVbgPXhLa4E4JQnDvv9K69KuK
	fWNNJRhK3s7diex2E7NRFOebv2aVReg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-KMhRdJaHNiqRE4dgosVy1Q-1; Wed,
 30 Oct 2024 10:59:43 -0400
X-MC-Unique: KMhRdJaHNiqRE4dgosVy1Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31D901955BEE;
	Wed, 30 Oct 2024 14:59:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AAB4300018D;
	Wed, 30 Oct 2024 14:59:36 +0000 (UTC)
Date: Wed, 30 Oct 2024 22:59:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Yi <yi1.lai@linux.intel.com>
Subject: Re: [PATCH 5/5] block: don't verify IO lock for freeze/unfreeze in
 elevator_init_mq()
Message-ID: <ZyJJ09rbc21frA-D@fedora>
References: <20241030124240.230610-1-ming.lei@redhat.com>
 <20241030124240.230610-6-ming.lei@redhat.com>
 <20241030144652.GD32043@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030144652.GD32043@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 30, 2024 at 03:46:52PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 08:42:37PM +0800, Ming Lei wrote:
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -598,13 +598,17 @@ void elevator_init_mq(struct request_queue *q)
> >  	 * drain any dispatch activities originated from passthrough
> >  	 * requests, then no need to quiesce queue which may add long boot
> >  	 * latency, especially when lots of disks are involved.
> > +	 *
> > +	 * Disk isn't added yet, so verifying queue lock only manually.
> >  	 */
> > -	blk_mq_freeze_queue(q);
> > +	blk_mq_freeze_queue_non_owner(q);
> > +	blk_freeze_acquire_lock(q, true, false);
> >  	blk_mq_cancel_work_sync(q);
> >  
> >  	err = blk_mq_init_sched(q, e);
> >  
> > -	blk_mq_unfreeze_queue(q);
> > +	blk_unfreeze_release_lock(q, true, false);
> > +	blk_mq_unfreeze_queue_non_owner(q);
> 
> Why do we need to free at all from the add_disk case?  The passthrough
> command should never hit the elevator, or am I missing something?

In theory the queue needn't to be frozen here, but both FS IO and PT req
share common blk-mq code, in which q->elevator is often referenced.


Thanks, 
Ming

