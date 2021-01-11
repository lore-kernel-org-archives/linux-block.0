Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4AAC433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94697206D8
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbhAKG7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 01:59:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:34744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbhAKG7a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 01:59:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BF37AB7A;
        Mon, 11 Jan 2021 06:58:49 +0000 (UTC)
Subject: Re: [PATCH V3 3/6] block: don't allocate inline bvecs if this bioset
 needn't bvecs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e2d4c28b-19e8-509e-a905-5e4019e9428a@suse.de>
Date:   Mon, 11 Jan 2021 07:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 4:05 AM, Ming Lei wrote:
> The inline bvecs won't be used if user needn't bvecs by not passing
> BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bio.c         | 7 +++++--
>   include/linux/bio.h | 1 +
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index cfa0e9db30e0..496aa5938f79 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -89,8 +89,7 @@ static struct bio_slab *create_bio_slab(unsigned int size)
>   
>   static inline unsigned int bs_bio_slab_size(struct bio_set *bs)
>   {
> -	return bs->front_pad + sizeof(struct bio) +
> -		BIO_INLINE_VECS * sizeof(struct bio_vec);
> +	return bs->front_pad + sizeof(struct bio) + bs->back_pad;
>   }
>   
>   static struct kmem_cache *bio_find_or_create_slab(struct bio_set *bs)
> @@ -1572,6 +1571,10 @@ int bioset_init(struct bio_set *bs,
>   		int flags)
>   {
>   	bs->front_pad = front_pad;
> +	if (flags & BIOSET_NEED_BVECS)
> +		bs->back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
> +	else
> +		bs->back_pad = 0;
>   
>   	spin_lock_init(&bs->rescue_lock);
>   	bio_list_init(&bs->rescue_list);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1edda614f7ce..f606eb1e556f 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -703,6 +703,7 @@ struct bio_set {
>   	mempool_t bvec_integrity_pool;
>   #endif
>   
> +	unsigned int back_pad;
>   	/*
>   	 * Deadlock avoidance for stacking block drivers: see comments in
>   	 * bio_alloc_bioset() for details
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
