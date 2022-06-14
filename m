Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38AFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 23:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiFNXkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFNXkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 19:40:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8644ECC0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655250013; x=1686786013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PuylZKQ7uT6jPu6TT451nQIoW9XVuF7UsaTzxmAADZg=;
  b=IVDytOw1M793bdPwjH7iswr+/7JRg3PGWp2yOuOB31ytSUP0baFR5Sq4
   lmsWHVBKd9Q4l7CTsyKA/NXP06VDaPhz2HpnrdH+gUVbGcTbkvvB4GlXq
   qKzHssv2GUTY+geIfSNoWps/47sq8dZ+DeXZ+KiD/8KBOCJh63arvx+Cx
   pOnOslV6O1laPRXUaOKocjUOMNo9w45pl/QAz1dRzwwPXfERDJIquUAQp
   Dqm9Gquhdvu9RGrUoid9Anubn0yoOsgt3/W+MdWxlF5CUjyzAf6SpM0ZT
   C0YmRHVZWuIf1SpoiHtg3mWQShuRFrpwY7qGT5H5YChJBVW2egrAhX//w
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="307462102"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 07:40:12 +0800
IronPort-SDR: gfiih5BB4gBpMSaquaYLsKe7nmKWpgrARJu3qo9OmeAssM3JNkIY1cOAkW9W8FgSF2A5TBlWMa
 vdnes1asj7aTYAJgWsJDodWV1vjjxzzJ2jA9v05Aa7V4ybshfJYTYLLq5kpAVS4UTJMVW2jFPm
 lfzaHl9v/qAuloozqknwNxWyhsCCVH1k3YJV21b/Y9D6ty8I8AnxjSBgMzeTVougIQFg1v+DiJ
 Z3egEJkhehnOq0TWTmEo64EDXW5QpkZhlamTc4pwgqDKIiMUw0zsNyOfYGSb9CSuuOQy1Erqgf
 w6v1r3DqYll4g2QtPbxFOhzb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:03:10 -0700
IronPort-SDR: zoae6i8/EElwJ8wXaDREjArWx9l8KghJBD+OVKkbyWJYjV7a3a/ESuLIYwtTepOKXAsyreTl0c
 SBFqRLz4f2oY/rwGxcmr8MXpi9dRUoaAh1himzMfiAz4xGFJ4OH0Hg0lCEprMk7B2om6OTWbaC
 11FGBlwHZ5CFEjxGyy9g0laGbK/+HQXEdIkbkezOG8Zv5swOIopQ5k3JZS/+sXo7y+D1UXpXTD
 hxnBbwJH3p7P62c9E6IhC6s2Lo4mnbafzut/RAJC2fZ4oUxRIB71lkZsyyAaCP2W2T1GykpUuy
 Th4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:40:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN4g02hsRz1Rvlx
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:40:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655250011; x=1657842012; bh=PuylZKQ7uT6jPu6TT451nQIoW9XVuF7UsaT
        zxmAADZg=; b=bOZeyQzVfgFR66elM+gdaM2VtVY+yyhjEEoNnd3eNPEDiWbJ3lr
        lKRK53ob4D2sfC4AyznsZjKY5TxguNlkxPQsL70WURUAJHcWwy2Yjh3l+jrFgLKW
        9hv15D7RDQ8sEDtqsJI4m/Fsf7TVxesjh9+WJG8dViqe+X2Xn028Uwn/PLa1Pg2g
        7T87uHoFA96TJc1xDJx97iTf76nMoRy/sxuPcT7d6f4j8FIe1+PD7IS67N12+2T2
        Nq6W8nHBSvtIGL7ZD5FC1tiSMZhz9sc+rVV8r2+ifNpW7BTT7PjQe792p3NuE4wH
        4sw0Lf1QL07jrEZsKwxoMCssRYS7ZVEmBrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1fvOQ1uBCC1n for <linux-block@vger.kernel.org>;
        Tue, 14 Jun 2022 16:40:11 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN4fx5nyrz1Rvlc;
        Tue, 14 Jun 2022 16:40:09 -0700 (PDT)
Message-ID: <582c6c13-9bed-f4b8-ddfa-55071d32b4cc@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 08:40:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] block/mq-deadline: Remove zone locking
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-6-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220614174943.611369-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 02:49, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one has a
> significant negative performance impact on zoned UFS devices. Hence this
> patch that removes zone locking from the mq-deadline scheduler. This
> patch is based on the following assumptions:
> - Applications submit write requests to sequential write required zones
>   in order.
> - If such write requests get reordered by the software or hardware queue
>   mechanism, nr_hw_queues * nr_requests - 1 retries are sufficient to
>   reorder the write requests.

As mentioned in my previous reply for patch 2, AHCI will not behave like
that, at all. Retrying will be useless most of the time because the
adapter send commands to the drive randomly from the set of commands that
are marked ready in the ready register. So no. I am opposed to
unconditionally removing zone write locking.

If UFS LLD can deliver commands in order then use a queue flag to say
"zone write locking not needed" to disable it for that device class. There
probably are some SAS HBAs that could benefit from this too, but I have
seen so many reordering bugs with these (e.g. requeue at tail of a write
that got a TSF) that I would not want to remove zone write locking for these.

And I also do not want to start getting 10 calls a day from customers
complaining about very bad write performance due to all these retries
which are likely going to be slower in the end than writing at QD=1 per zone.

