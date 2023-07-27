Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9BC0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 00:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjG0ADS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 20:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjG0ADO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 20:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74C71FF0
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 17:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F66161CC2
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 00:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE1C433C7;
        Thu, 27 Jul 2023 00:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690416190;
        bh=BCt15pnSFoGVcAF/4rYVb9VHGk2wVpgnDhUytiHLOwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=knTRLyKOqTJdWgth2uE5/bnUz/Nf1/CPqgV0br/Em5tVRWo5iKcUmcl+pYVSznLM4
         Kb3iPZedKWkzlKI7eenCEDChmxcd4Ry52DT4vLGMTuz9bDaPnxhxmweUPIXlXNyeN3
         J++oeppUeEE3OQ61zXUfOVEkDbgVXLVzYGfnZ+LMxnzlHISaVv7U3PSltcV68bk8WF
         u42dCghFhlClO5s1PRQDrMHGTOAaJa59PJO8TQCdgU4Dwxy5V5NQ2oQRfseUu5smba
         4aKW7/rfVqsaH+24PfpcNOClSu+/n5Z75Z5LKQMyAWoC9ldveWRWPobjAVa6+p0MWP
         xXcjo3wDbdiCQ==
Message-ID: <c5a8c02e-2cc5-391e-d81a-d6a3457fdd62@kernel.org>
Date:   Thu, 27 Jul 2023 09:03:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/7] block: Introduce the flag REQ_NO_ZONE_WRITE_LOCK
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-3-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726193440.1655149-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 04:34, Bart Van Assche wrote:
> Not all software that supports zoned storage allocates and submits zoned
> writes in LBA order per zone. Introduce the REQ_NO_WRITE_LOCK flag such
> that submitters of zoned writes can indicate that zoned writes are
> allocated and submitted in LBA order per zone.

This really needs more explanation... "Not all software that supports zoned
storage allocates and submits zoned writes in LBA order per zone" is very
misleading. I already commented on this on the last round. All writers to zones
are suppose to be writing sequentially. But while we can trust in-kernel users
to do that correctly, we cannot trust applications for the same. Hence this flag.

> Introduce the blk_no_zone_write_lock() function to make it easy to test
> whether both QUEUE_FLAG_NO_ZONE_WRITE_LOCK and REQ_NO_ZONE_WRITE_LOCK
> are set.

As mentioned in patch 1, I think it would be a lot better to squash this patch
with the previous one since the queue flag and the req flag work together are
are useless alone.

> 
> Make flush requests inherit the REQ_NO_ZONE_WRITE_LOCK flag from the
> request they are derived from.

This really needs to be moved to its own patch. But I still fail to understand
why flush needs to be touched. If flush commands are being subjected to zone
write locking, then that's a bug I think. Or I am missing something ?

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-flush.c         |  3 ++-
>  include/linux/blk-mq.h    | 11 +++++++++++
>  include/linux/blk_types.h |  8 ++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index e73dc22d05c1..038350ed7cce 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -336,7 +336,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>  		flush_rq->internal_tag = first_rq->internal_tag;
>  
>  	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
> -	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
> +	flush_rq->cmd_flags |= flags &
> +		(REQ_FAILFAST_MASK | REQ_NO_ZONE_WRITE_LOCK | REQ_DRV);

See above. Let's move this to another patch to better explain why this change
is needed.

>  	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
>  	flush_rq->end_io = flush_end_io;
>  	/*
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 01e8c31db665..dc8ec26ba2d0 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1170,6 +1170,12 @@ static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
>  		blk_rq_zone_is_seq(rq);
>  }
>  
> +static inline bool blk_no_zone_write_lock(struct request *rq)
> +{
> +	return blk_queue_no_zone_write_lock(rq->q) &&
> +		rq->cmd_flags & REQ_NO_ZONE_WRITE_LOCK;
> +}
> +
>  bool blk_req_needs_zone_write_lock(struct request *rq);
>  bool blk_req_zone_write_trylock(struct request *rq);
>  void __blk_req_zone_write_lock(struct request *rq);
> @@ -1205,6 +1211,11 @@ static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
>  	return false;
>  }
>  
> +static inline bool blk_no_zone_write_lock(struct request *rq)
> +{
> +	return true;
> +}
> +
>  static inline bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
>  	return false;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0bad62cca3d0..68f7934d8fa6 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -416,6 +416,12 @@ enum req_flag_bits {
>  	__REQ_PREFLUSH,		/* request for cache flush */
>  	__REQ_RAHEAD,		/* read ahead, can fail anytime */
>  	__REQ_BACKGROUND,	/* background IO */
> +	/*
> +	 * Do not use zone write locking. Setting this flag is only safe if
> +	 * the request submitter allocates and submit requests in LBA order per
> +	 * zone.

"submit requests" -> "submits write requests"
LBA -> sector (as requests use sector unit, not LBA unit)

> +	 */
> +	__REQ_NO_ZONE_WRITE_LOCK,
>  	__REQ_NOWAIT,           /* Don't wait if request will block */
>  	__REQ_POLLED,		/* caller polls for completion using bio_poll */
>  	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
> @@ -448,6 +454,8 @@ enum req_flag_bits {
>  #define REQ_PREFLUSH	(__force blk_opf_t)(1ULL << __REQ_PREFLUSH)
>  #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
>  #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
> +#define REQ_NO_ZONE_WRITE_LOCK	\
> +			(__force blk_opf_t)(1ULL << __REQ_NO_ZONE_WRITE_LOCK)
>  #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
>  #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
>  #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)

-- 
Damien Le Moal
Western Digital Research

