Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB1C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 08:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiF3Idk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiF3Idj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 04:33:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADAA1A382
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 01:33:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DDE9F21CA5;
        Thu, 30 Jun 2022 08:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656578016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDT1CUHWfgPQNA+zyxq3ITlTYfYGUqZD8UVFfpFXlbg=;
        b=fWoY0DDDB+Ww4AAimeCvfIV7Mb3IbBoWDjVyM9tgJWxGuAeJ9IvZfclwzIEbBV0cCtUGqZ
        +MDeXwOcmijwadpZDAEJ1V5jW2xJ0pHwFx8cE76Uk20nBEdvnsBc9Uzgtl6LhMLnbSE9Ea
        FjUkwb118Zl8I0v/UDA/g+GnQ6iM6YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656578016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDT1CUHWfgPQNA+zyxq3ITlTYfYGUqZD8UVFfpFXlbg=;
        b=fex9OB5OtU/+39RSYM4U2gerUkqZlMLSGkMplga9a7YnwpGf7Av1ah+Bp67b5OZP8cf9E4
        6kmQcIP+nOKDOQAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C726C2C141;
        Thu, 30 Jun 2022 08:33:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8278DA061F; Thu, 30 Jun 2022 10:33:36 +0200 (CEST)
Date:   Thu, 30 Jun 2022 10:33:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 07/63] block/bfq: Use the new blk_opf_t type
Message-ID: <20220630083336.ik4hkacm5ktdrqar@quack3.lan>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629233145.2779494-8-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 29-06-22 16:30:49, Bart Van Assche wrote:
> Use the new blk_opf_t type for arguments and variables that represent
> request flags or a bitwise combination of a request operation and
> request flags.
> 
> This patch does not change any functionality.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  | 16 ++++++++--------
>  block/bfq-iosched.c |  8 ++++----
>  block/bfq-iosched.h |  8 ++++----
>  3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 9fc605791b1e..af79028627a5 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -220,7 +220,7 @@ void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
>  }
>  
>  void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      unsigned int op)
> +			      blk_opf_t op)
>  {
>  	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
>  	bfqg_stats_end_empty_time(&bfqg->stats);
> @@ -228,18 +228,18 @@ void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
>  		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
>  }
>  
> -void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
> +void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op)
>  {
>  	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
>  }
>  
> -void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
> +void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op)
>  {
>  	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
>  }
>  
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
> -				  u64 io_start_time_ns, unsigned int op)
> +				  u64 io_start_time_ns, blk_opf_t op)
>  {
>  	struct bfqg_stats *stats = &bfqg->stats;
>  	u64 now = ktime_get_ns();
> @@ -255,11 +255,11 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
>  #else /* CONFIG_BFQ_CGROUP_DEBUG */
>  
>  void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      unsigned int op) { }
> -void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
> -void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
> +			      blk_opf_t op) { }
> +void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op) { }
> +void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op) { }
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
> -				  u64 io_start_time_ns, unsigned int op) { }
> +				  u64 io_start_time_ns, blk_opf_t op) { }
>  void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
>  void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
>  void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index e6d7e6b01a05..a724fc882158 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -668,7 +668,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
>   * significantly affect service guarantees coming from the BFQ scheduling
>   * algorithm.
>   */
> -static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> +static void bfq_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd = data->q->elevator->elevator_data;
>  	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
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
> index ca8177d7bf7c..6bde1f4ecc50 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -994,11 +994,11 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
>  
>  void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
>  void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      unsigned int op);
> -void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
> -void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op);
> +			      blk_opf_t op);
> +void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t op);
> +void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t op);
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
> -				  u64 io_start_time_ns, unsigned int op);
> +				  u64 io_start_time_ns, blk_opf_t op);
>  void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
>  void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
>  void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
