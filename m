Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A264C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 06:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F95120826
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 06:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtZCvMuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBG0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBG0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 02:26:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110BC061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 23:26:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a8so1815402plm.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ghKR0bKSUaxyBZ/reA4qd6Uz+YXDX8wUaiY2amtCN4=;
        b=AtZCvMufKcTfeMP0WxBIdDvRUBeIZZqQnkG1p/th8aae4J+8axQJA4K5lYJte9XJvF
         BKIahmU4AblE2Lhf9c6nfzNMr5InDMdJZHPpMVrny5gSiy7h67Ezc6pS+vg3mzwgeiMu
         Ock4qn2dy5ZThq2sVdaWatrJukbXH3lVhtP3GljLoqV3nipclKXNDpRLuUFvdW3kxkMi
         gqnYVqX46wHLuxRhZ+YId0buicvu6+X28NwbeJqkaqz8j+oX6D/ULT9e5r+wwqkiXVce
         xoFlpN8LYRX+i+vBWN8YW5swPECiz3Yrrs3M9xvQxhj2Apj1BSg+xYIlvwcoJMxB6oKv
         lI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ghKR0bKSUaxyBZ/reA4qd6Uz+YXDX8wUaiY2amtCN4=;
        b=TCossKYdBY7+5yt20hiHbtm/xg+zeqwd6eM1ikW7inIrJ1koeEiMbiinBC9i1J6/6A
         OFL90D00ADeKmZVRM+DQWeQ7HsoQN65TQ+KgtO1wYG4IDThq1NF1k1jKAzGFmoG6x588
         WyvC2gZeZAa8Kll2pEPiFZqKky3bqRVPTCf6ANMvFCM3B+fgVsCKlMwHQSbmoiUFjo15
         8FujVCinyMHg+wcTHa8Zv+DjqzaIfbU/X0t68mvE7NRjepOVJSc+IwNgQiix+4IGFhvt
         +6X3T9cGyvTLWv9XAWSJmk7a2hdiYR31nRwwPD8P/vjum00ZI361KsOs7zKOg6dx0thz
         F6/A==
X-Gm-Message-State: AOAM530PYiwB0ESTSAahsI28b/UqJYDTPtJmW3vaMs22YLIgnfHz9e2Z
        YUyovwrqXJTT1YrG3sdrj2fa8Nm/yZwGIQ==
X-Google-Smtp-Source: ABdhPJzKRfDeOttYBcg6Nqboz8UD2SSkQ5sqdCJcZvdvy4UNbTupAdWYKD0Z1o8SVbObAYMoFeATQA==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr861150pls.10.1599027960143;
        Tue, 01 Sep 2020 23:26:00 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id q190sm4125939pfc.176.2020.09.01.23.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:25:59 -0700 (PDT)
Date:   Wed, 2 Sep 2020 06:25:55 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] block: make bio_crypt_clone() return an error code
Message-ID: <20200902062555.GA2575283@google.com>
References: <20200902051511.79821-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902051511.79821-1-ebiggers@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 01, 2020 at 10:15:11PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Callers of bio_clone_fast() may use a gfp_mask that excludes
> GFP_DIRECT_RECLAIM.  For example, map_request() uses GFP_ATOMIC.
> 
> If this were to happen, the mempool_alloc() in __bio_crypt_clone() can
> fail, causing a NULL dereference.
The call to blk_crypto_rq_bio_prep() from blk_rq_prep_clone() could also
fail for the same reason. So we may need to make blk_crypto_rq_bio_prep()
also return a bool and handle the errors in the callers (the only other
caller is I think blk_mq_bio_to_request(), which explicitly calls the
function with GFP_NOIO, so maybe we could explicitly document the fact that
blk_mq_bio_to_request will return true when called with a gfp_mask that
includes GFP_DIRECT_RECLAIM, and ignore the return value in
blk_mq_bio_to_request()). (And maybe we should document the same for
bio_crypt_set_ctx and bio_crypt_clone?)
> 
> In reality map_request() currently never has to clone an encryption
> context, since inline encryption isn't yet supported on device-mapper
> devices at all, let alone on request-based ones.
> 
> But it is fragile to rely on this.  Just make bio_crypt_clone() able to
> fail, similar to bio_integrity_clone().
> 
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/bio.c                | 20 +++++++++-----------
>  block/blk-crypto.c         |  5 ++++-
>  block/bounce.c             | 19 +++++++++----------
>  drivers/md/dm.c            |  7 ++++---
>  include/linux/blk-crypto.h |  9 +++++----
>  5 files changed, 31 insertions(+), 29 deletions(-)
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
> index fb0255d25e4b2..e987b417d702f 100644
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
> index e82342907f2b1..d0dba84f6a608 100644
> --- a/include/linux/blk-crypto.h
> +++ b/include/linux/blk-crypto.h
> @@ -112,12 +112,13 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
>  
>  #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
>  
> -void __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
> -static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
> -				   gfp_t gfp_mask)
> +int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
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
> 
> base-commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
> -- 
> 2.28.0
> 
