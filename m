Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C923C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2792613B6
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 07:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhE0HKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 03:10:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53876 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbhE0HKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 03:10:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5AA8F1FD2A;
        Thu, 27 May 2021 07:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622099348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8O3D7QaPaPIFzW7sB8i2yrLQFQH6lTBXBjHFsdz8IE=;
        b=nJEYG8Ze5W4qip82Mb23xQ7MfwxRJ4GzoMADKi1YdEARn1Q7F8DVSb3PsqoBTUNZw0L5xC
        XKRLpuN+wyHi+ouUVn8UEzbA5ZUgc9AtJ6B41Hb5EhXSXoP7cpCfza5hN+xSZYLnR4PFz/
        12MQF/AUF4XEiqK7Y2yBchRWwFUvWDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622099348;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8O3D7QaPaPIFzW7sB8i2yrLQFQH6lTBXBjHFsdz8IE=;
        b=Q8IxujwHX4ir/au3ouvQXIhiJmxSVXN0diZqIBV/t+iA0HH3MWa6VDZtpwO/wxTlOac6SG
        G22lCDsOAzEH0lCQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id F3F4B11A98;
        Thu, 27 May 2021 07:07:55 +0000 (UTC)
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-9-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH 8/9] block/mq-deadline: Add I/O priority support
Message-ID: <807decf3-b269-e663-f3db-394b74f1da00@suse.de>
Date:   Thu, 27 May 2021 09:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527010134.32448-9-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 3:01 AM, Bart Van Assche wrote:
> Maintain one FIFO list per I/O priority: RT, BE and IDLE. Only dispatch
> requests for a lower priority after all higher priority requests have
> finished. Maintain statistics for each priority level. Split the debugfs
> attributes per priority level as follows:
> 
> $ ls /sys/kernel/debug/block/.../sched/
> async_depth  dispatch2        read_next_rq      write2_fifo_list
> batching     read0_fifo_list  starved           write_next_rq
> dispatch0    read1_fifo_list  write0_fifo_list
> dispatch1    read2_fifo_list  write1_fifo_list
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 293 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 223 insertions(+), 70 deletions(-)
> 
Interesting question, though, wrt to request merging and realtime
priority: what takes priority?
Is the realtime priority more important than request merging?

And also the ioprio document states that there are 8 levels of class
data, determining how much time each class should spend on disk access.
Have these been taken into consideration?

> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 81f487d77e09..5a703e1228fa 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -44,16 +44,27 @@ enum dd_data_dir {
>  
>  enum { DD_DIR_COUNT = 2 };
>  
> +enum dd_prio {
> +	DD_RT_PRIO	= 0,
> +	DD_BE_PRIO	= 1,
> +	DD_IDLE_PRIO	= 2,
> +	DD_PRIO_MAX	= 2,
> +} __packed;
> +
> +enum { DD_PRIO_COUNT = 3 };
> +
>  struct deadline_data {
>  	/*
>  	 * run time data
>  	 */
>  
>  	/*
> -	 * requests (deadline_rq s) are present on both sort_list and fifo_list
> +	 * Requests are present on both sort_list[] and fifo_list[][]. The
> +	 * first index of fifo_list[][] is the I/O priority class (DD_*_PRIO).
> +	 * The second index is the data direction (rq_data_dir(rq)).
>  	 */
>  	struct rb_root sort_list[DD_DIR_COUNT];
> -	struct list_head fifo_list[DD_DIR_COUNT];
> +	struct list_head fifo_list[DD_PRIO_COUNT][DD_DIR_COUNT];
>  
>  	/*
>  	 * next in sort order. read, write or both are NULL
> @@ -62,6 +73,12 @@ struct deadline_data {
>  	unsigned int batching;		/* number of sequential requests made */
>  	unsigned int starved;		/* times reads have starved writes */
>  
> +	/* statistics */
> +	atomic_t inserted[DD_PRIO_COUNT];
> +	atomic_t dispatched[DD_PRIO_COUNT];
> +	atomic_t merged[DD_PRIO_COUNT];
> +	atomic_t completed[DD_PRIO_COUNT];
> +
>  	/*
>  	 * settings that change how the i/o scheduler behaves
>  	 */
> @@ -73,7 +90,15 @@ struct deadline_data {
>  
>  	spinlock_t lock;
>  	spinlock_t zone_lock;
> -	struct list_head dispatch;
> +	struct list_head dispatch[DD_PRIO_COUNT];
> +};
> +
> +/* Maps an I/O priority class to a deadline scheduler priority. */
> +static const enum dd_prio ioprio_class_to_prio[] = {
> +	[IOPRIO_CLASS_NONE]	= DD_BE_PRIO,
> +	[IOPRIO_CLASS_RT]	= DD_RT_PRIO,
> +	[IOPRIO_CLASS_BE]	= DD_BE_PRIO,
> +	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
>  };
>  
>  static inline struct rb_root *
> @@ -149,12 +174,28 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
>  	}
>  }
>  
> +/* Returns the I/O class that has been assigned by dd_insert_request(). */
> +static u8 dd_rq_ioclass(struct request *rq)
> +{
> +	return (uintptr_t)rq->elv.priv[1];
> +}
> +
>  /*
>   * Callback function that is invoked after @next has been merged into @req.
>   */
>  static void dd_merged_requests(struct request_queue *q, struct request *req,
>  			       struct request *next)
>  {
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +	const u8 ioprio_class = dd_rq_ioclass(next);
> +	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +
> +	if (next->elv.priv[0]) {
> +		atomic_inc(&dd->merged[prio]);
> +	} else {
> +		WARN_ON_ONCE(true);
> +	}
> +
>  	/*
>  	 * if next expires before rq, assign its expire time to rq
>  	 * and move into next position (next will be deleted) in fifo
> @@ -191,14 +232,22 @@ deadline_move_request(struct deadline_data *dd, struct request *rq)
>  	deadline_remove_request(rq->q, rq);
>  }
>  
> +/* Number of requests queued for a given priority level. */
> +static u64 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> +{
> +	return atomic_read(&dd->inserted[prio]) -
> +		atomic_read(&dd->completed[prio]);
> +}
> +
>  /*
>   * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
>   * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
>   */
>  static inline int deadline_check_fifo(struct deadline_data *dd,
> +				      enum dd_prio prio,
>  				      enum dd_data_dir data_dir)
>  {
> -	struct request *rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
> +	struct request *rq = rq_entry_fifo(dd->fifo_list[prio][data_dir].next);
>  
>  	/*
>  	 * rq is expired!

I am _so_ not a fan of arrays in C.
Can't you make this an accessor and use
dd->fifo_list[prio * 2 + data_dir] ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
