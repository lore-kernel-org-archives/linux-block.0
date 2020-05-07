Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E79C38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5913B2083B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgEGPMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 11:12:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:56228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgEGPMR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 11:12:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A8D3BAF83;
        Thu,  7 May 2020 15:12:18 +0000 (UTC)
Subject: Re: [PATCH v6 4/5] block: rename __blk_mq_alloc_rq_map
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <61e07b3980c19287e4a1d12b8e2a3b26e262ea0b.1588856361.git.zhangweiping@didiglobal.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9daee91c-29b5-769c-38ca-d9941608f968@suse.de>
Date:   Thu, 7 May 2020 17:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <61e07b3980c19287e4a1d12b8e2a3b26e262ea0b.1588856361.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/20 3:04 PM, Weiping Zhang wrote:
> rename __blk_mq_alloc_rq_map to __blk_mq_alloc_map_and_request,
> actually it alloc both map and request, make function name
> align with function.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c6ba94cba17d..0a4f7fdd2248 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2473,7 +2473,8 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>   	}
>   }
>   
> -static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> +static bool __blk_mq_alloc_map_and_request(struct blk_mq_tag_set *set,
> +					int hctx_idx)
>   {
>   	int ret = 0;
>   
> @@ -2532,7 +2533,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   			hctx_idx = set->map[j].mq_map[i];
>   			/* unmapped hw queue can be remapped after CPU topo changed */
>   			if (!set->tags[hctx_idx] &&
> -			    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
> +			    !__blk_mq_alloc_map_and_request(set, hctx_idx)) {
>   				/*
>   				 * If tags initialization fail for some hctx,
>   				 * that hctx won't be brought online.  In this
> @@ -2988,7 +2989,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>   	int i;
>   
>   	for (i = 0; i < set->nr_hw_queues; i++)
> -		if (!__blk_mq_alloc_rq_map(set, i))
> +		if (!__blk_mq_alloc_map_and_request(set, i))
>   			goto out_unwind;
>   
>   	return 0;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
