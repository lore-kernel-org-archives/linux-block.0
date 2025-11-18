Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE12FE079
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432669; cv=none; b=e8OKINQT0e334EHFAev863JLWW1WcQBaQ4aL71idexhjmMq+d36eJ+MUBSF6bh2WqqqRcUcENBL2Kaphh0+FwZz5co+W+vzpzFFBhj0p0hITa0fsdBKRfYH6gmMT9XLhCe1tBM1Ijhfja3CI+ODGRYUrceWQMOmmu/XiGvnshT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432669; c=relaxed/simple;
	bh=jgLsL8EQyJd2Br4MPI3F6KwrqyOVSh00Wvrvs03QIXI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=X1YFvEUcIdOG+IeezrZQrxh7YGdd75+9qYbl3Ut7szXPZ5mm+eXoRs/7AEGp9xt0qLbFslgccHwnFFAFrDkIsvC+1ds5v60XRqZcJQaJucH5kmitCvXLQ4jinLhnPtC2j9KLHc4K2wLzZ+oV7cIJTRIAxdljNpxaAynUHsRvYFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/KuVxA4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGd/YpZh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/KuVxA4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGd/YpZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763432665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOwAePC/NPw7hDfXIpdlCbSHG9S1qqf21zBz7vtSHX8=;
	b=E/KuVxA4hcJrh1XOpq7pgPNUoWLLcfmiGXZflAfmJJd7JbrOdxby3V7chvFF/6ReuFuSuM
	kfCGcHIBxs7G0sAGIR7d5V5UxXW8+tek+Oag2DAJgN3WioaJP/fxJzhBqZDJ3KmW6kb2fR
	8YD3rMElbmQYXXogh4oc/qEWx2xxdIg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-UKxbZGRqNdmmoRMDR8FiYA-1; Mon, 17 Nov 2025 21:24:24 -0500
X-MC-Unique: UKxbZGRqNdmmoRMDR8FiYA-1
X-Mimecast-MFC-AGG-ID: UKxbZGRqNdmmoRMDR8FiYA_1763432664
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8804b9afe30so215211776d6.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763432664; x=1764037464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOwAePC/NPw7hDfXIpdlCbSHG9S1qqf21zBz7vtSHX8=;
        b=HGd/YpZhmFkzeGjRBnYktHiuc3F1mng1LhJ1FLUGa/3fr/ltC7bLPZqzPv+MnwwVgE
         c6zZ3P8JttyRdSsjZovgRNAKpVyUDuFiPet/0Klbb3lwkmntHoiMONcmSyf6HrFMoaqj
         lDUf8uTI0RpXg0yEGgqzVjJ3yFME2yzU3/y3P8SHQZSyYD0DE3GMmf7U8wlwLje2XqpI
         c5fNX8pDscnDYflTeOXmxL87u2pTF+FKmmlN3+/uQbw2rzPaU4gyTIVYshY9OnuCMdFO
         JDIBQP0+aV1Obgd+mBJOfNAbIXQp00FFrGDj2PMwCRf3wxgGy5H3RrrKjBPvHQQBRzQE
         5Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432664; x=1764037464;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOwAePC/NPw7hDfXIpdlCbSHG9S1qqf21zBz7vtSHX8=;
        b=UrSvfZF1inrbZrI2qvP1YAORgH4tEKxozxtOirw0ijSHlYSv4noc9j+6HEVbg7IzoZ
         OFDgG2pcvGTee1W7w5pgGBNOe4GFdsEhp50aHtVIhzpTHgbnPJZ1RR9dHVky2asfl0ga
         GKn8cSabBcW9RXervxcGQcxTiRz8LU20vV+BlZ7kFGFUOH0J0EZCA2Q/60qhMOSHt1Uo
         ey3XbXuw3k/l8xj+dErzMWU4tWLqe+Jpn1JJSDmTy0Q/VS5n6v5aESUufzCCeabYuHMe
         D+pOtYGsJTRQ3zLLcnAlbSD1JBAbGFIO1XS7j5/W/qb6UR6pfdua7nL4pf0BI3zGcxmP
         B1hA==
X-Forwarded-Encrypted: i=1; AJvYcCWu2/50rQCDOXZGQp9pEWME24lylZkqlsFQoctfRNIp5Wjs6Xr2xLLbV1vnMnStMFQOs0JOlAp67v5+eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa32zLBLriHvUn3OgN6bLTaWIt4lpyoGTqs1LK5s+xLKfdS/xe
	E483twDGfV5qn5TVNFHSqX75KHYlFS9TQ1P8IHKMgbbvSiONEb64vrvxoH8UnwvYG7aT0ctRLV8
	FVZfQvs2Sywl2KrcU3jVIzinlCoiRMbEedMcpMbR5Gt0UrGdlhXo71TYHgpF84pu2
