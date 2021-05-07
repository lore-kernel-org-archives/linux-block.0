Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1711C433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F674610CE
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhEGBNB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:13:01 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40645 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEGBNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:13:00 -0400
Received: by mail-pg1-f180.google.com with SMTP id y30so5982020pgl.7
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 18:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5GlhX9USqS0WbTyLMO6h0d5nXblY1YU3GTlW0bjgsg=;
        b=bakk2sUWK5GdjU48kJklp46ffnqdXKuPkuzDzxS7Hf1freAskbr4kVXAX7sjklcvCS
         B00OEKSYKM+tR9Gt8ZtRHyppu6AleQC9O69946KXlzb7wK8CHA4RyXc1WqzO/GpaNsVT
         +TUW1p9zwrrn8PlLNbfSGtBTU8g/rvR3B42LgfC1zOAk37vevASrg5xB0KSAaKkrUTw/
         lMEvSlY/86u+dEW0ccKw7NSS70C6gIP4qyNX0NorCofusz9hsGVyc8L4yBzqXIJFql2x
         g/Y6NwDJMW/CG+PTxSVnsuMcQ0ffr7/lUXXxddFfm0Ye6vtZQ09RLrORvXiJOAdUg6xo
         Mv7A==
X-Gm-Message-State: AOAM533faQI+LotTJtUhhdIE6Dm/pMvMqTmU6r1NY7dkeWy1M4ep4ifU
        yib7A2Pbc8ayRo/UdXaTqQhNn94bVgU=
X-Google-Smtp-Source: ABdhPJzCuu3q4F3Ut/xm1AKkiiq2wjRis6tFAfuD79oODq1YSs8LuH21mHzvZ4cDErZH67Ud1jEEUQ==
X-Received: by 2002:a63:9c6:: with SMTP id 189mr7116551pgj.411.1620349921420;
        Thu, 06 May 2021 18:12:01 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p1sm3119390pfp.137.2021.05.06.18.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 18:12:00 -0700 (PDT)
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <423139b7-cb64-64dd-08f0-86f5b2681e70@acm.org>
Date:   Thu, 6 May 2021 18:11:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505145855.174127-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/5/21 7:58 AM, Ming Lei wrote:
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 4a40d409f5dd..8b239dcce85f 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -203,9 +203,14 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>   		unsigned int bitnr)
>   {
>   	struct request *rq = tags->rqs[bitnr];
> +	unsigned long flags;
>   
> -	if (!rq || !refcount_inc_not_zero(&rq->ref))
> +	spin_lock_irqsave(&tags->lock, flags);
> +	if (!rq || !refcount_inc_not_zero(&rq->ref)) {
> +		spin_unlock_irqrestore(&tags->lock, flags);
>   		return NULL;
> +	}
> +	spin_unlock_irqrestore(&tags->lock, flags);
>   	return rq;
>   }

Shouldn't the 'rq = tags->rqs[bitnr]' assignment be protected by 
tags->lock too? Otherwise a request pointer could be read before the 
request pointer clearing happens and the refcount_inc_not_zero() call 
could happen after the request clearing.

Thanks,

Bart.
