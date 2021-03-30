Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC5BC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6161955
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 03:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC3Dxw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 23:53:52 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33059 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhC3DxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 23:53:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTp7.TS_1617076393;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTp7.TS_1617076393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 11:53:14 +0800
Subject: Re: [PATCH V4 09/12] blk-mq: limit hw queues to be polled in each
 blk_poll()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-10-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <0730c7f4-963c-7ac3-26ad-ccf66b6179ad@linux.alibaba.com>
Date:   Tue, 30 Mar 2021 11:53:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329152622.173035-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/29/21 11:26 PM, Ming Lei wrote:
> Limit at most 8 queues are polled in each blk_pull(), avoid to
> add extra latency when queue depth is high.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

> ---
>  block/blk-mq.c | 73 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b65f2c170fb0..414f5d99d9de 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3865,32 +3865,31 @@ static inline int blk_mq_poll_hctx(struct request_queue *q,
>  	return ret;
>  }
>  
> -static int blk_mq_poll_io(struct bio *bio)
> +#define POLL_HCTX_MAX_CNT 8
> +
> +static bool blk_add_unique_hctx(struct blk_mq_hw_ctx **data, int *cnt,
> +		struct blk_mq_hw_ctx *hctx)
>  {
> -	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> -	blk_qc_t cookie = bio_get_private_data(bio);
> -	int ret = 0;
> +	int i;
>  
> -	if (!bio_flagged(bio, BIO_DONE) && blk_qc_t_valid(cookie)) {
> -		struct blk_mq_hw_ctx *hctx =
> -			q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
> +	for (i = 0; i < *cnt; i++) {
> +		if (data[i] == hctx)
> +			goto exit;
> +	}
>  
> -		ret += blk_mq_poll_hctx(q, hctx);
> +	if (i < POLL_HCTX_MAX_CNT) {
> +		data[i] = hctx;
> +		(*cnt)++;
>  	}
> -	return ret;
> + exit:
> +	return *cnt == POLL_HCTX_MAX_CNT;
>  }
>  
> -static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
> +static void blk_build_poll_queues(struct bio_grp_list *grps,
> +		struct blk_mq_hw_ctx **data, int *cnt)
>  {
> -	int ret = 0;
>  	int i;
>  
> -	/*
> -	 * Poll hw queue first.
> -	 *
> -	 * TODO: limit max poll times and make sure to not poll same
> -	 * hw queue one more time.
> -	 */
>  	for (i = 0; i < grps->nr_grps; i++) {
>  		struct bio_grp_list_data *grp = &grps->head[i];
>  		struct bio *bio;
> @@ -3898,11 +3897,29 @@ static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
>  		if (bio_grp_list_grp_empty(grp))
>  			continue;
>  
> -		for (bio = grp->list.head; bio; bio = bio->bi_poll)
> -			ret += blk_mq_poll_io(bio);
> +		for (bio = grp->list.head; bio; bio = bio->bi_poll) {
> +			blk_qc_t  cookie;
> +			struct blk_mq_hw_ctx *hctx;
> +			struct request_queue *q;
> +
> +			if (bio_flagged(bio, BIO_DONE))
> +				continue;
> +			cookie = bio_get_private_data(bio);
> +			if (!blk_qc_t_valid(cookie))
> +				continue;
> +
> +			q = bio->bi_bdev->bd_disk->queue;
> +			hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
> +			if (blk_add_unique_hctx(data, cnt, hctx))
> +				return;
> +		}
>  	}
> +}
> +
> +static void blk_bio_poll_reap_ios(struct bio_grp_list *grps)
> +{
> +	int i;
>  
> -	/* reap bios */
>  	for (i = 0; i < grps->nr_grps; i++) {
>  		struct bio_grp_list_data *grp = &grps->head[i];
>  		struct bio *bio;
> @@ -3927,6 +3944,22 @@ static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
>  		}
>  		__bio_grp_list_merge(&grp->list, &bl);
>  	}
> +}
> +
> +static int blk_bio_poll_and_end_io(struct bio_grp_list *grps)
> +{
> +	int ret = 0;
> +	int i;
> +	struct blk_mq_hw_ctx *hctx[POLL_HCTX_MAX_CNT];
> +	int cnt = 0;
> +
> +	blk_build_poll_queues(grps, hctx, &cnt);
> +
> +	for (i = 0; i < cnt; i++)
> +		ret += blk_mq_poll_hctx(hctx[i]->queue, hctx[i]);
> +
> +	blk_bio_poll_reap_ios(grps);
> +
>  	return ret;
>  }
>  
> 

-- 
Thanks,
Jeffle
