Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5472FF659
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437334; cv=none; b=FC7Pv5cBWmKoAPpsTZJL7frttBj3/Xxr0iUUI+AsppRJi7nK7VRX1wzD37/t1w+GqJSNdlpX6ODldVwHDLg1E5rRMEY38rwBVSd7XH3F5MAj07eajyr1wbh+Gmz2S7ziiKEfGt4rha1Y8txadtcPWZ+kSWikFhTTaM/Iql4YjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437334; c=relaxed/simple;
	bh=fS6maj9Apd7/X406oumfTtJAFeHkTAqZESdDfVTGMeY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XfECALmlhSKHpMmY3DCsxbWqauQ7oG5Fe8O4eVGecYT+G6rWr6yY/+SezNNcimozQxSqyFwXd36EGGCBpUvOj4fOrRcGeRFrDyaXOyVIR2x3r6F4FKkWis+b+kUGYLwUOZReNA6Ch2zXyA81x1QAv8itS4PAMvI4dw4uFUG8NnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwQMt3tm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsAn19S9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwQMt3tm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsAn19S9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763437331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XxW3/cdpIpT5nG4CxK606QnZknlkTscj3Js3IBq6x4=;
	b=cwQMt3tmjv9LxjTNQjyeqFnJ55dZx07QMHkuRFFHDlFQTFiyl3/eDHWZ2pKleey+s1J36O
	Q/GA/2/2RsqHMoAActQ0gSwJ2NzW2dyuOJbh3QxTdx5nnwm+UNpzjW5SUK4LKjhfehCLQT
	MXDc2K1obNOV5/rG8TeRPsQ9/NSk0XE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-u6QMmPOZNm6Qf53xKw9ISQ-1; Mon, 17 Nov 2025 22:42:07 -0500
X-MC-Unique: u6QMmPOZNm6Qf53xKw9ISQ-1
X-Mimecast-MFC-AGG-ID: u6QMmPOZNm6Qf53xKw9ISQ_1763437327
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8823a371984so40300056d6.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 19:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763437327; x=1764042127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2XxW3/cdpIpT5nG4CxK606QnZknlkTscj3Js3IBq6x4=;
        b=bsAn19S9kTOTJm69s9KwZy+ftVck7SunuQFyTZYOw0lRddrPnpvUJ5aAAyF5xi06rC
         2Ioas4ZAPIsZHvCZ7t4VdrZPOTky/9MMG4JIWZ0HEWnPuCU7lExjncarZOZDaDMzdKDd
         k2luC5A3pHaXbL1ncnhn7eoLyPu9YXSYDxsT0thywcuMZAEZVjr6CQP0q+Se2LDMXrIA
         1CcfYynAjFwpJRLD+FuwqmjF1uBxVBTuCpy0PGFGOFJYOxioGlm4flGMH9yjnqswIARA
         ZPCVra9Wtp616VDPSwWlBBpvSH8hSV9+Aynl7ZJP/3zmKO9cvHnM4eC7DVkrDxy+nlEo
         htNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763437327; x=1764042127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XxW3/cdpIpT5nG4CxK606QnZknlkTscj3Js3IBq6x4=;
        b=DpDreEizquuIwIm4oaOXg5sj7oXlNYpT+b6ZtbCnlj0hWeYdr5FNNjiVRK5PikwRLX
         YyNZjXCoOlMunMW0jkJGu1lBHgtvn9qtkTJUjOCcLmQfAtVHFK3O0uvdZOsDL+CHdYWP
         R+p6OwFbcIeX9ivgs86aBJ4uvm9K9LnWhGx8Lava6bK8el12Irw1KOLy8JYMp8wYS2a7
         bjnFqDoJVyFLxKDSyY3xMf2bjOnWbKYa5ZC4jnNLkj3nUX7MdTvsI0l/FquKSP3Xi9s4
         nqI1XUuCAe3fz4GfVbvWMBn4VqZeSN9APvWqdqOc589ZdxfpOJ+2I3VkzVFmLdQi19J7
         GbMg==
X-Forwarded-Encrypted: i=1; AJvYcCXikZIToUHtjpnKOq+zHSH9S0HxWXhSn+eiforyyzZiyKYvwUqkGen6hOJ01iY/wX5jggRHqHubGLw8+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7eoHfkGI6I0awzXfVPD7atIazknAB6g11HANh2NwqYIiTKNK
	h1IszfipXomtU0mvH3Pn5cuXfvQLXcB2t1k7rGPF3QGQSubzC4dHoMnBzF7KtVomud+mjSQNlS6
	IRJAsVLuOX2RRgU5vguoFeLs+mJnY1W30cyKNyUbsvnlFzHD0fTOFZePTmdHDVdUe
