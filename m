Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1570C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 06:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0DB61A12
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 06:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCYG4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:56:12 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54584 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhCYGz7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 02:55:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UTFNVua_1616655357;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTFNVua_1616655357)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Mar 2021 14:55:57 +0800
Subject: Re: [PATCH V3 05/13] block: add req flag of REQ_POLL_CTX
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-6-ming.lei@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <c9e0383e-144b-e7cb-3b30-f50ee2f3d98a@linux.alibaba.com>
Date:   Thu, 25 Mar 2021 14:55:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/24/21 8:19 PM, Ming Lei wrote:
> Add one req flag REQ_POLL_CTX which will be used in the following patch for
> supporting bio based IO polling.
> 
> Exactly this flag can help us to do:
> 
> 1) request flag is cloned in bio_fast_clone(), so if we mark one FS bio
> as REQ_POLL_CTX, all bios cloned from this FS bio will be marked as
> REQ_POLL_CTX too.
> 
> 2) create per-task io polling context if the bio based queue supports
> polling and the submitted bio is HIPRI. Per-task io poll context will be
> created during submit_bio() before marking this HIPRI bio as REQ_POLL_CTX.
> Then we can avoid to create such io polling context if one cloned bio with
> REQ_POLL_CTX is submitted from another kernel context.
> 
> 3) for supporting bio based io polling, we need to poll IOs from all
> underlying queues of the bio device, this way help us to recognize which
> IO needs to polled in bio based style, which will be applied in
> following patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>


> ---
>  block/blk-core.c          | 25 ++++++++++++++++++++++++-
>  include/linux/blk_types.h |  4 ++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4671bbf31fd3..eb07d61cfdc2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -840,11 +840,30 @@ static inline bool blk_queue_support_bio_poll(struct request_queue *q)
>  static inline void blk_bio_poll_preprocess(struct request_queue *q,
>  		struct bio *bio)
>  {
> +	bool mq;
> +
>  	if (!(bio->bi_opf & REQ_HIPRI))
>  		return;
>  
> -	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
> +	/*
> +	 * Can't support bio based IO polling without per-task poll ctx
> +	 *
> +	 * We have created per-task io poll context, and mark this
> +	 * bio as REQ_POLL_CTX, so: 1) if any cloned bio from this bio is
> +	 * submitted from another kernel context, we won't create bio
> +	 * poll context for it, and that bio can be completed by IRQ;
> +	 * 2) If such bio is submitted from current context, we will
> +	 * complete it via blk_poll(); 3) If driver knows that one
> +	 * underlying bio allocated from driver is for FS bio, meantime
> +	 * it is submitted in current context, driver can mark such bio
> +	 * as REQ_HIPRI & REQ_POLL_CTX manually, so the bio can be completed
> +	 * via blk_poll too.
> +	 */
> +	mq = queue_is_mq(q);
> +	if (!blk_queue_poll(q) || (!mq && !blk_get_bio_poll_ctx()))
>  		bio->bi_opf &= ~REQ_HIPRI;
> +	else if (!mq)
> +		bio->bi_opf |= REQ_POLL_CTX;
>  }
>  
>  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> @@ -894,8 +913,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>  	/*
>  	 * Create per-task io poll ctx if bio polling supported and HIPRI
>  	 * set.
> +	 *
> +	 * If REQ_POLL_CTX isn't set for this HIPRI bio, we think it originated
> +	 * from FS and allocate io polling context.
>  	 */
>  	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
> +			!(bio->bi_opf & REQ_POLL_CTX) &&
>  			(bio->bi_opf & REQ_HIPRI));
>  
>  	blk_bio_poll_preprocess(q, bio);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index db026b6ec15a..99160d588c2d 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -394,6 +394,9 @@ enum req_flag_bits {
>  
>  	__REQ_HIPRI,
>  
> +	/* for marking IOs originated from same FS bio in same context */
> +	__REQ_POLL_CTX,
> +
>  	/* for driver use */
>  	__REQ_DRV,
>  	__REQ_SWAP,		/* swapping request. */
> @@ -418,6 +421,7 @@ enum req_flag_bits {
>  
>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
> +#define REQ_POLL_CTX			(1ULL << __REQ_POLL_CTX)
>  
>  #define REQ_DRV			(1ULL << __REQ_DRV)
>  #define REQ_SWAP		(1ULL << __REQ_SWAP)
> 

-- 
Thanks,
Jeffle
