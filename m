Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F462C433E3
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043F361A10
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhCXPck (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236498AbhCXPce (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 11:32:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4E32AF0D;
        Wed, 24 Mar 2021 15:32:32 +0000 (UTC)
Subject: Re: [PATCH V3 05/13] block: add req flag of REQ_POLL_CTX
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-6-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <614dcf6d-2b45-394c-d295-c14c14dc9070@suse.de>
Date:   Wed, 24 Mar 2021 16:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 1:19 PM, Ming Lei wrote:
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
> ---
>   block/blk-core.c          | 25 ++++++++++++++++++++++++-
>   include/linux/blk_types.h |  4 ++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 4671bbf31fd3..eb07d61cfdc2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -840,11 +840,30 @@ static inline bool blk_queue_support_bio_poll(struct request_queue *q)
>   static inline void blk_bio_poll_preprocess(struct request_queue *q,
>   		struct bio *bio)
>   {
> +	bool mq;
> +
>   	if (!(bio->bi_opf & REQ_HIPRI))
>   		return;
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
>   		bio->bi_opf &= ~REQ_HIPRI;
> +	else if (!mq)
> +		bio->bi_opf |= REQ_POLL_CTX;
>   }
>   
>   static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> @@ -894,8 +913,12 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
>   	/*
>   	 * Create per-task io poll ctx if bio polling supported and HIPRI
>   	 * set.
> +	 *
> +	 * If REQ_POLL_CTX isn't set for this HIPRI bio, we think it originated
> +	 * from FS and allocate io polling context.
>   	 */
>   	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
> +			!(bio->bi_opf & REQ_POLL_CTX) &&
>   			(bio->bi_opf & REQ_HIPRI));
>   
>   	blk_bio_poll_preprocess(q, bio);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index db026b6ec15a..99160d588c2d 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -394,6 +394,9 @@ enum req_flag_bits {
>   
>   	__REQ_HIPRI,
>   
> +	/* for marking IOs originated from same FS bio in same context */
> +	__REQ_POLL_CTX,
> +
>   	/* for driver use */
>   	__REQ_DRV,
>   	__REQ_SWAP,		/* swapping request. */
> @@ -418,6 +421,7 @@ enum req_flag_bits {
>   
>   #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
>   #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
> +#define REQ_POLL_CTX			(1ULL << __REQ_POLL_CTX)
>   
>   #define REQ_DRV			(1ULL << __REQ_DRV)
>   #define REQ_SWAP		(1ULL << __REQ_SWAP)
> 
What happens to split bios?
Will they be tracked similarly to cloned bios?
If so, shouldn't you document that here, too?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
