Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82846C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F4D206EB
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CMipeE03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgIAOyH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgIAOtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 10:49:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD56C061246
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 07:49:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a8so651668plm.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bv5b6EVobqUNVIF87/DhH+cY3Q1HWbgPFf0dl3Olwio=;
        b=CMipeE03VR2QYd8nNYYHCTHPEJ1IdeFQMtTtnIpV/ee4MfCFYBft28C9Z4GIQo5zBV
         QK2gfzj3Lpql1P1iBv4jZiYTXLyHgovXgqQQLVy76+locmo3vFm7G8IW78U6hSLjWo7C
         TmvExCXdwMAaqW+bR3RRmdaQKZIoFbMkIauAd4Zew6KCdayaeAjIDHW6XrU23yriK2g2
         5Q89cEUh6IL2lzZJX+Qf7KP7yzHzSFg6msQOEJiQKJLe5dli7EmEZ2MIJzwXeCgPjFMv
         f5rmHep1MxFV7CqvQH9xpVPyf7UJMS2PB90qgeGaBr0u7DCp24xr/+nuCabqF2zMIkui
         Rk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bv5b6EVobqUNVIF87/DhH+cY3Q1HWbgPFf0dl3Olwio=;
        b=d6LHe+5jPh1FRwWXUyAniBTenRYliYGAWDXcDvEX8tHNmuZnBlQhezdhgPMbS/A2Th
         N8dhsMN9rV4jTajrPZQ40M5bQg372wJaSQ+ogYBKzLmX1Elaug8IO5GMv4u2Go0bul43
         w/ArEvfR4IuwVHlesKNBerpeOcjl/Zj1+/ct7X7CWj+x0wrs/q1KgghzXH42u+omOuOm
         qnCrXE7nLGOlKq4AsgBKmifh7Bx7pJny4sAy0tnStmkc9DQiP6iHoDYtEE2Sh6oHgr/r
         DJ7+8d5qCZa7vGaWnkNqMMr6F5xb9zxP+CR67kqgWa6Wd3HfKNj0WWhv4T8qDRq3ijWo
         Pcxg==
X-Gm-Message-State: AOAM533Ps9yJkNt4FgWJl0I7P9eEaqi5m9MvDObnCTnhmkBte4Vngt/7
        WW49kPCoam9gajzW1aDgaDrKDZZ8iy6gMSBn
X-Google-Smtp-Source: ABdhPJwJT6OaFInhGXji8NM/sg0H1Gpqx+OhIP3Jac20+0b+pSpDpPp7UHpR6y/5tKsCNyF4pj13sg==
X-Received: by 2002:a17:90a:c086:: with SMTP id o6mr1911513pjs.224.1598971789688;
        Tue, 01 Sep 2020 07:49:49 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s67sm2304633pfs.117.2020.09.01.07.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:49:49 -0700 (PDT)
Subject: Re: [PATCH 0/1] block io layer filters api
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1598555619-14792-1-git-send-email-sergei.shtepa@veeam.com>
 <7a517822-6be2-7d0d-fae3-31472c85f543@kernel.dk>
 <20200901132957.GA18251@veeam.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <722e85ac-f494-2cb3-4caf-d903d79a5645@kernel.dk>
Date:   Tue, 1 Sep 2020 08:49:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901132957.GA18251@veeam.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 7:29 AM, Sergei Shtepa wrote:
> The 08/28/2020 16:54, Jens Axboe wrote:
>> On 8/27/20 1:13 PM, Sergei Shtepa wrote:
>>> Hello everyone! Requesting for your comments and suggestions.
>>>
>>> We propose new kernel API that should be beneficial for out-of-tree
>>> kernel modules of multiple backup vendors: block layer filter API.
>>
>> That's just a non-starter, I'm afraid. We generally don't carry
>> infrastructure in the kernel for out-of-tree modules, that includes
>> even exports of existing code.
>>
>> If there's a strong use case *in* the kernel, then such functionality
>> could be entertained.
>>
>> -- 
>> Jens Axboe
>>
> 
> To be honest, we've always dreamed to include our out-of-tree module
> into the kernel itself - so if you're open to that, that is great news
> indeed!

We're always open to that, provided that a promise is made to maintain
the in-kernel version. Sometimes we see submissions that end up being an
over-the-wall kind of dump, and then the vendor only maintains their own
out-of-tree version after the fact and point customers at that one too.
For those cases we don't want the driver, as it just becomes a
maintenance hassle for us.

So if you are serious about this, it's important to set and manage
internal expectations on how the driver is developed and maintained
going forward. The upstream driver *must* be the canonical version, and
if you want and need to have versions for older kernels available, then
it should be based on backports of the current in-tree driver.

> We've spent some time before responding to estimate how long it will
> take us to update the current source code to meet coding requirements.
> It looks like we will need 2-4 months of development and QC, and
> possibly much more to work on your feedback thereafter. This is much
> work, but we are fully committed to this if you are willing to include
> this module into the kernel.

Honestly I don't think that is that much work, and I wouldn't personally
be too worried about that being succesful. Complications are generally
mostly around APIs, since an in-tree driver might need to change how you
communicate with the driver. So yes, it'll be some work, but the
important part is how we treat the maintenance of it after all that is
said and done.

> However, the same time requirement also presents a big immediate
> problem - as until this is done, over a hundred thousands of Linux
> users will not be able to protect their servers running the impacted
> kernels (our backup agent is free). They will be forced to stop using
> the new version of the kernel (or take a risk of data loss).

You have plenty of time to get this done before it becomes a problem.
It's not like the current patches are going to -stable.

> Given that, is there any chance that you accept the proposed patch
> now, to restore the ability to protect their Linux machines - and buy
> us time to deliver the compliant module for inclusion into the kernel?

I'm afraid not, we simply cannot allow exposing internals like that for
a use case that isn't currently covered by existing in-tree drivers.

-- 
Jens Axboe

