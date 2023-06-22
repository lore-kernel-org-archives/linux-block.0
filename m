Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA018EB64D7
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 01:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFVBTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 21:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFVBTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 21:19:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E410D
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 18:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 444A26171D
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 01:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2808C433C0;
        Thu, 22 Jun 2023 01:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687396783;
        bh=LKecFOQdZIpf7R+cC8nCIr42aUAVFZh1NTJWcrcpQg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kdRhYhw/EYgjQ/mPkJnjIfOkcvqGe4/M0KF+C5gvs76B5cesS1VPDvmAVrTkRXB9R
         D1uz+teUvcpcGR7EHLQecWfydMALARoQ7xyw5DPiDScYaXPZKIwUczk97EfvdjhaVf
         2GM5F7bC77wuYwbl6b54cFgcFDXz7FBSeog5qxlAXO4HkZXUGoAQ2tp0i5UxQobpZY
         p54GYWKGkJF+shx8zw6itAkNELofDqkXA4XY9xK96Rlntv64H+P3dLbZBGnAed/2Cr
         ANnBFYpwTw4T0p3vw4GdjaVJu3+pcxH2/ItKKA/dnfWy2gqCt8K8Ks8x/niL14g1xR
         6QPmfyScLqFYA==
Message-ID: <989f9473-c17e-e85d-ab10-313182f7ac3b@kernel.org>
Date:   Thu, 22 Jun 2023 10:19:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-4-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230621201237.796902-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 05:12, Bart Van Assche wrote:
> Send requeued requests to the I/O scheduler if the dispatch order
> matters such that the I/O scheduler can control the order in which
> requests are dispatched.
> 
> This patch reworks commit aef1897cd36d ("blk-mq: insert rq with DONTPREP
> to hctx dispatch list when requeue"). Instead of sending DONTPREP
> requests to the dispatch list, send these to the I/O scheduler and
> prevent that the I/O scheduler merges these requests by adding
> RQF_DONTPREP to the list of flags that prevent merging
> (RQF_NOMERGE_FLAGS).
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c         | 10 +++++-----
>  include/linux/blk-mq.h |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f440e4aaaae3..453a90767f7a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1453,13 +1453,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  	while (!list_empty(&requeue_list)) {
>  		rq = list_entry(requeue_list.next, struct request, queuelist);
>  		/*
> -		 * If RQF_DONTPREP ist set, the request has been started by the
> -		 * driver already and might have driver-specific data allocated
> -		 * already.  Insert it into the hctx dispatch list to avoid
> -		 * block layer merges for the request.
> +		 * Only send those RQF_DONTPREP requests to the dispatch list
> +		 * that may be reordered freely. If the request order matters,
> +		 * send the request to the I/O scheduler.
>  		 */
>  		list_del_init(&rq->queuelist);
> -		if (rq->rq_flags & RQF_DONTPREP)
> +		if (rq->rq_flags & RQF_DONTPREP &&
> +		    !op_needs_zoned_write_locking(req_op(rq)))

Why ? I still do not understand the need for this. There is always only a single
in-flight write per sequential zone. Requeuing that in-flight write directly to
the dispatch list will not reorder writes and it will be better for the command
latency.

>  			blk_mq_request_bypass_insert(rq, 0);
>  		else
>  			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index f401067ac03a..2610b299ec77 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -62,8 +62,8 @@ typedef __u32 __bitwise req_flags_t;
>  #define RQF_RESV		((__force req_flags_t)(1 << 23))
>  
>  /* flags that prevent us from merging requests: */
> -#define RQF_NOMERGE_FLAGS \
> -	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
> +#define RQF_NOMERGE_FLAGS                                               \
> +	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_DONTPREP | RQF_SPECIAL_PAYLOAD)
>  
>  enum mq_rq_state {
>  	MQ_RQ_IDLE		= 0,

-- 
Damien Le Moal
Western Digital Research

