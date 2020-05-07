Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0495C38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3172073A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGPMw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 11:12:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgEGPMw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 11:12:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF091AB99;
        Thu,  7 May 2020 15:12:53 +0000 (UTC)
Subject: Re: [PATCH v6 5/5] block: rename blk_mq_alloc_rq_maps
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <db1712c57633b1cf63bc704a3c47456a0dda5ed8.1588856361.git.zhangweiping@didiglobal.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3a7a582f-8cfc-75f4-6073-d5fcf811192f@suse.de>
Date:   Thu, 7 May 2020 17:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <db1712c57633b1cf63bc704a3c47456a0dda5ed8.1588856361.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/20 3:04 PM, Weiping Zhang wrote:
> rename blk_mq_alloc_rq_maps to blk_mq_alloc_map_and_requests,
> this function allocs both map and request, make function name align
> with funtion.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0a4f7fdd2248..649a8abdd742 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3006,7 +3006,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>    * may reduce the depth asked for, if memory is tight. set->queue_depth
>    * will be updated to reflect the allocated depth.
>    */
> -static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> +static int blk_mq_alloc_map_and_requests(struct blk_mq_tag_set *set)
>   {
>   	unsigned int depth;
>   	int err;
> @@ -3166,7 +3166,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>   	if (ret)
>   		goto out_free_mq_map;
>   
> -	ret = blk_mq_alloc_rq_maps(set);
> +	ret = blk_mq_alloc_map_and_requests(set);
>   	if (ret)
>   		goto out_free_mq_map;
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
