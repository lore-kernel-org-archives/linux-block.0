Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A1C433E6
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 21:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F2922582
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 21:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbhAYV2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732635AbhAYVTj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 16:19:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D2C06174A
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 13:18:59 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q20so9133281pfu.8
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+E2QKYZrluBg1iBjQcak9MCibuQJCXbencd0L2CEXM=;
        b=w4IcicZbBoygZLxK2+ZjwfLVCA5GB0v4cbBBX+5PEGG9DjSu4dgMOET+57SXcJyBd/
         vONyKRVJJf7NIkT/Tg8JeJgtTzy9mceZ2+wyfmL+2bGpbzJej1eUsz6MlHoX3AX4elY8
         VV7onfeGs/WwGYsk1MfxUoGHtNg/yn0j/Qt6ty/YrR68JosNkFYn1HnFoSnhWCw2yt8P
         68/WR/FiZ+28j3UrwQBmd8iVwyucoP8IzkssTqyen0IEwUwQUc3XagTD+InltkBjrMew
         n8D5wE3Gn7iV9CtrMoTtcFas09mEAaQhUgX+aK0k7DZRFPgtIveXLAHXuc6wRWCoTcR8
         cdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+E2QKYZrluBg1iBjQcak9MCibuQJCXbencd0L2CEXM=;
        b=Uyxe3kL7Arr3XMuzHKgppZTzEFotDg4LHuNo+tFhZgu0nX7mD6I3NKVQ9li4L8EKcg
         d1ieiZX6kYUtD7VOorB7hU/tSrdB4WFH9j92kaKikw7O09QCRvSwwmvkv8Igjw6kGyzj
         6DIoWqEZyONEoOliL8UNJvyj9I6pj55i4ONAdgkQmSMIZXL9qlXNqOcLE2gup3lzgmol
         dp6uw9Ps+ZebUOVd+2H8WCcMxt0KSUTr8PyOMOxcuyxiZAKVkCp1qAP9oSEUOXdgX96Q
         LJ19D3LRIjoO5v2QZ96mP5MET9iKHMmRCvb1mDEKxatboh2Zohd4zwQeV6iaO7xInasr
         HYyw==
X-Gm-Message-State: AOAM532Ywxylz2KRhHDGLPjAns6OHgNJzowDRTsRMzvqt1Uuhd2rnKQ9
        8B0gMMUUXRY0xQOEzo+g+Cze/g==
X-Google-Smtp-Source: ABdhPJwLqpaGmQeIn98hN4B/n7hJ4LVC8tm8BvqnQxWCX+m2eS68Fwi/gy7lTD0qb2ib36JEDvAIaw==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr2363233pgr.221.1611609539114;
        Mon, 25 Jan 2021 13:18:59 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id n1sm240830pjv.47.2021.01.25.13.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:18:58 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: second batch of fixes
 and improvements
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210125190248.49338-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50888903-86bd-0815-e671-58df34aa01e2@kernel.dk>
Date:   Mon, 25 Jan 2021 14:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/21 12:02 PM, Paolo Valente wrote:
> Hi,
> here's batch 2/3.
> 
> Thanks,
> Paolo
> 
> Paolo Valente (6):
>   block, bfq: replace mechanism for evaluating I/O intensity
>   block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
>   block, bfq: fix switch back from soft-rt weitgh-raising
>   block, bfq: save also weight-raised service on queue merging
>   block, bfq: save also injection state on queue merging
>   block, bfq: make waker-queue detection more robust
> 
>  block/bfq-iosched.c | 328 ++++++++++++++++++++++++++------------------
>  block/bfq-iosched.h |  29 ++--
>  2 files changed, 214 insertions(+), 143 deletions(-)

Applied, thanks.

-- 
Jens Axboe

