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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49F7C43463
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 22:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD6208DB
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 22:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDdUvNwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIQWTf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 18:19:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF91C06174A
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 15:19:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so2111489pfn.8
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OYY9tIc9xfhOWrpXdHXfLce1m2xJL6GRbyCPd8OZlow=;
        b=TDdUvNwlrYpkchQrtz28+CDFMRXywYh4EJMA6ZJ0CV8S0/X+UXukvyK8rQBztjvRIW
         Ip9/nh4E5WNawXmOwcLol4EVc26ZEzIk0UdSB5gtHK++Xlud3qcGpBWw5tW1+MyQ7lPH
         QIvWEuce/lC0B3+os3Cdi62u7Qqeby8/JOy3gfdmIoZ4nFUXSpk2rNKS6kQmrfrAIHYz
         +g/eW5UehDmEzuXys2xVL9V7Xo+QWQ6U996LSn7M0xnVl+BXKwVysQr8vT7g2MhGY+JW
         cw1F4K7iNfIaKJQgBOzltdXAhnXWCe1huNOattmCMNhCnDV7Lt+ErX/X+OkDiEdA/i9L
         SI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OYY9tIc9xfhOWrpXdHXfLce1m2xJL6GRbyCPd8OZlow=;
        b=s7JdiMtZw+JC3TohwRYCJkc8ykkXf9lOoXaouwSLexMBwBiwER/rWDfdQ0mULGKitd
         p2MXrl7s10P32nX0SlRAOMKPNegjS5yYtY0xkkRk7dbeFrWaOHwH71ayyHoMDV0fB9p3
         VxTlHvkh/uxIMSD9qACmL7+f6cIZo252Kzs4wjtunsUAVq50tgx8qGftEEbWculTlK6B
         rdS19HDDDzQK6v57szJ1GowIiWKBnpJDE/EdR/OYzliT5IUTTPV1d+TbuCXcHbUDk+B4
         S7TVoAD//AJ35AJT029fbKDNJiuswECH0k+a+I9uD0RNGSZGbuKSxPSu9vY/HD33CI39
         0Ttg==
X-Gm-Message-State: AOAM531OO5x89/FeXcE12gcwa8+NV97eB1QTNnnzUMtEE0PcwilyecHy
        wuMGm4NxiGyjGb5iEMMY8JJCBQ==
X-Google-Smtp-Source: ABdhPJwalTHkX//endIf1ifjkPFrtGZZIq50ErBqLzyNrlwAewdAv9az3kJqdJS8SBSV6gXwxC0n3w==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr23535695pga.56.1600381173884;
        Thu, 17 Sep 2020 15:19:33 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id d8sm627085pgt.19.2020.09.17.15.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:19:33 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:19:29 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v2 2/3] block: make blk_crypto_rq_bio_prep() able to fail
Message-ID: <20200917221929.GB421296@google.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
 <20200916035315.34046-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035315.34046-3-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15, 2020 at 08:53:14PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> blk_crypto_rq_bio_prep() assumes its gfp_mask argument always includes
> __GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.
> 
> However, blk_crypto_rq_bio_prep() might be called with GFP_ATOMIC via
> setup_clone() in drivers/md/dm-rq.c.
> 
> This case isn't currently reachable with a bio that actually has an
> encryption context.  However, it's fragile to rely on this.  Just make
> blk_crypto_rq_bio_prep() able to fail.
> 
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Suggested-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/blk-core.c            |  8 +++++---
>  block/blk-crypto-internal.h | 21 ++++++++++++++++-----
>  block/blk-crypto.c          | 18 +++++++-----------
>  block/blk-mq.c              |  7 ++++++-
>  4 files changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ca3f0f00c9435..fbeaa49f6fe2c 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1620,8 +1620,10 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  		if (rq->bio) {
>  			rq->biotail->bi_next = bio;
>  			rq->biotail = bio;
> -		} else
> +		} else {
>  			rq->bio = rq->biotail = bio;
> +		}
> +		bio = NULL;
>  	}
>  
>  	/* Copy attributes of the original request to the clone request. */
> @@ -1634,8 +1636,8 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  	rq->nr_phys_segments = rq_src->nr_phys_segments;
>  	rq->ioprio = rq_src->ioprio;
>  
> -	if (rq->bio)
> -		blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask);
> +	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
> +		goto free_and_out;
>  
>  	return 0;
>  
> diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
> index d2b0f565d83cb..0d36aae538d7b 100644
> --- a/block/blk-crypto-internal.h
> +++ b/block/blk-crypto-internal.h
> @@ -142,13 +142,24 @@ static inline void blk_crypto_free_request(struct request *rq)
>  		__blk_crypto_free_request(rq);
>  }
>  
> -void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
> -			      gfp_t gfp_mask);
> -static inline void blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
> -					  gfp_t gfp_mask)
> +int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
> +			     gfp_t gfp_mask);
> +/**
> + * blk_crypto_rq_bio_prep - Prepare a request's crypt_ctx when its first bio
> + *			    is inserted
> + * @rq: The request to prepare
> + * @bio: The first bio being inserted into the request
> + * @gfp_mask: Memory allocation flags
> + *
> + * Return: 0 on success, -ENOMEM if out of memory.  -ENOMEM is only possible if
> + *	   @gfp_mask doesn't include %__GFP_DIRECT_RECLAIM.
> + */
> +static inline int blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
> +					 gfp_t gfp_mask)
>  {
>  	if (bio_has_crypt_ctx(bio))
> -		__blk_crypto_rq_bio_prep(rq, bio, gfp_mask);
> +		return __blk_crypto_rq_bio_prep(rq, bio, gfp_mask);
> +	return 0;
>  }
>  
>  /**
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index a3f27a19067c9..bbe7974fd74f0 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -283,20 +283,16 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
>  	return false;
>  }
>  
> -/**
> - * __blk_crypto_rq_bio_prep - Prepare a request's crypt_ctx when its first bio
> - *			      is inserted
> - *
> - * @rq: The request to prepare
> - * @bio: The first bio being inserted into the request
> - * @gfp_mask: gfp mask
> - */
> -void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
> -			      gfp_t gfp_mask)
> +int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
> +			     gfp_t gfp_mask)
>  {
> -	if (!rq->crypt_ctx)
> +	if (!rq->crypt_ctx) {
>  		rq->crypt_ctx = mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +		if (!rq->crypt_ctx)
> +			return -ENOMEM;
> +	}
>  	*rq->crypt_ctx = *bio->bi_crypt_context;
> +	return 0;
>  }
>  
>  /**
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e04b759add758..9ec0e7149ae69 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1940,13 +1940,18 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> +	int err;
> +
>  	if (bio->bi_opf & REQ_RAHEAD)
>  		rq->cmd_flags |= REQ_FAILFAST_MASK;
>  
>  	rq->__sector = bio->bi_iter.bi_sector;
>  	rq->write_hint = bio->bi_write_hint;
>  	blk_rq_bio_prep(rq, bio, nr_segs);
> -	blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
> +
> +	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
> +	err = blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
> +	WARN_ON_ONCE(err);
>  
>  	blk_account_io_start(rq);
>  }
Looks good!

Reviewed-by: Satya Tangirala <satyat@google.com>

> -- 
> 2.28.0
> 
