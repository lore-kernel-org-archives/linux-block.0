Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4BEC433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B552F6144C
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 14:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhENPAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 11:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhENPAb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 11:00:31 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24974C061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 07:59:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k25so28362622iob.6
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUiYa7NOZ3uEFHnN8U9tZoFZ0U9y8xDO2tLCrk/MPAE=;
        b=ZS+fdo2g9KKlIF+D3Jp3SjQn6Fq9t3lyrptDZZUQ+Y+8whquEBBPuDYYh8/+32RKhc
         6D38kDJQ+v+IDajiOZVyX21EPo86/PQ1Te7PmKGxMcKMiFd12/LVhSNd3OAo78/AVLxk
         v9nkfc2CAGco0yOXAwYd7D5ouWazxP3ADHBE8KDcDT7UwCU37KHKo2jqRWR4o8UB+/sY
         LBZeKbJpT9LcR+JROwmldt/5enh0jOq3IEk/cM8fFPHFQctbX9ibZbimBESHXeYMYGCX
         5RSVtA++UQXTACdES4jrVCCyxswFPFT4aclwMbkW8yfPLyeEORip1LrwNbRg71KFbuqg
         q6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUiYa7NOZ3uEFHnN8U9tZoFZ0U9y8xDO2tLCrk/MPAE=;
        b=rNgN1C1iN5Qx1dZKu1dbGsN8j2Y/h7IDevex0bhWbl6imodytFfQr9J/Pbwh+ul9Sj
         qFpHyivPeoJiE491cZh43732Uj/kBEFY7YcPkY10MkRxgEBHNoQKgP2Y4UViTjB3cp9N
         5X/iyZKAr4FNTjxDndJF7KIGWD8Ei6XnQoiFxGgemF2WSVBCp9HYFvuo0O0wDleeWXKP
         wCD7mLB7+kntf6hhy3oSUXbrGTMQ9YSzzxbkiz8i+lWtiN5d1BnavDLhoScdd6VazzoQ
         eFC2NlOvnIau5vli3ksvJWWIs4q+6+Ny3DvZrgH5GGHssS5xEc6zkB4rPnMcnbNdM3lM
         IB4g==
X-Gm-Message-State: AOAM53036Jj1ruvHM3wt+JBUotWcmh04fS8l+GrBFJ+T85VABoC/WFKx
        f3xUM/ANoyzqoCwudoEfe8Kcbg==
X-Google-Smtp-Source: ABdhPJzmC4zlVNLeIz2TT/ukU4SABhrZHj1IBQR2CqDkC1DFc5f4w18uvraxdczmzECw1iJsaNOV6Q==
X-Received: by 2002:a05:6602:1815:: with SMTP id t21mr13156198ioh.193.1621004359647;
        Fri, 14 May 2021 07:59:19 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r11sm3126299ilq.29.2021.05.14.07.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:59:19 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com
References: <20210514022052.1047665-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75ca571b-c132-245f-2fb0-159cc6aa4923@kernel.dk>
Date:   Fri, 14 May 2021 08:59:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210514022052.1047665-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/21 8:20 PM, Ming Lei wrote:
> In case of shared sbitmap, request won't be held in plug list any more
> sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
> tagset"), this way makes request merge from flush plug list & batching
> submission not possible, so cause performance regression.
> 
> Yanhui reports performance regression when running sequential IO
> test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
> is emulated with image stored on xfs/megaraid_sas.
> 
> Fix the issue by recovering original behavior to allow to hold request
> in plug list.

Applied, thanks.

-- 
Jens Axboe

