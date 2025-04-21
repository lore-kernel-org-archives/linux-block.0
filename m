Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0C1C5D5E
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220451; cv=none; b=FF45iXEEoIZ6ozdxrhrt8UVPhdHV8k+BZpz95Pk3jND1ohJOEyLS81e0Dimf/8ADyOjCK97wDyxSf4wPtRF1AGGvVXAw1tlEdaHYImbG10mwqvaLTIQrhe8a/93ODPrTHy1BoIt0O9i+h2WdrGtQSK8ydk+8dRv0d5Gq1HRcHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220451; c=relaxed/simple;
	bh=4zI5mQOWPDMxU0CL4PYocCfgFycpaWX1hKRzmm8L9so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7+z7R9r+/56Y853C6neM5KsFTJLkbMlgYpn2uk1uVHD+rcleBNNAuU7WiR4RUfi9Y4dt074WUd5mi6biF/sYECzkohnNeO/rpIDcIE6ty91i+5J191iZu7qD9X6b3bYADm2t0pMawg4bgAWGza8BThosehaFCByVkdDK7KfrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbvCRIUg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbvCRIUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745220448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FT6/N92L9aYAKkz0EMnSgRHQehhOpyLQRiOGW0cujrc=;
	b=WbvCRIUgst3O9w8VB6CQM6+5+nnxDtnSgqdL5suH29TOAl5u/Fq77MaYgKcKV5GhY8X7Ft
	US1VKRJ8UBQrjFDRzLDAPFXwm4n7lSAgM14XU1uXxa8rD8ICfi8n9+2Rt5hu859/snsK7v
	jptoPgCQ+PCy8iXp2m6SrPTtV96/SaY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-hN5nh-XcOlC0lNVbCSxhJA-1; Mon,
 21 Apr 2025 03:27:21 -0400
X-MC-Unique: hN5nh-XcOlC0lNVbCSxhJA-1
X-Mimecast-MFC-AGG-ID: hN5nh-XcOlC0lNVbCSxhJA_1745220440
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B151800876;
	Mon, 21 Apr 2025 07:27:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.136])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CEE41801770;
	Mon, 21 Apr 2025 07:27:14 +0000 (UTC)
Date: Mon, 21 Apr 2025 15:27:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
Message-ID: <aAXzToqtIlAoUP7t@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-21-ming.lei@redhat.com>
 <261d7b81-e611-47f4-ad55-6f7716c278c7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261d7b81-e611-47f4-ad55-6f7716c278c7@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 19, 2025 at 08:09:04PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/18/25 10:07 PM, Ming Lei wrote:
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
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/bfq-iosched.c | 2 +-
> >  block/elevator.c    | 5 +++++
> >  block/elevator.h    | 1 +
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 40e4106a71e7..310ce1d8c41e 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
> >  
> >  	blk_stat_disable_accounting(bfqd->queue);
> >  	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
> > -	wbt_enable_default(bfqd->queue->disk);
> > +	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
> >  
> >  	kfree(bfqd);
> >  }
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 8652fe45a2db..378553fce5d8 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -687,8 +687,13 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
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
> >  	if (ctx->new) {
> >  		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> > diff --git a/block/elevator.h b/block/elevator.h
> > index 486be0690499..b14c611c74b6 100644
> > --- a/block/elevator.h
> > +++ b/block/elevator.h
> > @@ -122,6 +122,7 @@ struct elevator_queue
> >  
> >  #define ELEVATOR_FLAG_REGISTERED	0
> >  #define ELEVATOR_FLAG_DYING		1
> > +#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
> >  
> >  /* Holding context data for changing elevator */
> >  struct elv_change_ctx {
> 
> It seems invoking wbt_enable_default from elevator_change_done could probably
> still race with ioc_qos_write or queue_wb_lat_store. Both ioc_qos_write and 
> queue_wb_lat_store run with ->freeze_lock and ->elevator_lock protection.

Actually wbt_enable_default() and wbt_init() needn't the above protection,
especially since the patch 2/20 removes q->elevator use in
wbt_enable_default().

Thanks,
Ming

