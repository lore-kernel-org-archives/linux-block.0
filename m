Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056BC352AA
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 03:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195122086A
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 03:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P0LswgQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfJBDeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:34:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfJBDeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 23:34:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id i14so11093032pgt.11
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 20:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KZYjF9DXIr0BjIx3ppCWG7wt6UZIOHaOIniyS/jHVS4=;
        b=P0LswgQXgl7CQR6u7OgAsAVe+ToO5cQ/tBx0ILWQeQ3x4KJHHnpgQuebRVeN5xvIJb
         GMsOWcZ8NGMU0FBV+VT/W72Y+06xgF4Q3+ypBJeIPIP/V1aBxNnDNeYjMkFdOBqj5FJA
         VEvzqkYGU5yn77dk0+AtwqcGXdPiLIvrDf/iGesIYrRWJfx0QhD66J795yx0/gIfX0yg
         h4UMVzKrimX8DEfv9dk2P5ykyKknL4peKAWnyWvUrOXnP56HC0XekXwzPKmO6FX3dZD2
         mv/gG465T+qOWknPi34hBI+qgxayvwsM3cgvuTRcJVVC9fWnyOy1a+xLTALw1cdXKL0o
         gPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KZYjF9DXIr0BjIx3ppCWG7wt6UZIOHaOIniyS/jHVS4=;
        b=XRd2c0oO2cQnmb4+EqX/wc7G6U+D6lRwIHZP+m8RiYmLdmZy3sdvB7Oe2Ffey5KZZF
         syjXGssWSLZ2tbn5DKOUeTSBPpbbEOvRfCfKmy5jUzX2tRPctIdNnfa/GYAIP5bCtdMe
         +iDudLc3u2f3Vrxt4F23bL80E6QQRAX+ZPmriFC6ZsiyvtmMhHzn7Y4tLXSWfvA5/Fsa
         CpSCwgAc1FMUMhSUZ5LXcAqliTpvzBvy16rHYTX8biGfxKRQ3g67xOrPMIeN51uUHo1Y
         FCcOEDe2Tmd/LvfSOkGo6F+pKj7oJ/bBBRuEYMkaUHSxZQT+jD/arfimM+e8s3zkerQ1
         Aeig==
X-Gm-Message-State: APjAAAVgHM8xCV2Tr/xa+n63SJgY+y3t4na5xAWUEkB7zoJv8LuZ0kLh
        3w/mc7q23ovI4VLuA6kC2MoMLw==
X-Google-Smtp-Source: APXvYqw6Z8TsJIQyrOoWDrnARrf3im4C/jnmDpwmcmNdwQNUYYxGaM13BXPDcyndKaO7UoSfcSyNXA==
X-Received: by 2002:a17:90a:ad8f:: with SMTP id s15mr1801907pjq.50.1569987240480;
        Tue, 01 Oct 2019 20:34:00 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b4sm3701384pju.16.2019.10.01.20.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 20:33:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20190930194846.23141-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1ca9de7-383b-4a84-31d0-92cfbb3759b2@kernel.dk>
