Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A59C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiFNQoP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiFNQnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:43:52 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114511D0D7
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:43:49 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id u18so8222167plb.3
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uW0kqvGmwIghHETO22GYzCXx8UvgozxQRy93g86AxH4=;
        b=w8k5SLNwr+BOdW8MgPepXoRw6lCKngI7vyY9UX7soVkbr/pCFdrEUw0msBJFWkHv54
         SJMrpCGXAjGFbQcPBQMv0XwDDDLeRp5muVrDEouioOAPNA5ov89nS5Wtdy/5GL8vliDE
         bHcvImWmPgWTO5liyPADHKvAPs30MvmNv+RdmpeBpuRF9NbqqpAFrKnTy3dIOUBp/v3M
         kmg2Dhc8CU1f3JMTzQ8GFHCNOUeIx92ckNaWwDszLK+mr+qD4c3pwIq0QkL2ZG05luLT
         XRFJYaOmStq/6ihYpka/ycBBb9/jdhSG4BzkuenUX7+N8UkIjQkql0kuyOU+6YNDDu+t
         O0og==
X-Gm-Message-State: AJIora/zIy30gxLbL5ncGuespQ7+USLIN/bohOzSih3pwteOj+JCCwG+
        1KFxaUD27XCmrt64JbrAA04=
X-Google-Smtp-Source: AGRyM1vp7ypTBO/dZSaLK6pGg9ApuLVuCvu/9rEpyb8fmCDVe3fW4co2+TkczKABYMpfKR85g9F22g==
X-Received: by 2002:a17:902:ec8f:b0:167:70f6:905c with SMTP id x15-20020a170902ec8f00b0016770f6905cmr5380178plg.12.1655225028337;
        Tue, 14 Jun 2022 09:43:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709029a8600b0016378bfeb90sm7443690plp.227.2022.06.14.09.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:43:47 -0700 (PDT)
Message-ID: <02468bd8-f2b3-1d5c-01dd-c9e9d6d5b09e@acm.org>
Date:   Tue, 14 Jun 2022 09:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/6] block: open code blk_max_size_offset in
 blk_rq_get_max_sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614090934.570632-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 02:09, Christoph Hellwig wrote:
> blk_rq_get_max_sectors always uses q->limits.chunk_sectors as the
> chunk_sectors argument, and already checks for max_sectors through the
> call to blk_queue_get_max_sectors.  That means much of
> blk_max_size_offset is not needed and open coding it simplifies the code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index db2e03c8af7f4..df003ecfbd474 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -566,17 +566,18 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
>   						  sector_t offset)
>   {
>   	struct request_queue *q = rq->q;
> +	unsigned int max_sectors;
>   
>   	if (blk_rq_is_passthrough(rq))
>   		return q->limits.max_hw_sectors;
>   
> +	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
>   	if (!q->limits.chunk_sectors ||
>   	    req_op(rq) == REQ_OP_DISCARD ||
>   	    req_op(rq) == REQ_OP_SECURE_ERASE)
> -		return blk_queue_get_max_sectors(q, req_op(rq));
> -
> -	return min(blk_max_size_offset(q, offset, 0),
> -			blk_queue_get_max_sectors(q, req_op(rq)));
> +		return max_sectors;
> +	return min(max_sectors,
> +		   blk_chunk_sectors_left(offset, q->limits.chunk_sectors));
>   }

blk_set_default_limits() initializes chunk_sectors to zero and 
blk_chunk_sectors_left() triggers a division by zero if a zero is passed 
as the second argument. What am I missing?

Thanks,

Bart.
