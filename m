Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7732C309
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431249; cv=none; b=O7NmP4qSIqM87JfYUTORTDeU0G/vnnMqVNxR7l8sCvSKM2Ak/wW+65cwCuOkAiEfOJ5GU8QZgjpob0QGa0n8dpJpVhKD3mGA7KV+6ZIuE+qy2jQ3M3EV5hBhyeFjbYri2wtpBhFEGoED449aD3/7jfzmlEfuFp7SBf3xocEtMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431249; c=relaxed/simple;
	bh=OAr3cwov0SbuJeIWmX+B3S+07DGFcfzASEZTWXd/XAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVnU5Z284zkyAlCbUitQoxN/UKm1Zi/Oo9h4VJOHUEN2Bc5F9tgh68UG4prtMAShWvjZ+xnKvWM86ruKmtREHAyO1pvOjItwvk0qcvVYX8RXLoiv1y2/eYErhDUZinRwuxHZ+8D3bG6bKHnT2crvC+ATz5vjw9fsNzKqIFJfeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRYYLL/A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRYYLL/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763431241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tybxaoC1HjvCM0UUInHr+nJiy9VXCA2YKrEQwU23f8=;
	b=NRYYLL/A6d9Vru4O4cPFTtLqqRW1jm+6fW+824PCbsFdmk20JV+N/ePUdQcap6m2gg8Fmo
	9Yb1+IrdwPB454zeo/jhDsa6TjDaABHmnEkAqWn1tvhnrHt57cqodnjsHSq9vyvjdXj2Od
	2SlA6XnE9Vu24vaG4riPBMU9ZVlZlBU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-jmbrNQTJNDemdSLKfTbqtA-1; Mon,
 17 Nov 2025 21:00:34 -0500
X-MC-Unique: jmbrNQTJNDemdSLKfTbqtA-1
X-Mimecast-MFC-AGG-ID: jmbrNQTJNDemdSLKfTbqtA_1763431232
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC0A11800107;
	Tue, 18 Nov 2025 02:00:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.204])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45F5D180049F;
	Tue, 18 Nov 2025 02:00:23 +0000 (UTC)
