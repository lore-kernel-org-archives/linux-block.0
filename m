Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAF3C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 04:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8152220645
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 04:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WCa5BcKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeLNE1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:27:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45804 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNE1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 23:27:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so2170837pfd.12
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 20:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RS8qYg/syg9O8QIkNGtp4nGUe0Uv/F1tDnJZTZS7wew=;
        b=WCa5BcKRYE0I+I1GqynZSFqofauz75gKt1zoZSzZQcIPgK/4xFBDPwWZWPJBC25GBf
         K5QXVueYdjgmlpmy50o5qcfsadHPOD0qi/6ZPIkEmv2ZXQlMFzQkRYf3iy1I2f7t9DdT
         pra4okf3H134zvrlqmcmvYu2wGlfcIrQ4HN0wIoaF1ZxcXfrmCXk/Lknr+oxAgGROxqa
         ORHGs0DQrBLEhmyiDS1nxCbw2G1hRj9PCzEztuAw4HYMai+ERCA2O18lcbi8zMw7QQ9W
         8cCedoM0FvlWSD7NuI97eC7vZTgtOF1Wa0/DsGiGdrpDWjFAYV6JhsPF9AFvLKMz214f
         9Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RS8qYg/syg9O8QIkNGtp4nGUe0Uv/F1tDnJZTZS7wew=;
        b=TqrkbILsCRA0Hw1+ztEGnybdPeEUHnTd6JwzTeuF3LUYZnSlN6U7rfeLFYLzFFi0sD
         dgFYICWDxIveBDP44/5isYRpnWZb3l7g2UZcAnlUD+fHHklamJbLpQsVgM8GjExc3Wqw
         KpiCStrGXY4C7qCcT4ZAzFUKwQZ3iVuJct943c0yrBxglPgfEao52q26f3qZ6g+/3Cum
         +DnZBGr22MeI5MHYp7kIJ1mRvc9iGCu5+vFC9mTRC1JOOjIvE3rkXoeYbqdiFoeXICY4
         J+NcGtYe9rXn3O6rJmri/6rjPeyA7SOyCjqT2JNYgC03P2RBP7yw+X3s/7pv5mXRHrW9
         QfPQ==
X-Gm-Message-State: AA+aEWYPvZ6DZyXt9Ee5E31+lkbi2ZkN+Zlf7eZBv/Cq1mYoAhqE0xTw
        E/OF+dzCOrNLJGXNEbY4MA9KjLF5k4Ll1g==
X-Google-Smtp-Source: AFSGD/UjVKyvE3NPFazJuydmnzVyuILs4DsKNTPMjl6E8dbLhz05tcrrusowrHeQEIf24sgTjkA7GA==
X-Received: by 2002:a62:a99:: with SMTP id 25mr1416796pfk.121.1544761667112;
        Thu, 13 Dec 2018 20:27:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b9sm4018627pfi.118.2018.12.13.20.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:27:46 -0800 (PST)
Subject: Re: [PATCH 2/7] block: remove the bio_phys_segments export
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20181213203214.10650-1-hch@lst.de>
 <20181213203214.10650-3-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05823f50-2678-2a05-4cfa-b1c0640cbd7a@kernel.dk>
Date:   Thu, 13 Dec 2018 21:27:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213203214.10650-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 1:32 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c       | 3 +--
>  block/blk-merge.c | 6 +++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 036e3f0cc736..fa1ea2ac66a8 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -571,14 +571,13 @@ void bio_put(struct bio *bio)
>  }
>  EXPORT_SYMBOL(bio_put);
>  
> -inline int bio_phys_segments(struct request_queue *q, struct bio *bio)
> +int bio_phys_segments(struct request_queue *q, struct bio *bio)
>  {
>  	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
>  		blk_recount_segments(q, bio);
>  
>  	return bio->bi_phys_segments;
>  }
> -EXPORT_SYMBOL(bio_phys_segments);
>  
>  /**
>   * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 09591daf4993..62e97ec92034 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -264,7 +264,11 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
>  	}
>  
>  	/* physical segments can be figured out during splitting */
> -	res = split ? split : *bio;
> +	if (split) {
> +		res = split;
> +	} else {
> +		res = *bio;
> +	}
>  	res->bi_phys_segments = nsegs;
>  	bio_set_flag(res, BIO_SEG_VALID);

Unrelated hunk in this patch.

-- 
Jens Axboe

