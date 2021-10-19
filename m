Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A3DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A3B6103B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhJSNpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbhJSNpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:45:22 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF7C06176D
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:43:09 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n63so4958692oif.7
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AzZQlch5YerrxYqFWX2CHv+QeTpWfo+hT7bSPFsst2w=;
        b=2tnwonCnsA+9aJuS7G+JTAdy+s1eAGOLcyzs3jOuIMW1B07nl7m6RUp+9d9iP0FUUD
         UgzjE16+P+pkSY7ifRbX+zexbg543XnTHLo24BSApIJe1+qUKGOPY428F1fWppMHkEAL
         fVmpffoaZcnwdfb+vkcnU9QCdLXl1Lw9CuaPORUMpj2eY45TyVeTBH07nocB/6/FUH8S
         msbY1NzbjfxsTuAKsOO3BrqEOdS7WOtx0i/qTnDY7EOGrrD8hy5rJf5rV8tokrU4Y01k
         hpnMt97ZbZosbWjhxVj1JYXDkglfqdrAtnSX/UOvMxvv7imoLoFQlhvnXt/mJwYnScLj
         dcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AzZQlch5YerrxYqFWX2CHv+QeTpWfo+hT7bSPFsst2w=;
        b=qdCokifmSWNCha8Vyfld4kiFincBIhwhsfZqOZrRfojQxX/t9/X8mcnfVFDo1/YW4k
         HliF34W+NO75xpvwRN995tilk51y0UWTAhiWt219+4LzlRa1d6PDc3tgTKG6QxsIM/kC
         NEElZ0ul2LfyRBN5v6PJ8/HHz3BXQ0y3i9NKX2cYvppCb2rTmZvcYqkh89E7ob+ypr8Q
         p5ggXVr81969wjs8frll2CLMl8vUAHk1HboW+ghpEyKfGKFt1evN93L5VZ96EJjukxqM
         7+0UT/NyqnFUQPCnz1rC9pgpR+f4y6rPnXpl7ptqob6JvFpnb4QrMWno6xJv2CLfvS9N
         RSyg==
X-Gm-Message-State: AOAM532+XfQkNd6D1FBKPCQFDcDUx80djHpc5g5hn/RikjZWxVQsj+9Q
        aM5Te4f3eQ3i/PwsLDiazSmmXRC4U156sQ==
X-Google-Smtp-Source: ABdhPJxxMlxFK4L3gHMIgO6tAJ3FEuVru6XvwjL+fJXGju0ulilC8bKeWShWgZ59hyHnP4xdS4+qmQ==
X-Received: by 2002:a54:4f82:: with SMTP id g2mr4036186oiy.134.1634650986597;
        Tue, 19 Oct 2021 06:43:06 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i205sm3734165oih.54.2021.10.19.06.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 06:43:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: remove the RQF_ELVPRIV check in
 blk_mq_free_request
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211019133944.2500822-1-hch@lst.de>
 <20211019133944.2500822-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6393ab57-3a9a-e5ee-6428-c1a4f0bee1f6@kernel.dk>
Date:   Tue, 19 Oct 2021 07:43:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019133944.2500822-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 7:39 AM, Christoph Hellwig wrote:
> If RQF_ELVPRIV is set RQF_ELV is by definition set as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 428e0e0fd5504..34392c439d2a8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -580,7 +580,7 @@ void blk_mq_free_request(struct request *rq)
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
> -	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
> +	if (rq->rq_flags & RQF_ELV) {

Actually just fixed a bug there. RQF_ELV means "we have an IO
scheduler", and RQF_ELVPRIV means that plus "we have rq private data".
The above shouldn't check RQF_ELV at all, just PRIV.


-- 
Jens Axboe

