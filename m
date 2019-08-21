Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC863C41514
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE72339E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 16:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfHUQSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:18:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfHUQSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 12:18:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id o70so1743525pfg.5
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 09:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ddSP2EwFRAxPUjcU/9JBnUFv6AciFVB3R/22qF122Wk=;
        b=WfeuSvfupiqE6STTlH2LwhTbvSB2art2LKk4l+EYNfDSEZFepbag8Oav5frhkNTMFC
         ySVITpQYWmILxcv9k93ch/j7ZPbkoxmo+frn51cJMTFbEdQ01PNscwWzgg2b+myv/a6P
         dRMdamwA3iFYgKctjj/M33b0xA10PBfTRE9pk/11aiBczCytgzcij2AaPoeFepcw2kv8
         vF/3YtSlpex0Mqpczi5PNbQG4oztFCLqNTG3PZNqqu3J7fTlDh6MA/394PZnm3pOnL30
         O+4U1Xpac+uGqmio0epvDX7QiKsIanmxqVCoc5newS+if/nulfWp07KqYpIXRyXu6rCu
         PSaA==
X-Gm-Message-State: APjAAAVVjxVhDEfCCjNvfNYBPN4oTJ7tM0X7sRfWwcqhum68mAblxVso
        ZrwllMZU801OIlVsQUu9ENE=
X-Google-Smtp-Source: APXvYqzkIoRJQwaIG/SsTV+dWtCfcj1gzouz3lEFD8v3KakX/2ulm7tK7cY4c/pOs561BdEL70rx1w==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr35303671pfh.56.1566404290307;
        Wed, 21 Aug 2019 09:18:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k36sm21247058pgl.42.2019.08.21.09.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 09:18:09 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] block: split .sysfs_lock into two locks
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-7-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6d97a960-52b5-5134-5382-dff73be00722@acm.org>
Date:   Wed, 21 Aug 2019 09:18:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091506.21196-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 2:15 AM, Ming Lei wrote:
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 31bbf10d8149..a4cc40ddda86 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -247,7 +247,7 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
>   	struct blk_mq_hw_ctx *hctx;
>   	int i;
>   
> -	lockdep_assert_held(&q->sysfs_lock);
> +	lockdep_assert_held(&q->sysfs_dir_lock);
>   
>   	queue_for_each_hw_ctx(q, hctx, i)
>   		blk_mq_unregister_hctx(hctx);
> @@ -297,7 +297,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
>   	int ret, i;
>   
>   	WARN_ON_ONCE(!q->kobj.parent);
> -	lockdep_assert_held(&q->sysfs_lock);
> +	lockdep_assert_held(&q->sysfs_dir_lock);
>   
>   	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
>   	if (ret < 0)

blk_mq_unregister_dev and __blk_mq_register_dev() are only used by 
blk_register_queue() and blk_unregister_queue(). It is the 
responsibility of the callers of these function to serialize request 
queue registration and unregistration. Is it really necessary to hold a 
mutex around the blk_mq_unregister_dev and __blk_mq_register_dev() 
calls? Or in other words, can it ever happen that multiple threads 
invoke one or both functions concurrently?

> @@ -331,7 +331,7 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
>   	struct blk_mq_hw_ctx *hctx;
>   	int i;
>   
> -	mutex_lock(&q->sysfs_lock);
> +	mutex_lock(&q->sysfs_dir_lock);
>   	if (!q->mq_sysfs_init_done)
>   		goto unlock;
>   
> @@ -339,7 +339,7 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
>   		blk_mq_unregister_hctx(hctx);
>   
>   unlock:
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->sysfs_dir_lock);
>   }
>   
>   int blk_mq_sysfs_register(struct request_queue *q)
> @@ -347,7 +347,7 @@ int blk_mq_sysfs_register(struct request_queue *q)
>   	struct blk_mq_hw_ctx *hctx;
>   	int i, ret = 0;
>   
> -	mutex_lock(&q->sysfs_lock);
> +	mutex_lock(&q->sysfs_dir_lock);
>   	if (!q->mq_sysfs_init_done)
>   		goto unlock;
>   
> @@ -358,7 +358,7 @@ int blk_mq_sysfs_register(struct request_queue *q)
>   	}
>   
>   unlock:
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->sysfs_dir_lock);
>   
>   	return ret;
>   }

blk_mq_sysfs_unregister() and blk_mq_sysfs_register() are only used by 
__blk_mq_update_nr_hw_queues(). Calls to that function are serialized by 
the tag_list_lock mutex. Is it really necessary to use any locking 
inside these functions?

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
>   
>   	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
>   	if (ret < 0) {
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
> +
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
> +
>   	ret = 0;
>   unlock:
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->sysfs_dir_lock);
>   	return ret;
>   }

My understanding is that the mutex_lock() / mutex_unlock() calls in this 
function are necessary today to prevent concurrent changes of the 
scheduler from this function and from sysfs. If the 
kobject_uevent(KOBJ_ADD) call is moved, does that mean that all 
mutex_lock() / mutex_unlock() calls can be left out from this function?

>   EXPORT_SYMBOL_GPL(blk_register_queue);
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
>   
>   	kobject_put(&disk_to_dev(disk)->kobj);
>   }

If this function would call kobject_del(&q->kobj) before doing anything 
else, does that mean that all mutex_lock() / mutex_unlock() calls can be 
left out from this function?

Thanks,

Bart.
