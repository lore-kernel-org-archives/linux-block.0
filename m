Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537832D7DB
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952782; cv=none; b=K+6nWYTkEOT1anbHyBj1+RBTF36PwGjUiR2FF4Wt4OVmDHXY3MX7d9eMXJh2DXSHmO3nmgO4iWKzw1pcd5YXJ4dppT/bchM+Ikd/bwmWsXcDTFvOUOKQ33+litXbJI2Iw4INc1szdnPcx93Kzop3pk7CcYAl4ClEwJxrTzHC2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952782; c=relaxed/simple;
	bh=yRpvY3hJhwpXCqWCyx548MJOOfNkhcNjgnkWr30Nu6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGVOEdMvHlN/0iCEcVVAYEo9Mk2QcN876WZx4cpnN8u/oD7v1Vx0+B0XW7dr0DnBSdeYqEOFetj7hT8LrNJZj4vCnc5H+iVOL9+QDi2CR7XUjScLQuNf8a0Y/gftEFU23sFhIfxnkTfWYvUkZ0BUCXHABruPAObvuBvhJhRgl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CHPQF26j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CHPQF26j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29ba9249e9dso32506175ad.3
        for <linux-block@vger.kernel.org>; Fri, 05 Dec 2025 08:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764952769; x=1765557569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTU+LxuJwXlNa9YUgQCS8AbBwlbqwdJ/enGGPEzwseM=;
        b=CHPQF26jK/SZzJlvvF65YOGJxvF3VOxhchcVVrNRNYieKNLyRIWcRcs7RqaLD88aEP
         6MhZ139Vp0bwLDLs1BA8/YPCV2aAfvUxo/nv3guXOXTTXkJNSQpg3OMkPzr7gq4iy4Qe
         bPlBMIZRUUeLKVF57t3bqpERMr6L1QCy/pNnKt0J/M467zxxYrGfM4aspSM1yw6/QDqG
         ZRe82bYVQboEBwoJ8Y18DgqcV3o5OtjEeokFdjtHIQi7pFSGraczQtnlGb2fy7UDKeo7
         kfOCBLVucXA3yMiG4YQZ9r8WBXjyqVcf/4VoITlZFJBSlXcUyKUjDZoIGC+Uoqrjy2g7
         cQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764952769; x=1765557569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTU+LxuJwXlNa9YUgQCS8AbBwlbqwdJ/enGGPEzwseM=;
        b=dLmfIQslIBC5OpHP35JK8A0Oa8v50RoNKSu1rvF2CwNkK+EzuF3taPR/gpANgzDDxO
         PGr5ygRctva70VtZacT2S7gOIradKFg/BEAmvEUqjfS+jkZ+9IUxh8WeyLQAW54rnO6w
         P2+QayHJC/NErhe9XL6FaQVysvZEuu4AqD5ftVzy9KPPROz8+1qkj4frFm9/4TzZmttl
         2EketE3aVtA4WT3oJ5pxJ8UBjjApdQ7eZWo9iEL0uHO6LTkXjGbzu4yT7DUK4/xx7rKw
         9CIgV9zIz5V7kzKCbI3YG6k616O2NXmyWx7TVByVDnOvvYa1NsjgrAPcy5eWomQygcZb
         yCUA==
X-Forwarded-Encrypted: i=1; AJvYcCWo0ytsvXv++kTdQ+T9Neq9ee9O3DtSPDJ3XGHPs6CcTLlzPBk8MDAeXSgeIEtGib4D7IsR5U010oI0ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyL+g71WVVghFIWYdVM1uMGr6G7W3+vjTDoaW4OMglXCGtaUuS
	mx0qVqN6VErQDQuVlNJQbbnAMp7SOyQpZfG/zLxRNFknqYMY7T0BtBT7tGuKSmprIvg=