> - It happens infrequently that zoned write requests are reordered by the
>   block layer.

What make you say that ? It only takes 2 contexts trying to dispatch
commands to different queues. Or a write process being rescheduled to a
different CPU/queue.

> - Either no I/O scheduler is used or an I/O scheduler is used that
>   submits write requests per zone in LBA order.

And unfortunately, as the AHCI example shows, having the scheduler
dispatch requests in LBA order is not enough.

> 
> DD_BE_PRIO is selected for sequential writes to preserve the LBA order.

So if the application wanted the writes to have RT policy so that these
commands get the high priority bit set on SATA disks, that will not be
honored. No to that too.

> 
> See also commit 5700f69178e9 ("mq-deadline: Introduce zone locking
> support").
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 74 ++++-----------------------------------------
>  1 file changed, 6 insertions(+), 68 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6ed602b2f80a..e168fc9a980a 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -104,7 +104,6 @@ struct deadline_data {
>  	int prio_aging_expire;
>  
>  	spinlock_t lock;
> -	spinlock_t zone_lock;
>  };
>  
>  /* Maps an I/O priority class to a deadline scheduler priority. */
> @@ -285,30 +284,10 @@ static struct request *
>  deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		      enum dd_data_dir data_dir)
>  {
> -	struct request *rq;
> -	unsigned long flags;
> -
>  	if (list_empty(&per_prio->fifo_list[data_dir]))
>  		return NULL;
>  
> -	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> -		return rq;
> -
> -	/*
> -	 * Look for a write request that can be dispatched, that is one with
> -	 * an unlocked target zone.
> -	 */
> -	spin_lock_irqsave(&dd->zone_lock, flags);
> -	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
> -		if (blk_req_can_dispatch_to_zone(rq))
> -			goto out;
> -	}
> -	rq = NULL;
> -out:
> -	spin_unlock_irqrestore(&dd->zone_lock, flags);
> -
> -	return rq;
> +	return rq_entry_fifo(per_prio->fifo_list[data_dir].next);
>  }
>  
>  /*
> @@ -319,29 +298,7 @@ static struct request *
>  deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		      enum dd_data_dir data_dir)
>  {
> -	struct request *rq;
> -	unsigned long flags;
> -
> -	rq = per_prio->next_rq[data_dir];
> -	if (!rq)
> -		return NULL;
> -
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> -		return rq;
> -
> -	/*
> -	 * Look for a write request that can be dispatched, that is one with
> -	 * an unlocked target zone.
> -	 */
> -	spin_lock_irqsave(&dd->zone_lock, flags);
> -	while (rq) {
> -		if (blk_req_can_dispatch_to_zone(rq))
> -			break;
> -		rq = deadline_latter_request(rq);
> -	}
> -	spin_unlock_irqrestore(&dd->zone_lock, flags);
> -
> -	return rq;
> +	return per_prio->next_rq[data_dir];
>  }
>  
>  /*
> @@ -467,10 +424,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	ioprio_class = dd_rq_ioclass(rq);
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	dd->per_prio[prio].stats.dispatched++;
> -	/*
> -	 * If the request needs its target zone locked, do it.
> -	 */
> -	blk_req_zone_write_lock(rq);
>  	rq->rq_flags |= RQF_STARTED;
>  	return rq;
>  }
> @@ -640,7 +593,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  	dd->fifo_batch = fifo_batch;
>  	dd->prio_aging_expire = prio_aging_expire;
>  	spin_lock_init(&dd->lock);
> -	spin_lock_init(&dd->zone_lock);
>  
>  	q->elevator = eq;
>  	return 0;
> @@ -716,17 +668,13 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>  	struct dd_per_prio *per_prio;
>  	enum dd_prio prio;
> +	bool seq_write = blk_rq_is_seq_write(rq);
>  	LIST_HEAD(free);
>  
>  	lockdep_assert_held(&dd->lock);
>  
> -	/*
> -	 * This may be a requeue of a write request that has locked its
> -	 * target zone. If it is the case, this releases the zone lock.
> -	 */
> -	blk_req_zone_write_unlock(rq);
> -
> -	prio = ioprio_class_to_prio[ioprio_class];
> +	prio = seq_write ? DD_BE_PRIO :
> +		ioprio_class_to_prio[ioprio_class];
>  	per_prio = &dd->per_prio[prio];
>  	if (!rq->elv.priv[0]) {
>  		per_prio->stats.inserted++;
> @@ -740,7 +688,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	trace_block_rq_insert(rq);
>  
> -	if (at_head) {
> +	if (at_head && !seq_write) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
>  		rq->fifo_time = jiffies;
>  	} else {
> @@ -819,16 +767,6 @@ static void dd_finish_request(struct request *rq)
>  		return;
>  
>  	atomic_inc(&per_prio->stats.completed);
> -
> -	if (blk_queue_is_zoned(q)) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&dd->zone_lock, flags);
> -		blk_req_zone_write_unlock(rq);
> -		if (!list_empty(&per_prio->fifo_list[DD_WRITE]))
> -			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
> -		spin_unlock_irqrestore(&dd->zone_lock, flags);
> -	}
>  }
>  
>  static bool dd_has_work_for_prio(struct dd_per_prio *per_prio)


-- 
Damien Le Moal
Western Digital Research
