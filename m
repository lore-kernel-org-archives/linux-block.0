Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F349C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FB020857
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 20:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDTU67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:58:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33979 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgDTU66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so1265171pfa.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 13:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IaOm+yazAl+CmRLl8xTFF//t/h24nlmxenrFqAq46WU=;
        b=hT7ybaO8tWj6HbQFx8a3VMiF+Yacqk1WwCuTKRRZ52N6r7l/XbDvT7ACq+QO0AaChV
         mY1ITixoFX9ae8cagCUJ0im8g4x6E9kRNApkjJuRDVDHuQDIC18IfxIDp4ZmiAhFXn8Z
         ajkQ9EAUIzYFkZeFcK18mGs1ctQ+IMfvCkoLjD0x+0xD9Asph2qSoGKaNKEFW1AvRdbf
         2EJ4y0j7RFXA7eavWIeT7glnAH2xJxEkY79+9Tp7DZ3ToOrB5a5Vod0ak5d3gCRwMdiM
         238F5B9yXiJ+hdX6RMnoW8qxcvdn93fR6NGnvlPzhGFWcY6UiwJkGNb8zE68gej8dAiW
         /ibw==
X-Gm-Message-State: AGi0PubwUvffEiN24GACoHT+TBeFPEMKoJ5Vilxv2DP085/4a0lIoLu/
        Jbd9qDhSTcOqjDkrlMJfppFsxGai
X-Google-Smtp-Source: APiQypKJotsjtr4qo1+rviT4LbUQYm8ipEy5N7DtkzdVoimljEjKYU3X5N3LiG7DOp3dw1IjilK2ag==
X-Received: by 2002:a63:de4b:: with SMTP id y11mr3583502pgi.23.1587416337466;
        Mon, 20 Apr 2020 13:58:57 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.10])
        by smtp.gmail.com with ESMTPSA id q145sm386808pfq.105.2020.04.20.13.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 13:58:56 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] block: free both map and request
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <e6368cfce3dca5238e8546e5624bbcab17824083.1586199103.git.zhangweiping@didiglobal.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <69f621d2-2e88-e920-813f-cba97dbe3cd3@acm.org>
Date:   Mon, 20 Apr 2020 13:58:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e6368cfce3dca5238e8546e5624bbcab17824083.1586199103.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 12:36 PM, Weiping Zhang wrote:
> For this error handle, it should free both map and request,
> otherwise memleak occur.
             ^^^^^^^
Please expand this into "a memory leak".

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4692e8232699..406df9ce9b55 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2990,7 +2990,7 @@ static int __blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
>   
>   out_unwind:
>   	while (--i >= 0)
> -		blk_mq_free_rq_map(set->tags[i]);
> +		blk_mq_free_map_and_requests(set, i);
>   
>   	return -ENOMEM;
>   }

The current upstream implementation is as follows:

static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
{
	int i;

	for (i = 0; i < set->nr_hw_queues; i++)
		if (!__blk_mq_alloc_rq_map(set, i))
			goto out_unwind;

	return 0;

out_unwind:
	while (--i >= 0)
		blk_mq_free_rq_map(set->tags[i]);

	return -ENOMEM;
}

The pointers to the memory allocated by __blk_mq_alloc_rq_map() are 
stored in set->tags[i] and set->tags[i]->static_rqs. 
blk_mq_free_rq_map() frees set->tags[i]->static_rqs and set->tags[i]. In 
other words, I don't see which memory is leaked. What did I miss?

Thanks,

Bart.
