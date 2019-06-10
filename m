Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2CAC4321A
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA502085A
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7/xuJ5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfFJRxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:53:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40453 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388108AbfFJRxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 13:53:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so2443472pfp.7
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kd7KC6lokn7uMh2zMS2YV82fz8qcNTlqpdP++zfaG+k=;
        b=E7/xuJ5NJd+N6PFZW4MVXLZREquMtMAnJg5Cic5KNADK/AGh1ISXTHR3PrQUNXK/Uf
         ZNtdVpXq85d37PgKZJuTtA4GxwuWcvJFGly0QxbGMyCFV+C7bs7qFRrcfBn9TUH5w2ig
         cYaQ4fZOrmq/yoFpFmu2IjEuV/b6W1ewoOnoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kd7KC6lokn7uMh2zMS2YV82fz8qcNTlqpdP++zfaG+k=;
        b=d3c3sxy8+poHKGcncxkd53GXnWIovFGSX3VyJo44wyiW5tFYxkrh25iP/Y02OpnTji
         Y1UGYMZeV41LJaAJSdsb2ySXKX++ssMEdHD9gLQ4w+/f48VShU/U4HAWekdSYNi9nQjK
         5V4sdI7ZYKfZDfXO/hNRvH7uEP1pf5Bo62oNjdTFp9fZEOlza115K1Hwey4nZ+b6OaCM
         dMDHIImti2RzxH/ybbFgax8wMXScpuye4GCct86OQDAUMEtSfBJpTbZKxe9tnZ3pem3C
         3DdWslABn0262NgdKX6Ox+3WTkN367EBjZfmJfMs7ONvc/S8Df/Z11SB37FlqXQidcG+
         cgow==
X-Gm-Message-State: APjAAAXM4ZY9MhDNazONw3Fj6Iy4BZwaCT8z0TbAi4eMYI/QwlhW9Fdx
        ra++tmCF2H9iDLt4Zi9DS4t8PQ==
X-Google-Smtp-Source: APXvYqyJA57OHA+tYziMtzCVgYMrG2uPQmAvwAMTztzx42z95Wdcck+fmwUMoGVU+1c5K4KI7YxZjQ==
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr22096509pjb.138.1560189190198;
        Mon, 10 Jun 2019 10:53:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j22sm11347858pfh.71.2019.06.10.10.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 10:53:09 -0700 (PDT)
Date:   Mon, 10 Jun 2019 10:53:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: bio: Use struct_size() in kmalloc()
Message-ID: <201906101053.6B73D8906@keescook>
References: <20190610150412.GA8430@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610150412.GA8430@embeddedor>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 10, 2019 at 10:04:12AM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct bio_map_data {
> 	...
>         struct iovec iov[];
> };
> 
> instance = kmalloc(sizeof(sizeof(struct bio_map_data) + sizeof(struct iovec) *
>                           count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, iov, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  block/bio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 683cbb40f051..4bcdcd3f63f4 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1120,8 +1120,7 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
>  	if (data->nr_segs > UIO_MAXIOV)
>  		return NULL;
>  
> -	bmd = kmalloc(sizeof(struct bio_map_data) +
> -		       sizeof(struct iovec) * data->nr_segs, gfp_mask);
> +	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
>  	if (!bmd)
>  		return NULL;
>  	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
> -- 
> 2.21.0
> 

-- 
Kees Cook
