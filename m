Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C6BC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EB9613EC
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFJGhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:37:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37936 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFJGhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:37:06 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5F11219A3;
        Thu, 10 Jun 2021 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANW2sLajzX1b4OPLfOibL4E81a5izslgUNtpaAvMiHE=;
        b=AQUUnl1XREDWrUC2/K2Yfm/n5SO0h8Wv6bQqio3E24BvIQloH25+lI+ZxnsYOfnhijfJ91
        gVAuz42oK/a+dYooHm2KilLN8cHmEedMHiGcIQ4G8wmJui87onGDlpV8e0eZK+lQ1e6SPM
        E3FEo2UNgH/RanSajz6UgTfIN1Kw+/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANW2sLajzX1b4OPLfOibL4E81a5izslgUNtpaAvMiHE=;
        b=5g1ie5dKMTt8UDibKaaVVv7EguQIEQYAA2NFmzYwDoJQ0f9j0/qhJaiNY6PLOqKDKRXVZb
        Tqu69lSW82G2OpCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 787B7118DD;
        Thu, 10 Jun 2021 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANW2sLajzX1b4OPLfOibL4E81a5izslgUNtpaAvMiHE=;
        b=AQUUnl1XREDWrUC2/K2Yfm/n5SO0h8Wv6bQqio3E24BvIQloH25+lI+ZxnsYOfnhijfJ91
        gVAuz42oK/a+dYooHm2KilLN8cHmEedMHiGcIQ4G8wmJui87onGDlpV8e0eZK+lQ1e6SPM
        E3FEo2UNgH/RanSajz6UgTfIN1Kw+/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANW2sLajzX1b4OPLfOibL4E81a5izslgUNtpaAvMiHE=;
        b=5g1ie5dKMTt8UDibKaaVVv7EguQIEQYAA2NFmzYwDoJQ0f9j0/qhJaiNY6PLOqKDKRXVZb
        Tqu69lSW82G2OpCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id dSGyHJ2ywWAGXwAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:35:09 +0000
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-13-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH 12/14] block/mq-deadline: Add I/O priority support
Message-ID: <62453468-1912-6be1-9223-88fdc9631dd9@suse.de>
Date:   Thu, 10 Jun 2021 08:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-13-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:07 AM, Bart Van Assche wrote:
> Maintain one dispatch list and FIFO one list per I/O priority class: RT, BE
> and IDLE. Maintain statistics for each priority level. Split the debugfs
> attributes per priority level as follows:
> 
> $ ls /sys/kernel/debug/block/.../sched/
> async_depth  dispatch2        read_next_rq      write2_fifo_list
> batching     read0_fifo_list  starved           write_next_rq
> dispatch0    read1_fifo_list  write0_fifo_list
> dispatch1    read2_fifo_list  write1_fifo_list
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 355 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 279 insertions(+), 76 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index a7d0584437d1..776ff49713c3 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -42,16 +42,40 @@ enum dd_data_dir {
>  
>  enum { DD_DIR_COUNT = 2 };
>  
> +enum dd_prio {
> +	DD_RT_PRIO	= 0,
> +	DD_BE_PRIO	= 1,
> +	DD_IDLE_PRIO	= 2,
> +	DD_PRIO_MAX	= 2,
> +};
> +
> +enum { DD_PRIO_COUNT = 3 };
> +
> +/* I/O statistics per I/O priority. */
> +struct io_stats_per_prio {
> +	local_t inserted;
> +	local_t merged;
> +	local_t dispatched;
> +	local_t completed;
> +};
> +
> +/* I/O statistics for all I/O priorities (enum dd_prio). */
> +struct io_stats {
> +	struct io_stats_per_prio stats[DD_PRIO_COUNT];
> +};
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

Damien already commented on this; I am really not a fan of arrays of
arrays. Make this a simple array and calculate the offset accordingly.

>  	/*
>  	 * next in sort order. read, write or both are NULL
> @@ -60,6 +84,8 @@ struct deadline_data {
>  	unsigned int batching;		/* number of sequential requests made */
>  	unsigned int starved;		/* times reads have starved writes */
>  
> +	struct io_stats __percpu *stats;
> +
>  	/*
>  	 * settings that change how the i/o scheduler behaves
>  	 */
> @@ -71,7 +97,42 @@ struct deadline_data {
>  
>  	spinlock_t lock;
>  	spinlock_t zone_lock;
> -	struct list_head dispatch;
> +	struct list_head dispatch[DD_PRIO_COUNT];
> +};
> +
> +/* Count one event of type 'event_type' and with I/O priority 'prio' */
> +#define dd_count(dd, event_type, prio) do {				\
> +	struct io_stats *io_stats = get_cpu_ptr((dd)->stats);		\
> +									\
> +	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
> +	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
> +	local_inc(&io_stats->stats[(prio)].event_type);			\
> +	put_cpu_ptr(io_stats);						\
> +} while (0)
> +
> +/*
> + * Returns the total number of dd_count(dd, event_type, prio) calls across all
> + * CPUs. No locking or barriers since it is fine if the returned sum is slightly
> + * outdated.
> + */
> +#define dd_sum(dd, event_type, prio) ({					\
> +	unsigned int cpu;						\
> +	u32 sum = 0;							\
> +									\
> +	BUILD_BUG_ON(!__same_type((dd), struct deadline_data *));	\
> +	BUILD_BUG_ON(!__same_type((prio), enum dd_prio));		\
> +	for_each_present_cpu(cpu)					\
> +		sum += local_read(&per_cpu_ptr((dd)->stats, cpu)->	\
> +				  stats[(prio)].event_type);		\
> +	sum;								\
> +})
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
> @@ -147,12 +208,31 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
>  	}
>  }
>  
> +/*
> + * Returns the I/O priority class (IOPRIO_CLASS_*) that has been assigned to a
> + * request.
> + */
> +static u8 dd_rq_ioclass(struct request *rq)
> +{
> +	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
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
> +		dd_count(dd, merged, prio);
> +	} else {
> +		WARN_ON_ONCE(true);
> +	}
> +
>  	/*
>  	 * if next expires before rq, assign its expire time to rq
>  	 * and move into next position (next will be deleted) in fifo
> @@ -189,14 +269,21 @@ deadline_move_request(struct deadline_data *dd, struct request *rq)
>  	deadline_remove_request(rq->q, rq);
>  }
>  
> +/* Number of requests queued for a given priority level. */
> +static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> +{
> +	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
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

Same here for the arrays of arrays sentiment. Can't you introduce an
accessor function?

>  
>  	/*
>  	 * rq is expired!
> @@ -212,15 +299,16 @@ static inline int deadline_check_fifo(struct deadline_data *dd,
>   * dispatch using arrival ordered lists.
>   */
>  static struct request *
> -deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
> +deadline_fifo_request(struct deadline_data *dd, enum dd_prio prio,
> +		      enum dd_data_dir data_dir)
>  {
>  	struct request *rq;
>  	unsigned long flags;
>  
> -	if (list_empty(&dd->fifo_list[data_dir]))
> +	if (list_empty(&dd->fifo_list[prio][data_dir]))
>  		return NULL;
>  
> -	rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
> +	rq = rq_entry_fifo(dd->fifo_list[prio][data_dir].next);
>  	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
>  		return rq;
>  
> @@ -229,7 +317,7 @@ deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
>  	 * an unlocked target zone.
>  	 */
>  	spin_lock_irqsave(&dd->zone_lock, flags);
> -	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {
> +	list_for_each_entry(rq, &dd->fifo_list[prio][DD_WRITE], queuelist) {
>  		if (blk_req_can_dispatch_to_zone(rq))
>  			goto out;
>  	}
> @@ -245,7 +333,8 @@ deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
>   * dispatch using sector position sorted lists.
>   */
>  static struct request *
> -deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_dir)
> +deadline_next_request(struct deadline_data *dd, enum dd_prio prio,
> +		      enum dd_data_dir data_dir)
>  {
>  	struct request *rq;
>  	unsigned long flags;
> @@ -276,15 +365,18 @@ deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_dir)
>   * deadline_dispatch_requests selects the best request according to
>   * read/write expire, fifo_batch, etc
>   */
> -static struct request *__dd_dispatch_request(struct deadline_data *dd)
> +static struct request *__dd_dispatch_request(struct deadline_data *dd,
> +					     enum dd_prio prio)
>  {
>  	struct request *rq, *next_rq;
>  	enum dd_data_dir data_dir;
> +	u8 ioprio_class;
>  
>  	lockdep_assert_held(&dd->lock);
>  
> -	if (!list_empty(&dd->dispatch)) {
> -		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
> +	if (!list_empty(&dd->dispatch[prio])) {
> +		rq = list_first_entry(&dd->dispatch[prio], struct request,
> +				      queuelist);
>  		list_del_init(&rq->queuelist);
>  		goto done;
>  	}
> @@ -292,9 +384,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  	/*
>  	 * batches are currently reads XOR writes
>  	 */
> -	rq = deadline_next_request(dd, DD_WRITE);
> +	rq = deadline_next_request(dd, prio, DD_WRITE);
>  	if (!rq)
> -		rq = deadline_next_request(dd, DD_READ);
> +		rq = deadline_next_request(dd, prio, DD_READ);
>  
>  	if (rq && dd->batching < dd->fifo_batch)
>  		/* we have a next request are still entitled to batch */
> @@ -305,10 +397,10 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  	 * data direction (read / write)
>  	 */
>  
> -	if (!list_empty(&dd->fifo_list[DD_READ])) {
> +	if (!list_empty(&dd->fifo_list[prio][DD_READ])) {
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));
>  
> -		if (deadline_fifo_request(dd, DD_WRITE) &&
> +		if (deadline_fifo_request(dd, prio, DD_WRITE) &&
>  		    (dd->starved++ >= dd->writes_starved))
>  			goto dispatch_writes;
>  
> @@ -321,7 +413,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  	 * there are either no reads or writes have been starved
>  	 */
>  
> -	if (!list_empty(&dd->fifo_list[DD_WRITE])) {
> +	if (!list_empty(&dd->fifo_list[prio][DD_WRITE])) {
>  dispatch_writes:
>  		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));
>  
> @@ -338,14 +430,14 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  	/*
>  	 * we are not running a batch, find best request for selected data_dir
>  	 */
> -	next_rq = deadline_next_request(dd, data_dir);
> -	if (deadline_check_fifo(dd, data_dir) || !next_rq) {
> +	next_rq = deadline_next_request(dd, prio, data_dir);
> +	if (deadline_check_fifo(dd, prio, data_dir) || !next_rq) {
>  		/*
>  		 * A deadline has expired, the last request was in the other
>  		 * direction, or we have run out of higher-sectored requests.
>  		 * Start again from the request with the earliest expiry time.
>  		 */
> -		rq = deadline_fifo_request(dd, data_dir);
> +		rq = deadline_fifo_request(dd, prio, data_dir);
>  	} else {
>  		/*
>  		 * The last req was the same dir and we have a next request in
> @@ -370,6 +462,13 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>  	dd->batching++;
>  	deadline_move_request(dd, rq);
>  done:
> +	ioprio_class = dd_rq_ioclass(rq);
> +	prio = ioprio_class_to_prio[ioprio_class];
> +	if (rq->elv.priv[0]) {
> +		dd_count(dd, dispatched, prio);
> +	} else {
> +		WARN_ON_ONCE(true);
> +	}
>  	/*
>  	 * If the request needs its target zone locked, do it.
>  	 */
> @@ -390,9 +489,14 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>  	struct request *rq;
> +	enum dd_prio prio;
>  
>  	spin_lock(&dd->lock);
> -	rq = __dd_dispatch_request(dd);
> +	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
> +		rq = __dd_dispatch_request(dd, prio);
> +		if (rq)
> +			break;
> +	}
>  	spin_unlock(&dd->lock);
>  
>  	return rq;
> @@ -439,9 +543,14 @@ static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>  static void dd_exit_sched(struct elevator_queue *e)
>  {
>  	struct deadline_data *dd = e->elevator_data;
> +	enum dd_prio prio;
> +
> +	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
> +		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_READ]));
> +		WARN_ON_ONCE(!list_empty(&dd->fifo_list[prio][DD_WRITE]));
> +	}
>  
> -	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));
> -	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));
> +	free_percpu(dd->stats);
>  
>  	kfree(dd);
>  }
> @@ -453,20 +562,29 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  {
>  	struct deadline_data *dd;
>  	struct elevator_queue *eq;
> +	enum dd_prio prio;
> +	int ret = -ENOMEM;
>  
>  	eq = elevator_alloc(q, e);
>  	if (!eq)
> -		return -ENOMEM;
> +		return ret;
>  
>  	dd = kzalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
> -	if (!dd) {
> -		kobject_put(&eq->kobj);
> -		return -ENOMEM;
> -	}
> +	if (!dd)
> +		goto put_eq;
> +
>  	eq->elevator_data = dd;
>  
> -	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);
> -	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
> +	dd->stats = alloc_percpu_gfp(typeof(*dd->stats),
> +				     GFP_KERNEL | __GFP_ZERO);
> +	if (!dd->stats)
> +		goto free_dd;
> +
> +	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
> +		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_READ]);
> +		INIT_LIST_HEAD(&dd->fifo_list[prio][DD_WRITE]);
> +		INIT_LIST_HEAD(&dd->dispatch[prio]);
> +	}
>  	dd->sort_list[DD_READ] = RB_ROOT;
>  	dd->sort_list[DD_WRITE] = RB_ROOT;
>  	dd->fifo_expire[DD_READ] = read_expire;
> @@ -476,10 +594,16 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  	dd->fifo_batch = fifo_batch;
>  	spin_lock_init(&dd->lock);
>  	spin_lock_init(&dd->zone_lock);
> -	INIT_LIST_HEAD(&dd->dispatch);
>  
>  	q->elevator = eq;
>  	return 0;
> +
> +free_dd:
> +	kfree(dd);
> +
> +put_eq:
> +	kobject_put(&eq->kobj);
> +	return ret;
>  }
>  
>  /*
> @@ -539,6 +663,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	struct request_queue *q = hctx->queue;
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	const enum dd_data_dir data_dir = rq_data_dir(rq);
> +	u16 ioprio = req_get_ioprio(rq);
> +	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
> +	enum dd_prio prio;
>  
>  	lockdep_assert_held(&dd->lock);
>  
> @@ -548,13 +675,18 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	 */
>  	blk_req_zone_write_unlock(rq);
>  
> +	prio = ioprio_class_to_prio[ioprio_class];
> +	dd_count(dd, inserted, prio);
> +	WARN_ON_ONCE(rq->elv.priv[0]);
> +	rq->elv.priv[0] = (void *)1ULL;
> +
>  	if (blk_mq_sched_try_insert_merge(q, rq))
>  		return;
>  
>  	trace_block_rq_insert(rq);
>  
>  	if (at_head) {
> -		list_add(&rq->queuelist, &dd->dispatch);
> +		list_add(&rq->queuelist, &dd->dispatch[prio]);
>  	} else {
>  		deadline_add_rq_rb(dd, rq);
>  
> @@ -568,7 +700,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  		 * set expire time and add to fifo list
>  		 */
>  		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> -		list_add_tail(&rq->queuelist, &dd->fifo_list[data_dir]);
> +		list_add_tail(&rq->queuelist, &dd->fifo_list[prio][data_dir]);
>  	}
>  }
>  
> @@ -592,12 +724,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  	spin_unlock(&dd->lock);
>  }
>  
> -/*
> - * Nothing to do here. This is defined only to ensure that .finish_request
> - * method is called upon request completion.
> - */
> +/* Callback from inside blk_mq_rq_ctx_init(). */
>  static void dd_prepare_request(struct request *rq)
>  {
> +	rq->elv.priv[0] = NULL;
>  }
>  
>  /*
> @@ -619,26 +749,41 @@ static void dd_prepare_request(struct request *rq)
>  static void dd_finish_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +	const u8 ioprio_class = dd_rq_ioclass(rq);
> +	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
> +
> +	if (rq->elv.priv[0])
> +		dd_count(dd, completed, prio);
>  
>  	if (blk_queue_is_zoned(q)) {
> -		struct deadline_data *dd = q->elevator->elevator_data;
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);
>  		blk_req_zone_write_unlock(rq);
> -		if (!list_empty(&dd->fifo_list[DD_WRITE]))
> +		if (!list_empty(&dd->fifo_list[prio][DD_WRITE]))
>  			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
>  		spin_unlock_irqrestore(&dd->zone_lock, flags);
>  	}
>  }
>  
> +static bool dd_has_work_for_prio(struct deadline_data *dd, enum dd_prio prio)
> +{
> +	return !list_empty_careful(&dd->dispatch[prio]) ||
> +		!list_empty_careful(&dd->fifo_list[prio][DD_READ]) ||
> +		!list_empty_careful(&dd->fifo_list[prio][DD_WRITE]);
> +}
> +
>  static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
> +	enum dd_prio prio;
> +
> +	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
> +		if (dd_has_work_for_prio(dd, prio))
> +			return true;
>  
> -	return !list_empty_careful(&dd->dispatch) ||
> -		!list_empty_careful(&dd->fifo_list[0]) ||
> -		!list_empty_careful(&dd->fifo_list[1]);
> +	return false;
>  }
>  
>  /*
> @@ -702,7 +847,7 @@ static struct elv_fs_entry deadline_attrs[] = {
>  };
>  
>  #ifdef CONFIG_BLK_DEBUG_FS
> -#define DEADLINE_DEBUGFS_DDIR_ATTRS(ddir, name)				\
> +#define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
>  static void *deadline_##name##_fifo_start(struct seq_file *m,		\
>  					  loff_t *pos)			\
>  	__acquires(&dd->lock)						\
> @@ -711,7 +856,7 @@ static void *deadline_##name##_fifo_start(struct seq_file *m,		\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
>  									\
>  	spin_lock(&dd->lock);						\
> -	return seq_list_start(&dd->fifo_list[ddir], *pos);		\
> +	return seq_list_start(&dd->fifo_list[prio][data_dir], *pos);	\
>  }									\
>  									\
>  static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
> @@ -720,7 +865,7 @@ static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
>  	struct request_queue *q = m->private;				\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
>  									\
> -	return seq_list_next(v, &dd->fifo_list[ddir], pos);		\
> +	return seq_list_next(v, &dd->fifo_list[prio][data_dir], pos);	\
>  }									\
>  									\
>  static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
> @@ -737,22 +882,31 @@ static const struct seq_operations deadline_##name##_fifo_seq_ops = {	\
>  	.next	= deadline_##name##_fifo_next,				\
>  	.stop	= deadline_##name##_fifo_stop,				\
>  	.show	= blk_mq_debugfs_rq_show,				\
> -};									\
> -									\
> +};
> +
> +#define DEADLINE_DEBUGFS_NEXT_RQ(data_dir, name)			\
>  static int deadline_##name##_next_rq_show(void *data,			\
>  					  struct seq_file *m)		\
>  {									\
>  	struct request_queue *q = data;					\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
> -	struct request *rq = dd->next_rq[ddir];				\
> +	struct request *rq = dd->next_rq[data_dir];			\
>  									\
>  	if (rq)								\
>  		__blk_mq_debugfs_rq_show(m, rq);			\
>  	return 0;							\
>  }
> -DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)
> -DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)
> +
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_RT_PRIO, DD_READ, read0)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_RT_PRIO, DD_WRITE, write0)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_BE_PRIO, DD_READ, read1)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_BE_PRIO, DD_WRITE, write1)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_READ, read2)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_IDLE_PRIO, DD_WRITE, write2)
> +DEADLINE_DEBUGFS_NEXT_RQ(DD_READ, read)
> +DEADLINE_DEBUGFS_NEXT_RQ(DD_WRITE, write)
>  #undef DEADLINE_DEBUGFS_DDIR_ATTRS
> +#undef DEADLINE_DEBUGFS_NEXT_RQ
>  
>  static int deadline_batching_show(void *data, struct seq_file *m)
>  {
> @@ -781,50 +935,99 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
>  	return 0;
>  }
>  
> -static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
> -	__acquires(&dd->lock)
> +static int dd_queued_show(void *data, struct seq_file *m)
>  {
> -	struct request_queue *q = m->private;
> +	struct request_queue *q = data;
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  
> -	spin_lock(&dd->lock);
> -	return seq_list_start(&dd->dispatch, *pos);
> +	seq_printf(m, "%u %u %u\n", dd_queued(dd, DD_RT_PRIO),
> +		   dd_queued(dd, DD_BE_PRIO),
> +		   dd_queued(dd, DD_IDLE_PRIO));
> +	return 0;
>  }
>  
> -static void *deadline_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
> +/* Number of requests owned by the block driver for a given priority. */
> +static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
>  {
> -	struct request_queue *q = m->private;
> -	struct deadline_data *dd = q->elevator->elevator_data;
> -
> -	return seq_list_next(v, &dd->dispatch, pos);
> +	return dd_sum(dd, dispatched, prio) + dd_sum(dd, merged, prio)
> +		- dd_sum(dd, completed, prio);
>  }
>  
> -static void deadline_dispatch_stop(struct seq_file *m, void *v)
> -	__releases(&dd->lock)
> +static int dd_owned_by_driver_show(void *data, struct seq_file *m)
>  {
> -	struct request_queue *q = m->private;
> +	struct request_queue *q = data;
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  
> -	spin_unlock(&dd->lock);
> +	seq_printf(m, "%u %u %u\n", dd_owned_by_driver(dd, DD_RT_PRIO),
> +		   dd_owned_by_driver(dd, DD_BE_PRIO),
> +		   dd_owned_by_driver(dd, DD_IDLE_PRIO));
> +	return 0;
>  }
>  
> -static const struct seq_operations deadline_dispatch_seq_ops = {
> -	.start	= deadline_dispatch_start,
> -	.next	= deadline_dispatch_next,
> -	.stop	= deadline_dispatch_stop,
> -	.show	= blk_mq_debugfs_rq_show,
> -};
> +#define DEADLINE_DISPATCH_ATTR(prio)					\
> +static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
> +					     loff_t *pos)		\
> +	__acquires(&dd->lock)						\
> +{									\
> +	struct request_queue *q = m->private;				\
> +	struct deadline_data *dd = q->elevator->elevator_data;		\
> +									\
> +	spin_lock(&dd->lock);						\
> +	return seq_list_start(&dd->dispatch[prio], *pos);		\
> +}									\
> +									\
> +static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
> +					    void *v, loff_t *pos)	\
> +{									\
> +	struct request_queue *q = m->private;				\
> +	struct deadline_data *dd = q->elevator->elevator_data;		\
> +									\
> +	return seq_list_next(v, &dd->dispatch[prio], pos);		\
> +}									\
> +									\
> +static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
> +	__releases(&dd->lock)						\
> +{									\
> +	struct request_queue *q = m->private;				\
> +	struct deadline_data *dd = q->elevator->elevator_data;		\
> +									\
> +	spin_unlock(&dd->lock);						\
> +}									\
> +									\
> +static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \
> +	.start	= deadline_dispatch##prio##_start,			\
> +	.next	= deadline_dispatch##prio##_next,			\
> +	.stop	= deadline_dispatch##prio##_stop,			\
> +	.show	= blk_mq_debugfs_rq_show,				\
> +}
> +
> +DEADLINE_DISPATCH_ATTR(0);
> +DEADLINE_DISPATCH_ATTR(1);
> +DEADLINE_DISPATCH_ATTR(2);
> +#undef DEADLINE_DISPATCH_ATTR
>  
> -#define DEADLINE_QUEUE_DDIR_ATTRS(name)						\
> -	{#name "_fifo_list", 0400, .seq_ops = &deadline_##name##_fifo_seq_ops},	\
> +#define DEADLINE_QUEUE_DDIR_ATTRS(name)					\
> +	{#name "_fifo_list", 0400,					\
> +			.seq_ops = &deadline_##name##_fifo_seq_ops}
> +#define DEADLINE_NEXT_RQ_ATTR(name)					\
>  	{#name "_next_rq", 0400, deadline_##name##_next_rq_show}
>  static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
> -	DEADLINE_QUEUE_DDIR_ATTRS(read),
> -	DEADLINE_QUEUE_DDIR_ATTRS(write),
> +	DEADLINE_QUEUE_DDIR_ATTRS(read0),
> +	DEADLINE_QUEUE_DDIR_ATTRS(write0),
> +	DEADLINE_QUEUE_DDIR_ATTRS(read1),
> +	DEADLINE_QUEUE_DDIR_ATTRS(write1),
> +	DEADLINE_QUEUE_DDIR_ATTRS(read2),
> +	DEADLINE_QUEUE_DDIR_ATTRS(write2),
> +	DEADLINE_NEXT_RQ_ATTR(read),
> +	DEADLINE_NEXT_RQ_ATTR(write),
>  	{"batching", 0400, deadline_batching_show},
>  	{"starved", 0400, deadline_starved_show},
>  	{"async_depth", 0400, dd_async_depth_show},
> -	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
> +	{"dispatch0", 0400, .seq_ops = &deadline_dispatch0_seq_ops},
> +	{"dispatch1", 0400, .seq_ops = &deadline_dispatch1_seq_ops},
> +	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
> +	{"owned_by_driver", 0400, dd_owned_by_driver_show},
> +	{"queued", 0400, dd_queued_show},
>  	{},
>  };
>  #undef DEADLINE_QUEUE_DDIR_ATTRS
> @@ -874,6 +1077,6 @@ static void __exit deadline_exit(void)
>  module_init(deadline_init);
>  module_exit(deadline_exit);
>  
> -MODULE_AUTHOR("Jens Axboe");
> +MODULE_AUTHOR("Jens Axboe, Damien Le Moal and Bart Van Assche");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("MQ deadline IO scheduler");
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
