Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F88C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 03:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65ED61430
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 03:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhDVDQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 23:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234247AbhDVDQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 23:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619061370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ag8jCCcBs7LFX08r9TvtZvmwtPeVTKsU9haeWHuF2XI=;
        b=CUuy+zJk5tUq6z0+M4vAHrPKcJmNlwmxgTtFwL7tutLa2eAC8fPM/AUpoaU/Tq822YQeSk
        LKdug0OGAnzlrnbbQ4CYpvPC20rZrGpfPWcow1bVzCm+Xo3VR6wvwERWqq6UVK5cFSqK5z
        4YbIqm0Q1muFSQionIMuMm+aWe8Ukd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-bglwxiGkOCGp4oD40kDRKg-1; Wed, 21 Apr 2021 23:16:06 -0400
X-MC-Unique: bglwxiGkOCGp4oD40kDRKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B5010054F6;
        Thu, 22 Apr 2021 03:16:04 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9354A5D747;
        Thu, 22 Apr 2021 03:15:54 +0000 (UTC)
Date:   Thu, 22 Apr 2021 11:15:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
Message-ID: <YIDqa6YkNoD5OiKN@T590>
References: <20210421000235.2028-1-bvanassche@acm.org>
 <20210421000235.2028-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421000235.2028-4-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20, 2021 at 05:02:33PM -0700, Bart Van Assche wrote:
> When multiple request queues share a tag set and when switching the I/O
> scheduler for one of the request queues associated with that tag set, the
> following race can happen:
> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
>   a pointer to a scheduler request to the local variable 'rq'.
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.
> 
> Fix this race as follows:
> * Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rqs[].
>   The performance impact of the assignments added to the hot path is minimal
>   (about 1% according to one particular test).
> * Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a
>   semaphore. Which mechanism is used depends on whether or not it is allowed
>   to sleep and also on whether or not the callback function may sleep.
> * Wait for all preexisting readers to finish before freeing scheduler
>   requests.
> 
> Another race is as follows:
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_queue_tag_busy_iter() iterates over the same tag set but for another
>   request queue than the queue for which scheduler tags are being freed.
> * bt_iter() examines rq->q after *rq has been freed.
> 
> Fix this race by protecting the rq->q read in bt_iter() with an RCU read
> lock and by calling synchronize_rcu() before freeing scheduler tags.
> 
> Multiple users have reported use-after-free complaints similar to the
> following (from https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/ ):
> 
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
> 
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description+0x71/0x239
>  kasan_report.cold.5+0x242/0x301
>  __asan_load8+0x54/0x90
>  bt_iter+0x86/0xf0
>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>  blk_mq_in_flight+0x96/0xb0
>  part_in_flight+0x40/0x140
>  part_round_stats+0x18e/0x370
>  blk_account_io_start+0x3d7/0x670
>  blk_mq_bio_to_request+0x19c/0x3a0
>  blk_mq_make_request+0x7a9/0xcb0
>  generic_make_request+0x41d/0x960
>  submit_bio+0x9b/0x250
>  do_blockdev_direct_IO+0x435c/0x4c70
>  __blockdev_direct_IO+0x79/0x88
>  ext4_direct_IO+0x46c/0xc00
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  ext4_file_write_iter+0x1b8/0x6f0
>  aio_write+0x204/0x310
>  io_submit_one+0x9d3/0xe80
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
> 
> Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-core.c   | 34 ++++++++++++++++++++++++++++++-
>  block/blk-mq-tag.c | 51 ++++++++++++++++++++++++++++++++++++++++------
>  block/blk-mq-tag.h |  4 +++-
>  block/blk-mq.c     | 21 +++++++++++++++----
>  block/blk-mq.h     |  1 +
>  block/blk.h        |  2 ++
>  block/elevator.c   |  1 +
>  7 files changed, 102 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9bcdae93f6d4..ca7f833e25a8 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -279,6 +279,36 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
>  }
>  EXPORT_SYMBOL(blk_dump_rq_flags);
>  
> +/**
> + * blk_mq_wait_for_tag_iter - wait for preexisting tag iteration functions to finish
> + * @set: Tag set to wait on.
> + *
> + * Waits for preexisting calls of blk_mq_all_tag_iter(),
> + * blk_mq_tagset_busy_iter() and also for their atomic variants to finish
> + * accessing hctx->tags->rqs[]. New readers may start while this function is
> + * in progress or after this function has returned. Use this function to make
> + * sure that hctx->tags->rqs[] changes have become globally visible.
> + *
> + * Waits for preexisting blk_mq_queue_tag_busy_iter(q, fn, priv) calls to
> + * finish accessing requests associated with other request queues than 'q'.
> + */
> +void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set)
> +{
> +	struct blk_mq_tags *tags;
> +	int i;
> +
> +	if (set->tags) {
> +		for (i = 0; i < set->nr_hw_queues; i++) {
> +			tags = set->tags[i];
> +			if (!tags)
> +				continue;
> +			down_write(&tags->iter_rwsem);
> +			up_write(&tags->iter_rwsem);
> +		}
> +	}
> +	synchronize_rcu();
> +}
> +
>  /**
>   * blk_sync_queue - cancel any pending callbacks on a queue
>   * @q: the queue
> @@ -412,8 +442,10 @@ void blk_cleanup_queue(struct request_queue *q)
>  	 * it is safe to free requests now.
>  	 */
>  	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> +	if (q->elevator) {
> +		blk_mq_wait_for_tag_iter(q->tag_set);
>  		blk_mq_sched_free_requests(q);
> +	}
>  	mutex_unlock(&q->sysfs_lock);
>  
>  	percpu_ref_exit(&q->q_usage_counter);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d8eaa38a1bd1..39d5c9190a6b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -209,14 +209,24 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  
>  	if (!reserved)
>  		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> -
> +	rcu_read_lock();
> +	/*
> +	 * The request 'rq' points at is protected by an RCU read lock until
> +	 * its queue pointer has been verified and by q_usage_count while the
> +	 * callback function is being invoked. See also the
> +	 * percpu_ref_tryget() and blk_queue_exit() calls in
> +	 * blk_mq_queue_tag_busy_iter().
> +	 */
> +	rq = rcu_dereference(tags->rqs[bitnr]);
>  	/*
>  	 * We can hit rq == NULL here, because the tagging functions
>  	 * test and set the bit before assigning ->rqs[].
>  	 */
> -	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> +	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx) {
> +		rcu_read_unlock();
>  		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	}
> +	rcu_read_unlock();
>  	return true;
>  }
>  
> @@ -254,11 +264,17 @@ struct bt_tags_iter_data {
>  	unsigned int flags;
>  };
>  
> +/* Include reserved tags. */
>  #define BT_TAG_ITER_RESERVED		(1 << 0)
> +/* Only include started requests. */
>  #define BT_TAG_ITER_STARTED		(1 << 1)
> +/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
>  #define BT_TAG_ITER_STATIC_RQS		(1 << 2)
> +/* The callback function may sleep. */
> +#define BT_TAG_ITER_MAY_SLEEP		(1 << 3)
>  
> -static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> +static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
> +			   void *data)
>  {
>  	struct bt_tags_iter_data *iter_data = data;
>  	struct blk_mq_tags *tags = iter_data->tags;
> @@ -275,7 +291,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>  		rq = tags->static_rqs[bitnr];
>  	else
> -		rq = tags->rqs[bitnr];
> +		rq = rcu_dereference_check(tags->rqs[bitnr],
> +					   lockdep_is_held(&tags->iter_rwsem));
>  	if (!rq)
>  		return true;
>  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
> @@ -284,6 +301,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	return iter_data->fn(rq, iter_data->data, reserved);
>  }
>  
> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> +{
> +	struct bt_tags_iter_data *iter_data = data;
> +	struct blk_mq_tags *tags = iter_data->tags;
> +	bool res;
> +
> +	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
> +		down_read(&tags->iter_rwsem);
> +		res = __bt_tags_iter(bitmap, bitnr, data);
> +		up_read(&tags->iter_rwsem);
> +	} else {
> +		rcu_read_lock();
> +		res = __bt_tags_iter(bitmap, bitnr, data);
> +		rcu_read_unlock();
> +	}
> +
> +	return res;
> +}

Holding one rwsem or rcu read lock won't avoid the issue completely
because request may be completed remotely in iter_data->fn(), such as
nbd_clear_req(), nvme_cancel_request(), complete_all_cmds_iter(),
mtip_no_dev_cleanup(), because blk_mq_complete_request() may complete
request in softirq, remote IPI, even wq, and the request is still
referenced in these contexts after bt_tags_iter() returns.


Thanks,
Ming

