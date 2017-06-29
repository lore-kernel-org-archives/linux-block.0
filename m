Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753244AbdF2Sfr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 14:35:47 -0400
Date: Thu, 29 Jun 2017 11:35:44 -0700
From: Shaohua Li <shli@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, gregkh@linuxfoundation.org, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH V4 10/12] block: call __bio_free in bio_endio
Message-ID: <20170629183544.sgza7orhftb4zkg4@kernel.org>
References: <cover.1498666964.git.shli@fb.com>
 <f1e84225656d403485ac5f1bd8b9f5db42bc74ca.1498666964.git.shli@fb.com>
 <20170628212908.GA19350@lst.de>
 <20170628214249.z42lypwtgzgdzh62@kernel.org>
 <20170629171552.GA28502@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629171552.GA28502@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 29, 2017 at 07:15:52PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 28, 2017 at 02:42:49PM -0700, Shaohua Li wrote:
> > > bio_integrity_endio -> bio_integrity_verify_fn -> bio_integrity_process
> > > access the integrity data, so I don't think this works as-is.
> > 
> > oh, I probably missed the integrity endio. could we let bio_integrity_verify_fn
> > free integrity info and and bio_endio free cgroup info?
> 
> something like this (will need the cgroup fixes from you still) should
> do the trick, although it's completely untested:
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index b8a3a65f7364..b66eb92b5a00 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(bio_integrity_alloc);
>   * Description: Used to free the integrity portion of a bio. Usually
>   * called from bio_free().
>   */
> -void bio_integrity_free(struct bio *bio)
> +static void bio_integrity_free(struct bio *bio)
>  {
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  	struct bio_set *bs = bio->bi_pool;
> @@ -120,8 +120,8 @@ void bio_integrity_free(struct bio *bio)
>  	}
>  
>  	bio->bi_integrity = NULL;
> +	bio->bi_opf &= ~REQ_INTEGRITY;
>  }
> -EXPORT_SYMBOL(bio_integrity_free);
>  
>  /**
>   * bio_integrity_add_page - Attach integrity metadata
> @@ -340,12 +340,6 @@ int bio_integrity_prep(struct bio *bio)
>  		offset = 0;
>  	}
>  
> -	/* Install custom I/O completion handler if read verify is enabled */
> -	if (bio_data_dir(bio) == READ) {
> -		bip->bip_end_io = bio->bi_end_io;
> -		bio->bi_end_io = bio_integrity_endio;
> -	}
> -
>  	/* Auto-generate integrity metadata if this is a write */
>  	if (bio_data_dir(bio) == WRITE)
>  		bio_integrity_process(bio, bi->profile->generate_fn);
> @@ -370,14 +364,12 @@ static void bio_integrity_verify_fn(struct work_struct *work)
>  	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
>  
>  	bio->bi_status = bio_integrity_process(bio, bi->profile->verify_fn);
> -
> -	/* Restore original bio completion handler */
> -	bio->bi_end_io = bip->bip_end_io;
> +	bio_integrity_free(bio);
>  	bio_endio(bio);

should we directly call bi_end_io here? Otherwise, looks reasonable to me.

Thanks,
Shaohua
