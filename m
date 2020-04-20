Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED7C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0912145D
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgDTUq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:46:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42355 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTUq7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 16:46:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id r20so5515457pfh.9
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 13:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eQohlX0OYNZHawhnjaYzAIgH1sXX/J3pNqJjSFtRE4k=;
        b=Fg7dkIIHF+/reaSpU5pyCkERevNyHaZKoXALWFfe0+3RqUN4m4qaIDBd7nPilwoyUC
         yYqKbI6GfOHu5qsx8fxZmrsnysogZKLyuSYAGpbahbwh+Qs5kr9wgujOqG6B7q1j7v7W
         lpE8mhP0tFib01BC9PtX/amAWevEW627oE0I68NkTLvIiy9onzLw1IqzxCUqnBZUIqAN
         g3TErS8ZY+MtcNWSTVtmcz40iythQRZeGHF20k5wZ8BDY2lw9+ju1ED+AkZ4JMd64C7n
         m+GOJAR2Txm5vv47X2o+XJcpzFcGi9VeRx2zTfz+wxdNpwVWBqB0v1nyUKMbrIRa/c+E
         zyTQ==
X-Gm-Message-State: AGi0PubV4uz/qHK0DnTOQQO6P1h3IwUIFzp14jA6LHQttyVOAijngFrW
        6zzc12i1oGtpww3pDaAiU4I=
X-Google-Smtp-Source: APiQypJttaJvt2PlIJt9gt0NP4SUA7P2tiqS8glI9l44PPms0BiIggy8r8n0YV/qkkbteZG/Lt+G+Q==
X-Received: by 2002:aa7:8b42:: with SMTP id i2mr5899289pfd.21.1587415618178;
        Mon, 20 Apr 2020 13:46:58 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.198.105])
        by smtp.gmail.com with ESMTPSA id o7sm379883pfg.74.2020.04.20.13.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:46:57 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] block: rename __blk_mq_alloc_rq_maps
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <51ece5240eda7e9ab80be0abf784a05fba7eef1a.1586199103.git.zhangweiping@didiglobal.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3cedcf7b-ca8b-6bf2-c270-905b79dc8b69@acm.org>
Date:   Mon, 20 Apr 2020 13:46:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <51ece5240eda7e9ab80be0abf784a05fba7eef1a.1586199103.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 12:36 PM, Weiping Zhang wrote:
> rename __blk_mq_alloc_rq_maps to __blk_mq_alloc_rq_map_and_requests,
> this function allocs both map and request, make function name align
> with funtion.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>   block/blk-mq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3a482ce7ed28..5a322130aaf2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2978,7 +2978,7 @@ void blk_mq_exit_queue(struct request_queue *q)
>   	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
>   }
>   
> -static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> +static int __blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
>   {
>   	int i;
>   
> @@ -3007,7 +3007,7 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>   
>   	depth = set->queue_depth;
>   	do {
> -		err = __blk_mq_alloc_rq_maps(set);
> +		err = __blk_mq_alloc_rq_map_and_requests(set);
>   		if (!err)
>   			break;

Just like for the previous patch, I prefer not to rename 
__blk_mq_alloc_rq_maps().

Thanks,

Bart.