X-Gm-Gg: ASbGncutdO0d7w8LCevo7r0MUnS9hV3fSas6pOfrs8hCgdROZaLWYPbnxWCy4QFeesi
	Slnqjkbs21mZ3Q5vn/Pdl0Qs+6FApji+mDDk+rIHyTbruEHL1pSxNGXidmeNZQsLpFKldyfxj8y
	uncGSQbhKjeL9TjlfvdGjImbnQ09D+IlOMwR/sl2zvtkZSF8mXAg372xLoa5TZgNO4iBtBdKHEE
	YxFw4HHGlfZSt4E6fD02Y0HZ6I4KV7rntVT6dqvkgN+MrB8bm1TXArnJwzzC5XJ0f7r731O2S9q
	PLH0cJD1rOVDesZQS8GssP2XtrETyEE23rzBYkWCcz21F2wwk0r4lU5zfQyvoflLEc4/1S+MLHK
	GrkV2rbBq6SyG49h9krxOetA+AWm4tdha5b0V0x1BdYIk6g==
X-Received: by 2002:a05:6214:268b:b0:880:2de3:eef3 with SMTP id 6a1803df08f44-882926b1e19mr236224706d6.32.1763432663657;
        Mon, 17 Nov 2025 18:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb7GLCy7ZCBeNDHvzfJNZiFnbDKqJIiNykFezhBonArB/ScdDKtqFSn50+jhEGKW0NwimkHQ==
X-Received: by 2002:a05:6214:268b:b0:880:2de3:eef3 with SMTP id 6a1803df08f44-882926b1e19mr236224426d6.32.1763432663252;
        Mon, 17 Nov 2025 18:24:23 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828630693bsm104340286d6.14.2025.11.17.18.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 18:24:22 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5db3bb06-0bf2-4ba3-b765-c217acda1b0c@redhat.com>
