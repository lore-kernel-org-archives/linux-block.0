Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D7C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 18:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjESSyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESSyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 14:54:43 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F308F3
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 11:54:42 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso1279474b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 11:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684522482; x=1687114482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9d7L2JNyXjSuGKUhELCRjZsa2u7rwmhhBEJ/pX8vKY=;
        b=W84rez4C8oucpHcp2zXYWN43n2HPeabDSf66p43vVMuiUj5jGjo3TGWKG1ng1Ga91d
         ua+59QSEEtb44rrKfYlr3p5LOr4b11BwEEpoqiYfIrkqw/IBhlJE6JS53Z1q7sYAfy6M
         uSXHQoczg4/+Y5EflTj52elWW1vXYPTAgYddzOpStiOo86z8yRF4n8VccDj2Qffo+V0J
         VE6xuL5pF7zIUe4UIAUAn/vXrJtBbGBbR8FThaWqyV2gfd31CV8tsNt9KqLo7o2scNCR
         MU6xj4R6JXKJzoOvbRueLQmPquOatBbHaQLWse47LmOYFCWJEW7V9Jzn1oYshlyyzQhC
         9ihQ==
X-Gm-Message-State: AC+VfDwEb9c5tTeT1VQZ/I4E2XQLRaldYLDiKRTqj9pfAcQLfApAFczB
        pUS8DY0/vOWJkasR0eRCkIJqYeDa770=
X-Google-Smtp-Source: ACHHUZ7DzzESG4ewp2EhXQgcMIGFPD/Evussw7fZgSaXbAiUMBY6oT6+anjhCpKGKGStfI/hZIlXVg==
X-Received: by 2002:a05:6a00:2183:b0:647:1cb7:b714 with SMTP id h3-20020a056a00218300b006471cb7b714mr3932622pfi.3.1684522481883;
        Fri, 19 May 2023 11:54:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b006460751222asm46013pfi.38.2023.05.19.11.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 11:54:37 -0700 (PDT)
Message-ID: <5d7a04dc-5616-182a-fd28-a269f4c8ee48@acm.org>
Date:   Fri, 19 May 2023 11:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] blk-mq: factor out a blk_rq_init_flush helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230519044050.107790-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 21:40, Christoph Hellwig wrote:
> Factor out a helper from blk_insert_flush that initializes the flush
> machine related fields in struct request, and don't bother with the
> full memset as there's just a few fields to initialize, and all but
> one already have explicit initializers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-flush.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 04698ed9bcd4a9..ed37d272f787eb 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -376,6 +376,15 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
>   	return RQ_END_IO_NONE;
>   }
>   
> +static void blk_rq_init_flush(struct request *rq)
> +{
> +	rq->flush.seq = 0;
> +	INIT_LIST_HEAD(&rq->flush.list);
> +	rq->rq_flags |= RQF_FLUSH_SEQ;
> +	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
> +	rq->end_io = mq_flush_data_end_io;
> +}
> +
>   /**
>    * blk_insert_flush - insert a new PREFLUSH/FUA request
>    * @rq: request to insert
> @@ -437,13 +446,7 @@ void blk_insert_flush(struct request *rq)
>   	 * @rq should go through flush machinery.  Mark it part of flush
>   	 * sequence and submit for further processing.
>   	 */
> -	memset(&rq->flush, 0, sizeof(rq->flush));
> -	INIT_LIST_HEAD(&rq->flush.list);
> -	rq->rq_flags |= RQF_FLUSH_SEQ;
> -	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
> -
> -	rq->end_io = mq_flush_data_end_io;
> -
> +	blk_rq_init_flush(rq);
>   	spin_lock_irq(&fq->mq_flush_lock);
>   	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
>   	spin_unlock_irq(&fq->mq_flush_lock);

Although I'm not sure it's useful to keep the "/* Usually NULL */" comment:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
