Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D110C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C00B61449
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbhDUQ4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbhDUQ4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 12:56:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C480C06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 09:56:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i22so30771953ila.11
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZFSOtZMmhPTU9JBlcmY+DOQRzSewGE0IcmlQTJi7S0=;
        b=bNTNqa0HnJa/B96/tgwhvBuQpuVTe1iPwITyvrdSrRHPB5DoRxLBUdBPLtLHjvIomh
         Ldqygq6t4Kkok2mJznizH5aq0ldY4422+lg1pAEcKFumDSlgL/0cAfmic/MOR4xeFRtM
         w6wmmTrJwmyZyeM2q0eiZUxxzm3f3r+0r41D2QZs0ngWt8J9xnYiCjZREmVVFuGlADNZ
         SzCHkhwXHuminZIE748/nkNkad8VDEspwN0xIcJ8fFbsmTNvUmED3o20aU7KzmrJo5vM
         Kl3Y2pOEN/X0qSYNgPu37WaqSA/DUC/s8XpqF99sag11yzyHd7t4Y+YUKyD35tN75Sue
         hkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZFSOtZMmhPTU9JBlcmY+DOQRzSewGE0IcmlQTJi7S0=;
        b=glAa9DwpUxFiFpEOO1j0RX5TSTqhVMyrjNru3hjLtd3KqYRhCe5LSk08NlkI8k7GZa
         6TBAanqXxu09gqFesEEBJaJGLLjIgRgYeSW6IhbUoXdqLgbh/KuOTEvx58C/w60w1Oye
         hswA7jeRvf/GxGun2k1N4TGuUGfV2nQ0Fv50wWS5jKmxcx2lcetHFMVe8Df0Ew5f1p/O
         z/OnTwq3CtLRgcZK50pHR9u8d5nTQ6IEolRYk8+jFpXZuhdCofcD7//2JM21mWIwuAZH
         Zbjxel/r6ELiiWECsPGSjNeoHmWq4dSaTHjfyNRnrpgJeOoVclIsMZMIUTZqft2I/5sO
         beTA==
X-Gm-Message-State: AOAM533CIFoLWwNaymOdBm6IMMfkGee546g94ylXbBdF17NpNLfp3O5U
        iUhcy2iVmlvXyYL0K+Sc/W1Qhw==
X-Google-Smtp-Source: ABdhPJz59S8ZopGsXeRykQwRa/BtMRNsMKDwQ8qauGoKqx1v9yg1pXNk1bR0YA5rQYC2szzx/kW01Q==
X-Received: by 2002:a92:2c02:: with SMTP id t2mr26500868ile.233.1619024178693;
        Wed, 21 Apr 2021 09:56:18 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a17sm1248701ili.6.2021.04.21.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:56:18 -0700 (PDT)
Subject: Re: [PATCH] brd: expose number of allocated pages in debugfs
To:     Saravanan D <saravanand@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkkm@fb.com, tj@kernel.org, kernel-team@fb.com,
        Calvin Owens <calvinowens@fb.com>
References: <20210416211829.4002947-1-saravanand@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd3added-1674-165a-0cfd-5e5841b738c7@kernel.dk>
Date:   Wed, 21 Apr 2021 10:56:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416211829.4002947-1-saravanand@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 3:18 PM, Saravanan D wrote:
> From: Calvin Owens <calvinowens@fb.com>
> 
> While the maximum size of each ramdisk is defined either
> as a module parameter, or compile time default, it's impossible
> to know how many pages have currently been allocated by each
> ram%d device, since they're allocated when used and never freed.
> 
> This patch creates a new directory at this location:
> 
> »       /sys/kernel/debug/ramdisk_pages/
> 
> ...which will contain a file named "ram%d" for each instantiated
> ramdisk on the system. The file is read-only, and read() will
> output the number of pages currently held by that ramdisk.

I folded in the justification and applied it for 5.13, thanks.

-- 
Jens Axboe