Date: Mon, 17 Nov 2025 21:24:21 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Hillf Danton <hdanton@sina.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Waiman Long <llong@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
Content-Language: en-US
In-Reply-To: <20251118013442.9414-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 8:34 PM, Hillf Danton wrote:
> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
>> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
>> tagset, the functions make sure that tagset and queues are marked as
>> shared when two or more queues are attached to the same tagset.
>> Initially a tagset starts as unshared and when the number of added
>> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
>> with all the queues attached to it. When the number of attached queues
>> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
>> the remaining queues as unshared.
>>
>> Both functions need to freeze current queues in tagset before setting on
>> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
>> hold set->tag_list_lock mutex, which makes sense as we do not want
>> queues to be added or deleted in the process. This used to work fine
>> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>> made the nvme driver quiesce tagset instead of quiscing individual
>> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
>> set->tag_list while holding set->tag_list_lock also.
>>
>> This results in deadlock between two threads with these stacktraces:
>>
>>    __schedule+0x48e/0xed0
>>    schedule+0x5a/0xc0
>>    schedule_preempt_disabled+0x11/0x20
>>    __mutex_lock.constprop.0+0x3cc/0x760
>>    blk_mq_quiesce_tagset+0x26/0xd0
>>    nvme_dev_disable_locked+0x77/0x280 [nvme]
>>    nvme_timeout+0x268/0x320 [nvme]
>>    blk_mq_handle_expired+0x5d/0x90
>>    bt_iter+0x7e/0x90
>>    blk_mq_queue_tag_busy_iter+0x2b2/0x590
>>    ? __blk_mq_complete_request_remote+0x10/0x10
>>    ? __blk_mq_complete_request_remote+0x10/0x10
>>    blk_mq_timeout_work+0x15b/0x1a0
>>    process_one_work+0x133/0x2f0
>>    ? mod_delayed_work_on+0x90/0x90
>>    worker_thread+0x2ec/0x400
>>    ? mod_delayed_work_on+0x90/0x90
>>    kthread+0xe2/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x2d/0x50
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork_asm+0x11/0x20
>>
>>    __schedule+0x48e/0xed0
>>    schedule+0x5a/0xc0
>>    blk_mq_freeze_queue_wait+0x62/0x90
>>    ? destroy_sched_domains_rcu+0x30/0x30
>>    blk_mq_exit_queue+0x151/0x180
>>    disk_release+0xe3/0xf0
>>    device_release+0x31/0x90
>>    kobject_put+0x6d/0x180
>>    nvme_scan_ns+0x858/0xc90 [nvme_core]
>>    ? nvme_scan_work+0x281/0x560 [nvme_core]
>>    nvme_scan_work+0x281/0x560 [nvme_core]
>>    process_one_work+0x133/0x2f0
>>    ? mod_delayed_work_on+0x90/0x90
>>    worker_thread+0x2ec/0x400
>>    ? mod_delayed_work_on+0x90/0x90
>>    kthread+0xe2/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x2d/0x50
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork_asm+0x11/0x20
>>
>> The top stacktrace is showing nvme_timeout() called to handle nvme
>> command timeout. timeout handler is trying to disable the controller and
>> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
>> to call queue callback handlers. The thread is stuck waiting for
>> set->tag_list_lock as it tires to walk the queues in set->tag_list.
>>
>> The lock is held by the second thread in the bottom stack which is
>> waiting for one of queues to be frozen. The queue usage counter will
>> drop to zero after nvme_timeout() finishes, and this will not happen
>> because the thread will wait for this mutex forever.
>>
>> Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
>> avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
>> semaphore for read since this is enough to guarantee no queues will be
>> added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
>> semaphore for write while updating set->tag_list and downgrade it to
>> read while freezing the queues. It should be safe to update set->flags
>> and hctx->flags while holding the semaphore for read since the queues
>> are already frozen.
>>
>> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>> ---
>>   block/blk-mq-sysfs.c   | 10 ++---
>>   block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
>>   include/linux/blk-mq.h |  4 +-
>>   3 files changed, 58 insertions(+), 51 deletions(-)
>>
>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>> index 58ec293373c6..f474781654fb 100644
>> --- a/block/blk-mq-sysfs.c
>> +++ b/block/blk-mq-sysfs.c
>> @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>   
>>   	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>>   
>> -	mutex_lock(&q->tag_set->tag_list_lock);
>> +	down_read(&q->tag_set->tag_list_rwsem);
>>   	queue_for_each_hw_ctx(q, hctx, i) {
>>   		ret = blk_mq_register_hctx(hctx);
>>   		if (ret)
>>   			goto out_unreg;
>>   	}
>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>> +	up_read(&q->tag_set->tag_list_rwsem);
>>   	return 0;
>>   
>>   out_unreg:
>> @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>   		if (j < i)
>>   			blk_mq_unregister_hctx(hctx);
>>   	}
>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>> +	up_read(&q->tag_set->tag_list_rwsem);
>>   
>>   	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>   	kobject_del(q->mq_kobj);
>> @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>>   	struct blk_mq_hw_ctx *hctx;
>>   	unsigned long i;
>>   
>> -	mutex_lock(&q->tag_set->tag_list_lock);
>> +	down_read(&q->tag_set->tag_list_rwsem);
>>   	queue_for_each_hw_ctx(q, hctx, i)
>>   		blk_mq_unregister_hctx(hctx);
>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>> +	up_read(&q->tag_set->tag_list_rwsem);
>>   
>>   	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>   	kobject_del(q->mq_kobj);
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index d626d32f6e57..9211d32ce820 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>>   {
>>   	struct request_queue *q;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	down_read(&set->tag_list_rwsem);
>>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>   		if (!blk_queue_skip_tagset_quiesce(q))
>>   			blk_mq_quiesce_queue_nowait(q);
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>> +	up_read(&set->tag_list_rwsem);
>>   
>>   	blk_mq_wait_quiesce_done(set);
>>   }
>> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>>   {
>>   	struct request_queue *q;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	down_read(&set->tag_list_rwsem);
>>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>   		if (!blk_queue_skip_tagset_quiesce(q))
>>   			blk_mq_unquiesce_queue(q);
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>> +	up_read(&set->tag_list_rwsem);
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>>   
>> @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>>   	}
>>   }
>>   
>> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
>> -					 bool shared)
>> -{
>> -	struct request_queue *q;
>> -	unsigned int memflags;
>> -
>> -	lockdep_assert_held(&set->tag_list_lock);
>> -
>> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> -		memflags = blk_mq_freeze_queue(q);
>> -		queue_set_hctx_shared(q, shared);
>> -		blk_mq_unfreeze_queue(q, memflags);
>> -	}
>> -}
>> -
>>   static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>   {
>>   	struct blk_mq_tag_set *set = q->tag_set;
>> +	struct request_queue *firstq;
>> +	unsigned int memflags;
>>   
>> -	mutex_lock(&set->tag_list_lock);
>> +	down_write(&set->tag_list_rwsem);
>>   	list_del(&q->tag_set_list);
>> -	if (list_is_singular(&set->tag_list)) {
>> -		/* just transitioned to unshared */
>> -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>> -		/* update existing queue */
>> -		blk_mq_update_tag_set_shared(set, false);
>> +	if (!list_is_singular(&set->tag_list)) {
>> +		up_write(&set->tag_list_rwsem);
>> +		goto out;
>>   	}
>> -	mutex_unlock(&set->tag_list_lock);
>> +
>> +	/*
>> +	 * Transitioning the remaining firstq to unshared.
>> +	 * Also, downgrade the semaphore to avoid deadlock
>> +	 * with blk_mq_quiesce_tagset() while waiting for
>> +	 * firstq to be frozen.
>> +	 */
>> +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>> +	downgrade_write(&set->tag_list_rwsem);
> If the first lock waiter is for write, it could ruin your downgrade trick.

That is true. The downgrade will wake up all the waiting readers at the 
front of the wait queue, but if there is one or more writers in the mix. 
The wakeup will stop when the first writer is hit and all the readers 
after that will not be woken up.

We can theoretically provide a downgrade variant that wakes up all the 
readers if it is a useful feature.

Cheers,
Longman


