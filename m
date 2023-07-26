Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2347FC00528
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 08:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjGZIpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjGZIp2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 04:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542013D
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 01:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCF76185C
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 08:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB83C433C8;
        Wed, 26 Jul 2023 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690360654;
        bh=aZVbBr3AnqAs0VagWazc3p7PJwKhae2L6knt4R+xNys=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iW7tcDgyrSmXtcobtiyfAqXU00N5BTgCueqBYf/uS2Fsyr7Y5XKZolOusQ+rL6Gou
         RoOJsj2JXZj896a0OrE6kb267ticqt8Ln8IbKXiesw591fwT8qhPgYWvDWwtxQfcez
         qd2AsOi3TCiiUUWHg20i3KKDdwAKC5SKx8mJcLGBMyy+XPPd8rftGc4PRcX2zWh5nF
         Hud0B029bnPRp1R0spWEQGjIksCegDKgYvgrTL5kr2YEB+BlrpxBYNA+I0oRsTYS/b
         I6czeGXiw0XHIHNCrNq8RyravAy+Q7UEg885tIFHd0pgLtzh7ugovbix2AcDnn+E7S
         JANRoH+/knWcg==
Message-ID: <c853e8bb-5873-c63d-22ad-2292e39e9184@kernel.org>
Date:   Wed, 26 Jul 2023 17:37:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/6] block: Introduce the flag REQ_NO_WRITE_LOCK
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-2-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726005742.303865-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 09:57, Bart Van Assche wrote:
> Not all software that supports zoned storage allocates and submits zoned
> writes in LBA order per zone. Introduce the REQ_NO_WRITE_LOCK flag such
> that submitters of zoned writes can indicate that zoned writes are
> allocated and submitted in LBA order per zone.

That is absolutely NOT true. *ALL* in-kernel and application software supporting
zoned block devices issue writes sequentially. Otherwise, they are considered
buggy. The justification for zone write locking is to preserve sequential write
streams in the presence of storage adapters that do not preserve command orders,
or if the low level driver requeue write commands. If both of these conditions
are false (e.g. UFS), with the help of proper scsi requeue handling, zone write
locking can be disabled. REQ_NO_WRITE_LOCK indicates that a write request does
not need zone write locking when the underlying device signaled that it can
preserve command ordering. So we also need a queue flag for that...

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-flush.c         | 3 ++-
>  include/linux/blk_types.h | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
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

Why ? I do not see why this change is necessary. If it is, the commit message
should mention it and this change should probably be its own patch.

>  	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
>  	flush_rq->end_io = flush_end_io;
>  	/*
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

...if the request submitter submits write requests sequentially per zone.

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

