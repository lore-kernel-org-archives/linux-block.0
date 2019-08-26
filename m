Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510CBC3A59F
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F952080C
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfHZQYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:24:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45794 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfHZQYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Aug 2019 12:24:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so12086776pfq.12
        for <linux-block@vger.kernel.org>; Mon, 26 Aug 2019 09:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xVHNyYBK0KwLvolOFlKOV3Y1dVggj7fK6L2swHbmA9s=;
        b=bDcX2g2zpUX3N5QPAaWU6H4rpxKSAdbLpgDb3F0sOryAnzf0Ic8yj8/10oqDgWbaRF
         m11F8HDemT9a8iWoeBRSNhslykPHS2mrtCDKp80Tzi2X45ljGE9jDcvAaOzPDQNECQrj
         zbKUgU9zWdIJgzkbiL5IobWKFyXblqJBAZZD1EBpQliHvSd6VCQV9d0zzkDdMivSe3Jr
         IemY14V5HfVims1d6OKWLnvNnWKw3cGdbp/SNXurmQLvWyUg0Kb/KNdep6fkI6hnC133
         dsGCja6zkobqVleBp/8CgMr5P413xpaiZOqT9p2TO/jN4Ck8o4qybvPHuZDGBNDPhZiq
         rCFQ==
X-Gm-Message-State: APjAAAU+qUgZaHvk34LdUHTQzZyLcV4Tu62KTeiMj+u5B1og2WOIlylZ
        JmxFte/K53CIHRUbjA2FMmjKMXfV
X-Google-Smtp-Source: APXvYqylNyQxO7RSayP1zvicya+zIolIKAH9aIApZQFB5uFjy7nESptQoOu90ShXKbLjsUOy6HeDhA==
X-Received: by 2002:a63:2043:: with SMTP id r3mr17245573pgm.311.1566836645281;
        Mon, 26 Aug 2019 09:24:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a189sm13233227pfa.60.2019.08.26.09.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:24:04 -0700 (PDT)
Subject: Re: [PATCH V3 5/5] block: split .sysfs_lock into two locks
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190826025146.31158-1-ming.lei@redhat.com>
 <20190826025146.31158-6-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6499b212-fa8c-7d19-8149-43c8ad1e950d@acm.org>
Date:   Mon, 26 Aug 2019 09:24:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826025146.31158-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/19 7:51 PM, Ming Lei wrote:
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 5b0b5224cfd4..5941a0176f87 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -938,6 +938,7 @@ int blk_register_queue(struct gendisk *disk)
>   	int ret;
>   	struct device *dev = disk_to_dev(disk);
>   	struct request_queue *q = disk->queue;
> +	bool has_elevator = false;
>   
>   	if (WARN_ON(!q))
>   		return -ENXIO;
> @@ -945,7 +946,6 @@ int blk_register_queue(struct gendisk *disk)
>   	WARN_ONCE(blk_queue_registered(q),
>   		  "%s is registering an already registered queue\n",
>   		  kobject_name(&dev->kobj));
> -	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
>   
>   	/*
>   	 * SCSI probing may synchronously create and destroy a lot of
> @@ -966,7 +966,7 @@ int blk_register_queue(struct gendisk *disk)
>   		return ret;
>   
>   	/* Prevent changes through sysfs until registration is completed. */
> -	mutex_lock(&q->sysfs_lock);
> +	mutex_lock(&q->sysfs_dir_lock);

Does mutex_lock(&q->sysfs_dir_lock) really protect against changes of 
the I/O scheduler through sysfs or does it only protect against 
concurrent sysfs object creation and removal? In other words, should the 
comment above this mutex lock call be updated?

> @@ -987,26 +987,37 @@ int blk_register_queue(struct gendisk *disk)
>   		blk_mq_debugfs_register(q);
>   	}
>   
> -	kobject_uevent(&q->kobj, KOBJ_ADD);
> -
> -	wbt_enable_default(q);
> -
> -	blk_throtl_register_queue(q);
> -
> +	/*
> +	 * The queue's kobject ADD uevent isn't sent out, also the
> +	 * flag of QUEUE_FLAG_REGISTERED isn't set yet, so elevator
> +	 * switch won't happen at all.
> +	 */
>   	if (q->elevator) {
> -		ret = elv_register_queue(q);
> +		ret = elv_register_queue(q, false);
>   		if (ret) {
> -			mutex_unlock(&q->sysfs_lock);
> -			kobject_uevent(&q->kobj, KOBJ_REMOVE);
> +			mutex_unlock(&q->sysfs_dir_lock);
>   			kobject_del(&q->kobj);
>   			blk_trace_remove_sysfs(dev);
>   			kobject_put(&dev->kobj);
>   			return ret;
>   		}
> +		has_elevator = true;
>   	}

