Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00035C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjELO6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbjELO60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 10:58:26 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC9DC60
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:58:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3355cb2f4a1so873595ab.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683903494; x=1686495494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGuO9uAkYQgkNZy7b91jsKYegy6TbOpfslNkTDY+8ac=;
        b=1WVL72ya6qP7dGrPu7BNlkLeAizIvkdbU8SZrfj2rNUaajZGhH5j+aRAqiRDTgAyEC
         G01rOMNEGf01xwDcwtnNtvXJEcSP/sb/cUQ6KOn0kOiJb7STskLaiVUhLD/Xuufq2mkN
         FoHxF1nshyFhZtC6oqXhZmYkGDq9jdilM89fwAXuqYnTylcmcejSMBatZ03GKhl9qZ17
         Etal008fc/HStLgLA8JYEzR5DZQF99LjqFcxHyzuUg375D4y5IepKMbRIfOh7TkxXiG+
         d+VJxXq3G+bU5wOJ37xGsdVj+j9kK+uVt4E2n6uydwMRFnNrrfWekqs5Ukom3HHB/VxY
         GM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903494; x=1686495494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGuO9uAkYQgkNZy7b91jsKYegy6TbOpfslNkTDY+8ac=;
        b=gvmL1yGu8L90YUVwwUJR2oq3i8kY9XmaMG816fPj6gRA7HaQ0nDfsp9jop5rCFBmoX
         0gSyi6FCAOfZfiF/4HPswF6T2UaVprVHfCsghGL+rrccl5JlRSAISVOAZ4Ix4d1m84SA
         66ymPeuOKkeNNUU6yxGmimNM5lVPNKqY5sFg4w3VzLnx87BomffmSqQtT9xBom71R7c/
         EWXEDhKmvJ7UZbEd0/9JtEnqHDghPhZwwih1nPoKHpMybOYIhsPF52OJFYrJnT7Zxx0U
         OxtziC51G+rkgJqDWVIoHzUfOfA7NDyvmIdbijtaFiIaAz/J6C+qtoibXs+xtnM23KqP
         66Gg==
X-Gm-Message-State: AC+VfDyenEpaCP1pIYmoXzfpQnPTvfmr9j6ALUnI9nl8wAZf9Ns4Y+af
        1SUH4qnURThevQiW2hNtFmyA0A==
X-Google-Smtp-Source: ACHHUZ4tREfqhvKm6HZzH3bDbtNZfeS/vtcf5wxZcKNt9Kiz6niZQjLR0Bh2nrF7rlg1xgnEFxbH8A==
X-Received: by 2002:a05:6e02:1b08:b0:331:1267:31f9 with SMTP id i8-20020a056e021b0800b00331126731f9mr12668601ilv.0.1683903493782;
        Fri, 12 May 2023 07:58:13 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z1-20020a92cec1000000b0032648a86067sm5084686ilq.4.2023.05.12.07.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:58:13 -0700 (PDT)
Message-ID: <2b18e6ed-bce0-44f5-5ec4-8903f3c85cfe@kernel.dk>
Date:   Fri, 12 May 2023 08:58:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -next v2 0/6] blk-wbt: minor fix and cleanup
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, tj@kernel.org,
        josef@toxicpanda.com, yukuai3@huawei.com
Cc:     lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230512093554.911753-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 3:35 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>  - make the code more readable for patch 1
>  - add a new attr_group that is only visible for rq based device
>  - explain in detail for patch 4
>  - add review tag for patch 2,3,5
> 
> Yu Kuai (6):
>   blk-wbt: fix that wbt can't be disabled by default
>   blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
>   blk-wbt: remove dead code to handle wbt enable/disable with io
>     inflight
>   blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>   blk-iocost: move wbt_enable/disable_default() out of spinlock
>   blk-sysfs: add a new attr_group for blk_mq
> 
>  block/blk-iocost.c |   7 +-
>  block/blk-sysfs.c  | 181 ++++++++++++++++++++++++++-------------------
>  block/blk-wbt.c    |  33 +++------
>  block/blk-wbt.h    |  19 -----
>  4 files changed, 117 insertions(+), 123 deletions(-)

We need a 6.4 version of the fix to get rid of the regression. If you
want to do cleanups on top of that, then that's fine and that can go into
6.5. But don't mix them up.

-- 
Jens Axboe


