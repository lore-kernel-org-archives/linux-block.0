Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E6EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 04:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104EA225A9
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 04:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhAKEp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 23:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbhAKEp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 23:45:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9657C061794
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:45:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g185so13772367wmf.3
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wFOQhYf4KY0iQ0wXgWJplDGuOa9qNeREhz6BlaWfJAw=;
        b=chKI19xMHmt1QEO4mHjzAkDO+8EcutUJBmQsQqdUJrGeUjm1SccGY2VtnpsRGyenFx
         TpzEPTm7KpkCwL1fwQHS4vwxkbL1L3GDHs0ejILnCXqmlJ4siDQ9eMxY2AFJVHPO0CqK
         2FKFb7BPiuVGPASMoGVO9ZGJxaCN/CXLcXb2Vk8yRL7+6Ca7HvfRtU3MqyJkGl+nrQOa
         i1OjLdA2o1QGEPsaIsm3FVVC/2u54cW7k7Je7n6NfhN9u56dM73/TnKM/JImzrj7PzC6
         LAWn6e0YBNI/tdyQ2i5442tu9gTPhicI4i6yKMjMM+2nYBnKlPGrwEWkQvIsWNnPBl4I
         bVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wFOQhYf4KY0iQ0wXgWJplDGuOa9qNeREhz6BlaWfJAw=;
        b=AMsuTQtvGMKFNmhjweTCPlsKRV+4yFAzlU7EDSTaIqGIJNDiSnlfXdtkEr9RlGce1j
         /iSRY7tT06SrQLeMmQe+sECClrEnujn3noLqRG5lidH3oL7KN7A6W4pcDERboitQ3fEp
         8ZWHXlJFjqT9NKC+62Jp8GU6FRM7bXZh2rJXfoEZYBOnawu2UH56KwjkzfkGQAAH7wdD
         ejOGnCuTLgxEU1I+93AJBn9b2sXa5tJTjeWg4Q2y3R/5QaOPRIdvQqFEznD0PZbq8S4l
         k7uqb3mswXRYVgk4pwAOGbX6ACLttog48vSueFbfBVwL5JkZoaZWY1+wSXXPyT1/l8nW
         y+2Q==
X-Gm-Message-State: AOAM532t0Y1BG7UXhleFF9xc0FjrWp7tcBxDizXdQkCNlczDNCk3wOmI
        njimvpgGKCARz5OK5zhevVZAqs52eh4=
X-Google-Smtp-Source: ABdhPJzUrkBb8HnejGY/T738mYFuemjsfNGQB46siXNXqTus3C8GYsmNqu1TETa11M4qvCnJB4ugHA==
X-Received: by 2002:a1c:6208:: with SMTP id w8mr12955082wmb.96.1610340314783;
        Sun, 10 Jan 2021 20:45:14 -0800 (PST)
Received: from [192.168.8.119] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id k18sm26071171wrd.45.2021.01.10.20.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 20:45:14 -0800 (PST)
Subject: Re: [PATCH V3 3/6] block: don't allocate inline bvecs if this bioset
 needn't bvecs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-4-ming.lei@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <269c3677-88c2-9e3a-45d2-438edd03a82b@gmail.com>
Date:   Mon, 11 Jan 2021 04:41:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/01/2021 03:05, Ming Lei wrote:
> The inline bvecs won't be used if user needn't bvecs by not passing
> BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Tested-by: Pavel Begunkov <asml.silence@gmail.com>

> ---
>  block/bio.c         | 7 +++++--
>  include/linux/bio.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index cfa0e9db30e0..496aa5938f79 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -89,8 +89,7 @@ static struct bio_slab *create_bio_slab(unsigned int size)
>  
>  static inline unsigned int bs_bio_slab_size(struct bio_set *bs)
>  {
> -	return bs->front_pad + sizeof(struct bio) +
> -		BIO_INLINE_VECS * sizeof(struct bio_vec);
> +	return bs->front_pad + sizeof(struct bio) + bs->back_pad;
>  }
>  
>  static struct kmem_cache *bio_find_or_create_slab(struct bio_set *bs)
> @@ -1572,6 +1571,10 @@ int bioset_init(struct bio_set *bs,
>  		int flags)
>  {
>  	bs->front_pad = front_pad;
> +	if (flags & BIOSET_NEED_BVECS)
> +		bs->back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
> +	else
> +		bs->back_pad = 0;
>  
>  	spin_lock_init(&bs->rescue_lock);
>  	bio_list_init(&bs->rescue_list);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1edda614f7ce..f606eb1e556f 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -703,6 +703,7 @@ struct bio_set {
>  	mempool_t bvec_integrity_pool;
>  #endif
>  
> +	unsigned int back_pad;
>  	/*
>  	 * Deadlock avoidance for stacking block drivers: see comments in
>  	 * bio_alloc_bioset() for details
> 

-- 
Pavel Begunkov
