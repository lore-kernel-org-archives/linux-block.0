Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B0C433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 04:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C9661424
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 04:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhDVEC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 00:02:27 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34593 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhDVEC0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 00:02:26 -0400
Received: by mail-pg1-f182.google.com with SMTP id z16so31897320pga.1
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 21:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HNFolq8+GrECmgGY3oS/A2vROLpITk5Xy0pz1CpUxz0=;
        b=MYkm8AqWZQiSJYt9hM7Whk9Pv9lV5p6CbPqAVbBPHhxAgIpIKfTueO6JEBpmygVTqA
         SYAXyZOHLDlGyzk11/wOQN7414wV7qqk2YZWCRmnaOqQhciewVm2nchI6nQfolWElFP0
         XKf41/cFApcVV4Sv8nynT2LJ34EtZsJMBjY9aDlAk8IC1oLRdh49AvfTz8dzD/ePT03m
         kfxGViCc8J5+F/fIENxuqAc4Zm/uMG4z0UEHFUcfyBX/AXZ14xeVcjn1XbKJbsqzHa+V
         uhDDDuDpl7cbqtTcsjAQ0z/qx5qFofaQY+9H6BXOy/ug/e8td3bYl/gOmp5E78SGw3i0
         Oipw==
X-Gm-Message-State: AOAM531o6zsiKvN9njoN2Icelpn3s/wlYwyFZuf3D0uDMr3TjV0N5pEi
        4I77yymSLGL5q36RVlqmLZc=
X-Google-Smtp-Source: ABdhPJwgNv/IkhoEdhCWLZxPXaK/WWexqEWZg2P3/HtUZyu0Zj30CkN7WJb0+b/ZOwiz8xwhuPgXdA==
X-Received: by 2002:a05:6a00:24c3:b029:248:f517:1b9 with SMTP id d3-20020a056a0024c3b0290248f51701b9mr1431909pfv.46.1619064112191;
        Wed, 21 Apr 2021 21:01:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:bce0:5b8f:12:4649? ([2601:647:4000:d7:bce0:5b8f:12:4649])
        by smtp.gmail.com with ESMTPSA id s22sm720666pjs.42.2021.04.21.21.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 21:01:51 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
References: <20210421000235.2028-1-bvanassche@acm.org>
 <20210421000235.2028-4-bvanassche@acm.org> <YIDegAPz+17BA/9x@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <67442b28-3b08-1704-fff3-6f0e6a23465e@acm.org>
