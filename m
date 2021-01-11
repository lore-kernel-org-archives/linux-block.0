Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE61C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 07:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9E22516
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 07:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbhAKHA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 02:00:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:35032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbhAKHAZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 02:00:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3879AB7A;
        Mon, 11 Jan 2021 06:59:44 +0000 (UTC)
Subject: Re: [PATCH V3 4/6] block: set .bi_max_vecs as actual allocated vector
 number
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-5-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6554005f-d57c-0ae2-a0fc-6dc3cafa2c27@suse.de>
Date:   Mon, 11 Jan 2021 07:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 4:05 AM, Ming Lei wrote:
> bvec_alloc() may allocate more bio vectors than requested, so set
> .bi_max_vecs as actual allocated vector number, instead of the requested
> number. This way can help fs build bigger bio because new bio often won't
> be allocated until the current one becomes full.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bio.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 496aa5938f79..37e3f2d9df99 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -505,12 +505,13 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
>   			goto err_free;
>   
>   		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
> +		bio->bi_max_vecs = bvec_nr_vecs(idx);
>   	} else if (nr_iovecs) {
>   		bvl = bio->bi_inline_vecs;
> +		bio->bi_max_vecs = inline_vecs;
>   	}
>   
>   	bio->bi_pool = bs;
> -	bio->bi_max_vecs = nr_iovecs;
>   	bio->bi_io_vec = bvl;
>   	return bio;
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
