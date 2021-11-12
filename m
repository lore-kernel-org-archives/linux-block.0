Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C96C433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3BC60273
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 15:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhKLPtz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhKLPtz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 10:49:55 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1AC061766
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 07:47:04 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id k21so11682458ioh.4
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 07:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CuAIBr44q+v8jfyJzncpVPELi5PdSz7B41xZ4cMVpUA=;
        b=ymvQKzEBDqdH2KxJQ1pGFFOiNnGM5eSr2S9B/BNrgTlbb9CK/PEU/F4GPCNXcqKX18
         OiVD0/Bbsaum6gYtg1Q/ZwnOc799r/oIGNlSGdAPClwAgaRP7IvlmSE5SDEa0BLh8WDv
         J9EFRQee+eHvKKgFMEwN+fN7fBTc9MntWL/0T8yY4YJSm2c+64OBoB8tXRmunFFpL8AH
         oxUR/KVz2gjhpHBZ1dxe7n3CfMocG/u5K3L+yFAR7Pf8SkWGuhYqBh1dRsRIWdXd+p83
         BRracfwmRfdLgwPIU5ZboBdA1ZlxaObtF4wAQuKwQBKaV4WIl3j1jkju1U9hMAOzSRwU
         Ymgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CuAIBr44q+v8jfyJzncpVPELi5PdSz7B41xZ4cMVpUA=;
        b=SoU9iEGoDJcCx/jmvhx9KAbz44dZXql0I26afSyW32fGRcyvOHWzSQ5EgpU45kWUwo
         AVAhqHBkz0FMWiqD9NEiaUoJ1NFYjILOroRdNbqtW2SgWdW+lUvIPeZ8w+3htzfzYAMj
         Fil2IbumzBwCnElbwrND5SjfqVFyN+3b0wrUKs5R41gsqGumnfO4SpSUxoe2G6mp/mCI
         PbzVIrm/r5Y/cgMFll/AwQwIWpegKpgn9JomBEerkRHMPRnKr6PdRuLjLaldwFTxM0kn
         r1honggwmvyXOSUKBdRVkSnadgw81uwEZC8xVqmOMQLGERPh4XVxD/jJf7SrIj8sm+fD
         SJGg==
X-Gm-Message-State: AOAM532z6AtrW1wnGHpzWoOhkk686K4xT3oDPM5BKfh4NyWhNhPQ4BTQ
        Uyy1WXhSe6Q9+MWg1eJzM0MnOg==
X-Google-Smtp-Source: ABdhPJx85OqvmTUEsDTgMm33wpEEBO5S48pLV4qRoedflGTKQqxgl+wiVC0pP4ExGw59jvnAtQqHXQ==
X-Received: by 2002:a6b:7306:: with SMTP id e6mr10971771ioh.25.1636732023681;
        Fri, 12 Nov 2021 07:47:03 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j13sm4384844ila.6.2021.11.12.07.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 07:47:03 -0800 (PST)
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de> <YY4nv5eQUTOF5Wfv@T590>
 <20211112084441.GA32120@lst.de> <YY5iUwZ2TVtfqfXN@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c04076d-6264-07c2-aa97-948211d5bc7f@kernel.dk>
Date:   Fri, 12 Nov 2021 08:47:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YY5iUwZ2TVtfqfXN@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/21 5:47 AM, Ming Lei wrote:
> On Fri, Nov 12, 2021 at 09:44:41AM +0100, Christoph Hellwig wrote:
>> On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
>>>> can only be used for reads, and no fua can be set if the preallocating
>>>> I/O didn't use fua, etc.
>>>>
>>>> What are the pitfalls of just chanigng cmd_flags?
>>>
>>> Then we need to check cmd_flags carefully, such as hctx->type has to
>>> be same, flush & passthrough flags has to be same, that said all
>>> ->cmd_flags used for allocating rqs have to be same with the following
>>> bio->bi_opf.
>>>
>>> In usual cases, I guess all IOs submitted from same plug batch should be
>>> same type. If not, we can switch to change cmd_flags.
>>
>> Jens: is this a limit fitting into your use cases?
>>
>> I guess as a quick fix this rejecting different flags is probably the
>> best we can do for now, but I suspect we'll want to eventually relax
>> them.
> 
> rw mixed workload will be affected, so I think we need to switch to
> change cmd_flags, how about the following patch?
> 
> From 9ab77b7adee768272944c20b7cffc8abdb85a35b Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Fri, 12 Nov 2021 08:14:38 +0800
> Subject: [PATCH] blk-mq: fix filesystem I/O request allocation
> 
> submit_bio_checks() may update bio->bi_opf, so we have to initialize
> blk_mq_alloc_data.cmd_flags with bio->bi_opf after submit_bio_checks()
> returns when allocating new request.
> 
> In case of using cached request, fallback to allocate new request if
> cached rq isn't compatible with the incoming bio, otherwise change
> rq->cmd_flags with incoming bio->bi_opf.
> 
> Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 39 ++++++++++++++++++++++++++++++---------
>  block/blk-mq.h | 26 +++++++++++++++-----------
>  2 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f511db395c7f..3ab34c4f20da 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2521,12 +2521,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	};
>  	struct request *rq;
>  
> -	if (unlikely(bio_queue_enter(bio)))
> -		return NULL;
> -	if (unlikely(!submit_bio_checks(bio)))
> -		goto put_exit;
>  	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
> -		goto put_exit;
> +		return NULL;
>  
>  	rq_qos_throttle(q, bio);
>  
> @@ -2543,19 +2539,32 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	rq_qos_cleanup(q, bio);
>  	if (bio->bi_opf & REQ_NOWAIT)
>  		bio_wouldblock_error(bio);
> -put_exit:
> -	blk_queue_exit(q);
> +
>  	return NULL;
>  }
>  
> +static inline bool blk_mq_can_use_cached_rq(struct request *rq,
> +		struct bio *bio)
> +{
> +	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
> +		return false;
> +
> +	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
> +		return false;
> +
> +	return true;

I think we should just check if hctx is the same, that should be enough.
We don't need to match the type, just disallow if hw queue has changed.


-- 
Jens Axboe

