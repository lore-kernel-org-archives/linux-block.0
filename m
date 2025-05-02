Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9F2AF14
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190023; cv=none; b=LG/i4QI7ZSgVN+u/Hs8S+/DU72Jv7MtgH8K8i1ylHlioCF/NrauYvLkiK750PKM8uC2oQwYOwvZA9hfxURUbYRpWuzrN5hjWuSNjR56csB+Y9tSM1wd957/ltaC7BHqdhomndj+hvlHqP5HVBDkIlyfD2jvkocmBPRMJoisuO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190023; c=relaxed/simple;
	bh=J04/UQ90y9K+J9JYM0Ea8vjHuoee8+vN68H1obMDeBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQx87fZu0Ob8hZ/9MAK7rH6ZCnXIbwmqPjcFlObiVXLKLuDd3qaZ5uBlF7LN6OqXNBRFQwz01YgR6oaNESmJZH5a/DhXbSJxocnNE6m+i+N7UrIqaCtMO9+ys//LmeBiKhw0TxO9el9JQcj/g2qNJGF4sUXivzuyLiANw8p259w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgTQfgul; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgTQfgul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746190020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qR+26RAxK2TwKm2uQr96iwt4cshLMU2dX+ei3mIW0o=;
	b=UgTQfgulT3Dw9bGDbM4Larjxa1BFeQiSPKc4QQhfXIUrJsoPCbPs6JCoA/nThmmL45NAtw
	l28hsa+bLWuT0AWLywUJkW1sws6WpeKZC2SIP1gBRfjlaMLljXpY3+XwzM4NEnqs48H5jo
	+snCA+hD+S3Yw7Bls7vVE+ar8uomdPg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-eemoC189NNenPFsjuQ3plg-1; Fri,
 02 May 2025 08:46:55 -0400
X-MC-Unique: eemoC189NNenPFsjuQ3plg-1
X-Mimecast-MFC-AGG-ID: eemoC189NNenPFsjuQ3plg_1746190013
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FC6A19560A7;
	Fri,  2 May 2025 12:46:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADCFF195608D;
	Fri,  2 May 2025 12:46:48 +0000 (UTC)
Date: Fri, 2 May 2025 20:46:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 11/24] block: move blk_queue_registered() check into
 elv_iosched_store()
Message-ID: <aBS-s1uZV3SFROoa@fedora>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-12-ming.lei@redhat.com>
 <1b9ddb33-2db2-490a-a3f3-cd91d8837c7a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9ddb33-2db2-490a-a3f3-cd91d8837c7a@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, May 01, 2025 at 03:25:01PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/30/25 10:05 AM, Ming Lei wrote:
> > Move blk_queue_registered() check into elv_iosched_store() and prepare
> > for using elevator_change() for covering any kind of elevator change in
> > adding/deleting disk and updating nr_hw_queue.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/elevator.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index df3e59107a2a..ac72c4f5a542 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -676,10 +676,6 @@ int elevator_switch(struct request_queue *q, const char *name)
> >   */
> >  static int elevator_change(struct request_queue *q, const char *elevator_name)
> >  {
> > -	/* Make sure queue is not in the middle of being removed */
> > -	if (!blk_queue_registered(q))
> > -		return -ENOENT;
> > -
> >  	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
> >  		return 0;
> >  
> > @@ -708,6 +704,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >  	struct request_queue *q = disk->queue;
> >  	struct blk_mq_tag_set *set = q->tag_set;
> >  
> > +	/* Make sure queue is not in the middle of being removed */
> > +	if (!blk_queue_registered(q))
> > +		return -ENOENT;
> > +
> >  	/*
> >  	 * If the attribute needs to load a module, do it before freezing the
> >  	 * queue to ensure that the module file can be read when the request
> 
> Shouldn't blk_queue_registered needs protection? For instance, I see here a race 

I think it isn't needed because both blk_queue_flag_set() and blk_queue_registered()
are atomic operation, and almost all check of blk_queue_registered() isn't
protected too.


thanks,
Ming