X-Gm-Gg: ASbGncuyOV7Rg9Ycn2xEw76yNk6cD9UibYwJ1wgzyD/FHjhZ0S4RQcV2O8liNEqAS8y
	ukDABNJHOz8C/rTMYtqNUWcZrO/LC+Dlcm/zAYtlCGNzHKg1fST3Ya54tiBf9gkR0uZs1zbearE
	2kfvlxhA6+lBJmyRktk2ogNejABXgbW2Wd86sQqKjY0hwkgVOjZASAp7z0bpqeWH0evkLbVo1DV
	t4u/0JbWg4Sle609LMVEuHXkcW8o2eN1Qd4Ilx9vFoudyNez8JAaziwJEpf+Ci3L2OqAUyhbr8N
	YZ8UlM2t+DinDZgs8303pJnXGaNyuPEBpZYw+vF3fY+UEpc8QJz5BNQpQ0XRXxRF2nedkuwZmU7
	OcZycPbSQsI8dJbsADu5G6pCv4iN5FswClXYiU5DMMWD+cQ==
X-Received: by 2002:a05:6214:da4:b0:880:460a:96d0 with SMTP id 6a1803df08f44-882926d4d81mr193131516d6.54.1763437327149;
        Mon, 17 Nov 2025 19:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvF2cpzlrcyundtwxPYaOVNm6InJJZmhHeI5ssiKbAedeez6kqVgsutwGj45j+Bi+1EqeTZA==
X-Received: by 2002:a05:6214:da4:b0:880:460a:96d0 with SMTP id 6a1803df08f44-882926d4d81mr193131406d6.54.1763437326732;
        Mon, 17 Nov 2025 19:42:06 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828631454csm105583056d6.18.2025.11.17.19.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 19:42:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8b07bdd3-5779-4fe4-be05-a8c8efc89f9d@redhat.com>
Date: Mon, 17 Nov 2025 22:42:04 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>, Jens Axboe
 <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251118013442.9414-1-hdanton@sina.com>
 <5db3bb06-0bf2-4ba3-b765-c217acda1b0c@redhat.com> <aRvjQ6QluONcObXD@fedora>
