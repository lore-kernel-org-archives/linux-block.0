Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6AC433C1
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 01:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C083B61A12
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 01:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhCYB4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 21:56:39 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43738 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231199AbhCYB4g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 21:56:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTEBnSt_1616637393;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTEBnSt_1616637393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Mar 2021 09:56:34 +0800
Subject: Re: [PATCH V3 01/13] block: add helper of blk_queue_poll
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-2-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <693bf48d-46e9-16a6-2b77-a733327c9841@linux.alibaba.com>
Date:   Thu, 25 Mar 2021 09:56:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/24/21 8:19 PM, Ming Lei wrote:
> There has been 3 users, and will be more, so add one such helper.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Better to also convert blk-sysfs.c:queue_poll_show().

With that fixed,

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>


> ---
>  block/blk-core.c         | 2 +-
>  block/blk-mq.c           | 3 +--
>  drivers/nvme/host/core.c | 2 +-
>  include/linux/blkdev.h   | 1 +
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..a31371d55b9d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -836,7 +836,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  		}
>  	}
>  
> -	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +	if (!blk_queue_poll(q))
>  		bio->bi_opf &= ~REQ_HIPRI;
>  
>  	switch (bio_op(bio)) {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa439..63c81df3b8b5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3869,8 +3869,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>  	struct blk_mq_hw_ctx *hctx;
>  	long state;
>  
> -	if (!blk_qc_t_valid(cookie) ||
> -	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +	if (!blk_qc_t_valid(cookie) || !blk_queue_poll(q))
>  		return 0;
>  
>  	if (current->plug)
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0896e21642be..34b8c78f88e0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -956,7 +956,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
>  {
>  	DECLARE_COMPLETION_ONSTACK(wait);
>  
> -	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> +	WARN_ON_ONCE(!blk_queue_poll(q));
>  
>  	rq->cmd_flags |= REQ_HIPRI;
>  	rq->end_io_data = &wait;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bc6bc8383b43..89a01850cf12 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -665,6 +665,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> +#define blk_queue_poll(q)	test_bit(QUEUE_FLAG_POLL, &(q)->queue_flags)
>  
>  extern void blk_set_pm_only(struct request_queue *q);
>  extern void blk_clear_pm_only(struct request_queue *q);
> 

-- 
Thanks,
Jeffle
