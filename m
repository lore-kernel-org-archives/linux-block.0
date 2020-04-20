Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C6C55181
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 21:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148B520724
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 21:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTVAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:00:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33425 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgDTVAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 17:00:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay1so4413203plb.0
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 14:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3TuwdIYeeNPr2KMrN211tvdv8gH14Z/o8lNzcTRlXQ=;
        b=OqhAU5xwmcj7e5cMPhvQ3h9uUkTx9AAo/hPipShEzuBMQMUsmcpyAtUc+aAtCVnViC
         FmvR/THiBQBFSV9KSTTB/e4ceWrCZiGaJnvLC+0ExRIrqdXOAY71ecR4yiKLIkVyrybE
         1vSi9DGgzdKRzMevcT75YOO5IcKMMZ7r5RE/fQDZUuzunLdh8lOxUxSuYzjIQk7bHnOp
         ovWJLPfbJUJ9p8Dtnd+fr3eXYkTT6igCTuGvNcvEFwahaa54flt5RrCyGCjUgUiLmo/U
         keda4OUML2HV8h7n/+oUAL37haIO+lnLbfKeSBTYqjY3Q3Qn9Et2oUMEjAMNOiEwJUW4
         zKUw==
X-Gm-Message-State: AGi0PuZEOeochVOywb+FRALolJCJg1/GCQD52J59MkkTYCs3XhQgw9vh
        T9ZYhBCXNIvbTTTWG72Ziy4=
X-Google-Smtp-Source: APiQypJtYB2wywgARVOSX/hUbh3Q7c/iI5p1cwS0YvUjEfJhI/4PSdtuAn/MgGIZdwYggnZphBEarA==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr18956273plq.5.1587416446539;
        Mon, 20 Apr 2020 14:00:46 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.10])
        by smtp.gmail.com with ESMTPSA id c1sm380497pfo.152.2020.04.20.14.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:00:45 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] block: save previous hardware queue count before
 udpate
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <59933060f4b91d5cacd7b5ef1ac937b06c53b442.1586199103.git.zhangweiping@didiglobal.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ec99f5f2-b88e-bf68-3a83-93a53f250f7a@acm.org>
Date:   Mon, 20 Apr 2020 14:00:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <59933060f4b91d5cacd7b5ef1ac937b06c53b442.1586199103.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 12:37 PM, Weiping Zhang wrote:
> blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
> save old set->nr_hw_queues before call this function.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 406df9ce9b55..df243c19a158 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3342,11 +3342,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   		blk_mq_sysfs_unregister(q);
>   	}
>   
> +	prev_nr_hw_queues = set->nr_hw_queues;
>   	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
>   	    0)
>   		goto reregister;
>   
> -	prev_nr_hw_queues = set->nr_hw_queues;
>   	set->nr_hw_queues = nr_hw_queues;
>   	blk_mq_update_queue_map(set);
>   fallback:

How about adding Fixes: and Cc: stable tags? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
