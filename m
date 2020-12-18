Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1818BC4361B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7A823AFD
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 14:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgLROxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgLROxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 09:53:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F2C0617B0
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 06:53:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w6so1700091pfu.1
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPIWdyhhv2p0RK54BfyU00oulzKpVJG7soxRWcanAR4=;
        b=F02KD6DaV/aPKcjLUlLPP43rCeLPtbxNuUvPp1MEYpUq0w5n17jV+1bRZEY4+qQoXA
         AOkl7AMKS00RJBlstpvnRhWuSJiI6LZvuhcNrTnEJbcualpbtYXM1ALmw0aLoLodQXQP
         LiaNJ2cAY4Qku6YUDXG1SYzb007BAwE0fsz4Mh1zqJ8KyiniulqNd7dPcJgjRz39re1b
         pOl4E9gpua1SH9s13uNImMPWnYl86WXoVA2IkVdVm3CcYmroufHzRzRJZcUqsY3xxjCa
         5fltazm7+yzzBWlmLCOf1vinzXP5Wv1iSkkL28+xei+g8fKSyBKEl42fuQ8vl6daCmrU
         nxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPIWdyhhv2p0RK54BfyU00oulzKpVJG7soxRWcanAR4=;
        b=T7YZdnVXW8UQbKD6HbfoYTvuQ5LzSaOR+8PEQO2kZLJI7buaTpsf+NqaJ8bHsUahtE
         csPH49SAKZxrBaX/cVO2HWOZ1RAqgLIoImHVI/uLgNOHHwYzbwUKilBXmyMCREEVDWs4
         t3RAE24hQrd9YiuaaXEPDJCFLMFElwBoxmowSfJVLwffp5GBNwWKehQx0xjWkewV4dbm
         +A9wThqbVFrVzmbmwEHl0amD8LENmdXNDDKy3+f6FE4eSth6goo/xkbQJcikGrYuJXUh
         SXH/vo5DEuOqtCuGlNKZ4OXdMFZHaetZhmkPJi0M4L+njdt11uV6zHZmhdHrClC600Zb
         8Y7A==
X-Gm-Message-State: AOAM532ZFRto8dwtiLFWdMLCy76m6EYVsyMXz+LUTVxfe1tuWVjQudhx
        Gd7mcRxSc7RycHQ32OyccHOpnug5VaN/HQ==
X-Google-Smtp-Source: ABdhPJyG3zp40pY2POLr3CI3iKSHSsS1x1yHuFri50Mu1Kdnc3J5tOOIRHoPXDTmwr6d7IrUrqfnUw==
X-Received: by 2002:a05:6a00:1344:b029:19d:a886:f0ad with SMTP id k4-20020a056a001344b029019da886f0admr4546691pfu.81.1608303184804;
        Fri, 18 Dec 2020 06:53:04 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k14sm8790624pfp.132.2020.12.18.06.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 06:53:04 -0800 (PST)
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        swapnil ingle <ingleswapnil@gmail.com>,
        linux-rdma@vger.kernel.org,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
 <CAHg0HuzKb0e21bo3V53zskKtk+zaJXhxkU8m4w6Q2DWoWPkU6w@mail.gmail.com>
 <CAJCWmDdEPa23XDZ8pdStH=PgMszq4N6mHmNWtUA5Fn4THSNRmw@mail.gmail.com>
 <CAMGffEm2LVxXJP-HseTqihcCvPeYOkCsaFHVNKXDZAYxCPzwTA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a36bef5e-f7e3-c29b-8e65-38dc92812850@kernel.dk>
Date:   Fri, 18 Dec 2020 07:53:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMGffEm2LVxXJP-HseTqihcCvPeYOkCsaFHVNKXDZAYxCPzwTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 11:46 PM, Jinpu Wang wrote:
> Hi Jens,
> 
> On Thu, Dec 17, 2020 at 6:44 PM swapnil ingle <ingleswapnil@gmail.com> wrote:
>>
>> Adding linux-rdma@vger.kernel.org
>>
>> On Fri, Nov 27, 2020 at 1:54 PM Danil Kipnis <danil.kipnis@cloud.ionos.com> wrote:
>>>
>>> On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
>>>>
>>>> Adding name to the Contributors List
>>>>
>>>> Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
>>>
>>> Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Can you pick up this patch, or do you need a resend from me or Swapnil?

Just include as part of the next series of patches. Though I do question
why we need such a contributors list to begin with, if you do git log on
the rnbd/ directory it'd show you anyway.

I'd also suggest moving the parts of the README that makes sense into a
proper Documentation/ file, nobody is going to find it deep in the
kernel source tree as it is.

-- 
Jens Axboe

