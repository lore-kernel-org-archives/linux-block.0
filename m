Return-Path: <SRS0=JXuJ=C2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A879C43464
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F086D20874
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 22:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzxYFG3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIQWR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 18:17:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35184C06174A
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 15:17:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so3385598pju.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c+4ph0tZxAltz1VN10j3r0ou5+B9luLqkBN/ND6jA8Y=;
        b=qzxYFG3lvEEc7y+LB/VTLnsrJWJIltszV3fGzC3VF96PqohvxgqcAV9cB5cbD14dr9
         XX1Oz4IMzc91vMNomEodF6x4cU07aKGDjfdq/1B2XeYUCjk0ZJriawj1SMHC0bDb3vHn
         Y3W53w0Aq1PH2YG7pk+XMtX1siw3Y900DtrIjtICtBtQiYaOVXxmoBmQuZjoxQ/E8LO6
         uFFmadnTaRbNiUIPLASacDhxCNcgj11ny++C3TM4AMsPgXSVzerzfX3B1iQJSj1cW+Jm
         C5aY5fggT+IyknEMqpT370wNV5VdSHzsHioK0fSaJqJq3FJz+cH+NdiAdh9DP+WtZld2
         EAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c+4ph0tZxAltz1VN10j3r0ou5+B9luLqkBN/ND6jA8Y=;
        b=KHEYKMgbgp1vMHChf0DpawOgTNCxx01l2WbbL2lSH4Ec2airdllvoyogB46A9kxMlO
         tINdwIMOILf/MmMlvjFD3aJQIVP6rBk8tTuGsYY1/sEjO9EEdjdUw0AxMwd8Cd3YPnWc
         4w9MJTCb1Afl1N3MOmtjSzCcOMMTVnKdoK3kDdNGo/obL7oXS+vQfL7Vn7LoasVLFcSK
         qT3VGUEqeSILveEzEz9yyj/B71D1JPH+6uy9LhW/DKP8Y8djCIullE+Oldl+dXzRRF5+
         AW10XPcZxJ+iDSaf2vYD7y6tvblKduD0twvJONoYzUn68bE1RgYQFHaA4EsVkOBYGCUX
         wyLg==
X-Gm-Message-State: AOAM530khYfGlH2j0cUWDlnhydqcQU+X8yFxxLKYdlgYanVg/Yme35sK
        qkadsk6Mv9U/NyBerFF1rOKXXHNDWzPnig==
X-Google-Smtp-Source: ABdhPJzQ5LC5wQL53AW0SgR+ExyQHxB64LONHJn9M9xZqnDVikgKGqlol6lu/mS5yJ1tMTIXE5N0KQ==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr10274476pjb.20.1600381077417;
        Thu, 17 Sep 2020 15:17:57 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id br22sm603711pjb.35.2020.09.17.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:17:56 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:17:52 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v2 1/3] block: make bio_crypt_clone() able to fail
Message-ID: <20200917221752.GA421296@google.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
 <20200916035315.34046-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035315.34046-2-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 08:53:13PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> bio_crypt_clone() assumes its gfp_mask argument always includes
