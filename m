Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2191C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDF1613B7
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbhDFHHP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244153AbhDFHHO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 03:07:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617692826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfFh6ZjZPthEgwcndwZi/HB6XSEIUsHFZ7RPWwdJ02w=;
        b=m3AYf1wMm3xReVtZ0WOd+GNRx246Jf4m7xyIeTtD13NJ6mXlmGhHYORhW+gTiLMkdJeR3e
        xhNUG2b0Fq57eLZX1JpAljY8zygb4I/j83NqWAOpUDWOrmNNjpyeA9VQq4prHnDEZz6RJN
        s2DnJdEW+GVmRpD+6DEr1wQLsC76oeI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D69FBAE81;
        Tue,  6 Apr 2021 07:07:06 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20210311081713.2763171-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <69af0d7b-192a-eebd-9dff-223a301e9605@suse.com>
Date:   Tue, 6 Apr 2021 10:07:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311081713.2763171-1-nborisov@suse.com>
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
>  block/blk-mq-tag.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..99bc5fe14e9b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -517,7 +517,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>  	tags->nr_tags = total_tags;
>  	tags->nr_reserved_tags = reserved_tags;
>  
> -	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
> +	if (blk_mq_is_sbitmap_shared(flags))
>  		return tags;
>  
>  	if (blk_mq_init_bitmap_tags(tags, node, alloc_policy) < 0) {
> @@ -529,7 +529,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>  
>  void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
>  {
> -	if (!(flags & BLK_MQ_F_TAG_HCTX_SHARED)) {
> +	if (!blk_mq_is_sbitmap_shared(flags)) {
>  		sbitmap_queue_free(tags->bitmap_tags);
>  		sbitmap_queue_free(tags->breserved_tags);
>  	}
> 
