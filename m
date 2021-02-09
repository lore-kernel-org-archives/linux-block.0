Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20057C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 00:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF4B64E10
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 00:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhBIAm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 19:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhBIAmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Feb 2021 19:42:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBE1C06178A
        for <linux-block@vger.kernel.org>; Mon,  8 Feb 2021 16:42:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so21399879eds.12
        for <linux-block@vger.kernel.org>; Mon, 08 Feb 2021 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yi/OsGvm9F4NGL8CsgpgANjWj0CeFOFwGfa0MH8SBbQ=;
        b=aZFukaxgh6Itq9XMTFXNvaFVakAZAE1Cn81OtQ1aEoM6cjG75x+j4N5ayzxQjtti5K
         pIC6D924rmUFP7+L/a516Qf59JXLH+7IzP2Zo+yE3J1oBJnFq0JuN8bIhufWFiQCQz9N
         xKYAjmC2u3PEKPpiZoo82lewhKaHDQd01UA3GjdC3uStXugu4wD6d70HHamKavyoyNjH
         8OPktNTmhDt/xF/ILxG63TRHRkkEklNNnzeGmw+pPT+xfcwyExwZDFpLOCO0L2l9ns//
         ssPId/EO0J9cgL9y6gVSQ4sqwxJFBB3cyNwS9+mVc+MmeWMmeeEyfqHPVv5OBDdAIgng
         CsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yi/OsGvm9F4NGL8CsgpgANjWj0CeFOFwGfa0MH8SBbQ=;
        b=XGCsL8ReM8QphcOSg+2OYFyqrA1zfNBs8p4EykuB+sxdOa3DfqzZfA0mrXUxnJd3KA
         nqZo7luSWx3PTQFicZPYkZeuEvnJzvWaJph16r/jEU1g7o5NTgVFCTYP0fxmVOy2lVNb
         mnG4rA2DyBTc4sYKZKPC9V+da4u6vXCPysWvax78oXPx3J8w4phiY/6jmJkHZXNfEvTA
         ZroqtSwoPFwzXfvCQtm3QGgAbNaPRM+cKsaFs44j67Tk16j2x2rFraUZP4iuGrB4XX8t
         /dHEfoT4PUPwH1zsi/bFZ/O8pV9BjoGF4BwQ1tYcVn+aliTXEook5yyOjgyeUg+ZAk95
         jtjA==
X-Gm-Message-State: AOAM532apkCd2SSY4ZB7zk5n1pUVW+O1nEW5dE2R2FGCo2JPZK4pn3vs
        HXa0KQSNt1iBWp47/VWa3ESmiQ==
X-Google-Smtp-Source: ABdhPJxUF4Jo5HaYG9V20Z/NUZ2WK6MEkrBEtxLiDAgKxVORCxula/ZdedexG3wTbvg/MOo/LjxF6Q==
X-Received: by 2002:a05:6402:31a3:: with SMTP id dj3mr19557589edb.172.1612831332540;
        Mon, 08 Feb 2021 16:42:12 -0800 (PST)
Received: from [0.0.0.0] ([2001:1438:4010:2540:8ad:59ed:fe2a:9dd9])
        by smtp.gmail.com with ESMTPSA id u18sm9747207ejc.76.2021.02.08.16.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:42:11 -0800 (PST)
Subject: Re: [PATCH V4 0/3] block: add two statistic tables
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
References: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <d3e8d3e3-9061-373e-5a6a-47216dfe6778@cloud.ionos.com>
Date:   Tue, 9 Feb 2021 01:42:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Any chance can this be considered for 5.12?

Thanks,
Guoqing

On 2/3/21 16:10, Guoqing Jiang wrote:
> Hi Jens,
> 
> This version adds Reviewed-by tag from Johannes.
> 
> Thanks,
> Guoqing
> 
> PATCH V3: https://lore.kernel.org/linux-block/7f78132a-affc-eb03-735a-4da43e143b6e@cloud.ionos.com/T/#t
> * reorgnize the patchset per Johannes's suggestion.
> 
> PATCH V2: https://lore.kernel.org/linux-block/20210201012727.28305-1-guoqing.jiang@cloud.ionos.com/T/#t
> *. remove BLK_ADDITIONAL_DISKSTAT option per Christoph's comment.
> *. move blk_queue_io_extra_stat into blk_additional_{latency,sector}
>     per Christoph's comment.
> *. simplify blk_additional_latency by pass duration time directly.
> 
> PATCH V1: https://marc.info/?l=linux-block&m=161176000024443&w=2
> * add Jack's reviewed-by.
> 
> RFC V4: https://marc.info/?l=linux-block&m=161027198729158&w=2
> * rebase with latest code.
> 
> RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
> * Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
>    per Johannes's comment.
> * Tweak the output of two tables to make they are more intuitive
> 
> RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
> * don't call ktime_get_ns and drop unnecessary patches.
> * add io_extra_stats to avoid potential overhead.
> 
> RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2
> 
> Guoqing Jiang (3):
>    block: add io_extra_stats node
>    block: add a statistic table for io latency
>    block: add a statistic table for io sector
> 
>   Documentation/ABI/testing/sysfs-block | 26 ++++++++++
>   Documentation/block/queue-sysfs.rst   |  5 ++
>   block/blk-core.c                      | 43 ++++++++++++++++
>   block/blk-sysfs.c                     |  3 ++
>   block/genhd.c                         | 74 +++++++++++++++++++++++++++
>   include/linux/blkdev.h                |  2 +
>   include/linux/part_stat.h             |  6 +++
>   7 files changed, 159 insertions(+)
> 
