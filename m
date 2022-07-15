Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E7C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 09:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGOJlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiGOJlU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 05:41:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33247FE54
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 02:41:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A10D31FCEA;
        Fri, 15 Jul 2022 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657878078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M2ep95EsyNsOUq8lAoKXnzJ/mAfGet4AvyL+3exRQ4o=;
        b=bknMClarTfeEs7fYDHqfKWSFZ1mVTzwgi25Hg1YnpGl3INwDRUNPL2EgBMOQ8BR5NJ4GbO
        XdB5TOOw8F2o7bwvS1hmJAtnmkpUK4zahXNSAPrkcVD5JlRHYLnP4YMKsFa5O5jqyQ7UDy
        5K70lvncyIS2k6VzGC7PXcB0xGkm/d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657878078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M2ep95EsyNsOUq8lAoKXnzJ/mAfGet4AvyL+3exRQ4o=;
        b=0EGWheiU/lcDKXpJLdPZWdQhSbYycLTABwzfl8s/wJlfZowqNZ88LDXLmTrH3yPm48wXS9
        9z8QNwi2Tg44IfDA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 873C52C141;
        Fri, 15 Jul 2022 09:41:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B42EA0657; Fri, 15 Jul 2022 11:41:18 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:41:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 07/63] block/bfq: Use the new blk_opf_t type
Message-ID: <20220715094118.dp5sxbzho6ud6rqd@quack3>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714180729.1065367-8-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 14-07-22 11:06:33, Bart Van Assche wrote:
> Use the new blk_opf_t type for arguments and variables that represent
> request flags or a bitwise combination of a request operation and
> request flags. Rename those variables from 'op' into 'opf'.
> 
> This patch does not change any functionality.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  | 26 +++++++++++++-------------
>  block/bfq-iosched.c | 16 ++++++++--------
>  block/bfq-iosched.h |  8 ++++----
>  3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 9fc605791b1e..30b15a9a47c4 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -220,46 +220,46 @@ void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
>  }
>  
>  void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      unsigned int op)
> +			      blk_opf_t opf)
>  {
> -	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
> +	blkg_rwstat_add(&bfqg->stats.queued, opf, 1);
>  	bfqg_stats_end_empty_time(&bfqg->stats);
>  	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
>  		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
>  }
>  
> -void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
> +void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf)
>  {
> -	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
> +	blkg_rwstat_add(&bfqg->stats.queued, opf, -1);
>  }
>  
> -void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
> +void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf)
>  {
> -	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
> +	blkg_rwstat_add(&bfqg->stats.merged, opf, 1);
>  }
>  
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
> -				  u64 io_start_time_ns, unsigned int op)
> +				  u64 io_start_time_ns, blk_opf_t opf)
>  {
>  	struct bfqg_stats *stats = &bfqg->stats;
>  	u64 now = ktime_get_ns();
>  
>  	if (now > io_start_time_ns)
> -		blkg_rwstat_add(&stats->service_time, op,
> +		blkg_rwstat_add(&stats->service_time, opf,
>  				now - io_start_time_ns);
>  	if (io_start_time_ns > start_time_ns)
> -		blkg_rwstat_add(&stats->wait_time, op,
> +		blkg_rwstat_add(&stats->wait_time, opf,
>  				io_start_time_ns - start_time_ns);
>  }
>  
>  #else /* CONFIG_BFQ_CGROUP_DEBUG */
>  
>  void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      unsigned int op) { }
> -void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
> -void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
> +			      blk_opf_t opf) { }
> +void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf) { }
> +void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf) { }
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
> -				  u64 io_start_time_ns, unsigned int op) { }
> +				  u64 io_start_time_ns, blk_opf_t opf) { }
>  void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
>  void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
>  void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index e6d7e6b01a05..c740b41fe0a4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -668,19 +668,19 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
>   * significantly affect service guarantees coming from the BFQ scheduling
>   * algorithm.
>   */
> -static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> +static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd = data->q->elevator->elevator_data;
>  	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
> -	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(op)) : NULL;
> +	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(opf)) : NULL;
>  	int depth;
>  	unsigned limit = data->q->nr_requests;
>  
>  	/* Sync reads have full depth available */
> -	if (op_is_sync(op) && !op_is_write(op)) {
> +	if (op_is_sync(opf) && !op_is_write(opf)) {
>  		depth = 0;
>  	} else {
> -		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
> +		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
>  		limit = (limit * depth) >> bfqd->full_depth_shift;
>  	}
>  
> @@ -693,7 +693,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
>  		depth = 1;
>  
>  	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
> -		__func__, bfqd->wr_busy_queues, op_is_sync(op), depth);
> +		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
>  	if (depth)
>  		data->shallow_depth = depth;
>  }
> @@ -6104,7 +6104,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
>  static void bfq_update_insert_stats(struct request_queue *q,
>  				    struct bfq_queue *bfqq,
>  				    bool idle_timer_disabled,
> -				    unsigned int cmd_flags)
> +				    blk_opf_t cmd_flags)
>  {
>  	if (!bfqq)
>  		return;
> @@ -6129,7 +6129,7 @@ static void bfq_update_insert_stats(struct request_queue *q,
>  static inline void bfq_update_insert_stats(struct request_queue *q,
>  					   struct bfq_queue *bfqq,
>  					   bool idle_timer_disabled,
> -					   unsigned int cmd_flags) {}
> +					   blk_opf_t cmd_flags) {}
>  #endif /* CONFIG_BFQ_CGROUP_DEBUG */
>  
>  static struct bfq_queue *bfq_init_rq(struct request *rq);
> @@ -6141,7 +6141,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	struct bfq_data *bfqd = q->elevator->elevator_data;
>  	struct bfq_queue *bfqq;
>  	bool idle_timer_disabled = false;
> -	unsigned int cmd_flags;
> +	blk_opf_t cmd_flags;
>  	LIST_HEAD(free);
>  
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index ca8177d7bf7c..ad8e513d7e87 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -994,11 +994,11 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
>  
>  void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
>  void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      unsigned int op);
> -void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
> -void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op);
> +			      blk_opf_t opf);
> +void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf);
> +void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf);
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
> -				  u64 io_start_time_ns, unsigned int op);
> +				  u64 io_start_time_ns, blk_opf_t opf);
>  void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
>  void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
>  void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
