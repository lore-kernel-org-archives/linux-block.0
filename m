Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342B66115A
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJSW2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJSW2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 18:28:22 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A097C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 15:26:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b188so17337346iof.8
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CxAVpN65ej2sl22y1JSHL1CR7fzfghNGDTHMGW2HI7s=;
        b=RyQoURPjykhjcaibRBekjVUtz6XomYDbVvGGV1gY3Bu0y1FSYrX2qyG0GxAHh8z0IF
         rG/RyrgMm6WirXQDFvpNUbGGc+tC2e1OI4+glAtW8+7ZK/d2Ahf39Ba7A+Yuavgid6PA
         QGm17zXL9TYo4oQwGMqvyEjXbWN6tJHsTkIWIBnEZq3MJAeJu2fXjtWbPZctjjQO4qnx
         8vf7cdGw3KgBV0bW3xClsWA44DiVbbRnBUPq43NFKbW4/QsRTC0aAqR5qSvwUBE0rHZh
         /Xon2EeaVjPTcbShNvl+RfFZMxnePyMZWOcdaX9N2QGaEjF5/KGT1NVHCNgfPgCrvQK3
         0vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxAVpN65ej2sl22y1JSHL1CR7fzfghNGDTHMGW2HI7s=;
        b=QB06SD/tzE/2thlxII2JlrvUxT0d1oYv8vTCf+wn/iQ9DUJ6nafcFTEYi0OE4fPPC7
         4IpPVpLvYaH4iw9n3By1225hFCpiR/VIWppvsl6OcSRaJZPzJc6Q/5Hq7NI87UrO/oly
         /qt83SrZrQSWxTBfAKlMOxUNxbrictZTIvrdjE6bo3trq53Hy6modSOYLf8U7sJjOVyR
         XUvJq5TD7OH2nqKB28BgqkijtmfeEfIttCNaUKjrm665eW5DacD0SKtO+lLaPcvlnoUT
         CXtHhKX5oJVDNZc5/bz4IpqtBD2sTqz2paguH+FjuF2eOcRs9AnYk1Unhh6v7fKjfPhw
         3dlw==
X-Gm-Message-State: AOAM531dopnzrduzERJYymd5CJtnUuhhuY1BVnuDbjyikYWJ4e/zs9gO
        kvfLrewYB1ePuJN1cg4F5cDacHIezxQzLA==
X-Google-Smtp-Source: ABdhPJw/RHyzSVpfTWPUJngmo5nYBRpsPRYqd5V3qJivu8WmBU3NeWQEM3tOK+irVmIzUL1P1UtBBw==
X-Received: by 2002:a02:9609:: with SMTP id c9mr6213669jai.118.1634682368917;
        Tue, 19 Oct 2021 15:26:08 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 81sm169730iou.21.2021.10.19.15.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 15:26:08 -0700 (PDT)
Subject: Re: [PATCH 06/14] block: store elevator state in request
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-7-axboe@kernel.dk>
 <1a08141a-407f-0fda-4b27-e9dd350c6e79@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8654edbf-0161-5dc1-5133-2d0623628229@kernel.dk>
Date:   Tue, 19 Oct 2021 16:26:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1a08141a-407f-0fda-4b27-e9dd350c6e79@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 4:21 PM, Guillaume Tucker wrote:
> Hi Jens,
> 
> On 17/10/2021 02:37, Jens Axboe wrote:
>> Add an rq private RQF_ELV flag, which tells the block layer that this
>> request was initialized on a queue that has an IO scheduler attached.
>> This allows for faster checking in the fast path, rather than having to
>> deference rq->q later on.
>>
>> Elevator switching does full quiesce of the queue before detaching an
>> IO scheduler, so it's safe to cache this in the request itself.
> 
> A kernelci.org automated bisection found that this patch
> introduced a regression in next-20211019 with a NULL pointer
> dereference, which only seems to be affecting QEMU but across all
> architectures.
> 
> More details about the regression can be found here:
> 
>   https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20211019/plan/baseline/
>   https://linux.kernelci.org/test/case/id/616ea20eb7104071c43358ea/
> 
> See also all the test jobs involved in the automated bisection:
> 
>   https://lava.collabora.co.uk/scheduler/device_type/qemu?dt_search=bisection-287
> 
> If you do send a fix, please include this trailer:
> 
>   Reported-by: "kernelci.org bot" <bot@kernelci.org>
> 
> 
> Please let us know if this seems like a valid bisection result
> and if you need any help to debug the issue or try a fix.

This got fixed yesterday, current tree is fine.

-- 
Jens Axboe