Date:   Wed, 21 Apr 2021 21:01:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIDegAPz+17BA/9x@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 7:25 PM, Ming Lei wrote:
> On Tue, Apr 20, 2021 at 05:02:33PM -0700, Bart Van Assche wrote:
>> When multiple request queues share a tag set and when switching the I/O
>> scheduler for one of the request queues associated with that tag set, the
>> following race can happen:
>> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
>>   a pointer to a scheduler request to the local variable 'rq'.
>> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
>> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.
>>
>> Fix this race as follows:
>> * Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rqs[].
>>   The performance impact of the assignments added to the hot path is minimal
>>   (about 1% according to one particular test).
>> * Protect hctx->tags->rqs[] reads with an RCU read-side lock or with a
>>   semaphore. Which mechanism is used depends on whether or not it is allowed
>>   to sleep and also on whether or not the callback function may sleep.
>> * Wait for all preexisting readers to finish before freeing scheduler
>>   requests.
>>
>> Another race is as follows:
>> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
>> * blk_mq_queue_tag_busy_iter() iterates over the same tag set but for another
>>   request queue than the queue for which scheduler tags are being freed.
>> * bt_iter() examines rq->q after *rq has been freed.
>>
>> Fix this race by protecting the rq->q read in bt_iter() with an RCU read
>> lock and by calling synchronize_rcu() before freeing scheduler tags.
>>
>> Multiple users have reported use-after-free complaints similar to the
>> following (from https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/ ):
>>
>> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
>> Read of size 8 at addr ffff88803b335240 by task fio/21412
>>
>> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> Call Trace:
>>  dump_stack+0x86/0xca
>>  print_address_description+0x71/0x239
>>  kasan_report.cold.5+0x242/0x301
>>  __asan_load8+0x54/0x90
>>  bt_iter+0x86/0xf0
>>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>>  blk_mq_in_flight+0x96/0xb0
>>  part_in_flight+0x40/0x140
>>  part_round_stats+0x18e/0x370
>>  blk_account_io_start+0x3d7/0x670
>>  blk_mq_bio_to_request+0x19c/0x3a0
>>  blk_mq_make_request+0x7a9/0xcb0
>>  generic_make_request+0x41d/0x960
>>  submit_bio+0x9b/0x250
>>  do_blockdev_direct_IO+0x435c/0x4c70
>>  __blockdev_direct_IO+0x79/0x88
>>  ext4_direct_IO+0x46c/0xc00
>>  generic_file_direct_write+0x119/0x210
>>  __generic_file_write_iter+0x11c/0x280
>>  ext4_file_write_iter+0x1b8/0x6f0
>>  aio_write+0x204/0x310
>>  io_submit_one+0x9d3/0xe80
>>  __x64_sys_io_submit+0x115/0x340
>>  do_syscall_64+0x71/0x210
>>
>> Reviewed-by: Khazhismel Kumykov <khazhy@google.com>
>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Martin K. Petersen <martin.petersen@oracle.com>
>> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Khazhy Kumykov <khazhy@google.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>  block/blk-core.c   | 34 ++++++++++++++++++++++++++++++-
>>  block/blk-mq-tag.c | 51 ++++++++++++++++++++++++++++++++++++++++------
>>  block/blk-mq-tag.h |  4 +++-
>>  block/blk-mq.c     | 21 +++++++++++++++----
>>  block/blk-mq.h     |  1 +
>>  block/blk.h        |  2 ++
>>  block/elevator.c   |  1 +
>>  7 files changed, 102 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 9bcdae93f6d4..ca7f833e25a8 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -279,6 +279,36 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
>>  }
>>  EXPORT_SYMBOL(blk_dump_rq_flags);
>>  
>> +/**
>> + * blk_mq_wait_for_tag_iter - wait for preexisting tag iteration functions to finish
>> + * @set: Tag set to wait on.
>> + *
>> + * Waits for preexisting calls of blk_mq_all_tag_iter(),
>> + * blk_mq_tagset_busy_iter() and also for their atomic variants to finish
>> + * accessing hctx->tags->rqs[]. New readers may start while this function is
>> + * in progress or after this function has returned. Use this function to make
>> + * sure that hctx->tags->rqs[] changes have become globally visible.
>> + *
>> + * Waits for preexisting blk_mq_queue_tag_busy_iter(q, fn, priv) calls to
>> + * finish accessing requests associated with other request queues than 'q'.
>> + */
>> +void blk_mq_wait_for_tag_iter(struct blk_mq_tag_set *set)
>> +{
>> +	struct blk_mq_tags *tags;
>> +	int i;
>> +
>> +	if (set->tags) {
>> +		for (i = 0; i < set->nr_hw_queues; i++) {
>> +			tags = set->tags[i];
>> +			if (!tags)
>> +				continue;
>> +			down_write(&tags->iter_rwsem);
>> +			up_write(&tags->iter_rwsem);
>> +		}
>> +	}
>> +	synchronize_rcu();
>> +}
>> +
>>  /**
>>   * blk_sync_queue - cancel any pending callbacks on a queue
>>   * @q: the queue
>> @@ -412,8 +442,10 @@ void blk_cleanup_queue(struct request_queue *q)
>>  	 * it is safe to free requests now.
>>  	 */
>>  	mutex_lock(&q->sysfs_lock);
>> -	if (q->elevator)
>> +	if (q->elevator) {
>> +		blk_mq_wait_for_tag_iter(q->tag_set);
>>  		blk_mq_sched_free_requests(q);
>> +	}
>>  	mutex_unlock(&q->sysfs_lock);
>>  
>>  	percpu_ref_exit(&q->q_usage_counter);
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index d8eaa38a1bd1..39d5c9190a6b 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -209,14 +209,24 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  
>>  	if (!reserved)
>>  		bitnr += tags->nr_reserved_tags;
>> -	rq = tags->rqs[bitnr];
>> -
>> +	rcu_read_lock();
>> +	/*
>> +	 * The request 'rq' points at is protected by an RCU read lock until
>> +	 * its queue pointer has been verified and by q_usage_count while the
>> +	 * callback function is being invoked. See also the
>> +	 * percpu_ref_tryget() and blk_queue_exit() calls in
>> +	 * blk_mq_queue_tag_busy_iter().
>> +	 */
>> +	rq = rcu_dereference(tags->rqs[bitnr]);
>>  	/*
>>  	 * We can hit rq == NULL here, because the tagging functions
>>  	 * test and set the bit before assigning ->rqs[].
>>  	 */
>> -	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
>> +	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx) {
>> +		rcu_read_unlock();
>>  		return iter_data->fn(hctx, rq, iter_data->data, reserved);
>> +	}
>> +	rcu_read_unlock();
>>  	return true;
>>  }
>>  
>> @@ -254,11 +264,17 @@ struct bt_tags_iter_data {
>>  	unsigned int flags;
>>  };
>>  
>> +/* Include reserved tags. */
>>  #define BT_TAG_ITER_RESERVED		(1 << 0)
>> +/* Only include started requests. */
>>  #define BT_TAG_ITER_STARTED		(1 << 1)
>> +/* Iterate over tags->static_rqs[] instead of tags->rqs[]. */
>>  #define BT_TAG_ITER_STATIC_RQS		(1 << 2)
>> +/* The callback function may sleep. */
>> +#define BT_TAG_ITER_MAY_SLEEP		(1 << 3)
>>  
>> -static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>> +static bool __bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr,
>> +			   void *data)
>>  {
>>  	struct bt_tags_iter_data *iter_data = data;
>>  	struct blk_mq_tags *tags = iter_data->tags;
>> @@ -275,7 +291,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>>  		rq = tags->static_rqs[bitnr];
>>  	else
>> -		rq = tags->rqs[bitnr];
>> +		rq = rcu_dereference_check(tags->rqs[bitnr],
>> +					   lockdep_is_held(&tags->iter_rwsem));
>>  	if (!rq)
>>  		return true;
>>  	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
>> @@ -284,6 +301,25 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>  	return iter_data->fn(rq, iter_data->data, reserved);
>>  }
>>  
>> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>> +{
>> +	struct bt_tags_iter_data *iter_data = data;
>> +	struct blk_mq_tags *tags = iter_data->tags;
>> +	bool res;
>> +
>> +	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
>> +		down_read(&tags->iter_rwsem);
>> +		res = __bt_tags_iter(bitmap, bitnr, data);
>> +		up_read(&tags->iter_rwsem);
>> +	} else {
>> +		rcu_read_lock();
>> +		res = __bt_tags_iter(bitmap, bitnr, data);
>> +		rcu_read_unlock();
>> +	}
>> +
>> +	return res;
>> +}
>> +
>>  /**
>>   * bt_tags_for_each - iterate over the requests in a tag map
>>   * @tags:	Tag map to iterate over.
>> @@ -357,10 +393,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>  {
>>  	int i;
>>  
>> +	might_sleep();
>> +
>>  	for (i = 0; i < tagset->nr_hw_queues; i++) {
>>  		if (tagset->tags && tagset->tags[i])
>>  			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>> -					      BT_TAG_ITER_STARTED);
>> +				BT_TAG_ITER_STARTED | BT_TAG_ITER_MAY_SLEEP);
>>  	}
>>  }
>>  EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>> @@ -544,6 +582,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>>  
>>  	tags->nr_tags = total_tags;
>>  	tags->nr_reserved_tags = reserved_tags;
>> +	init_rwsem(&tags->iter_rwsem);
>>  
>>  	if (blk_mq_is_sbitmap_shared(flags))
>>  		return tags;
>> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
>> index 0290c308ece9..d1d73d7cc7df 100644
>> --- a/block/blk-mq-tag.h
>> +++ b/block/blk-mq-tag.h
>> @@ -17,9 +17,11 @@ struct blk_mq_tags {
>>  	struct sbitmap_queue __bitmap_tags;
>>  	struct sbitmap_queue __breserved_tags;
>>  
>> -	struct request **rqs;
>> +	struct request __rcu **rqs;
>>  	struct request **static_rqs;
>>  	struct list_head page_list;
>> +
>> +	struct rw_semaphore iter_rwsem;
>>  };
>>  
>>  extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 79c01b1f885c..8b59f6b4ec8e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -496,8 +496,10 @@ static void __blk_mq_free_request(struct request *rq)
>>  	blk_crypto_free_request(rq);
>>  	blk_pm_mark_last_busy(rq);
>>  	rq->mq_hctx = NULL;
>> -	if (rq->tag != BLK_MQ_NO_TAG)
>> +	if (rq->tag != BLK_MQ_NO_TAG) {
>>  		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>> +		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
> 
> After the tag is released, it can be re-allocated from another context
> immediately. And the above rcu_assign_pointer(NULL) could be run after
> the re-allocation and new ->rqs[rq->tag] assignment in submission path,
> is it one issue?

How about swapping the rcu_assign_pointer() and blk_mq_put_tag() calls?
That should be safe since the tag iteration functions check whether or
not hctx->tags->rqs[] is NULL.

There are already barriers in sbitmap_queue_clear() so I don't think
that any new barriers would need to be added.

Thanks,

Bart.

