Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 23:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGMX5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 19:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGMX5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 19:57:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AFB53D16
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 16:57:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id l124so370056pfl.8
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 16:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kmp9OwZZXpp7dYLW+I8EROE7mdEtSphWTitPY+itN4A=;
        b=foAugmdL46coCdeOwuUQbCi0E6TbeAxJKdHVpuIQJZKo1+V8dq+7pdDKj0vNtrzq1v
         on/JvI0c6iN8H3xLRXRl35TnqMBtEuYRVNoWNqpmTiYPRA/9TDxPqIp98PwQHKSPJvOv
         IYoJ7uAKvuqnkrysXsV35nTaT2NcTHNni87skjX+HAzVUKdGfnLN6Wuh9plrdDTrZ+kq
         nwu0H6mhdfVMqe2kQDmUO/ZgNUgoH7L8hPBl94ZaNC3xqymPC83DVKCxbGYJ3uecV+8d
         onANMXhGYTV/IR1IFQr/8pCjSMrzrfJ105izYPuz148HcNuSFYevXq1EP+gB14fzQpYZ
         YNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kmp9OwZZXpp7dYLW+I8EROE7mdEtSphWTitPY+itN4A=;
        b=4B5V614xUhmKHOu4w3f542UKnbsa0SwLjLyij4DYg0zxHWHMZU/wFWdLaPQ3pDXfg0
         cTWksjVil2obGb+kX3aH82h145xitC1M4OV/gAXQ5gannvqL2u5m1IqQTW7KLziS5Y08
         b3TNw9DWcIiXY/1TrbJ2yX72bcvh5mh/Sw5CLtAdgsLV8vJ+Jm80dtvgERRBzuPUB4sI
         5VcopaOqQNZcpzYxfjqUWVlkOFy/bOjfbl8FxOfVSrskHB5o0Zt3BjRn50KHAyxfCi/N
         pqjvD88/qkuC+bBSuNXhJOKizr1zGE6WqmzldJTdB5Zl0ysdbG/E7oqrvcpMxO+i8ip/
         vQsg==
X-Gm-Message-State: AJIora9cS4vsmVszvkcti90hFmL9BkylecbhNT1mdsghsKOtMtN+6i4R
        DXF9a+hPnmrqDiK83s1eyGi8/A==
X-Google-Smtp-Source: AGRyM1vFBOg7SlcSGkkP6dNcoqUsyVQplclOJyy5i0FfMKeZ0CDbgPD291lVnYQ1LgS/gQkd2SGiQQ==
X-Received: by 2002:a63:1009:0:b0:415:d29d:eadd with SMTP id f9-20020a631009000000b00415d29deaddmr4937510pgl.195.1657756641576;
        Wed, 13 Jul 2022 16:57:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q16-20020aa79830000000b00528d4f647f2sm121743pfl.91.2022.07.13.16.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 16:57:20 -0700 (PDT)
Message-ID: <c9113e57-1055-425f-f757-3d575943afde@kernel.dk>
Date:   Wed, 13 Jul 2022 17:57:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 00/63] Improve static type checking for request flags
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <d1a88d4f-9f03-a1d6-cf4a-fcdb8070399c@acm.org>
 <ee65aa8a-2e74-9a7a-f8e6-11266744a326@kernel.dk>
 <0496421c-5793-40c4-4662-865fc19bbbdc@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0496421c-5793-40c4-4662-865fc19bbbdc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/22 5:49 PM, Bart Van Assche wrote:
> On 7/13/22 16:46, Jens Axboe wrote:
>> On 7/13/22 3:48 PM, Bart Van Assche wrote:
>>> I think that everyone who is interested in reviewing this patch series
>>> has had sufficient time to review the patches in this patch series. Do
>>> you prefer to queue this patch series for kernel v5.20 or kernel
>>> v5.21?
>>
>> I've been pondering the same. I'm fine with going for 5.20 as this will
>> be a pain to maintain, but the first patch doesn't even apply to my
>> for-5.20/block branch...
> 
> Hi Jens,
> 
> This patch series was prepared against your for-next branch. I will
> rebase it on top of your for-5.20/block branch, retest and repost it.

It probably just conflicts with changes added after you posted this one,
though not that many went in I think. In any case, please do respin on
the current branch and we'll see what it looks like.

-- 
Jens Axboe