Date: Tue, 18 Nov 2025 10:00:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
Message-ID: <aRvTM5LbnehQU77-@fedora>
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117202414.4071380-2-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 17, 2025 at 12:23:53PM -0800, Mohamed Khalfella wrote:
> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> tagset, the functions make sure that tagset and queues are marked as
> shared when two or more queues are attached to the same tagset.
> Initially a tagset starts as unshared and when the number of added
> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> with all the queues attached to it. When the number of attached queues
> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> the remaining queues as unshared.
> 
> Both functions need to freeze current queues in tagset before setting on
> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> hold set->tag_list_lock mutex, which makes sense as we do not want
> queues to be added or deleted in the process. This used to work fine
> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> made the nvme driver quiesce tagset instead of quiscing individual
> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> set->tag_list while holding set->tag_list_lock also.
> 
> This results in deadlock between two threads with these stacktraces:
> 
>   __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   schedule_preempt_disabled+0x11/0x20
>   __mutex_lock.constprop.0+0x3cc/0x760
>   blk_mq_quiesce_tagset+0x26/0xd0
>   nvme_dev_disable_locked+0x77/0x280 [nvme]
>   nvme_timeout+0x268/0x320 [nvme]
>   blk_mq_handle_expired+0x5d/0x90
>   bt_iter+0x7e/0x90
>   blk_mq_queue_tag_busy_iter+0x2b2/0x590
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   ? __blk_mq_complete_request_remote+0x10/0x10
>   blk_mq_timeout_work+0x15b/0x1a0
>   process_one_work+0x133/0x2f0
>   ? mod_delayed_work_on+0x90/0x90
>   worker_thread+0x2ec/0x400
>   ? mod_delayed_work_on+0x90/0x90
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x2d/0x50
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
> 
>   __schedule+0x48e/0xed0
>   schedule+0x5a/0xc0
>   blk_mq_freeze_queue_wait+0x62/0x90
>   ? destroy_sched_domains_rcu+0x30/0x30
>   blk_mq_exit_queue+0x151/0x180
>   disk_release+0xe3/0xf0
>   device_release+0x31/0x90
>   kobject_put+0x6d/0x180
>   nvme_scan_ns+0x858/0xc90 [nvme_core]
>   ? nvme_scan_work+0x281/0x560 [nvme_core]
>   nvme_scan_work+0x281/0x560 [nvme_core]
>   process_one_work+0x133/0x2f0
>   ? mod_delayed_work_on+0x90/0x90
>   worker_thread+0x2ec/0x400
>   ? mod_delayed_work_on+0x90/0x90
>   kthread+0xe2/0x110
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x2d/0x50
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork_asm+0x11/0x20
> 
> The top stacktrace is showing nvme_timeout() called to handle nvme
> command timeout. timeout handler is trying to disable the controller and
> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> to call queue callback handlers. The thread is stuck waiting for
> set->tag_list_lock as it tires to walk the queues in set->tag_list.
> 
> The lock is held by the second thread in the bottom stack which is
> waiting for one of queues to be frozen. The queue usage counter will
> drop to zero after nvme_timeout() finishes, and this will not happen
> because the thread will wait for this mutex forever.
> 
> Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
> avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
> semaphore for read since this is enough to guarantee no queues will be
> added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
> semaphore for write while updating set->tag_list and downgrade it to
> read while freezing the queues. It should be safe to update set->flags
> and hctx->flags while holding the semaphore for read since the queues
> are already frozen.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  block/blk-mq-sysfs.c   | 10 ++---
>  block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
>  include/linux/blk-mq.h |  4 +-
>  3 files changed, 58 insertions(+), 51 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 58ec293373c6..f474781654fb 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>  
>  	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>  
> -	mutex_lock(&q->tag_set->tag_list_lock);
> +	down_read(&q->tag_set->tag_list_rwsem);
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		ret = blk_mq_register_hctx(hctx);
>  		if (ret)
>  			goto out_unreg;
>  	}
> -	mutex_unlock(&q->tag_set->tag_list_lock);
> +	up_read(&q->tag_set->tag_list_rwsem);
>  	return 0;
>  
>  out_unreg:
> @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>  		if (j < i)
>  			blk_mq_unregister_hctx(hctx);
>  	}
> -	mutex_unlock(&q->tag_set->tag_list_lock);
> +	up_read(&q->tag_set->tag_list_rwsem);
>  
>  	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>  	kobject_del(q->mq_kobj);
> @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> -	mutex_lock(&q->tag_set->tag_list_lock);
> +	down_read(&q->tag_set->tag_list_rwsem);
>  	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_unregister_hctx(hctx);
> -	mutex_unlock(&q->tag_set->tag_list_lock);
> +	up_read(&q->tag_set->tag_list_rwsem);
>  
>  	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>  	kobject_del(q->mq_kobj);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..9211d32ce820 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> -	mutex_lock(&set->tag_list_lock);
> +	down_read(&set->tag_list_rwsem);
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_quiesce_queue_nowait(q);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +	up_read(&set->tag_list_rwsem);
>  
>  	blk_mq_wait_quiesce_done(set);
>  }
> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> -	mutex_lock(&set->tag_list_lock);
> +	down_read(&set->tag_list_rwsem);
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_unquiesce_queue(q);
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +	up_read(&set->tag_list_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>  
> @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>  	}
>  }
>  
> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
> -					 bool shared)
> -{
> -	struct request_queue *q;
> -	unsigned int memflags;
> -
> -	lockdep_assert_held(&set->tag_list_lock);
> -
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> -		memflags = blk_mq_freeze_queue(q);
> -		queue_set_hctx_shared(q, shared);
> -		blk_mq_unfreeze_queue(q, memflags);
> -	}
> -}
> -
>  static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
> +	struct request_queue *firstq;
> +	unsigned int memflags;
>  
> -	mutex_lock(&set->tag_list_lock);
> +	down_write(&set->tag_list_rwsem);
>  	list_del(&q->tag_set_list);
> -	if (list_is_singular(&set->tag_list)) {
> -		/* just transitioned to unshared */
> -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> -		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, false);
> +	if (!list_is_singular(&set->tag_list)) {
> +		up_write(&set->tag_list_rwsem);
> +		goto out;
>  	}
> -	mutex_unlock(&set->tag_list_lock);
> +
> +	/*
> +	 * Transitioning the remaining firstq to unshared.
> +	 * Also, downgrade the semaphore to avoid deadlock
> +	 * with blk_mq_quiesce_tagset() while waiting for
> +	 * firstq to be frozen.
> +	 */
> +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> +	downgrade_write(&set->tag_list_rwsem);
> +	firstq = list_first_entry(&set->tag_list, struct request_queue,
> +				  tag_set_list);
> +	memflags = blk_mq_freeze_queue(firstq);
> +	queue_set_hctx_shared(firstq, false);
> +	blk_mq_unfreeze_queue(firstq, memflags);
> +	up_read(&set->tag_list_rwsem);
> +out:
>  	INIT_LIST_HEAD(&q->tag_set_list);
>  }
>  
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  				     struct request_queue *q)
>  {
> -	mutex_lock(&set->tag_list_lock);
> +	struct request_queue *firstq;
> +	unsigned int memflags;
>  
> -	/*
> -	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
> -	 */
> -	if (!list_empty(&set->tag_list) &&
> -	    !(set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
> -		set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> -		/* update existing queue */
> -		blk_mq_update_tag_set_shared(set, true);
> -	}
> -	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> -		queue_set_hctx_shared(q, true);
> -	list_add_tail(&q->tag_set_list, &set->tag_list);
> +	down_write(&set->tag_list_rwsem);
> +	if (!list_is_singular(&set->tag_list)) {
> +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> +			queue_set_hctx_shared(q, true);
> +		list_add_tail(&q->tag_set_list, &set->tag_list);
> +		up_write(&set->tag_list_rwsem);
> +		return;
> +	}
>  
> -	mutex_unlock(&set->tag_list_lock);
> +	/* Transitioning firstq and q to shared. */
> +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
> +	list_add_tail(&q->tag_set_list, &set->tag_list);
> +	downgrade_write(&set->tag_list_rwsem);
> +	queue_set_hctx_shared(q, true);

queue_set_hctx_shared(q, true) should be moved into write critical area
because this queue has been added to the list.


Thanks, 
Ming