Content-Language: en-US
In-Reply-To: <aRvjQ6QluONcObXD@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 10:08 PM, Ming Lei wrote:
> On Mon, Nov 17, 2025 at 09:24:21PM -0500, Waiman Long wrote:
>> On 11/17/25 8:34 PM, Hillf Danton wrote:
>>> On Mon, 17 Nov 2025 12:23:53 -0800 Mohamed Khalfella wrote:
>>>> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
>>>> tagset, the functions make sure that tagset and queues are marked as
>>>> shared when two or more queues are attached to the same tagset.
>>>> Initially a tagset starts as unshared and when the number of added
>>>> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
>>>> with all the queues attached to it. When the number of attached queues
>>>> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
>>>> the remaining queues as unshared.
>>>>
>>>> Both functions need to freeze current queues in tagset before setting on
>>>> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
>>>> hold set->tag_list_lock mutex, which makes sense as we do not want
>>>> queues to be added or deleted in the process. This used to work fine
>>>> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>>>> made the nvme driver quiesce tagset instead of quiscing individual
>>>> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
>>>> set->tag_list while holding set->tag_list_lock also.
>>>>
>>>> This results in deadlock between two threads with these stacktraces:
>>>>
>>>>     __schedule+0x48e/0xed0
>>>>     schedule+0x5a/0xc0
>>>>     schedule_preempt_disabled+0x11/0x20
>>>>     __mutex_lock.constprop.0+0x3cc/0x760
>>>>     blk_mq_quiesce_tagset+0x26/0xd0
>>>>     nvme_dev_disable_locked+0x77/0x280 [nvme]
>>>>     nvme_timeout+0x268/0x320 [nvme]
>>>>     blk_mq_handle_expired+0x5d/0x90
>>>>     bt_iter+0x7e/0x90
>>>>     blk_mq_queue_tag_busy_iter+0x2b2/0x590
>>>>     ? __blk_mq_complete_request_remote+0x10/0x10
>>>>     ? __blk_mq_complete_request_remote+0x10/0x10
>>>>     blk_mq_timeout_work+0x15b/0x1a0
>>>>     process_one_work+0x133/0x2f0
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     worker_thread+0x2ec/0x400
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     kthread+0xe2/0x110
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork+0x2d/0x50
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork_asm+0x11/0x20
>>>>
>>>>     __schedule+0x48e/0xed0
>>>>     schedule+0x5a/0xc0
>>>>     blk_mq_freeze_queue_wait+0x62/0x90
>>>>     ? destroy_sched_domains_rcu+0x30/0x30
>>>>     blk_mq_exit_queue+0x151/0x180
>>>>     disk_release+0xe3/0xf0
>>>>     device_release+0x31/0x90
>>>>     kobject_put+0x6d/0x180
>>>>     nvme_scan_ns+0x858/0xc90 [nvme_core]
>>>>     ? nvme_scan_work+0x281/0x560 [nvme_core]
>>>>     nvme_scan_work+0x281/0x560 [nvme_core]
>>>>     process_one_work+0x133/0x2f0
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     worker_thread+0x2ec/0x400
>>>>     ? mod_delayed_work_on+0x90/0x90
>>>>     kthread+0xe2/0x110
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork+0x2d/0x50
>>>>     ? kthread_complete_and_exit+0x20/0x20
>>>>     ret_from_fork_asm+0x11/0x20
>>>>
>>>> The top stacktrace is showing nvme_timeout() called to handle nvme
>>>> command timeout. timeout handler is trying to disable the controller and
>>>> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
>>>> to call queue callback handlers. The thread is stuck waiting for
>>>> set->tag_list_lock as it tires to walk the queues in set->tag_list.
>>>>
>>>> The lock is held by the second thread in the bottom stack which is
>>>> waiting for one of queues to be frozen. The queue usage counter will
>>>> drop to zero after nvme_timeout() finishes, and this will not happen
>>>> because the thread will wait for this mutex forever.
>>>>
>>>> Convert set->tag_list_lock mutex to set->tag_list_rwsem rwsemaphore to
>>>> avoid the deadlock. Update blk_mq_[un]quiesce_tagset() to take the
>>>> semaphore for read since this is enough to guarantee no queues will be
>>>> added or removed. Update blk_mq_{add,del}_queue_tag_set() to take the
>>>> semaphore for write while updating set->tag_list and downgrade it to
>>>> read while freezing the queues. It should be safe to update set->flags
>>>> and hctx->flags while holding the semaphore for read since the queues
>>>> are already frozen.
>>>>
>>>> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
>>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>>> ---
>>>>    block/blk-mq-sysfs.c   | 10 ++---
>>>>    block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
>>>>    include/linux/blk-mq.h |  4 +-
>>>>    3 files changed, 58 insertions(+), 51 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>>>> index 58ec293373c6..f474781654fb 100644
>>>> --- a/block/blk-mq-sysfs.c
>>>> +++ b/block/blk-mq-sysfs.c
>>>> @@ -230,13 +230,13 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>>>    	kobject_uevent(q->mq_kobj, KOBJ_ADD);
>>>> -	mutex_lock(&q->tag_set->tag_list_lock);
>>>> +	down_read(&q->tag_set->tag_list_rwsem);
>>>>    	queue_for_each_hw_ctx(q, hctx, i) {
>>>>    		ret = blk_mq_register_hctx(hctx);
>>>>    		if (ret)
>>>>    			goto out_unreg;
>>>>    	}
>>>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>>>> +	up_read(&q->tag_set->tag_list_rwsem);
>>>>    	return 0;
>>>>    out_unreg:
>>>> @@ -244,7 +244,7 @@ int blk_mq_sysfs_register(struct gendisk *disk)
>>>>    		if (j < i)
>>>>    			blk_mq_unregister_hctx(hctx);
>>>>    	}
>>>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>>>> +	up_read(&q->tag_set->tag_list_rwsem);
>>>>    	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>>>    	kobject_del(q->mq_kobj);
>>>> @@ -257,10 +257,10 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>>>>    	struct blk_mq_hw_ctx *hctx;
>>>>    	unsigned long i;
>>>> -	mutex_lock(&q->tag_set->tag_list_lock);
>>>> +	down_read(&q->tag_set->tag_list_rwsem);
>>>>    	queue_for_each_hw_ctx(q, hctx, i)
>>>>    		blk_mq_unregister_hctx(hctx);
>>>> -	mutex_unlock(&q->tag_set->tag_list_lock);
>>>> +	up_read(&q->tag_set->tag_list_rwsem);
>>>>    	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
>>>>    	kobject_del(q->mq_kobj);
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index d626d32f6e57..9211d32ce820 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>>>>    {
>>>>    	struct request_queue *q;
>>>> -	mutex_lock(&set->tag_list_lock);
>>>> +	down_read(&set->tag_list_rwsem);
>>>>    	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>    		if (!blk_queue_skip_tagset_quiesce(q))
>>>>    			blk_mq_quiesce_queue_nowait(q);
>>>>    	}
>>>> -	mutex_unlock(&set->tag_list_lock);
>>>> +	up_read(&set->tag_list_rwsem);
>>>>    	blk_mq_wait_quiesce_done(set);
>>>>    }
>>>> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>>>>    {
>>>>    	struct request_queue *q;
>>>> -	mutex_lock(&set->tag_list_lock);
>>>> +	down_read(&set->tag_list_rwsem);
>>>>    	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>    		if (!blk_queue_skip_tagset_quiesce(q))
>>>>    			blk_mq_unquiesce_queue(q);
>>>>    	}
>>>> -	mutex_unlock(&set->tag_list_lock);
>>>> +	up_read(&set->tag_list_rwsem);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>>>> @@ -4274,56 +4274,63 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
>>>>    	}
>>>>    }
>>>> -static void blk_mq_update_tag_set_shared(struct blk_mq_tag_set *set,
>>>> -					 bool shared)
>>>> -{
>>>> -	struct request_queue *q;
>>>> -	unsigned int memflags;
>>>> -
>>>> -	lockdep_assert_held(&set->tag_list_lock);
>>>> -
>>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>> -		memflags = blk_mq_freeze_queue(q);
>>>> -		queue_set_hctx_shared(q, shared);
>>>> -		blk_mq_unfreeze_queue(q, memflags);
>>>> -	}
>>>> -}
>>>> -
>>>>    static void blk_mq_del_queue_tag_set(struct request_queue *q)
>>>>    {
>>>>    	struct blk_mq_tag_set *set = q->tag_set;
>>>> +	struct request_queue *firstq;
>>>> +	unsigned int memflags;
>>>> -	mutex_lock(&set->tag_list_lock);
>>>> +	down_write(&set->tag_list_rwsem);
>>>>    	list_del(&q->tag_set_list);
>>>> -	if (list_is_singular(&set->tag_list)) {
>>>> -		/* just transitioned to unshared */
>>>> -		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>>>> -		/* update existing queue */
>>>> -		blk_mq_update_tag_set_shared(set, false);
>>>> +	if (!list_is_singular(&set->tag_list)) {
>>>> +		up_write(&set->tag_list_rwsem);
>>>> +		goto out;
>>>>    	}
>>>> -	mutex_unlock(&set->tag_list_lock);
>>>> +
>>>> +	/*
>>>> +	 * Transitioning the remaining firstq to unshared.
>>>> +	 * Also, downgrade the semaphore to avoid deadlock
>>>> +	 * with blk_mq_quiesce_tagset() while waiting for
>>>> +	 * firstq to be frozen.
>>>> +	 */
>>>> +	set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
>>>> +	downgrade_write(&set->tag_list_rwsem);
>>> If the first lock waiter is for write, it could ruin your downgrade trick.
> If the 1st waiter is for WEITE, rwsem_mark_wake() simply returns and grants
> read lock to this caller, meantime wakes up nothing.
>
> That is exactly what this use case expects, so can you explain in detail why
> `it could ruin your downgrade trick`?
>
>> That is true. The downgrade will wake up all the waiting readers at the
>> front of the wait queue, but if there is one or more writers in the mix. The
>> wakeup will stop when the first writer is hit and all the readers after that
>> will not be woken up.
> So waiters for WRITE won't be waken up by downgrade_write() if I understand correctly,
> and rwsem_downgrade_wake() documents this behavior too.
>
>> We can theoretically provide a downgrade variant that wakes up all the
>> readers if it is a useful feature.
> The following up_read() in this code block will wake up the waiter for
> WRITE, which finally wakes up other waiters for READ, then I am confused
> what is the problem with this usage?

I am just referring to the fact that not all the readers may be woken 
up. So if the deadlock is caused by one of those readers that is not 
woken up, it can be a problem. I haven't analyzed the deadlock scenario 
in detail to see if that is really the case. It is up to you and others 
who are more familiar with this code base to figure this out.

Cheers,
Longman

