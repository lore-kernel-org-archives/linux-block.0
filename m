Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754771AbdEKHrP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2017 03:47:15 -0400
Date: Thu, 11 May 2017 15:46:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] Guard bvec iteration logic
Message-ID: <20170511074653.GA31975@ming.t460p>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
 <1494429652-9488-8-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494429652-9488-8-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 10, 2017 at 07:20:50PM +0400, Dmitry Monakhov wrote:
> Currently if some one try to advance bvec beyond it's size we simply
> dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
> This simply means that we endup dereferencing/corrupting random memory
> region.
> 
> Sane reaction would be to propagate error back to calling context
> But bvec_iter_advance's calling context is not always good for error
> handling. For safity reason let truncate iterator size to zero which
> will break external iteration loop which prevent us from unpredictable
> memory range corruption. And even it caller ignores an error, it will
> corrupt it's own bvecs, not others.
> 
> This patch does:
> - Return error back to caller with hope that it will react on this
> - Truncate iterator size
> 
> Code was added long time ago here 4550dd6c, luckily no one hit it
> in real life :)
> 
> changes since V1:
>  - Replace  BUG_ON with error logic.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  drivers/nvdimm/blk.c |  4 +++-
>  drivers/nvdimm/btt.c |  4 +++-
>  include/linux/bio.h  |  8 ++++++--
>  include/linux/bvec.h | 11 ++++++++---
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
> index 0b49336..c82331b 100644
> --- a/drivers/nvdimm/blk.c
> +++ b/drivers/nvdimm/blk.c
> @@ -106,7 +106,9 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk *nsblk,
>  
>  		len -= cur_len;
>  		dev_offset += cur_len;
> -		bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
> +		err = bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
> +		if (err)
> +			return err;
>  	}
>  
>  	return err;
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 3d7a9fe..5a68681 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -942,7 +942,9 @@ static int btt_rw_integrity(struct btt *btt, struct bio_integrity_payload *bip,
>  
>  		len -= cur_len;
>  		meta_nsoff += cur_len;
> -		bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
> +		ret = bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return ret;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1b4ebb4..643ecba 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -168,8 +168,12 @@ static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
>  
>  	if (bio_no_advance_iter(bio))
>  		iter->bi_size -= bytes;
> -	else
> -		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
> +	else {
> +		int err;
> +
> +		err = bvec_iter_advance(bio->bi_io_vec, iter, bytes);
> +		/* TODO: It is reasonable to complete bio with error here. */
> +	}
>  }
>  
>  #define __bio_for_each_segment(bvl, bio, iter, start)			\
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 89b65b8..984a7a8 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -22,6 +22,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/bug.h>
> +#include <linux/errno.h>
>  
>  /*
>   * was unsigned short, but we might as well be ready for > 64kB I/O pages
> @@ -66,12 +67,15 @@ struct bvec_iter {
>  	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
>  })
>  
> -static inline void bvec_iter_advance(const struct bio_vec *bv,
> +static inline int bvec_iter_advance(const struct bio_vec *bv,
>  				     struct bvec_iter *iter,
>  				     unsigned bytes)
>  {
> -	WARN_ONCE(bytes > iter->bi_size,
> -		  "Attempted to advance past end of bvec iter\n");
> +	if (WARN_ONCE(bytes > iter->bi_size,
> +		     "Attempted to advance past end of bvec iter\n")) {
> +		iter->bi_size = 0;
> +		return -EINVAL;
> +	}
>  
>  	while (bytes) {
>  		unsigned iter_len = bvec_iter_len(bv, *iter);
> @@ -86,6 +90,7 @@ static inline void bvec_iter_advance(const struct bio_vec *bv,
>  			iter->bi_idx++;
>  		}
>  	}
> +	return 0;
>  }
>  
>  #define for_each_bvec(bvl, bio_vec, iter, start)			\
> -- 
> 2.9.3
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