> __GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.
> 
> However, bio_crypt_clone() might be called with GFP_ATOMIC via
> setup_clone() in drivers/md/dm-rq.c, or with GFP_NOWAIT via
> kcryptd_io_read() in drivers/md/dm-crypt.c.
> 
> Neither case is currently reachable with a bio that actually has an
> encryption context.  However, it's fragile to rely on this.  Just make
> bio_crypt_clone() able to fail, analogous to bio_integrity_clone().
> 
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/bio.c                | 20 +++++++++-----------
>  block/blk-crypto.c         |  5 ++++-
>  block/bounce.c             | 19 +++++++++----------
>  drivers/md/dm.c            |  7 ++++---
>  include/linux/blk-crypto.h | 20 ++++++++++++++++----
>  5 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a9931f23d9332..b42e046b12eb3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -713,20 +713,18 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
>  
>  	__bio_clone_fast(b, bio);
>  
> -	bio_crypt_clone(b, bio, gfp_mask);
> +	if (bio_crypt_clone(b, bio, gfp_mask) < 0)
> +		goto err_put;
>  
> -	if (bio_integrity(bio)) {
> -		int ret;
> -
> -		ret = bio_integrity_clone(b, bio, gfp_mask);
> -
> -		if (ret < 0) {
> -			bio_put(b);
> -			return NULL;
> -		}
> -	}
> +	if (bio_integrity(bio) &&
> +	    bio_integrity_clone(b, bio, gfp_mask) < 0)
> +		goto err_put;
>  
>  	return b;
> +
> +err_put:
> +	bio_put(b);
> +	return NULL;
>  }
>  EXPORT_SYMBOL(bio_clone_fast);
>  
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 2d5e60023b08b..a3f27a19067c9 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -95,10 +95,13 @@ void __bio_crypt_free_ctx(struct bio *bio)
>  	bio->bi_crypt_context = NULL;
>  }
>  
> -void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
> +int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
>  {
>  	dst->bi_crypt_context = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +	if (!dst->bi_crypt_context)
> +		return -ENOMEM;
>  	*dst->bi_crypt_context = *src->bi_crypt_context;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(__bio_crypt_clone);
>  
> diff --git a/block/bounce.c b/block/bounce.c
> index 431be88a02405..162a6eee89996 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -267,22 +267,21 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
>  		break;
>  	}
>  
> -	bio_crypt_clone(bio, bio_src, gfp_mask);
> +	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0)
> +		goto err_put;
>  
> -	if (bio_integrity(bio_src)) {
> -		int ret;
> -
> -		ret = bio_integrity_clone(bio, bio_src, gfp_mask);
> -		if (ret < 0) {
> -			bio_put(bio);
> -			return NULL;
> -		}
> -	}
> +	if (bio_integrity(bio_src) &&
> +	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0)
> +		goto err_put;
>  
>  	bio_clone_blkg_association(bio, bio_src);
>  	blkcg_bio_issue_init(bio);
>  
>  	return bio;
> +
> +err_put:
> +	bio_put(bio);
> +	return NULL;
>  }
>  
>  static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3dedd9cc4fb65..5487c3ff74b51 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1326,14 +1326,15 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
>  		     sector_t sector, unsigned len)
>  {
>  	struct bio *clone = &tio->clone;
> +	int r;
>  
>  	__bio_clone_fast(clone, bio);
>  
> -	bio_crypt_clone(clone, bio, GFP_NOIO);
> +	r = bio_crypt_clone(clone, bio, GFP_NOIO);
> +	if (r < 0)
> +		return r;
>  
>  	if (bio_integrity(bio)) {
> -		int r;
> -
>  		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
>  			     !dm_target_passes_integrity(tio->ti->type))) {
>  			DMWARN("%s: the target %s doesn't support integrity data.",
> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
> index e82342907f2b1..69b24fe92cbf1 100644
> --- a/include/linux/blk-crypto.h
> +++ b/include/linux/blk-crypto.h
> @@ -112,12 +112,24 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
>  
>  #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
>  
> -void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
> -static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
> -				   gfp_t gfp_mask)
> +int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
> +/**
> + * bio_crypt_clone - clone bio encryption context
> + * @dst: destination bio
> + * @src: source bio
> + * @gfp_mask: memory allocation flags
> + *
> + * If @src has an encryption context, clone it to @dst.
> + *
> + * Return: 0 on success, -ENOMEM if out of memory.  -ENOMEM is only possible if
> + *	   @gfp_mask doesn't include %__GFP_DIRECT_RECLAIM.
> + */
> +static inline int bio_crypt_clone(struct bio *dst, struct bio *src,
> +				  gfp_t gfp_mask)
>  {
>  	if (bio_has_crypt_ctx(src))
> -		__bio_crypt_clone(dst, src, gfp_mask);
> +		return __bio_crypt_clone(dst, src, gfp_mask);
> +	return 0;
>  }
>  
>  #endif /* __LINUX_BLK_CRYPTO_H */
Looks good to me :). Please feel free to add

Reviewed-by: Satya Tangirala <satyat@google.com>

> -- 
> 2.28.0
> 