X-Gm-Gg: ASbGncurYSE8x2VcnMgIfkWD/Xry6avW1VaOffQlFLIdwt/+e3SRcOLsk0EVVuH+4o3
	wyLqBnrrcm12V6g6GpnukBXjMu1oHhNYtymAVpBRBoVT/jMgJBMMLMROzUwsZLlA/aOZqnEU7Qy
	AGn1u+y4Kbabij8ifEhAQHLJU47lDwQ47hzEc0nYKl0d3DAueQF0fTUPcyp0QYlwNyaYlBy8VND
	8rdfcSHyLKvQ6Q7IEL2n1NHeySdT3hHPdIMMU2HvYzGBJwQS9HVaUIyLd1zund3a2Vw29P+AJIG
	sVuV2SE0IJi38m3SSbFtf2p9ADFq/6LOTqGRMqqYksKI7rA5Mr5+n1e9NtPrD89nYmUdMVTJZNY
	lPHvaosnmKKZuxyR6wgihtDLTYGoGNtS9654qF0B9Ri/63gbB0oCnFXWh4GdkxXPRIPTEz2t5IQ
	1w44OUE2y//ahJgfYm6oeVM9SEh5k=
X-Google-Smtp-Source: AGHT+IGyqqXd0/T+TfMGuiq+NHZnOPlJ5gPhROJprsj74mw36MvYZMv3SkASuMrsEc7UEyVTpKpkdw==
X-Received: by 2002:a05:7301:da88:b0:2a4:61a1:c0d5 with SMTP id 5a478bee46e88-2ab92ebc2d6mr5258910eec.36.1764952768406;
        Fri, 05 Dec 2025 08:39:28 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2aba87d7b9dsm20321107eec.4.2025.12.05.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 08:39:27 -0800 (PST)
Date: Fri, 5 Dec 2025 08:39:26 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251205163926.GI2376676-mkhalfella@purestorage.com>
References: <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
 <aTH8opTiwJxH2PMA@kbusch-mbp>
 <201a7e9e-4782-4f71-a73b-9d58a51ee8ec@acm.org>
 <aTI2L6j50VWjp7aW@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTI2L6j50VWjp7aW@kbusch-mbp>

On Thu 2025-12-04 18:32:31 -0700, Keith Busch wrote:
> On Thu, Dec 04, 2025 at 01:22:49PM -1000, Bart Van Assche wrote:
> > 
> > On 12/4/25 11:26 AM, Keith Busch wrote:
> > > On Thu, Dec 04, 2025 at 10:24:03AM -1000, Bart Van Assche wrote:>> Hence, the deadlock can be
> > > > solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
> > > > and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
> > > > I/O and does not call blk_mq_quiesce_tagset() then the
> > > > blk_mq_freeze_queue_wait() call will finish instead of triggering a
> > > > deadlock. However, I do not know whether this proposal seems acceptable
> > > > to the NVMe maintainers.
> > > 
> > > You periodically make this suggestion, but there's never a reason
> > > offered to introduce yet another work queue for the driver to
> > > synchronize with at various points. The whole point of making blk-mq
> > > timeout handler in a work queue (it used to be a timer) was so that we
> > > could do blocking actions like this.
> > Hi Keith,
> > 
> > The blk_mq_quiesce_tagset() call from the NVMe timeout handler is
> > unfortunate because it triggers a deadlock with
> > blk_mq_update_tag_set_shared().
> 
> So in this scenario, the driver is modifying a tagset list from two
> queues to one, which causes blk-mq to clear the "shared" flags. The
> remaining one just so happens to have hit a timeout at the same time,
> which runs in a context with an elevated "q_usage_counter". The current
> rule, then, is you can not take the tag_list_lock from any context using
> any queue in the tag list.
> 
> > I proposed to modify the NVMe driver because I think that's a better
> > approach than introducing a new synchronize_rcu() call in the block
> > layer core.
> 
> I'm not interested in introducing rcu synchronize here either. I guess I
> would make it so you can quiesce a tagset from a context that entered
> the queue. So quick shot at that here:

