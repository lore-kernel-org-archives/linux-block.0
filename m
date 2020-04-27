Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C8C4CECD
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0720B1F
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588014219;
	bh=xqDU3aTzpyVy0HZwtgJghSBIPOFiLHnK3GAPMOq9oD0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cAmfvTyAFyNbJ1Lls0263XGaY0ir3pr5hVHxw9UF285InU1Zgir93k87xtzqPrIu4
	 0l19qG3Tm9KIdsvGJx5To20WJTvQFP0rpdqR22/HEm/HonScdyqgqgGx0vWH1I2tWB
	 SEAC4ZfkkU+P/K5kr+vmQfVJUf0maSH9hhEhvWqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD0TDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgD0TDi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 15:03:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5983D20775;
        Mon, 27 Apr 2020 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588014217;
        bh=xqDU3aTzpyVy0HZwtgJghSBIPOFiLHnK3GAPMOq9oD0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qM7QeZWUKCB2Uk0YzvlT1nmg86w5hB5k2HbjDOg0W4uNj84w2+i2gGA1wNFZWLbSy
         zZPx/MPAAwJRiYMkZoRvro9twPBRjRQ9SvDNfRyWTtkVwSdce8WJqGs5WEHhmhiQkV
         NjDsaamZ/WZJJ4Rkb38DPW0ex6bDXr8DqH9VtInk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3DF1335227CC; Mon, 27 Apr 2020 12:03:37 -0700 (PDT)
Date:   Mon, 27 Apr 2020 12:03:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200427190337.GK7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
 <20200424103851.GD28156@lst.de>
 <20200425031723.GC477579@T590>
 <20200425083224.GA5634@lst.de>
 <20200425093437.GA495669@T590>
 <20200425095351.GC495669@T590>
 <20200425154832.GA16004@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425154832.GA16004@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 25, 2020 at 05:48:32PM +0200, Christoph Hellwig wrote:
> FYI, here is what I think we should be doing (but the memory model
> experts please correct me):

I would be happy to, but could you please tell me what to apply this
against?  I made several wrong guesses, and am not familiar enough with
this code to evaluate this patch in isolation.

							Thanx, Paul

