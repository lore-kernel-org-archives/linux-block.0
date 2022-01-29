Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C61FC433F5
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 01:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352099AbiA2Bvt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 20:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352076AbiA2Bvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 20:51:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD75C061747
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 17:51:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so8293625pjy.1
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 17:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3HAETZklYMRHOBMF4nZqSUVtbfOCXRHz+7u9x6rdHNk=;
        b=KdotavDnl39ndT7clf/ig6ckZcizJxpNLOerW7ygxH6m8J6LOd+Y69okHEcP764r5P
         dwq2DNviRFubvvn/eCYqrjpbkdg7JtZueRxpFK67Lj9+H5LB8tdiG4y0LosjH89ED0Fa
         /VGdGOuwT121ACmm+0o+QFBukGwqZqpmXP73IYCdPTb2dL/Ay2fCyTGFijwv2cXky5vJ
         6uQTU6iVTYa8ePLqI5Ijjne0AFuNPouLMMXzbJZ/+litaEcSV72lQeOub9t6EGdHmC0e
         3EHwPtb23R2Smae00Eg6//vzR5n2E0Nbm9Xf0cXbEqxhWC8hpRln8XeGaGiq9r858tWC
         vQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3HAETZklYMRHOBMF4nZqSUVtbfOCXRHz+7u9x6rdHNk=;
        b=eUYGKcmaVbNHMQ7aWFtBNp+GKFYs/xbe7QZrT+8cbUXpqR5+fxhn1hLrRBmtAvatBW
         q6iJVHd/HwAolBdWSmDK+JaDjo4JCbB1r0PTHKg9aMhOW0xgkV/xMJ7xLLr+kSr0JaHG
         +gpo2pbaNetdrH9ZZ/sJ54gvHdWWrsjIj3Y0UpAdUeT4VRkwcvVmKsKYYEW/aTMblMCq
         MXHv7a/KOEyoNez+4SLySXlQPizZHx1NYs8vy9iujE9xD4yaflJjuFlquw2pHxYvFKD8
         WhatmmxlamdxC9mgYtwO3L12deQvZEOQOTd1SK53eRxJs2IENNNGyoXG1RT4lBfEhdXc
         yoXw==
X-Gm-Message-State: AOAM532LEP13inZxtTNpgKBr+WMr2R0bmk2bYHZTJH/jokd2FJckFiVi
        +OBF37BZWeAI05SFlQiGGS6sxA==
X-Google-Smtp-Source: ABdhPJxIAjqPrZg0Dh0AgczUDxeDVDYuUMiAhQxGCbZ0io601R9FaHnpIHoXrdalmoKZF9W0y06rMQ==
X-Received: by 2002:a17:903:404b:: with SMTP id n11mr11675278pla.42.1643421104746;
        Fri, 28 Jan 2022 17:51:44 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 190sm10123225pfg.181.2022.01.28.17.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 17:51:44 -0800 (PST)
Subject: Re: [PATCH v3 0/3] block, bfq: minor cleanup and fix
To:     Yu Kuai <yukuai3@huawei.com>, paolo.valente@linaro.org,
        jack@suse.cz
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220129015924.3958918-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7cb40388-02e9-712a-6a40-ccabd5605880@kernel.dk>
Date:   Fri, 28 Jan 2022 18:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220129015924.3958918-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/22 6:59 PM, Yu Kuai wrote:
> Changes in v3:
>  - fix a clerical error in patch 2
> 
> Chagnes in v2:
>  - add comment in patch 2
>  - remove patch 4, since the problem do not exist.
> 
> Yu Kuai (3):
>   block, bfq: cleanup bfq_bfqq_to_bfqg()
>   block, bfq: avoid moving bfqq to it's parent bfqg
>   block, bfq: don't move oom_bfqq
> 
>  block/bfq-cgroup.c  | 16 +++++++++++++++-
>  block/bfq-iosched.c |  4 ++--
>  block/bfq-iosched.h |  1 -
>  block/bfq-wf2q.c    | 15 ---------------
>  4 files changed, 17 insertions(+), 19 deletions(-)

I'm not even looking at this until you tell me that:

a) you've actually compiled this one. which, btw, I can't believe
   needs mentioning, particularly when you had enough time to keep
   pinging about this patchset.

b) it's actually be run. last one was clearly not.

-- 
Jens Axboe