Date:   Tue, 1 Oct 2019 21:33:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930194846.23141-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 1:48 PM, André Almeida wrote:
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 0bf056de5cc3..d0aab34972b7 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -11,12 +11,85 @@ struct blk_flush_queue;
>   
>   /**
>    * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware block device
> + *
> + * @lock:	Lock for accessing dispatch queue
> + * @dispatch:	Queue of dispatched requests, waiting for workers to send them
> + *		to the hardware.
> + * @state:	BLK_MQ_S_* flags. Define the state of the hw queue (active,
> + *		scheduled to restart, stopped).
> + *
> + * @run_work:		Worker for dispatch scheduled requests to hardware.
> + *			BLK_MQ_CPU_WORK_BATCH workers will be assigned to a CPU,
> + *			then the following ones will be assigned to
> + *			the next_cpu.
> + * @cpumask:		Map of available CPUs.
> + * @next_cpu:		Index of CPU/workqueue to be used in the next batch
> + *			of workers.
> + * @next_cpu_batch:	Counter of how many works letf in the batch before
> + *			changing to the next CPU. A batch has the size of
> + *			BLK_MQ_CPU_WORK_BATCH.
> + *
> + * @flags:	BLK_MQ_F_* flags. Define the behaviour of the queue.
> + *
> + * @sched_data: Data to support schedulers.
> + * @queue:	Queue of request to be dispatched.
> + * @fq:		Queue of requests to be flushed from memory to storage.
> + *
> + * @driver_data: Device driver specific queue.
> + *
> + * @ctx_map:	Bitmap for each software queue. If bit is on, there is a
> + *		pending request.
> + *
> + * @dispatch_from: Queue to be used when there is no scheduler was selected.
> + * @dispatch_busy: Number used by blk_mq_update_dispatch_busy() to decide
> + *		   if the hw_queue is busy using Exponential Weighted Moving
> + *		   Average algorithm.
> + *
> + * @type:	HCTX_TYPE_* flags. Type of hardware queue.
> + * @nr_ctx:	Number of software queues.
> + * @ctxs:	Array of software queues.
> + *
> + * @dispatch_wait_lock: Lock for dispatch_wait queue.
> + * @dispatch_wait:	Waitqueue for dispatched requests. Request here will
> + *			be processed when
> + *			percpu_ref_is_zero(&q->q_usage_counter) evaluates true
> + *			for q as a request_queue.
> + * @wait_index:		Index of next wait queue to be used.
> + *
> + * @tags:	Request tags.
> + * @sched_tags:	Request tags for schedulers.
> + *
> + * @queued:	Number of queued requests.
> + * @run:	Number of dispatched requests.
> + * @dispatched:	Number of dispatch requests by queue.
> + *
> + * @numa_node:	NUMA node index of this hardware queue.
> + * @queue_num:	Index of this hardware queue.
> + *
> + * @nr_active:	Number of active tags.
> + *
> + * @cpuhp_dead:	List to store request if some CPU die.
> + * @kobj:	Kernel object for sysfs.
> + *
> + * @poll_considered:	Count times blk_poll() was called.
> + * @poll_invoked:	Count how many requests blk_poll() polled.
> + * @poll_success:	Count how many polled requests were completed.
> + *
> + * @debugfs_dir:	debugfs directory for this hardware queue. Named
> + *			as cpu<cpu_number>.
> + * @sched_debugfs_dir:	debugfs directory for the scheduler.
> + *
> + * @hctx_list:		List of all hardware queues.
> + *
> + * @srcu:	Sleepable RCU. Use as lock when type of the hardware queue is
> + *		blocking (BLK_MQ_F_BLOCKING). Must be the last member - see
> + *		also blk_mq_hw_ctx_size().
>    */
>   struct blk_mq_hw_ctx {
>   	struct {
>   		spinlock_t		lock;
>   		struct list_head	dispatch;
> -		unsigned long		state;		/* BLK_MQ_S_* flags */
> +		unsigned long		state;
>   	} ____cacheline_aligned_in_smp;
>   
>   	struct delayed_work	run_work;
> @@ -24,7 +97,7 @@ struct blk_mq_hw_ctx {
>   	int			next_cpu;
>   	int			next_cpu_batch;
>   
> -	unsigned long		flags;		/* BLK_MQ_F_* flags */
> +	unsigned long		flags;
>   
>   	void			*sched_data;
>   	struct request_queue	*queue;
> @@ -72,41 +145,73 @@ struct blk_mq_hw_ctx {
>   
>   	struct list_head	hctx_list;
>   
> -	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
>   	struct srcu_struct	srcu[0];
>   };

I like improving how much is documented, but I absolutely don't like how
everything is pulled into one section above the struct instead of being
documented inline instead.

I realize this probably makes it easier to make nice external
documentation, but imho that's absolutely secondary to having the
documentation being right there where you read the code.

> @@ -142,81 +253,100 @@ typedef bool (busy_fn)(struct request_queue *);
>   typedef void (complete_fn)(struct request *);
>   typedef void (cleanup_rq_fn)(struct request *);
>   
> -
> +/**
> + * struct blk_mq_ops - list of callback functions for blk-mq drivers
> + */
>   struct blk_mq_ops {
> -	/*
> -	 * Queue request
> +	/**
> +	 * @queue_rq: Queue a new request from block IO.
>   	 */
>   	queue_rq_fn		*queue_rq;
>   
> -	/*
> -	 * If a driver uses bd->last to judge when to submit requests to
> -	 * hardware, it must define this function. In case of errors that
> -	 * make us stop issuing further requests, this hook serves the
> +	/**
> +	 * @commit_rqs: If a driver uses bd->last to judge when to submit
> +	 * requests to hardware, it must define this function. In case of errors
> +	 * that make us stop issuing further requests, this hook serves the
>   	 * purpose of kicking the hardware (which the last request otherwise
>   	 * would have done).
>   	 */
>   	commit_rqs_fn		*commit_rqs;

Stuff like this is MUCH better. Why isn't all of it done like this?

-- 
Jens Axboe

