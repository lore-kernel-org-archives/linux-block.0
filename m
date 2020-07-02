Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60113C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 05:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389B1207D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 05:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GjEE7/+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgGBFDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBFDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 01:03:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48939C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 22:03:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so6004367pgm.11
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q/NFfD8OBp4UH+DHkWhHxr9Ncs4D8L0t2eCb4T2mnog=;
        b=GjEE7/+XizIKZWorgH1JGr828eodi4qGByZgzhxv2si/rN5ow+QunJI7P9aNHaKksO
         tYif8iHeBE/bcOs9vRaLaR1iNtS2QyT/HVtRejls5K13v/XvcUP2V4BcJES9e70wvdxC
         1OX0BRhsYL0EOKBy5YyBorYK3b9vDPFMMPiy712HfgLPSv0mRKCRxdYFmG45yVxejjcl
         5wfEs1ZVwUIxkSaUbBMsLg24BRE0n69nwuRgbYa+IQR+mZdck5fE6DnLg8K6R3yUXwCr
         Dr0ILGqWpScFncZtU+j/e8pnovkqd/Z9/3ZbuNgVQbFr9+YmhQr72VfmK8WBhViZsrD1
         jgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/NFfD8OBp4UH+DHkWhHxr9Ncs4D8L0t2eCb4T2mnog=;
        b=ZRTl2dg1gC9/Mdsj+IdxukrJo/wJ4wu2r788N4iYDJvBOhbk4Z4WHOTFkjoQpxdqGy
         ex03caH6dFjosrErMwaJFHvd2r0/dCYKk7f3Py4ua2CdQIhoPnjrgPtqWJk4RoBq3WmA
         sqRbHq3XLGGD4eV43cr+5XsVqLsztwF7pL+gDlUs7YFIMzAJzIckfKobFLW3bAPoU0Vw
         kX3FSF80rFZNEvuCUU7O3Kh9OMQxvglaTR08u5Xx3YNApl0tACmVKJIXgHDjiaYHmlbC
         OFYsftAZ2P8rO/SdfTTxfR7W6tzuv+7hTnm8j42EYbe4zqSq5KIBZVAGHRWPQYDSMiQb
         +9wg==
X-Gm-Message-State: AOAM531U0KHGN+V0/YI5Uf373wHiFJIcp/TCErL/o7a8KFatUrZCVrlL
        0zy5mYe7VKJnS41vOw7iEKt8sGXKwZ+rJA==
X-Google-Smtp-Source: ABdhPJzg5xJecHS70pyG3MelkVXmepgD3AWQfivI9ypNv+3RC4j13Gq97VlfLcNRG7fiJH8w7CXiag==
X-Received: by 2002:a65:6415:: with SMTP id a21mr22435141pgv.129.1593666219830;
        Wed, 01 Jul 2020 22:03:39 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b0a2:2229:1cbe:53d2? ([2605:e000:100e:8c61:b0a2:2229:1cbe:53d2])
        by smtp.gmail.com with ESMTPSA id 6sm7369760pfi.170.2020.07.01.22.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 22:03:39 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
To:     Ming Lei <ming.lei@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200629094759.2002708-1-ming.lei@redhat.com>
 <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
 <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
 <20200701134512.GA2443512@T590>
 <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
 <20200702012231.GA2452799@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <adffbc51-f85a-7507-94da-260ff0c1b7b4@kernel.dk>
Date:   Wed, 1 Jul 2020 23:03:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702012231.GA2452799@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 7:22 PM, Ming Lei wrote:
> On Wed, Jul 01, 2020 at 04:16:32PM +0200, Marek Szyprowski wrote:
>> Hi Ming,
>>
>> On 01.07.2020 15:45, Ming Lei wrote:
>>> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
>>>> On 29.06.2020 11:47, Ming Lei wrote:
>>>>> It is natural to release driver tag when this request is completed by
>>>>> LLD or device since its purpose is for LLD use.
>>>>>
>>>>> One big benefit is that the released tag can be re-used quicker since
>>>>> bio_endio() may take too long.
>>>>>
>>>>> Meantime we don't need to release driver tag for flush request.
>>>>>
>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
>>>> it causes a regression on one of my test systems (ARM 32bit, Samsung
>>>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
>>>> and then after a few seconds every executed command hangs. No
>>>> panic/ops/any other message. I will try to provide more information asap
>>>> I find something to share. Simple reverting it in linux-next is not
>>>> possible due to dependencies.
>>> What is the exact eMMC's driver code(include the host driver)?
>>
>> dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)
> 
> Hi,
> 
> Just take a quick look at mmc code, there are only two req->tag
> consumers:

Just a heads up that I've queued up a revert of the offending commits.
It's not just this issue, there's also another one reported with
swapping.

-- 
Jens Axboe

