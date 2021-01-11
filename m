Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD51AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7337206A3
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbhAKG61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 01:58:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:34582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbhAKG60 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 01:58:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5295ADC4;
        Mon, 11 Jan 2021 06:57:45 +0000 (UTC)
Subject: Re: [PATCH V3 2/6] block: don't pass BIOSET_NEED_BVECS for
 q->bio_split
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <968dfd4b-17fc-a78f-ec97-2bd5d06562a3@suse.de>
Date:   Mon, 11 Jan 2021 07:57:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 4:05 AM, Ming Lei wrote:
> q->bio_split is only used by bio_split() for fast cloning bio, and no
> need to allocate bvecs, so remove this flag.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7663a9b94b80..00d415be74e6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -531,7 +531,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	if (q->id < 0)
>   		goto fail_q;
>   
> -	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> +	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
>   	if (ret)
>   		goto fail_id;
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
