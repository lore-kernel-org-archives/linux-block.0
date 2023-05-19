Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFEC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 19:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjESTig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjESTif (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 15:38:35 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B93F7
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:38:34 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-51b33c72686so2496956a12.1
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684525114; x=1687117114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y7YSUEnrjEt3BX0ZrJXNknVjVCA266WB1ET7lLuq3s=;
        b=fgJLHQlJzCCoEts7iF3aKrlHmTdw4iw5toCVEwHs52P5Ja6Og8YtHWzXXUqMFnWx8e
         FSqBWqPluWWMwmOEmLJZL8HkX3Flnh6H71sdzN6p//K8mDSbY/lAloNDM7ZSgnUZmvSg
         ao6bFPzEx4ZRlv51g0hDE2b6gXusxIk72tAzOfUVBS7YXHMI3BD5TvZ2yeQkD3FfnEGQ
         pZJ/Rq3ZQxyxvgtOFRzBiaGcytHzNhQoUKOZKBFvcyQMfmokTa2xciiNG0t7GlZrLyvq
         nW56rGY0mckB+Zn98bw6ohC3r49SeDIrqfoDk+5QKi4cRD8iz8SqD5bKwwOiSAR2wwWh
         xz5A==
X-Gm-Message-State: AC+VfDyTxcQfNT60KbxNEsmkgrv4fc46Z/sx9YISuz4RPsGvPOShGzR/
        PtSCwtnVW3xlBaTrPjCA+pIlJ27fI/s=
X-Google-Smtp-Source: ACHHUZ6FB9PxDXV7LYrUR3x0lK1U1LwnnbDd5arjV6XWICv/ga8l0JbjI7rlSvWx+rNLo1nwV6CK/g==
X-Received: by 2002:a17:902:c40b:b0:1a9:9d00:8c92 with SMTP id k11-20020a170902c40b00b001a99d008c92mr4315002plk.42.1684525114175;
        Fri, 19 May 2023 12:38:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902c18600b001addf547a6esm24508pld.17.2023.05.19.12.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:38:33 -0700 (PDT)
Message-ID: <5641e563-6873-4b7a-eda2-58f56b498020@acm.org>
Date:   Fri, 19 May 2023 12:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] blk-mq: reflow blk_insert_flush
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230519044050.107790-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 21:40, Christoph Hellwig wrote:
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index ed37d272f787eb..d8144f1f6fb12f 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -402,6 +402,9 @@ void blk_insert_flush(struct request *rq)
>   	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
>   	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>   
> +	/* FLUSH/FUA request must never be merged */
> +	WARN_ON_ONCE(rq->bio != rq->biotail);

request -> requests?

> -	/*
> -	 * If there's data but flush is not necessary, the request can be
> -	 * processed directly without going through flush machinery.  Queue
> -	 * for normal execution.
> -	 */
> -	if ((policy & REQ_FSEQ_DATA) &&
> -	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> +	case REQ_FSEQ_DATA:
> +		/*
> +		 * If there's data, but no flush is necessary, the request can
> +		 * be processed directly without going through flush machinery.
> +		 * Queue for normal execution.
> +		 */

there's -> there is. "there's" is a contraction of "there has". See also
https://dictionary.cambridge.org/dictionary/english/there-s.

Otherwise this patch looks good to me. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
