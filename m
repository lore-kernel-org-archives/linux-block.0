Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288ABC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E3060041
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 23:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVX32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 19:29:28 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:35405 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVX32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 19:29:28 -0400
Received: by mail-pj1-f49.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so2690090pjb.0
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 16:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HJP1fjGEg4+4J2KrnTwWfOLLiLCJhq9/BwRbe7lqBPQ=;
        b=p4kNhb7LzqoLIEILIsBxKx6qq9mfEByerE1LV442sg+sraYM0uVP++LKTzoqsgZFoS
         9VQf3qyGjxne3su9I8t6uSCXcmJc1X9GVrJoHAUfssIU7ebDVQ4O/StkMmAmkMJ4GORc
         l4og29wVa/66+EFse5eP1dFIhi/rdxVAqr87aVeDi4BvYl6yFux5zvZBGusTdOy6Ljn9
         5s43PvDbpx74QJSNJLt4GyWF8FOYJO3tWHIcXXqdjFqzugkVJAIvgROkL8zaRzBKIOtp
         TDYR6jVzAS4o6cczPYZnC+3pFykol6mIjBdluEkpg/NMG9jajcPhcgGRtL8lPZvbkTk3
         XBtw==
X-Gm-Message-State: AOAM533qU8XhiBgIkxkHjtySt5lkdb0Xzn6vS2uYwUp32KFHuofS6xnR
        UbBnA6MARFirVACNkqSuewsLqM8dPN4=
X-Google-Smtp-Source: ABdhPJx3rnM8eyBtB8iLQ3ebFbAQ+eZ+geJghq+M/b/P7iz1vWANpOgqruM3ZSSz1qJMA0fvu8bFTQ==
X-Received: by 2002:a17:902:446:b029:120:1fd:adbf with SMTP id 64-20020a1709020446b029012001fdadbfmr25002615ple.52.1624404431528;
        Tue, 22 Jun 2021 16:27:11 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c5sm3193082pjq.38.2021.06.22.16.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 16:27:11 -0700 (PDT)
Subject: Re: [PATCH 9/9] loop: allow user to set the queue depth
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20210622231952.5625-1-chaitanya.kulkarni@wdc.com>
 <20210622231952.5625-10-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d433361c-f270-f1a4-4eb2-3c1c10e7e5ec@acm.org>
Date:   Tue, 22 Jun 2021 16:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622231952.5625-10-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/21 4:19 PM, Chaitanya Kulkarni wrote:
> Instead of hardcoding queue depth allow user to set the hw queue depth
> using module parameter. Set default value to 128 to retain the existing
> behavior.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/loop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6fc3cfa87598..c0d54ffd6ef3 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1942,6 +1942,9 @@ module_param(max_loop, int, 0444);
>  MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
> +static int hw_queue_depth = 128;
> +module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
> +MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
>  
> @@ -2094,7 +2097,7 @@ static int loop_add(struct loop_device **l, int i)
>  	err = -ENOMEM;
>  	lo->tag_set.ops = &loop_mq_ops;
>  	lo->tag_set.nr_hw_queues = 1;
> -	lo->tag_set.queue_depth = 128;
> +	lo->tag_set.queue_depth = hw_queue_depth;
>  	lo->tag_set.numa_node = NUMA_NO_NODE;
>  	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
>  	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;

Is there any use case for which the performance improves by using
another queue depth than the default?

Thanks,

Bart.


