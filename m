Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA773C4361B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 11:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9359B22D01
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 11:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgLFLV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Dec 2020 06:21:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:39542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLFLV1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Dec 2020 06:21:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B436ABE9;
        Sun,  6 Dec 2020 11:20:46 +0000 (UTC)
Subject: Re: [PATCH] block: fix bio chaining in blk_next_bio()
To:     Tom Yan <tom.ty89@gmail.com>, linux-block@vger.kernel.org,
        hch@lst.de, ming.l@ssi.samsung.com, sagig@grimberg.me, axboe@fb.com
Cc:     tom.leiming@gmail.com
References: <20201206051802.1890-1-tom.ty89@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2bfe61a7-2dd1-9bb1-76a4-26e948493342@suse.de>
Date:   Sun, 6 Dec 2020 12:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201206051802.1890-1-tom.ty89@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/20 6:18 AM, Tom Yan wrote:
> While it seems to have worked for so long, it doesn't seem right
> that we set the new bio as the parent. bio_chain() seems to be used
> in the other way everywhere else anyway.
> 
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> ---
>   block/blk-lib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e90614fd8d6a..918deaf5c8a4 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -15,7 +15,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
>   	struct bio *new = bio_alloc(gfp, nr_pages);
>   
>   	if (bio) {
> -		bio_chain(bio, new);
> +		bio_chain(new, bio);
>   		submit_bio(bio);
>   	}
>   
> 
I don't think this is correct.
This code is submitting the original bio, and we _want_ to keep the 
newly allocated one even though the original might have been completed 
already. If we were setting the 'parent' to the original bio upper 
layers might infer that the entire request has been completed (as the 
original bio is now the 'parent' bio), which is patently not true.

So, rather not.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
