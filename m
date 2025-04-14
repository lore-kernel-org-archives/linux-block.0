Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CA14F117
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744593749; cv=none; b=UQYUfgm3hNT3PKPIbDvVptPJNT3VTzN5aNskU0dj6GduLhleeWD11ge+1D1PigBNYHOg1dNVJHvnMmBQyf3V1GxyJLRbLj24QH/JNyojBetUFkXHnKwm9DnUVEjnw+hhMZVQEDua5aavKG4JQ0DYPP+MNQKXor3uosCihKbDV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744593749; c=relaxed/simple;
	bh=raxIuW9ncCIy79pni/zUY1ER+gi8MyLUIMEwoDiiQgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI9wNt0Vt1J5IoepFt0XEASCBEY5IGWAjOkBEKFnluuu8iL8Gn5D6zlsKez/M2oI4WFDD7s8U2Fuc2FSdZW6R4XLOd+ESj6AXja8wQSmMfPRuR9PttxYbkR5RgH40co2v0OJEc/zVg4j9XKleKlgKW77eu56jOj22zyR9PcrX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fnz38ogX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnz38ogX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744593745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCvOR0N/aFyDQJGSKzBMYgidKrZIJKzjTFLcmtLTxnY=;
	b=Fnz38ogXNm1XqgE5Bca2g4heCvTeoKi4AY1xi3FzV9ikXPgYB3qJt7aEZw9JM97P8C9MSN
	Isff0KAV0vvq61ygLt7eWPWaFREcV9szcw7EJ4ipXhuIWlF90Vrc7+ROkyXnE7v0UuurWW
	sczYDAmOvPkZl2u8D1gVWvQKa0IeZdU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-Rd-F0DtFNEWCzRb0Hy64WQ-1; Sun,
 13 Apr 2025 21:22:22 -0400
X-MC-Unique: Rd-F0DtFNEWCzRb0Hy64WQ-1
X-Mimecast-MFC-AGG-ID: Rd-F0DtFNEWCzRb0Hy64WQ_1744593741
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF71919560B7;
	Mon, 14 Apr 2025 01:22:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2320195609D;
	Mon, 14 Apr 2025 01:22:16 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:22:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/15] block: unifying elevator change
Message-ID: <Z_xjQ3djcyF39F_w@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-10-ming.lei@redhat.com>
 <83f5e47a-8738-4776-ae23-7ff0cad7ba48@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f5e47a-8738-4776-ae23-7ff0cad7ba48@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Apr 11, 2025 at 12:07:34AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:00 PM, Ming Lei wrote:
> >  /*
> >   * Use the default elevator settings. If the chosen elevator initialization
> >   * fails, fall back to the "none" elevator (no elevator).
> >   */
> > -void elevator_init_mq(struct request_queue *q)
> > +void elevator_set_default(struct request_queue *q)
> >  {
> > -	struct elevator_type *e;
> > -	unsigned int memflags;
> > +	struct elev_change_ctx ctx = { };
> >  	int err;
> >  
> > -	WARN_ON_ONCE(blk_queue_registered(q));
> > -
> > -	if (unlikely(q->elevator))
> > +	if (!queue_is_mq(q))
> >  		return;
> >  
> > -	e = elevator_get_default(q);
> > -	if (!e)
> > +	ctx.name = use_default_elevator(q) ? "mq-deadline" : "none";
> > +	if (!q->elevator && !strcmp(ctx.name, "none"))
> >  		return;
> > +	err = elevator_change(q, &ctx);
> > +	if (err < 0)
> > +		pr_warn("\"%s\" set elevator failed %d, "
> > +			"falling back to \"none\"\n", ctx.name, err);
> > +}
> >  
> If we fail to set the evator to default (mq-deadline) while registering queue, 
> because nr_hw_queue update is simultaneously running then we may end up setting 
> the queue elevator to none and that's not correct. Isn't it?

It still works with none.

I think it isn't one big deal. And if it is really one issue in future, we can
set one flag in elevator_set_default(), and let blk_mq_update_nr_hw_queues set
default sched for us.

> 
> > +void elevator_set_none(struct request_queue *q)
> > +{
> > +	struct elev_change_ctx ctx = {
> > +		.name	= "none",
> > +		.uevent = 1,
> > +	};
> > +	int err;
> >  
> > -	blk_mq_unfreeze_queue(q, memflags);
> > +	if (!queue_is_mq(q))
> > +		return;
> >  
> > -	if (err) {
> > -		pr_warn("\"%s\" elevator initialization failed, "
> > -			"falling back to \"none\"\n", e->elevator_name);
> > -	}
> > +	if (!q->elevator)
> > +		return;
> >  
> > -	elevator_put(e);
> > +	err = elevator_change(q, &ctx);
> > +	if (err < 0)
> > +		pr_warn("%s: set none elevator failed %d\n", __func__, err);
> >  }
> >  
> Here as well if we fail to disable/exit elevator while deleting disk 
> because nr_hw_queue update is simultaneously running  then we may
> leak elevator resource? 

When blk_mq_update_nr_hw_queues() observes that queue is dying, it
forces to change elevator to none, so there isn't elevator leak issue.

> 
> > @@ -565,11 +559,7 @@ int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
> >  	if (disk->major == BLOCK_EXT_MAJOR)
> >  		blk_free_ext_minor(disk->first_minor);
> >  out_exit_elevator:
> > -	if (disk->queue->elevator) {
> > -		mutex_lock(&disk->queue->elevator_lock);
> > -		elevator_exit(disk->queue);
> > -		mutex_unlock(&disk->queue->elevator_lock);
> > -	}
> > +	elevator_set_none(disk->queue);
> Same comment as above here as well but this is in add_disk code path.

We can avoid it by forcing to change to none in blk_mq_update_nr_hw_queues() for
!blk_queue_registered()


Thanks,
Ming

