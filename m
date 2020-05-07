Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148EC54E49
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5083B20936
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEGPJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 11:09:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgEGPJV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 11:09:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A79FAFAC;
        Thu,  7 May 2020 15:09:23 +0000 (UTC)
Subject: Re: [PATCH v6 1/5] block: free both rq_map and request
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <e26c4cfa43d586ef83743908ce1c33cc69bb9a2f.1588856361.git.zhangweiping@didiglobal.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ed7f1076-b0e8-6bf4-28d1-502ce668627f@suse.de>
Date:   Thu, 7 May 2020 17:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e26c4cfa43d586ef83743908ce1c33cc69bb9a2f.1588856361.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/20 3:03 PM, Weiping Zhang wrote:
> Allocation:
> 
> __blk_mq_alloc_rq_map
> 	blk_mq_alloc_rq_map
> 		blk_mq_alloc_rq_map
> 			tags = blk_mq_init_tags : kzalloc_node:
> 			tags->rqs = kcalloc_node
> 			tags->static_rqs = kcalloc_node
> 	blk_mq_alloc_rqs
> 		p = alloc_pages_node
> 		tags->static_rqs[i] = p + offset;
> 
> Free:
> 
> blk_mq_free_rq_map
> 	kfree(tags->rqs);
> 	kfree(tags->static_rqs);
> 	blk_mq_free_tags
> 		kfree(tags);
> 
> The page allocated in blk_mq_alloc_rqs cannot be released,
> so we should use blk_mq_free_map_and_requests here.
> 
> blk_mq_free_map_and_requests
> 	blk_mq_free_rqs
> 		__free_pages : cleanup for blk_mq_alloc_rqs
> 	blk_mq_free_rq_map : cleanup for blk_mq_alloc_rq_map
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a7785df2c944..f789b3e1b3ab 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2995,7 +2995,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>   
>   out_unwind:
>   	while (--i >= 0)
> -		blk_mq_free_rq_map(set->tags[i]);
> +		blk_mq_free_map_and_requests(set, i);
>   
>   	return -ENOMEM;
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
