Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B6C55181
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4218E206E9
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgDTUlH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:41:07 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36920 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDTUlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 16:41:07 -0400
Received: by mail-pj1-f65.google.com with SMTP id a7so374761pju.2
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 13:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5llEQW4n3S6sqVp7YYVstmfl+Xs5blzM3eVsTmbMn6U=;
        b=Mqht2fCTFbeinWosKxHoFfjLf/YOvPLsEmBJmM9VX654hl5275HMJIBiGSOcZt39g8
         ZuamzSogISdGm8W81zw6zB+gVRJbCRbus2r5mHUieC3mSKmEK0mWIVqveqzIaGj3sHHV
         bYPkbZY9J/MGCZ1F0jtVo0p8/z8sk5p8BcB3sRcE5A5WQfAs4l1//uUFdFR4xJpnNSaW
         yla7Hig+Zl6lXw7TAzkk27rn//OLfbPnWVDcitwhRyt5WaP0yXJ4sQtgP6MVjU7Z0Qmz
         yNPFhYsddM9TQ3zM9yW1Hc8TYftM8f9XqLiwDexmJPLUfYcwzcf35tsqmkvqUv3U+CFP
         72oA==
X-Gm-Message-State: AGi0PuZmELwgfW8YdnwQb8PslCjamcZP+f/UT2zGoVr3q0GnzCgtEDs6
        NUsVLcXDC2X97TRvTclQH4oaVarm
X-Google-Smtp-Source: APiQypIlGdbODLdwERpllCLZtnvWLIxC1RxEM/7fRq6DFYRfyk2HT+f6oMNBGj/pb9F9M2eIzieeOg==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr1411383pjs.156.1587415266236;
        Mon, 20 Apr 2020 13:41:06 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.198.105])
        by smtp.gmail.com with ESMTPSA id y13sm359342pfc.78.2020.04.20.13.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:41:05 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] block: rename __blk_mq_alloc_rq_map
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <9e542bceca1c467c99f114be7ab958066b8c7bf5.1586199103.git.zhangweiping@didiglobal.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a0fd4ea9-750a-92a1-11ae-a95d5f5dc74f@acm.org>
Date:   Mon, 20 Apr 2020 13:41:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9e542bceca1c467c99f114be7ab958066b8c7bf5.1586199103.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 12:36 PM, Weiping Zhang wrote:
> rename __blk_mq_alloc_rq_map to __blk_mq_alloc_rq_map_and_request,
> actually it alloc both map and request, make function name
> align with function.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f6291ceedee4..3a482ce7ed28 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2468,7 +2468,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>   	}
>   }
>   
> -static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> +static bool __blk_mq_alloc_rq_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)
>   {
>   	int ret = 0;
>   
> @@ -2519,7 +2519,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
>   		/* unmapped hw queue can be remapped after CPU topo changed */
>   		if (!set->tags[hctx_idx] &&
> -		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> +		    !__blk_mq_alloc_rq_map_and_request(set, hctx_idx)) {
>   			/*
>   			 * If tags initialization fail for some hctx,
>   			 * that hctx won't be brought online.  In this
> @@ -2983,7 +2983,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>   	int i;
>   
>   	for (i = 0; i < set->nr_hw_queues; i++)
> -		if (!__blk_mq_alloc_rq_map(set, i))
> +		if (!__blk_mq_alloc_rq_map_and_request(set, i))
>   			goto out_unwind;
>   
>   	return 0;

What the __blk_mq_alloc_rq_map() function allocates is a request map and 
requests. The new name is misleading because it suggests that only a 
single request is allocated instead of multiple. The name 
__blk_mq_alloc_rq_map_and_requests() is probably a better choice than 
__blk_mq_alloc_rq_map_and_request().

My opinion is that the old name is clear enough. I prefer the current name.

Thanks,

Bart.