>  - just drop the direct_issue flag and check for the CPU, which is
>    cheap enough
>  - replace the raw_smp_processor_id with a get_cpu to make sure we
>    don't hit the tiny migration windows
>  - a bunch of random cleanups to make the code easier to read, mostly
>    by being more self-documenting or improving the comments.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index bfa4020256ae9..da749865f6eed 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1049,28 +1049,16 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
>  		atomic_inc(&data.hctx->nr_active);
>  	}
>  	data.hctx->tags->rqs[rq->tag] = rq;
> -	return true;
> -}
> -
> -static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
> -{
> -	if (rq->tag != -1)
> -		return true;
>  
> -	if (!__blk_mq_get_driver_tag(rq))
> -		return false;
>  	/*
> -	 * Add one memory barrier in case that direct issue IO process is
> -	 * migrated to other CPU which may not belong to this hctx, so we can
> -	 * order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> -	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> -	 * and driver tag assignment are run on the same CPU in case that
> -	 * BLK_MQ_S_INACTIVE is set.
> +	 * Ensure updates to rq->tag and tags->rqs[] are seen by
> +	 * blk_mq_tags_inflight_rqs.  This pairs with the smp_mb__after_atomic
> +	 * in blk_mq_hctx_notify_offline.  This only matters in case a process
> +	 * gets migrated to another CPU that is not mapped to this hctx.
>  	 */
> -	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> +	if (rq->mq_ctx->cpu != get_cpu())
>  		smp_mb();
> -	else
> -		barrier();
> +	put_cpu();
>  
>  	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
>  		blk_mq_put_driver_tag(rq);
> @@ -1079,6 +1067,13 @@ static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
>  	return true;
>  }
>  
> +static bool blk_mq_get_driver_tag(struct request *rq)
> +{
> +	if (rq->tag != -1)
> +		return true;
> +	return __blk_mq_get_driver_tag(rq);
> +}
> +
>  static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
>  				int flags, void *key)
>  {
> @@ -1125,7 +1120,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
>  		 * Don't clear RESTART here, someone else could have set it.
>  		 * At most this will cost an extra queue run.
>  		 */
> -		return blk_mq_get_driver_tag(rq, false);
> +		return blk_mq_get_driver_tag(rq);
>  	}
>  
>  	wait = &hctx->dispatch_wait;
> @@ -1151,7 +1146,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
>  	 * allocation failure and adding the hardware queue to the wait
>  	 * queue.
>  	 */
> -	ret = blk_mq_get_driver_tag(rq, false);
> +	ret = blk_mq_get_driver_tag(rq);
>  	if (!ret) {
>  		spin_unlock(&hctx->dispatch_wait_lock);
>  		spin_unlock_irq(&wq->lock);
> @@ -1252,7 +1247,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  			break;
>  		}
>  
> -		if (!blk_mq_get_driver_tag(rq, false)) {
> +		if (!blk_mq_get_driver_tag(rq)) {
>  			/*
>  			 * The initial allocation attempt failed, so we need to
>  			 * rerun the hardware queue when a tag is freed. The
> @@ -1284,7 +1279,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  			bd.last = true;
>  		else {
>  			nxt = list_first_entry(list, struct request, queuelist);
> -			bd.last = !blk_mq_get_driver_tag(nxt, false);
> +			bd.last = !blk_mq_get_driver_tag(nxt);
>  		}
>  
>  		ret = q->mq_ops->queue_rq(hctx, &bd);
> @@ -1886,7 +1881,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	if (!blk_mq_get_dispatch_budget(hctx))
>  		goto insert;
>  
> -	if (!blk_mq_get_driver_tag(rq, true)) {
> +	if (!blk_mq_get_driver_tag(rq)) {
>  		blk_mq_put_dispatch_budget(hctx);
>  		goto insert;
>  	}
> @@ -2327,23 +2322,24 @@ static bool blk_mq_inflight_rq(struct request *rq, void *data,
>  static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct count_inflight_data count_data = {
> -		.count	= 0,
>  		.hctx	= hctx,
>  	};
>  
>  	blk_mq_all_tag_busy_iter(hctx->tags, blk_mq_count_inflight_rq,
>  			blk_mq_inflight_rq, &count_data);
> -
>  	return count_data.count;
>  }
>  
> -static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> +static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> +		struct blk_mq_hw_ctx *hctx)
>  {
> -	while (1) {
> -		if (!blk_mq_tags_inflight_rqs(hctx))
> -			break;
> -		msleep(5);
> -	}
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return false;
> +	if (cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu)
> +		return false;
> +	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
> +		return false;
> +	return true;
>  }
>  
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> @@ -2351,25 +2347,19 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>  			struct blk_mq_hw_ctx, cpuhp_online);
>  
> -	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> -		return 0;
> -
> -	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu) ||
> -	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids))
> +	if (!blk_mq_last_cpu_in_hctx(cpu, hctx))
>  		return 0;
>  
>  	/*
> -	 * The current CPU is the last one in this hctx, S_INACTIVE
> -	 * can be observed in dispatch path without any barrier needed,
> -	 * cause both are run on one same CPU.
> +	 * Order setting BLK_MQ_S_INACTIVE versus checking rq->tag and rqs[tag],
> +	 * in blk_mq_tags_inflight_rqs.  It pairs with the smp_mb() in
> +	 * blk_mq_get_driver_tag.
>  	 */
>  	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> -	/*
> -	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
> -	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
> -	 */
>  	smp_mb__after_atomic();
> -	blk_mq_hctx_drain_inflight_rqs(hctx);
> +
> +	while (blk_mq_tags_inflight_rqs(hctx))
> +		msleep(5);
>  	return 0;
>  }
>  