I think the reference to the kobject ADD event in the comment is 
misleading. If e.g. a request queue is registered, unregistered and 
reregistered quickly, can it happen that a udev rule for the ADD event 
triggered by the first registration is executed in the middle of the 
second registration? Is setting the REGISTERED flag later sufficient to 
fix the race against scheduler changes through sysfs? If so, how about 
leaving out the reference to the kobject ADD event from the above comment?

> +	mutex_lock(&q->sysfs_lock);
> +	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
> +	wbt_enable_default(q);
> +	blk_throtl_register_queue(q);
> +	mutex_unlock(&q->sysfs_lock);
> +
> +	/* Now everything is ready and send out KOBJ_ADD uevent */
> +	kobject_uevent(&q->kobj, KOBJ_ADD);
> +	if (has_elevator)
> +		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);

Can it happen that immediately after mutex_unlock(&q->sysfs_lock) a 
script removes the I/O scheduler and hence makes the value of the 
'has_elevator' variable stale? In other words, should emitting KOBJ_ADD 
also be protected by sysfs_lock?

> @@ -1021,6 +1032,7 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
>   void blk_unregister_queue(struct gendisk *disk)
>   {
>   	struct request_queue *q = disk->queue;
> +	bool has_elevator;
>   
>   	if (WARN_ON(!q))
>   		return;
> @@ -1035,25 +1047,25 @@ void blk_unregister_queue(struct gendisk *disk)
>   	 * concurrent elv_iosched_store() calls.
>   	 */
>   	mutex_lock(&q->sysfs_lock);
> -
>   	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
> +	has_elevator = !!q->elevator;
> +	mutex_unlock(&q->sysfs_lock);
>   
> +	mutex_lock(&q->sysfs_dir_lock);
>   	/*
>   	 * Remove the sysfs attributes before unregistering the queue data
>   	 * structures that can be modified through sysfs.
>   	 */
>   	if (queue_is_mq(q))
>   		blk_mq_unregister_dev(disk_to_dev(disk), q);
> -	mutex_unlock(&q->sysfs_lock);
>   
>   	kobject_uevent(&q->kobj, KOBJ_REMOVE);
>   	kobject_del(&q->kobj);
>   	blk_trace_remove_sysfs(disk_to_dev(disk));
>   
> -	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> +	if (has_elevator)
>   		elv_unregister_queue(q);
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->sysfs_dir_lock);

Is it safe to call elv_unregister_queue() if no I/O scheduler is 
associated with a request queue? If so, have you considered to leave out 
the 'has_elevator' variable from this function?

> @@ -567,10 +580,23 @@ int elevator_switch_mq(struct request_queue *q,
>   	lockdep_assert_held(&q->sysfs_lock);
>   
>   	if (q->elevator) {
> -		if (q->elevator->registered)
> +		if (q->elevator->registered) {
> +			mutex_unlock(&q->sysfs_lock);
> +
>   			elv_unregister_queue(q);
> +
> +			mutex_lock(&q->sysfs_lock);
> +		}
>   		ioc_clear_queue(q);
>   		elevator_exit(q, q->elevator);
> +
> +		/*
> +		 * sysfs_lock may be dropped, so re-check if queue is
> +		 * unregistered. If yes, don't switch to new elevator
> +		 * any more
> +		 */
> +		if (!blk_queue_registered(q))
> +			return 0;
>   	}

So elevator_switch_mq() is called with sysfs_lock held and releases and 
reacquires that mutex? What will happen if e.g. syzbot writes into 
/sys/block/*/queue/scheduler from multiple threads concurrently? Can 
that lead to multiple concurrent calls of elv_register_queue() and 
elv_unregister_queue()? Can that e.g. cause concurrent calls of the 
following code from elv_register_queue(): kobject_add(&e->kobj, 
&q->kobj, "%s", "iosched")?

Is it even possible to fix this lock inversion by introducing only one 
new mutex? I think the sysfs directories and attributes referenced by 
this patch are as follows:

/sys/block/<q>/queue
/sys/block/<q>/queue/attr
/sys/block/<q>/queue/iosched/attr
/sys/block/<q>/mq
/sys/block/<q>/mq/<n>
/sys/block/<q>/mq/<n>/attr

Isn't the traditional approach to protect such a hierarchy to use one 
mutex per level? E.g. one mutex to serialize "queue" and "mq" 
manipulations (sysfs_dir_lock?), one mutex to protect the queue/attr 
attributes (sysfs_lock?), one mutex to serialize kobj creation in the mq 
directory, one mutex to protect the mq/<n>/attr attributes and one mutex 
to protect the I/O scheduler attributes?

Thanks,

Bart.
