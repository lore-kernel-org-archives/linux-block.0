Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1033062
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319247; cv=none; b=u3XeEDHQHNqELV7GJ66HusZPwI0yzxckKBu462ODBb3J/YJEniICqQahGUIhm7t5Vb2b6HBu+R2ZKqnZdDL/DqQSUxder6MZgRzh82ECn1rGbgMUSpkhu1vL9eWjGQg6odFRA85TKyHoxqYt6QUYKY7nRvYkIWVfCoF4LZc1mks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319247; c=relaxed/simple;
	bh=2NfhLSfU9L5Oao6pZIsOYE/5KjrhCkBOVgQVK5suDF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxAFNDfaO9W1/mRevw3YgCC5hqdLfSRtEGyzu3nDIkcYT/pgtWtbd6Z6AatU/J5YeFJUUvxAY3fGY9sKFJYrcbivBhqLTEDZPrdm1BKzvuYNUJFicyHdi6AtKhPH2MTxp1sOVb711M1adM58Hf9ujH9uPH/E57MP3he90o2kxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbUqbfrg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbUqbfrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745319244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB7Xpqr2lVxUmmIpoche6F70I8JSkoSQL/vP4GO29SQ=;
	b=hbUqbfrgqQF9jrqSvcyzUH1VaAedDtTJBVJFqSQHksNpCpjoPIoGPr9V3Z/wc87NFcR/bA
	CJYZLcARXAPXozrw50TwiuVuf3q/9OEwfommcK3wmU6tEiE0aeLTT4FHjW+3VXd/zl156K
	M8rtTZymP9iAm77v+wLs0GovqsQNYc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-X4QPM6MgMiKogMl1sAhnPw-1; Tue,
 22 Apr 2025 06:54:01 -0400
X-MC-Unique: X4QPM6MgMiKogMl1sAhnPw-1
X-Mimecast-MFC-AGG-ID: X4QPM6MgMiKogMl1sAhnPw_1745319240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E856195608E;
	Tue, 22 Apr 2025 10:54:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0225F180045C;
	Tue, 22 Apr 2025 10:53:55 +0000 (UTC)
Date: Tue, 22 Apr 2025 18:53:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 16/20] block: move elv_register[unregister]_queue out
 of elevator_lock
Message-ID: <aAd1PnHtnT6jTZFE@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-17-ming.lei@redhat.com>
 <9d15a519-c0bb-492f-9602-f3840b85dbe1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d15a519-c0bb-492f-9602-f3840b85dbe1@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 19, 2025 at 07:25:31PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/18/25 10:06 PM, Ming Lei wrote:
> > Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> > so we can kill many lockdep warnings.
> > 
> > elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> > debugfs things, no need to be done with queue frozen.
> > 
> > With this change, elevator's ->exit() is called before calling
> > elv_unregister_queue, then user may call into ->show()/store() of elevator's
> > sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> > 
> > For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> > debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> > there isn't such issue.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c   |  9 ++++----
> >  block/blk.h      |  1 +
> >  block/elevator.c | 58 ++++++++++++++++++++++++++++++++++--------------
> >  block/elevator.h |  5 +++++
> >  4 files changed, 52 insertions(+), 21 deletions(-)
> > 
> 
> [...]
> 
> > +static void elevator_exit(struct request_queue *q)
> > +{
> > +	__elevator_exit(q);
> > +	kobject_put(&q->elevator->kobj);
> >  }
> 
> [...]  
> > +int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
> > +{
> > +	int ret = 0;
> > +
> > +	if (ctx->old) {
> > +		elv_unregister_queue(q, ctx->old);
> > +		kobject_put(&ctx->old->kobj);
> > +	}
> > +	if (ctx->new) {
> > +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> > +		if (ret) {
> > +			unsigned memflags = blk_mq_freeze_queue(q);
> > +
> > +			mutex_lock(&q->elevator_lock);
> > +			elevator_exit(q);
> > +			mutex_unlock(&q->elevator_lock);
> > +			blk_mq_unfreeze_queue(q, memflags);
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> It seems that we're still leaking ->elevator_lock in sysfs/kernfs with
> the above elevator_exit call. I think we probably want to move out 
> kobject_put(&q->elevator->kobj) from elevator_exit and invoke it 
> after we release ->elevator_lock in elevator_change_done.

q->elevator_lock is owned by request queue instead of elevator queue, so it
shouldn't be one issue, or can you explain in details?

Thanks,
Ming