Why sychronize_rcu() is intolerable in this blk_mq_del_queue_tag_set()?
This code is not performance sensitive, right?

Looking at the code again, I _think_ synchronize_rcu() along with 
INIT_LIST_HEAD(&q->tag_set_list) can be deleted. I do not see usecase
where "q" is re-added to a tagset after it is deleted from one.
Also, "q" is freed in blk_free_queue() after end of RCU grace period.

Are there any other concerns with this approach other than
synchronize_rcu()? If not, I will delete it and submit v3.

> 
> ---
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4e96bb2462475..20450017b9512 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4262,11 +4262,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   * Caller needs to ensure that we're either frozen/quiesced, or that
>   * the queue isn't live yet.
>   */
> -static void queue_set_hctx_shared(struct request_queue *q, bool shared)
> +static void queue_set_hctx_shared_locked(struct request_queue *q)
>  {
> +	struct blk_mq_tag_set *set = q->tag_set;
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
> +	bool shared;
> +
> +	lockdep_assert_held(&set->tag_list_lock);
>  
> +	shared = set->flags & BLK_MQ_F_TAG_QUEUE_SHARED;
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (shared) {
>  			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> @@ -4277,24 +4282,22 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>  	}
>  }
>  
> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
> -					 bool shared)
> +static void queue_set_hctx_shared(struct request_queue *q)
>  {
> -	struct request_queue *q;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  	unsigned int memflags;
>  
> -	lockdep_assert_held(&set->tag_list_lock);
> -
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> -		memflags = blk_mq_freeze_queue(q);
> -		queue_set_hctx_shared(q, shared);
> -		blk_mq_unfreeze_queue(q, memflags);
> -	}
> +	memflags = blk_mq_freeze_queue(q);
> +	mutex_lock(&set->tag_list_lock);
> +	queue_set_hctx_shared_locked(q);
> +	mutex_unlock(&set->tag_list_lock);
> +	blk_mq_unfreeze_queue(q, memflags);
>  }
>  
>  static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *shared = NULL;
>  
>  	mutex_lock(&set->tag_list_lock);
>  	list_del(&q->tag_set_list);
> @@ -4302,15 +4305,25 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  		/* just transitioned to unshared */
>  		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>  		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, false);
> +		shared = list_first_entry(&set->tag_list, struct request_queue,
> +					  tag_set_list);
> +		if (!blk_get_queue(shared))
> +			shared = NULL;
>  	}
>  	mutex_unlock(&set->tag_list_lock);
>  	INIT_LIST_HEAD(&q->tag_set_list);
> +
> +	if (shared) {
> +		queue_set_hctx_shared(shared);
> +		blk_put_queue(shared);
> +	}
>  }
>  
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  				     struct request_queue *q)
>  {
> +	struct request_queue *shared = NULL;
> +
>  	mutex_lock(&set->tag_list_lock);
>  
>  	/*
> @@ -4318,15 +4331,24 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  	 */
>  	if (!list_empty(&set->tag_list) &&
>  	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
>  		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, true);
> +		shared = list_first_entry(&set->tag_list, struct request_queue,
> +					  tag_set_list);
> +		if (!blk_get_queue(shared))
> +			shared = NULL;
> +		else
> +			set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
>  	}
>  	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> -		queue_set_hctx_shared(q, true);
> +		queue_set_hctx_shared_locked(q);
>  	list_add_tail(&q->tag_set_list, &set->tag_list);
>  
>  	mutex_unlock(&set->tag_list_lock);
> +
> +	if (shared) {
> +		queue_set_hctx_shared(shared);
> +		blk_put_queue(shared);
> +	}
>  }
>  
>  /* All allocations will be freed in release handler of q->mq_kobj */
> --

__blk_mq_update_nr_hw_queues() freezes the queues while holding
set->tag_list_lock. Can this cause the same deadlock?
