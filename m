Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138EFC433ED
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B479961077
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhDABS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhDABS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 21:18:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03861C061574
        for <linux-block@vger.kernel.org>; Wed, 31 Mar 2021 18:18:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h25so534427pgm.3
        for <linux-block@vger.kernel.org>; Wed, 31 Mar 2021 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwm6IUe1wkh4SgCMiSRN9banOffkLbnFdJqYNato/r4=;
        b=Hqvun3EvAgEXKcsG8/6rRia9Pya6VpGRX/xNVC53epbEGAczD0tZllnWOjwdJG+vAP
         MZW525b8knsFgyy+fwQ0mbrwj3Tb4buEzfcFsW5pbyTMEVarQso+P5DpvdQiDpltoGnk
         6oRnZMYyxrlgmxByK0kP2PzGstn+LLz1eNPYhYHMnqotUv1Edjr8StsLJpKZyYCUcptt
         cu/jtxP40Zlz7+zq4mg6CV9qxhpcKPfuJFROvEePIfH7yUzUARmp8qBibSqRISbpMCSM
         Svtasw0KrCGq5wTqJUyScILAWkwmSNJrUV2lLNop7+9PjGyPVNuBmUbVPRMwi6pefY7t
         oE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwm6IUe1wkh4SgCMiSRN9banOffkLbnFdJqYNato/r4=;
        b=BpT7yI8X1tdAmNb1rpZbvhmOaMD1qvhUOWwORdAH6vxqGJPTZ7N18l2L+56f07UOBv
         TMiGqH6pi9w+2sjWG2lKLI5oBVxKxacWpRAMKVlrzPrSV21my/SueOHoZfm0ZaGhjMWp
         XWghEfIuN94mbkco1Q6LrOImfp4qnfKeux4OU8+eAo5000B3InoU5Om84vm65cjuggsR
         GWn/aZtndyC2ZWvUqqcjMHzX8jwTPKUqmCBA58VIkLVhKIGAfFKym/AdHCRgqmU4Q+ob
         zpb+gMsK+2YGck71Pg3NRU0dM+poktAxk5vChY75raTsqIKZJukDzcRIz/XJgb4nKCC8
         5O5g==
X-Gm-Message-State: AOAM533YoFOhzID/Yo6ma7OJqN6s+5Lc6QdppR1eOiocxMkAmFkIFDCt
        HemaEXeKarO4OziDCpo0oGyiDw==
X-Google-Smtp-Source: ABdhPJwA9DdJMRLSNQcHBU+zM8VrjFuY19gkVCAtaqySxpDzCumHHq00j5jGqxDvZnHy6cZJZLNDhw==
X-Received: by 2002:a63:2318:: with SMTP id j24mr5641005pgj.134.1617239905554;
        Wed, 31 Mar 2021 18:18:25 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r1sm3917519pfh.153.2021.03.31.18.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 18:18:25 -0700 (PDT)
Subject: Re: [PATCH] block: only update parent bi_status when bio fail
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
References: <20210331115359.1125679-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3afcc0a1-d01b-5007-2621-231e7d8143e9@kernel.dk>
Date:   Wed, 31 Mar 2021 19:18:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331115359.1125679-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/21 5:53 AM, Yufen Yu wrote:
> For multiple split bios, if one of the bio is fail, the whole
> should return error to application. But we found there is a race
> between bio_integrity_verify_fn and bio complete, which return
> io success to application after one of the bio fail. The race as
> following:
> 
> split bio(READ)          kworker
> 
> nvme_complete_rq
> blk_update_request //split error=0
>   bio_endio
>     bio_integrity_endio
>       queue_work(kintegrityd_wq, &bip->bip_work);
> 
>                          bio_integrity_verify_fn
>                          bio_endio //split bio
>                           __bio_chain_endio
>                              if (!parent->bi_status)
> 
>                                <interrupt entry>
>                                nvme_irq
>                                  blk_update_request //parent error=7
>                                  req_bio_endio
>                                     bio->bi_status = 7 //parent bio
>                                <interrupt exit>
> 
>                                parent->bi_status = 0
>                         parent->bi_end_io() // return bi_status=0
> 
> The bio has been split as two: split and parent. When split
> bio completed, it depends on kworker to do endio, while
> bio_integrity_verify_fn have been interrupted by parent bio
> complete irq handler. Then, parent bio->bi_status which have
> been set in irq handler will overwrite by kworker.
> 
> In fact, even without the above race, we also need to conside
> the concurrency beteen mulitple split bio complete and update
> the same parent bi_status. Normally, multiple split bios will
> be issued to the same hctx and complete from the same irq
> vector. But if we have updated queue map between multiple split
> bios, these bios may complete on different hw queue and different
> irq vector. Then the concurrency update parent bi_status may
> cause the final status error.

Applied, thanks.

-- 
Jens Axboe

