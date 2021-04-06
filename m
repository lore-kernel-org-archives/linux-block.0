Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC154C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F6E6101D
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhDFHUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:20:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhDFHUw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 03:20:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40827B0B6;
        Tue,  6 Apr 2021 07:20:44 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
To:     Nikolay Borisov <nborisov@suse.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20210311081713.2763171-1-nborisov@suse.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5a114d8c-0af4-5643-0ff7-3759755be46d@suse.de>
Date:   Tue, 6 Apr 2021 09:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210311081713.2763171-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/21 9:17 AM, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   block/blk-mq-tag.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..99bc5fe14e9b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -517,7 +517,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>   	tags->nr_tags = total_tags;
>   	tags->nr_reserved_tags = reserved_tags;
>   
> -	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
> +	if (blk_mq_is_sbitmap_shared(flags))
>   		return tags;
>   
>   	if (blk_mq_init_bitmap_tags(tags, node, alloc_policy) < 0) {
> @@ -529,7 +529,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>   
>   void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
>   {
> -	if (!(flags & BLK_MQ_F_TAG_HCTX_SHARED)) {
> +	if (!blk_mq_is_sbitmap_shared(flags)) {
>   		sbitmap_queue_free(tags->bitmap_tags);
>   		sbitmap_queue_free(tags->breserved_tags);
>   	}
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
