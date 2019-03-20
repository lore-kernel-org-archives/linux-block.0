Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80CC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F602184E
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfCTIvh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:51:37 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:43240 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCTIvh (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 20 Mar 2019 04:51:37 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 20 Mar 2019 09:51:35 +0100
Subject: Re: [PATCH] block_dev: fix crash on chained bios with O_DIRECT
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20190320081253.129688-1-hare@suse.de>
 <9cec723b-d0d0-859f-37c2-bfdccb898071@suse.de>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <e9953e6c-fd4c-cde5-976e-a5831d7c79a3@suse.com>
Date:   Wed, 20 Mar 2019 09:51:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9cec723b-d0d0-859f-37c2-bfdccb898071@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/19 9:45 AM, Johannes Thumshirn wrote:
> On 20/03/2019 09:12, Hannes Reinecke wrote:
>> __blkdev_direct_IO_simple() is allocating a bio on the stack.
>> When that bio needs to be split bio_chain_endio() invokes bio_put()
>> on this bio, causing the kernel to crash in mempool_free() as the
>> bio was never allocated from a mempool in the first place.
>> So call bio_get() before submitting to avoid this problem.
> 
> Hmm this sounds as if we're just papering over the real issue here,
> which is calling bio_free() for bios not allocated using bio_alloc_bioset().
> 
> How about the following untested patch:
> 
>  From 9c8434e5bf81595e97ea5647437d12bfce0e37b6 Mon Sep 17 00:00:00 2001
> From: Johannes Thumshirn <jthumshirn@suse.de>
> Date: Wed, 20 Mar 2019 09:40:18 +0100
> Subject: [PATCH] bio: Introduce BIO_ALLOCED flag and check it in bio_free
> 
> When we're submitting a bio from stack and this ends up being split, we
> call bio_put(). bio_put() will eventually call bio_free() if the reference
> count drops to 0. But freeing the bio is wrong, as it was never allocated
> out of the bio's mempool.
> 
> Flag each normally allocated bio as 'BIO_ALLOCATED' and skip freeing if the
> flag isn't set.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   block/bio.c               | 4 ++++
>   include/linux/blk_types.h | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4db1008309ed..caa8bc076377 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -253,6 +253,9 @@ static void bio_free(struct bio *bio)
>   	struct bio_set *bs = bio->bi_pool;
>   	void *p;
> 
> +	if (!bio_flagged(bio, BIO_ALLOCED))
> +		return;
> +
>   	bio_uninit(bio);
> 
>   	if (bs) {
> @@ -521,6 +524,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask,
> unsigned int nr_iovecs,
>   		bvl = bio->bi_inline_vecs;
>   	}
> 
> +	bio_set_flag(bio, BIO_ALLOCED);
>   	bio->bi_pool = bs;
>   	bio->bi_max_vecs = nr_iovecs;
>   	bio->bi_io_vec = bvl;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d66bf5f32610..14b4f87a1eab 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -229,6 +229,7 @@ struct bio {
>   				 * of this bio. */
>   #define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
>   #define BIO_TRACKED 12		/* set if bio goes through the rq_qos path */
> +#define BIO_ALLOCED 13		/* set if the bio was allocated by
> bio_alloc_bioset */
> 
>   /* See BVEC_POOL_OFFSET below before adding new flags */
> 
Yeah, should work, too.
But we should be calling bio_uninit() for all bios.

Will you be sending an updated patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
