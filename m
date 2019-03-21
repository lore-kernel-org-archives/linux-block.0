Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA9C10F0D
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509CB218FF
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 13:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfCUNSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:18:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbfCUNSm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 09:18:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EBEFAF2F;
        Thu, 21 Mar 2019 13:18:40 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@fb.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190321123045.32396-1-jthumshirn@suse.de>
 <20190321123045.32396-2-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <886489c7-133d-b0bb-6ae9-f054727985e4@suse.de>
Date:   Thu, 21 Mar 2019 14:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321123045.32396-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 1:30 PM, Johannes Thumshirn wrote:
> With the introduction of BIO_ALLOCED we've used up all available bits in
> bio::bi_flags.
> 
> Make sure no-one adds a new one and thus overrides the BVEC_POOL_IDX
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   block/bio.c               |  8 ++++++++
>   include/linux/blk_types.h | 31 +++++++++++++++++--------------
>   2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4db1008309ed..8c689aed46a0 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2126,12 +2126,20 @@ static void __init biovec_init_slabs(void)
>   	}
>   }
>   
> +static inline void bio_flag_buildtime_check(void)
> +{
> +	BUILD_BUG_ON(BIO_FLAG_LAST > BVEC_POOL_OFFSET);
> +}
> +
>   static int __init init_bio(void)
>   {
>   	bio_slab_max = 2;
>   	bio_slab_nr = 0;
>   	bio_slabs = kcalloc(bio_slab_max, sizeof(struct bio_slab),
>   			    GFP_KERNEL);
> +
> +	bio_flag_buildtime_check();
> +
>   	if (!bio_slabs)
>   		panic("bio: can't allocate bios\n");
>   
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d66bf5f32610..0273bad71a96 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -215,20 +215,23 @@ struct bio {
>   /*
>    * bio flags
>    */
> -#define BIO_SEG_VALID	1	/* bi_phys_segments valid */
> -#define BIO_CLONED	2	/* doesn't own data */
> -#define BIO_BOUNCED	3	/* bio is a bounce bio */
> -#define BIO_USER_MAPPED 4	/* contains user pages */
> -#define BIO_NULL_MAPPED 5	/* contains invalid user pages */
> -#define BIO_QUIET	6	/* Make BIO Quiet */
> -#define BIO_CHAIN	7	/* chained bio, ->bi_remaining in effect */
> -#define BIO_REFFED	8	/* bio has elevated ->bi_cnt */
> -#define BIO_THROTTLED	9	/* This bio has already been subjected to
> -				 * throttling rules. Don't do it again. */
> -#define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
> -				 * of this bio. */
> -#define BIO_QUEUE_ENTERED 11	/* can use blk_queue_enter_live() */
> -#define BIO_TRACKED 12		/* set if bio goes through the rq_qos path */
> +enum {
> +	BIO_SEG_VALID =	1,		/* bi_phys_segments valid */
> +	BIO_CLONED = 2,			/* doesn't own data */
> +	BIO_BOUNCED = 3,		/* bio is a bounce bio */
> +	BIO_USER_MAPPED = 4,		/* contains user pages */
> +	BIO_NULL_MAPPED = 5,		/* contains invalid user pages */
> +	BIO_QUIET = 6,			/* Make BIO Quiet */
> +	BIO_CHAIN = 7,			/* chained bio, ->bi_remaining in effect */
> +	BIO_REFFED = 8,			/* bio has elevated ->bi_cnt */
> +	BIO_THROTTLED =	9,		/* This bio has already been subjected to
> +					 * throttling rules. Don't do it again. */
> +	BIO_TRACE_COMPLETION = 10,	/* bio_endio() should trace the final completion
> +					 * of this bio. */
> +	BIO_QUEUE_ENTERED = 11,		/* can use blk_queue_enter_live() */
> +	BIO_TRACKED = 12,		/* set if bio goes through the rq_qos path */
> +	BIO_FLAG_LAST
> +};
>   
>   /* See BVEC_POOL_OFFSET below before adding new flags */
>   
> 
Where's the point of the enum if all values are initialized?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
