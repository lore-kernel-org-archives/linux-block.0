Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DFAC4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 18:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD921721
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 18:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJHSMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:12:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46152 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfJHSMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 14:12:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so8785666plr.13;
        Tue, 08 Oct 2019 11:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WO0UfvP5hWvRycJbNL9RqVvE2KNQTq70cfKr8pWoYb8=;
        b=PulnEYM/0wKLSJRnpQdzTxUZE4lJcvMH9i1VUiUH19rIZ5DaUKgE9Gvwwv4RFwfDI7
         RNMHuwDyv+d/d/Udqvs/vr69kVkKv1UW0lTr+O4fr29xZUqiiaFN+Hgf7JGMlhL4MJv3
         TZ+52Q79M+TmM3KAm2UsaGfhor8ByumxnZeaD9vXy46hzUa4SZ5a0EpPFh3Ria1u+qUw
         qJqI+v/Y9hSN/sPEknjaGpJVXczpXcWfXcZ6OUX/dDVTxZlFVTxK78PZKm/540yvI+Dy
         tybzHjJ2dS7C0eNoL15P7mfgMmgiZKgj/3eQ595r1dMe6IwvtHIuNPO2TO/9wILQ5PwR
         0eOw==
X-Gm-Message-State: APjAAAUSgPSlaH5wdpVvvQCeo9ngXJTpIoT1Cnw5Z3AqlYJrbd+NXYeW
        jo1ObbYrSCx1oKr0arbi6VOPs1oT
X-Google-Smtp-Source: APXvYqwcLYU5f1HW++6DMTnWMGff/JOcEykO6zgn4/n1ObwqTdFwpOm6ukg4RXAcguurGXZEYGJYxQ==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr35875643pls.331.1570558368113;
        Tue, 08 Oct 2019 11:12:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h4sm17593940pgg.81.2019.10.08.11.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 11:12:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com
References: <20191008001416.12656-1-andrealmeid@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <16a10539-c0a0-e411-8f9a-1f0830579986@acm.org>
Date:   Tue, 8 Oct 2019 11:12:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008001416.12656-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 5:14 PM, André Almeida wrote:
>   struct blk_mq_hw_ctx {
>   	struct {
> +		/** @lock: Lock for accessing dispatch queue */
>   		spinlock_t		lock;

This spinlock not only protects dispatch list accesses but also 
modifications of the dispatch list. How about changing that comment into 
"protects the dispatch list"?

> +		/**
> +		 * @dispatch: Queue of dispatched requests, waiting for
> +		 * workers to send them to the hardware.
> +		 */
>   		struct list_head	dispatch;

What is a worker? That word is not used anywhere in the block layer. How 
about changing that comment into "requests owned by this hardware queue"?

> -		unsigned long		state;		/* BLK_MQ_S_* flags */
> +		 /**
> +		  * @state: BLK_MQ_S_* flags. Define the state of the hw
                                               ^^^^^^
                                               Defines?
>   
> +	/**
> +	 * @run_work: Worker for dispatch scheduled requests to hardware.
> +	 * BLK_MQ_CPU_WORK_BATCH workers will be assigned to a CPU, then the
> +	 * following ones will be assigned to the next_cpu.
> +	 */
 >   	struct delayed_work	run_work;

I'd prefer if algorithm details would be left out from structure 
documentation since such documentation becomes easily outdated. How 
about using something like the following description: "used for 
scheduling a hardware queue run at a later time"?

> +	/**
> +	 * @next_cpu: Index of CPU/workqueue to be used in the next batch
> +	 * of workers.
> +	 */

The word "workers" here is confusing. How about the following 
description: "used by blk_mq_hctx_next_cpu() for round-robin CPU 
selection from @cpumask"?

> +	/**
> +	 * @next_cpu_batch: Counter of how many works letf in the batch before
                                                       ^^^^
                                                       left?
> +	 * changing to the next CPU. A batch has the size
> +	 * of BLK_MQ_CPU_WORK_BATCH.
> +	 */
>   	int			next_cpu_batch;

Again, I think this is too much detail about the actual algorithm.

>   
> -	unsigned long		flags;		/* BLK_MQ_F_* flags */
> +	/** @flags: BLK_MQ_F_* flags. Define the behaviour of the queue. */
                                       ^^^^^^
                                       Defines?
> +	unsigned long		flags;
>   
> +	/** @sched_data: Data to support schedulers. */
>   	void			*sched_data;

That's a rather vague description. How about mentioning that this 
pointer is owned by the I/O scheduler that has been attached to a 
request queue and that the I/O scheduler decides how to use this pointer?

> +	/** @queue: Queue of request to be dispatched. */
>   	struct request_queue	*queue;

How about "pointer to the request queue that owns this hardware context"?

> +	/**
> +	 * @ctx_map: Bitmap for each software queue. If bit is on, there is a
> +	 * pending request.
> +	 */
>   	struct sbitmap		ctx_map;

Please add " in that software queue" at the end of the description.

>   
> +	/**
> +	 * @dispatch_from: Queue to be used when there is no scheduler
> +	 * was selected.
> +	 */
>   	struct blk_mq_ctx	*dispatch_from;

Does the word "queue" refer to a request queue, software queue or 
hardware queue? Please make that clear.

> +	/**
> +	 * @dispatch_wait: Waitqueue for dispatched requests. Request here will
> +	 * be processed when percpu_ref_is_zero(&q->q_usage_counter) evaluates
> +	 * true for q as a request_queue.
> +	 */
>   	wait_queue_entry_t	dispatch_wait;

That description doesn't look correct to me. I think that @dispatch_wait 
is used to wait if no tags are available. The comment above 
blk_mq_mark_tag_wait() is as follows:

/*
  * Mark us waiting for a tag. For shared tags, this involves hooking us
  * into the tag wakeups. For non-shared tags, we can simply mark us
  * needing a restart. For both cases, take care to check the condition
  * again after marking us as waiting.
  */

> +	/** @wait_index: Index of next wait queue to be used. */
>   	atomic_t		wait_index;

To be used by what?

> +	/** @tags: Request tags. */
>   	struct blk_mq_tags	*tags;
> +	/** @sched_tags: Request tags for schedulers. */
>   	struct blk_mq_tags	*sched_tags;

I think @tags represents tags owned by the block driver and @sched_tags 
represents tags owned by the I/O scheduler. If no I/O scheduler is 
associated with a request queue, only a driver tag is allocated. If an 
I/O scheduler has been associated with a request queue, a request is 
assigned a tag from @sched_tags when that request is allocated. A tag 
from @tags is only assigned when a request is dispatched to a hardware 
queue. See also blk_mq_get_driver_tag().

> +	/** @nr_active:	Number of active tags. */
>   	atomic_t		nr_active;

Isn't this the number of active requests instead of the number of active 
tags? Please mention that this member is only used when a tag set is 
shared across request queues.

> +/**
> + * struct blk_mq_queue_data - Data about a request inserted in a queue
> + *
> + * @rq:   Data about the block IO request.

How about changing this into "Request pointer"?

> +/**
> + * struct blk_mq_ops - list of callback functions that implements block driver
> + * behaviour.
> + */

Is this really a list?

>    * Driver command data is immediately after the request. So subtract request
> - * size to get back to the original request, add request size to get the PDU.
> + * size to get back to the original request.
>    */
>   static inline struct request *blk_mq_rq_from_pdu(void *pdu)
>   {
>   	return pdu - sizeof(struct request);
>   }

I'm not sure this change is an improvement.

Bart.
