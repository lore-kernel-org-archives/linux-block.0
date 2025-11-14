Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23855244664
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763098485; cv=none; b=J4HYutBL+subE787qf1BA/UA4OCJrV4zkNDDwzT2XOx2eKcxdrTo4YJsoLsq3LchrLDjCbTJPyQbUn5hLFQUoyD9y+ocwDGf5rYF1EeAWz4ONG9yUWx7jyMcaziGADkG/NMfVCpBuPVt9qceR1ptU5vwQCKSyx2oCQHcViZxCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763098485; c=relaxed/simple;
	bh=b/T+1TPc1DuabZw4+om1RiiTUraM4E+igr0OmPJdYr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwsauHMT91vh4vqtg5wkSe1m7YHpqLlNZR6/EFykfitQ4/8bm9O32AUSIBl5PjlwRqkjtB3wOWQmejemX7AMV2OwoD4fzAnk+xxSpuyPrjHcuxvaqC1gBWk00rq+WiQmT/4aSJoSsMxL4d9ZQDUQTl6nmd/F9lKM0kVYH2uVXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T5VDzc3M; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T5VDzc3M"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso814029a12.3
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 21:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763098483; x=1763703283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ceqWDqvY/FDdzTWcr1CZe6B3SXd28YT0+hfhTO7utYg=;
        b=T5VDzc3MZGgWJGgU+bgiV+ofVitRtslKKQ87vkGijfPD61St58HFDgKyrp1A3w5Uqh
         yYLUgr2jUMAsq5ADNRuEmLfXq2NpKWJHwATY3WyxOcrwE0bCUzo04nu83qPrEnWzVT52
         Mxw5fzIYDBRcLoYIa8+7RcBarmwak1fI95DLRAfkap/hkdnN/qkxFESY71RrMmTsTR0J
         ppPBCb8Aq3I8IjicKX1A+KRS9yHEpr2eZzmO+Z5H8ieNYBX/D+mjGfdRa/mbu0SAojDt
         FnQPpJMOzStPjB1Ob2lrF9MgVYVkosDH/F1M1Fb+SHJfKfFrtkk3LeFdyMQ4TRbBJJBs
         reDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763098483; x=1763703283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceqWDqvY/FDdzTWcr1CZe6B3SXd28YT0+hfhTO7utYg=;
        b=S+e6YF8ic0Oe2lo8/nlyzR9+33OJMCwY/QTw5F4WavZBLB0o/RMZstJA4CDu+sQYgZ
         jsMVntxh459wrourREqbLf2KqyrVatbk+FyauMSUb+rGx8Zubk0mR651S1AljuJVJz4C
         QlbFmn7cSsCe4TrevwMHq3dY+nsmDvQlNDyok3iXkDu3hAf9QUyWH/btBsRcVWVKChYD
         efe8aqRxGgyUKg2zXh2u4FQXbMckg862eYhPWeisimQ0XRfx9J75G9aizhz2Xs47ycV8
         DRebzv9h/9hwyQWucarVazaY6yS44n+kYc7qy0O5pdM0DQVnArwd+WLFQKnRMSRXHDQu
         FdpA==
X-Forwarded-Encrypted: i=1; AJvYcCVS1GQNtxGnbfX14cKlvciLVj6C14+ZDFrr6e8Ox476L8uDyGqdVe1Ac2zeYZm5sRIkVU/lqe8YkQnf2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvuNk8UVmCJwT1sg5N5xilNKZsWXs2syBTaf1YkudDyCjLWro
	N/iAsdq3AMDg54C9iqgglM1hksFNnUnWQX54hGF554/E5iOk3k475EaXPqJMdfLkpww=
X-Gm-Gg: ASbGncu2Zh0Cz1PIUtVnNpa59s3BzFz2PBL9pqCjXFeV2L2x1XlyYEpY3sMBQOJ+FDD
	+PhP9ygvSJ6XDTgmhj4rFCAUhl5JtKm/CFobEZkoNRgTPR8cPUG07SIXKlnvqV6zdouSMMvzsov
	+ZODHPYgEWqb6t+DRW9YJoaxE9hm/cJwfXomVY8adJRO05iYc0COC1qDEAfWccPU7+UkrCfRhKb
	dUJMTpLmcyDsGw7aL07PCe/GVJgWBG7vyicjMNqCV6NNrqG5uNTHBNrrAaTXX1yDqQpyLKB6z6A
	jlN8yhAEuvuyasIOeeTkAbZM6Pv5G5xfEkeXaxlTsxGisLUMQ9usXpXd6dfzGdd5uCJcpO0rnOC
	9o4BrfiftuchXX9YWtXBxtplV3lfgjEmbmjt2DmmSqd9ZvRyN7fxxuE4WfTlu/PklFMjUbTY6nR
	k3qc2bSrPfpVVDnYPm68AvCkWswd8=
X-Google-Smtp-Source: AGHT+IGIgnw7CDjq0fpnsLtUjTEZ73eF0bdJWF2fyLL7lw2+x9X+bKjReBfIZfCnd2FsYgdRnHLNnA==
X-Received: by 2002:a05:7022:62aa:b0:11a:72c6:22df with SMTP id a92af1059eb24-11b40e79761mr624220c88.4.1763098483110;
        Thu, 13 Nov 2025 21:34:43 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::f013])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11b060885c0sm6352228c88.3.2025.11.13.21.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:34:42 -0800 (PST)
