Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAA7483
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592094; cv=none; b=tVn3J4OJ4YhmaIVoq7GEUkSSXxfFTC7ywi19EaZYeUduATdOUdIM7LrtAycNgJ7mH0HWLYBDDNlq4y34UNlDtXUInAUqvvXVv3Hy3l0OqgLO19FjsmhTy8s0hbwYnR5CveO+cyS1hw9Rk/pbOA5kTR3GLPmgKxU+hqFPLFBOJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592094; c=relaxed/simple;
	bh=fKBDUJpjU0ZRJeG8X+Cx53NG2FC8phGsHka/yf3FnNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snqwhoOAEWAJwJudNrGJ6RLDBPP8c7jN501nJCzDXs6ZAn6f7++PNlIun7BG58z71IlJm8ASoDCFhS6jVpNK347t0I7/U+VAuxdJ/4pWdUes/ESAcB6JsuiejLEJn+ac2+s4xbTAU6A75pArCDWAKj6jGZ/PrNuNM8X/MRwuSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czWjJTpn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czWjJTpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744592091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rRtRCPNlbJCB8Xi1dhAvmJgE7GuEWGN9s22sx0acqw=;
	b=czWjJTpn5HKoq0+1nHhfhOgv/n9Y9LXIsCcKlwK3Lt9DPA8mHjr+V5IRZCGjKOJ1+k5h5m
	0IeggMYcyJfllfr7i7ZP/9Av5mEcQ6EX+Pw/eED6v86ukv0bs5+b3ifzZtor7AxJUZNn+n
	zWKMHmnbewJcdDI5gdy+SfPU6rzAPHc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-7FZX9L8AOgqI_-HG1dOfpg-1; Sun,
 13 Apr 2025 20:54:47 -0400
X-MC-Unique: 7FZX9L8AOgqI_-HG1dOfpg-1
X-Mimecast-MFC-AGG-ID: 7FZX9L8AOgqI_-HG1dOfpg_1744592086
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECF1818004A9;
	Mon, 14 Apr 2025 00:54:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15A12180B487;
	Mon, 14 Apr 2025 00:54:41 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:54:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 04/15] block: prevent elevator switch during updating
 nr_hw_queues
Message-ID: <Z_xczMuX5_yDKdAs@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-5-ming.lei@redhat.com>
 <20250410143622.GC10701@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410143622.GC10701@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 10, 2025 at 04:36:22PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 09:30:16PM +0800, Ming Lei wrote:
> > updating nr_hw_queues is usually used for error handling code, when it
> 
> Capitalize the first word of each sentence, please.
> 
> > doesn't make sense to allow blk-mq elevator switching, since nr_hw_queues
> > may change, and elevator tags depends on nr_hw_queues.
> 
> I don't think it's really updated from error handling

NVMe does use it in error handling. I can remove error handling words, but
the trouble doesn't change.

> 
>  - nbd does it when starting a device
>  - nullb can do it through debugfs
>  - xen-blkfront does it when resuming from a suspend
>  - nvme does it when resetting a controller.  While error handling
>    can escalate to it¸ it's basically probing and re-probing code

reset is part of error handling.

> 
> > Prevent elevator switch during updating nr_hw_queues by setting flag of
> > BLK_MQ_F_UPDATE_HW_QUEUES, and use srcu to fail elevator switch during
> > the period. Here elevator switch code is srcu reader of nr_hw_queues,
> > and blk_mq_update_nr_hw_queues() is the writer.
> 
> That being said as we generally are in a setup path I think the general
> idea is fine.  No devices should be life yet at this point and thus
> no udev rules changing the scheduler should run yet.
> 
> > This way avoids lot of trouble.
> 
> Can you spell that out a bit?

Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/

> 
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> 
> Are we using Closes for bug reports now?  I haven't really seen that
> anywhere.

The blktests block/039 isn't merged yet, and the patch is posted recently.

kernel panic and kasan is triggered in this test.

> 
> >  out_cleanup_srcu:
> >  	if (set->flags & BLK_MQ_F_BLOCKING)
> >  		cleanup_srcu_struct(set->srcu);
> > @@ -5081,7 +5087,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> >  {
> >  	mutex_lock(&set->tag_list_lock);
> > +	/*
> > +	 * Mark us in updating nr_hw_queues for preventing switching
> > +	 * elevator
> >
> > +	 *
> > +	 * Elevator switch code can _not_ acquire ->tag_list_lock
> 
> Please add a . at the end of a sentences.  Also this should probably
> be something like "Mark us as in.." but I'll leave more nitpicking
> to the native speakers.

OK.

> 
> >  	struct request_queue *q = disk->queue;
> > +	struct blk_mq_tag_set *set = q->tag_set;
> >  
> >  	/*
> >  	 * If the attribute needs to load a module, do it before freezing the
> > @@ -732,6 +733,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >  
> >  	elv_iosched_load_module(name);
> >  
> > +	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> > +
> > +	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
> 
> What provides atomicity for field modifications vs reading of set->flags?
> i.e. does this need to switch using test/set_bit?

WRITE is serialized via tag set lock with synchronize_srcu().

READ is covered by srcu read lock.

It is typical RCU usage, one writer vs. multiple writer.

> 
> > +	struct srcu_struct	update_nr_hwq_srcu;
> >  };
> >  
> >  /**
> > @@ -681,7 +682,14 @@ enum {
> >  	 */
> >  	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
> >  
> > -	BLK_MQ_F_MAX = 1 << 7,
> > +	/*
> > +	 * True when updating nr_hw_queues is in-progress
> > +	 *
> > +	 * tag_set only flag, not usable for hctx
> > +	 */
> > +	BLK_MQ_F_UPDATE_HW_QUEUES	= 1 << 7,
> > +
> > +	BLK_MQ_F_MAX = 1 << 8,
> 
> Also mixing internal state with driver provided flags is always
> a bad idea.  So this should probably be a new state field in the
> tag_set and not reuse flags.
 
That is fine, but BLK_MQ_F_TAG_QUEUE_SHARED is used in this way too.

thanks, 
Ming

