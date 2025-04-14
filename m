Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A329D19
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595721; cv=none; b=SHYsekGQ18XGwFWsxCaqsWtaf3MH5bSrvnzl6K1DpA3rXbyJoblB6atc0mbEoO0QRPl22Uy7JHAm2dpsuO293a1/+aIEM/pWb9xZkEu65RgWHL1Im7D0AXghFCBGHcB13/Tb/4RO92nxioiTz/rYSJO/pm3Ic4TN8FUwmWlNCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595721; c=relaxed/simple;
	bh=7iZG9gTxa2DYGhbx7JaszXV4rmkYotZgfUhAZDkUo9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klTQ48v+61eiSM/9G/OE5Fn0k5buLU+IoOhxldASTm3tBPgSkeTPO4zPZ0oFu915U+eyYCiP2/hYORLk7in/Z6Eob2OOlJC98OWW3w9t4Jp4UUOr3B6BH4R6cCrA71ZjeFHB95VhFZgbGxz4MQD4BQMT2xPcdIra+BnMuIae10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAB/7EdY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAB/7EdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744595718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zhsye8WX5Dcuy0+lUsgO0kREG7qpsZuQWzr5kpGvbLQ=;
	b=fAB/7EdYCFkYH7/FW9RHOVdrIeQCUyrHHbUrKR8cExnDoejjJRXAn+AC+0JC4+5Z19tKtR
	Fgk+OBbZAj6MJXVL9PGtAFt49u1PQ15mbZSfnZ0or6nss7LS69cF6dGbkJJ8M8rukZx7qY
	GmHtLyfB9YmfHJYh2uI5scdS/PSqk1I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-HyUpYibSMYGllk4f_YjFtA-1; Sun,
 13 Apr 2025 21:55:15 -0400
X-MC-Unique: HyUpYibSMYGllk4f_YjFtA-1
X-Mimecast-MFC-AGG-ID: HyUpYibSMYGllk4f_YjFtA_1744595714
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0027D18007E1;
	Mon, 14 Apr 2025 01:55:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03C0819560AD;
	Mon, 14 Apr 2025 01:55:09 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:55:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/15] block: move wbt_enable_default() out of queue
 freezing from scheduler's ->exit()
Message-ID: <Z_xq-H7eM8sD9FaU@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-16-ming.lei@redhat.com>
 <d3f8673e-682f-41a2-bcae-d256e3b26746@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f8673e-682f-41a2-bcae-d256e3b26746@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Apr 11, 2025 at 12:50:42AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:00 PM, Ming Lei wrote:
> > scheduler's ->exit() is called with queue frozen and elevator lock is held, and
> > wbt_enable_default() can't be called with queue frozen, otherwise the
> > following lockdep warning is triggered:
> > 
> > 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
> > 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
> > 	#4 (&q->elevator_lock){+.+.}-{4:4}:
> > 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> > 	#2 (fs_reclaim){+.+.}-{0:0}:
> > 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> > 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
> > 
> > Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
> > call it from elevator_change_done().
> 
> [...]
> 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 1cc640a9db3e..9cf78db4d6a4 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -676,8 +676,13 @@ int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
> >  	int ret = 0;
> >  
> >  	if (ctx->old) {
> > +		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
> > +				&ctx->old->flags);
> > +
> >  		elv_unregister_queue(q, ctx->old);
> >  		kobject_put(&ctx->old->kobj);
> > +		if (enable_wbt)
> > +			wbt_enable_default(q->disk);
> >  	}
> wbt_enable_default is also called from ioc_qos_write and blk_register_queue 
> with ->elevator_lock protection. So avoiding protection here doesn't seem
> correct.

The only code which needs the protection should be:

```
wbt_enable_default():
	...
	if (q->elevator && test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
		enable = false;

```

The flag can be moved to request queue from elevator queue, will do it in
V2.


Thanks,
Ming

