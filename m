Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36E4C433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD2C22516
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 06:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbhAKG5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 01:57:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:34508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbhAKG5v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 01:57:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EE35AB3E;
        Mon, 11 Jan 2021 06:57:10 +0000 (UTC)
Subject: Re: [PATCH V3 1/6] block: manage bio slab cache by xarray
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <27b9d901-51d4-2974-bb9d-3d0c4b2d8230@suse.de>
Date:   Mon, 11 Jan 2021 07:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 4:05 AM, Ming Lei wrote:
> Managing bio slab cache via xarray by using slab cache size as xarray
> index, and storing 'struct bio_slab' instance into xarray.
> 
> So code is simplified a lot, meantime it becomes more readable than before.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bio.c | 116 ++++++++++++++++++++++------------------------------
>   1 file changed, 49 insertions(+), 67 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1f2cc1fbe283..cfa0e9db30e0 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -19,6 +19,7 @@
>   #include <linux/highmem.h>
>   #include <linux/sched/sysctl.h>
>   #include <linux/blk-crypto.h>
> +#include <linux/xarray.h>
>   
>   #include <trace/events/block.h>
>   #include "blk.h"
> @@ -58,89 +59,80 @@ struct bio_slab {
>   	char name[8];
>   };
>   static DEFINE_MUTEX(bio_slab_lock);
> -static struct bio_slab *bio_slabs;
> -static unsigned int bio_slab_nr, bio_slab_max;
> +static DEFINE_XARRAY(bio_slabs);
>   
> -static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
> +static struct bio_slab *create_bio_slab(unsigned int size)
>   {
> -	unsigned int sz = sizeof(struct bio) + extra_size;
> -	struct kmem_cache *slab = NULL;
> -	struct bio_slab *bslab, *new_bio_slabs;
> -	unsigned int new_bio_slab_max;
> -	unsigned int i, entry = -1;
> +	struct bio_slab *bslab = kzalloc(sizeof(*bslab), GFP_KERNEL);
>   
> -	mutex_lock(&bio_slab_lock);
> +	if (!bslab)
> +		return NULL;
>   
> -	i = 0;
> -	while (i < bio_slab_nr) {
> -		bslab = &bio_slabs[i];
> +	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
> +	bslab->slab = kmem_cache_create(bslab->name, size,
> +			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
> +	if (!bslab->slab)
> +		goto fail_alloc_slab;
>   
> -		if (!bslab->slab && entry == -1)
> -			entry = i;
> -		else if (bslab->slab_size == sz) {
> -			slab = bslab->slab;
> -			bslab->slab_ref++;
> -			break;
> -		}
> -		i++;
> -	}
> +	bslab->slab_ref = 1;
> +	bslab->slab_size = size;
>   

Why don't you use a kref here?

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
