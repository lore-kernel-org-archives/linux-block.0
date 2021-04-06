Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5F6C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04ACF613B7
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbhDFHHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244135AbhDFHHI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 03:07:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617692818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ud5LnEX5HC2IyBMX2ooJa4zdaPw7TGVWn5XsMhHS8UU=;
        b=mz/ombGjDwCUr8cSwhfIcBkxedPb0ghMYgsz/ZAAId1fGcG03LFlhqeg2GEfCWzZ6D0ZJ8
        ciQ1zSwBKe8zX0Ce4DDCfLJ+lYwrktDSmE2MjXJ9rtInd7fK90ENC+OmgTqF/1tn+aelPo
        wKK0LCFo97/TBify6ATMLKysdlz7CFY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CEFDAE81;
        Tue,  6 Apr 2021 07:06:58 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: Document some blk_mq_ctx fields
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20210311081729.2763232-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <cac575af-ac02-2b72-aa70-aaa67a3ea67c@suse.com>
Date:   Tue, 6 Apr 2021 10:06:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311081729.2763232-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11.03.21 г. 10:17, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Ping

> ---
>  block/blk-mq.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 3616453ca28c..f0079e177bba 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -17,12 +17,26 @@ struct blk_mq_ctxs {
>   */
>  struct blk_mq_ctx {
>  	struct {
> +		/** @lock: Protects the rq_lists */
>  		spinlock_t		lock;
>  		struct list_head	rq_lists[HCTX_MAX_TYPES];
>  	} ____cacheline_aligned_in_smp;
>  
> +	/**
> +	 * @cpu: id of cpu owning this context
> +	 */
>  	unsigned int		cpu;
> +
> +	/**
> +	 * @index_hw: Number of software queues mapped to the hw queue for each
> +	 * hardware queue type
> +	 */
>  	unsigned short		index_hw[HCTX_MAX_TYPES];
> +
> +	/**
> +	 * @hctxs: Hardware queue this queue maps to for each hardware queue
> +	 * type
> +	 */
>  	struct blk_mq_hw_ctx 	*hctxs[HCTX_MAX_TYPES];
>  
>  	/* incremented at dispatch time */
> @@ -32,6 +46,9 @@ struct blk_mq_ctx {
>  	/* incremented at completion time */
>  	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
>  
> +	/**
> +	 * @queue: Pointer to the request queue that owns this software context.
> +	 */
>  	struct request_queue	*queue;
>  	struct blk_mq_ctxs      *ctxs;
>  	struct kobject		kobj;
> 