Date: Thu, 13 Nov 2025 21:34:41 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Message-ID: <20251114053441.GA2037010-mkhalfella@purestorage.com>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <e629ec9c-9f25-48b3-8fb4-1c94cf83604b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e629ec9c-9f25-48b3-8fb4-1c94cf83604b@nvidia.com>

On Fri 2025-11-14 04:56:52 +0000, Chaitanya Kulkarni wrote:
> On 11/13/25 12:23, Mohamed Khalfella wrote:
> > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > tagset, the functions make sure that tagset and queues are marked as
> > shared when two or more queues are attached to the same tagset.
> > Initially a tagset starts as unshared and when the number of added
> > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > with all the queues attached to it. When the number of attached queues
> > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > the remaining queues as unshared.
> >
> > Both functions need to freeze current queues in tagset before setting on
> > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > hold set->tag_list_lock mutex, which makes sense as we do not want
> > queues to be added or deleted in the process. This used to work fine
> > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > made the nvme driver quiesce tagset instead of quiscing individual
> > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > set->tag_list while holding set->tag_list_lock also.
> >
> > This results in deadlock between two threads with these stacktraces:
> >
> [...]
> 
> >
> > The top stacktrace is showing nvme_timeout() called to handle nvme
> > command timeout. timeout handler is trying to disable the controller and
> > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > to call queue callback handlers. The thread is stuck waiting for
> > set->tag_list_lock as it tires to walk the queues in set->tag_list.
> >
> > The lock is held by the second thread in the bottom stack which is
> > waiting for one of queues to be frozen. The queue usage counter will
> > drop to zero after nvme_timeout() finishes, and this will not happen
> > because the thread will wait for this mutex forever.
> >
> > Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> > avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> > semaphore for read since this is enough to guarantee no queues will be
> > added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> > semaphore for write while updating set->tag_list and downgrade it to
> > read while freezing the queues. It should be safe to update set->flags
> > and hctx->flags while holding the semaphore for read since the queues
> > are already frozen.
> >
> > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> I think there is no better way to solve this in to nvme code ?

I can not think of way to fix this issue within nvme code.

> 
> will it have any impact on existing users, if any, that are relying
> on current mutex based implementation ?
> 

I audited the codepaths that use the mutex to the best of my knowledge.
I think this change should not have impact on existing code that uses
the mutex.

> BTW, thanks for reporting this and providing a patch.
> 

No problem.

> > ---
> >   block/blk-mq-sysfs.c   | 10 +++----
> >   block/blk-mq.c         | 63 ++++++++++++++++++++++--------------------
> >   include/linux/blk-mq.h |  4 +--
> >   3 files changed, 40 insertions(+), 37 deletions(-)
> >
> > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > index 58ec293373c6..f474781654fb 100644
> > --- a/block/blk-mq-sysfs.c
> > +++ b/block/blk-mq-sysfs.c
> > @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
> >   
> >   	kobject_uevent(q->mq_kobj, KOBJ_ADD);
> >   
> > -	mutex_lock(&q->tag_set->tag_list_lock);
> > +	down_read(&q->tag_set->tag_list_rwsem);
> >   	queue_for_each_hw_ctx(q, hctx, i) {
> >   		ret = blk_mq_register_hctx(hctx);
> >   		if (ret)
> >   			goto out_unreg;
> >   	}
> > -	mutex_unlock(&q->tag_set->tag_list_lock);
> > +	up_read(&q->tag_set->tag_list_rwsem);
> >   	return 0;
> >   
> 
> [...]
> 
> >   static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
> >   				     struct request_queue *q)
> >   {
> > -	mutex_lock(&set->tag_list_lock);
> > +	down_write(&set->tag_list_rwsem);
> > +	if (!list_is_singular(&set->tag_list)) {
> > +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > +			queue_set_hctx_shared(q, true);
> > +		list_add_tail(&q->tag_set_list, &set->tag_list);
> > +		up_write(&set->tag_list_rwsem);
> > +		return;
> > +	}
> >   
> > -	/*
> > -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> > -	 */
> > -	if (!list_empty(&set->tag_list) &&
> > -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> > -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> > -		/* update existing queue */
> > -		blk_mq_update_tag_set_shared(set, true);
> > -	}
> > -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> > -		queue_set_hctx_shared(q, true);
> > +	/* Transitioning to shared. */
> > +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> >   	list_add_tail(&q->tag_set_list, &set->tag_list);
> > -
> > -	mutex_unlock(&set->tag_list_lock);
> > +	downgrade_write(&set->tag_list_rwsem);
> 
> do we need a comment here what to expect since downgrade_write() is
> not as common as mutex_unlock()|down_write() before merging the
> patch ?
> 

	/*
	 * Downgrade the semaphore before freezing the queues to avoid
	 * deadlock with a thread trying to quiesce the tagset before
	 * completing requests.
	 */

Yes, this could use some explanation. How about the three lines above?

> -ck
> 
> 
