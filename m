Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB5202F68
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509800; cv=none; b=uOem/y/6uZcOTX8SnBInK+WDa1u0RiMHrjr6V5yaBY8f/xCa0Mm2UBX6tyiyYpkQR3Zm8gSpteu7FfblzxE77SL63MiPvYOxqv4xzWhY9/B7QID6Rot01lRA7aRIJQqX2Q0Z/1dYc4vr870bdwooCetw53HZqPbnoitcjSGO434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509800; c=relaxed/simple;
	bh=N35vb5cdNr3EyVaPJIc3XYLhIENIrpdB/OABpH2s+28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryWBvnwmw6WYPf2iAYphzPSRAIDGUBxYC83Xhwj1nCz6CASQ3+5X4tzxFvchdaKGL8iUs1fjbA9dELErpMMHeO1lDvVM3bYgrrV3f41My/sACN6Khrs/7/kRLjmmReJjPJc0WqookU6XCS7tZtnyX0FFbMUrUvCfRHMnskQdSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRtp53VZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRtp53VZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743509797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqpsL6oK/qQwqmu8rOHD+0YUpbKB9lezEyKO6Au+xus=;
	b=TRtp53VZt261ValF0887xq4D/UiKZqO3rQyYKTLsL9bk6l+JLceKcnH5t97sozXzSCepqR
	0CbZNGk3481iEFrBNp7MMOIa+M3IX9EgexEFNpNdvSbYcVOd4NfyUUn4YDyWyN49N1wbCU
	ICMYLhX9QiH7SY4Xb1rWW7lth5caecY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-mWh5sp33OFuT6qyLNqdnog-1; Tue,
 01 Apr 2025 08:16:32 -0400
X-MC-Unique: mWh5sp33OFuT6qyLNqdnog-1
X-Mimecast-MFC-AGG-ID: mWh5sp33OFuT6qyLNqdnog_1743509791
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73D3619560BD;
	Tue,  1 Apr 2025 12:16:30 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6EB180A803;
	Tue,  1 Apr 2025 12:16:25 +0000 (UTC)
Date: Tue, 1 Apr 2025 20:16:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: syzbot <syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in elv_iosched_store
Message-ID: <Z-vZE2pyrg4_I2SV@fedora>
References: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
 <Z-dUCLvf06SfTOHy@fedora>
 <462d4e8a-dd95-48fe-b9fe-a558057f9595@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462d4e8a-dd95-48fe-b9fe-a558057f9595@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Apr 01, 2025 at 05:23:56PM +0530, Nilay Shroff wrote:
> 
> 
> On 3/29/25 7:29 AM, Ming Lei wrote:
> > On Fri, Mar 28, 2025 at 07:37:25AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1384b43f980000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7163a109ac459a8
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=4c7e0f9b94ad65811efb
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178cfa4c580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8ca4c580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/fc7dc9f0d9a7/disk-1a9239bb.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/f555a3ae03d3/vmlinux-1a9239bb.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/55f6ea74eaf2/bzImage-1a9239bb.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> >>
> > 
> > ...
> > 
> >>
> >> If you want syzbot to run the reproducer, reply with:
> >> #syz test: git://repo/address.git branch-or-commit-hash
> >> If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index ae8494d88897..d7a103dc258b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4465,14 +4465,12 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
> >  	return NULL;
> >  }
> >  
> > -static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > -						struct request_queue *q)
> > +static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > +				     struct request_queue *q)
> >  {
> >  	struct blk_mq_hw_ctx *hctx;
> >  	unsigned long i, j;
> >  
> > -	/* protect against switching io scheduler  */
> > -	mutex_lock(&q->elevator_lock);
> >  	for (i = 0; i < set->nr_hw_queues; i++) {
> >  		int old_node;
> >  		int node = blk_mq_get_hctx_node(set, i);
> > @@ -4505,7 +4503,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >  
> >  	xa_for_each_start(&q->hctx_table, j, hctx, j)
> >  		blk_mq_exit_hctx(q, set, hctx, j);
> > -	mutex_unlock(&q->elevator_lock);
> > +}
> > +
> > +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> > +				   struct request_queue *q, bool lock)
> > +{
> > +	if (lock) {
> > +		/* protect against switching io scheduler  */
> > +		mutex_lock(&q->elevator_lock);
> > +		__blk_mq_realloc_hw_ctxs(set, q);
> > +		mutex_unlock(&q->elevator_lock);
> > +	} else {
> > +		__blk_mq_realloc_hw_ctxs(set, q);
> > +	}
> >  
> >  	/* unregister cpuhp callbacks for exited hctxs */
> >  	blk_mq_remove_hw_queues_cpuhp(q);
> > @@ -4537,7 +4547,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> >  
> >  	xa_init(&q->hctx_table);
> >  
> > -	blk_mq_realloc_hw_ctxs(set, q);
> > +	blk_mq_realloc_hw_ctxs(set, q, false);
> >  	if (!q->nr_hw_queues)
> >  		goto err_hctxs;
> >  
> > @@ -5033,7 +5043,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >  fallback:
> >  	blk_mq_update_queue_map(set);
> >  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > -		blk_mq_realloc_hw_ctxs(set, q);
> > +		blk_mq_realloc_hw_ctxs(set, q, true);
> >  
> >  		if (q->nr_hw_queues != set->nr_hw_queues) {
> >  			int i = prev_nr_hw_queues;
> > 
> 
> This patch looks good to me, however after we fix this one, I found another splat. 
> I see that these new splats are side effect of commit ffa1e7ada456 ("block: Make 
> request_queue lockdep splats show up earlier").
> 
> IMO in the block layer code (unless it's in an IO submission path or a path where we 
> have already frozen queue) we may still want to allow memory allocation with GFP_KERNEL. 
> So in that sense, for example, we may acquire ->elevator_lock followed by fs_reclaim. 

If any memory GFP_KERNEL allocation grabs ->elevator_lock, it is one real
deadlock risk.

> Or in another words, shouldn't it be legitimate to acquire blk layer specific lock and 
> then allocate memory using GFP_KERNEL assuming we haven't freezed queue or we're not in 
> IO submission path. But this commit ffa1e7ada456 ("block: Make request_queue lockdep
> splats show up earlier") now showing up some false-positive splat as well, please see
> below:

It depends if we may run GFP_KERNEL allocation with ->elevator_lock.

I feel ->elevator_lock is still used too many...


thanks,
Ming

