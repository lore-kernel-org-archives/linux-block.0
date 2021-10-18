Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD09C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56A961002
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhJRKvR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhJRKvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:51:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA4AC061714
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:49:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d9so69058598edh.5
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ko3Q1u+AAtYGLyC9ZVPqCPC+URUQQf05TygFrEddakA=;
        b=f9PafyYD7eNYGQwAHLesEzk9kScpeXlxZY++VTVKQp/N1s7IpNgqc79hZc1xRlcl+D
         i7iGukPDkDkVAglGl2SirCh8TN67sP4dJ3PAFXfXlcetPbmiEICE5ILrXUEbL8KYL/4s
         F/YvT+GsfGsMdKpa3HWm6Ar66aT+FH7ZTxIrMnLCy3fYKX/PlDmfdLbs36oqXOKZy0ow
         K3TNhkzZ3quHVc5lF69kfgqYjIjIVy4DPDpgBYIPD0NuwLCm0ailqELTFRZSH1Ts7wuf
         UTmO2cMWYU6JJkgMYlL+7+RCYVQzJIOfHSjYmixLefje4p8k1FLWuBDeNW9wpIgtdgds
         Uz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ko3Q1u+AAtYGLyC9ZVPqCPC+URUQQf05TygFrEddakA=;
        b=RxU/m/KaUu1vv56AvplPOkn68TBSpbvVdi3nyUPZq78TN9QSAnTmj8Tp6d/hFR3hIb
         DD6gt4gEJyBiRGJ4TFYlevJ4rkhj1d/pxpxSPBy9f82eRwi5njUEuqnRchc9umI8ZsyH
         bvahyOlhT2dtVT+LxJ78/TC1GfJ0O5MBm+VakK2KNfLmBINg7lK9OtqBqZ63yt/RCeZz
         +I6lRrJJowlh74NBEN+22XAEjqM25YDe+SQ+ldPq0aHAz3SgemuqSFXxxoC0AUGzty/a
         03veSQgcsj3Lbsu4fRXvh9hiVNXjWGgrMltvZqu1ARodK8i9qhGZZAQdVY6jdXKMqQhP
         vsGw==
X-Gm-Message-State: AOAM532vwKsFeyn00OSGREc0sGdaAB6u12RB+7D2VUECMuB7YGbysuoS
        i1lpWC2r8qcfNp/lHQk5pJo=
X-Google-Smtp-Source: ABdhPJzTmerKZGJccoWVrp++dYffrbIBjZHp8v9gTKTVNvZuUWL99lRonIRuF4vKaKSVOMimdxHHVw==
X-Received: by 2002:aa7:da51:: with SMTP id w17mr22918044eds.289.1634554139963;
        Mon, 18 Oct 2021 03:48:59 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.145.195])
        by smtp.gmail.com with ESMTPSA id c26sm3596697edx.2.2021.10.18.03.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:48:59 -0700 (PDT)
Message-ID: <0459e3f7-019f-3d7c-d502-f46b9ba52d9b@gmail.com>
Date:   Mon, 18 Oct 2021 10:49:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/14] block: don't call blk_status_to_errno() for success
 status
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-6-axboe@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20211017013748.76461-6-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 01:37, Jens Axboe wrote:
> We only need to call it to resolve the blk_status_t -> errno mapping
> if the status is different than BLK_STS_OK. Check that it is before
> doing so.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ffccc5f0f66a..fa5b12200404 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -676,9 +676,11 @@ static void blk_account_io_completion(struct request *req, unsigned int bytes)
>   bool blk_update_request(struct request *req, blk_status_t error,
>   		unsigned int nr_bytes)
>   {
> -	int total_bytes;
> +	int total_bytes, blk_errno = 0;
>   
> -	trace_block_rq_complete(req, blk_status_to_errno(error), nr_bytes);
> +	if (unlikely(error != BLK_STS_OK))
> +		blk_errno = blk_status_to_errno(error);
> +	trace_block_rq_complete(req, blk_errno, nr_bytes);

Last time I checked relevant asm, the inference of arguments was done
under the trace branch, so no extra work if tracing is not active.


>   
>   	if (!req->bio)
>   		return false;
> 

-- 
Pavel Begunkov
