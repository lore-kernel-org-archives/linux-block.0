Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679418C2C
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763346654; cv=none; b=TvzlVScPPPB0Qts2BJvEWKhMgBLeVyN80ydbqLa7MyxlF3oqg2q0BtiRgi0dovbjyWl425rKcQtQD1Gh8RPS5NCFbrMpV9bOJhkN2ieTtlgd6OsIRv+AmPnnDlzrDtvS4sHYsMGrRG6u0yrdcx36CeFy+qrWJ9YRrroS1G1svOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763346654; c=relaxed/simple;
	bh=kDZGpFttNKAb1zeVRoFl3jLsYxmSaHx88ekDdcDWnyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX8nvfd3dqah9sWADJFFv29sTrcYJnk7XeGLCR67rakJcLBerhsb0koITQ6t3VoX2lNITjcaVyBGpD19Ajw2+KCMwYLJNE+NlIbh2X42RHOw7V/gLNfnqhD3t8mStSe9j2htlQzBmdFLHljsPlY8hS6wlYYK18eq9vW0Iw2k3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkP8rAlH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkP8rAlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763346651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAt5O2OGCvrxi43qiiw7KlLubL52Moiy7Jw1EGFHlqI=;
	b=TkP8rAlHqubnsm9lGvtl60QjPkJswhkiGY6v8TPSE+EjM/l7/j41yYYmnonPlfS9WJ831B
	/0LMGvcLdfjYletRmnB3sY95OTmiH2AZuObiWR4SsoPwfn55hFZhNPALHUHzBZqJzNxilS
	6JFxxx3mWNMc6K6fcJcevrj6wb82NQ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-03LoMAaWNH6HgnL1Df_Huw-1; Sun,
 16 Nov 2025 21:30:46 -0500
X-MC-Unique: 03LoMAaWNH6HgnL1Df_Huw-1
X-Mimecast-MFC-AGG-ID: 03LoMAaWNH6HgnL1Df_Huw_1763346645
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E7BA1800342;
	Mon, 17 Nov 2025 02:30:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BEB93002D0D;
	Mon, 17 Nov 2025 02:30:35 +0000 (UTC)
Date: Mon, 17 Nov 2025 10:30:31 +0800
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
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Message-ID: <aRqIxzyppFEBBHNT@fedora>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113202320.2530531-1-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
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
>  block/blk-mq-sysfs.c   | 10 +++----
>  block/blk-mq.c         | 63 ++++++++++++++++++++++--------------------
>  include/linux/blk-mq.h |  4 +--
>  3 files changed, 40 insertions(+), 37 deletions(-)
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
> index d626d32f6e57..1770277fe453 100644
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
> @@ -4280,7 +4280,7 @@ static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
>  	struct request_queue *q;
>  	unsigned int memflags;
>  
> -	lockdep_assert_held(&set->tag_list_lock);
> +	lockdep_assert_held(&set->tag_list_rwsem);
>  
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		memflags = blk_mq_freeze_queue(q);
> @@ -4293,37 +4293,40 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  {
>  	struct blk_mq_tag_set *set = q->tag_set;
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
> +	/* Transitioning to unshared. */
> +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> +	downgrade_write(&set->tag_list_rwsem);
> +	blk_mq_update_tag_set_shared(set, false);
> +	up_read(&set->tag_list_rwsem);
> +out:
>  	INIT_LIST_HEAD(&q->tag_set_list);
>  }
>  
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  				     struct request_queue *q)
>  {
> -	mutex_lock(&set->tag_list_lock);
> +	down_write(&set->tag_list_rwsem);
> +	if (!list_is_singular(&set->tag_list)) {
> +		if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
> +			queue_set_hctx_shared(q, true);
> +		list_add_tail(&q->tag_set_list, &set->tag_list);
> +		up_write(&set->tag_list_rwsem);
> +		return;
> +	}

It could be more readable to add documentation:

  /*
   * Three cases:
   * 1. Empty list (first queue): Add without shared flag
   * 2. Singular list (1→2 queues): Transition to shared
   * 3. Multiple queues (2+): Add with existing shared flag
   */

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
> +	/* Transitioning to shared. */
> +	set->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
>  	list_add_tail(&q->tag_set_list, &set->tag_list);
> -
> -	mutex_unlock(&set->tag_list_lock);
> +	downgrade_write(&set->tag_list_rwsem);
> +	blk_mq_update_tag_set_shared(set, true);
> +	up_read(&set->tag_list_rwsem);
>  }

Here you change to freeze two queues, and the in-tree code just freezes the
1st added queue. Probably it is nice to keep existing behavior to just freeze
the 1st old queue.

Also blk_mq_update_tag_set_shared() is only done on single queue, so
the helper can be removed and just open-code queue_set_hctx_shared(),
which can show the single queue point obviously and more readable.

Otherwise, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

