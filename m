Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91203C352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 16:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636E02168B
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 16:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="erLpYgoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbfJAQCS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:02:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35835 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfJAQCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 12:02:18 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so49407647iop.2
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzi5F38nYz4q1+zWjnpkp9mXCPxISIRw+yzzuhROKoQ=;
        b=erLpYgoQl2arc1QonX+IsMDjWEUHNpnW9f9j4jwZaYF6hJx30OnZQoJHPQ7PbEgvRh
         N+23Lxx4oQuiX7VBPH8Rv3Nn+vNXwsQNb7ZK/j+ThkrbV4F9s+Rr/4gIrBX31lI0sNFH
         t4wFITNnYulUWlgwYo/bcwIZhDuf5TCvH8aa45ga4RxWzUNXU2boT1Nxh6SGxeKYbkCU
         Fy7c1s/lxtG8uAyf3VQ6SHv3/fUbFseSYz3+pjJmdji3xhwlaL/rSkOZiaUHYnDJkuVR
         18R34znx1vWuIIONLqXhuktbSEzuU3F9uTBCilG4OxVsX206jcB9cnkOCN4syu038gk+
         clYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzi5F38nYz4q1+zWjnpkp9mXCPxISIRw+yzzuhROKoQ=;
        b=gIEUFvIl+IwpcBnKANMFCAgOhCemGR+xiVJGv135rh2mo+QIpN7iCNr4Itd8xAAD8W
         Yl9WwA3In2oXQMIg+k5Y8q1Cfm7LmtY24vdnur70un3oVTpi+9At/T0+306H68XhFmsz
         fKgBvPxaN6KDa36dqVQwyXoEh2RuyoC/WLEwxofPsTbL47lCV4nHpkpESVFjE4mr/U7h
         ZerD8++P+ETBEQDvGJD90rpV4aAc0fQoEoDQtanbrj6hxZ7wAXcei85nlEHX+jxSExGd
         N9LAGydvmogWtAAT4cj4fUv+ftWgdXxFnPaDVU0w7L5f1eWcmFJ1+fGkauzugjH8m256
         t/oA==
X-Gm-Message-State: APjAAAXiUbSYR6hKZmb16hHEzzDFg2aCLsngm3A4FKWRiFb01chqHY50
        T5PtSkqVoG/m+Fvvu0CrqWbktg==
X-Google-Smtp-Source: APXvYqzzyMV7tR/JUb30p2Yc/xp2zJL29JdNUr7d9S5n2DetK2I4DerUSEPK2xTBqvGazQna4WtLMA==
X-Received: by 2002:a6b:6613:: with SMTP id a19mr17190502ioc.241.1569945737769;
        Tue, 01 Oct 2019 09:02:17 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q11sm6978034ilc.29.2019.10.01.09.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 09:02:16 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190930202055.1748710-1-arnd@arndb.de>
 <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
 <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk>
 <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
 <ca0a5bbe-c20e-d5be-110e-942c604ad2d7@kernel.dk>
 <CAK8P3a19TDk0uo1eu4CcaKHvQCPUJGMjBV8Txtpgvg1ifAgW_A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <77f90d5b-d6f8-b395-ba57-9d1f0ece9a00@kernel.dk>
Date:   Tue, 1 Oct 2019 10:02:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a19TDk0uo1eu4CcaKHvQCPUJGMjBV8Txtpgvg1ifAgW_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/19 9:57 AM, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 5:52 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 10/1/19 9:49 AM, Arnd Bergmann wrote:
>>> On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:
> 
>>> What's wrong with using __kernel_timespec? Just the name?
>>> I suppose liburing could add a macro to give it a different name
>>> for its users.
>>
>> Just that it seems I need to make it available through liburing on
>> systems that don't have it yet. Not a big deal, though.
> 
> Ah, right. I t would not cover the case of building against kernel
> headers earlier than linux-5.1 but running on a 5.4+ kernel.
> 
> I assumed that that you would require new kernel headers anyway,
> but if you have a copy of the io_uring header, that is not necessary.

Since I rely mostly on folks using liburing, we include the header as
well. So I'm just going to use __kernel_timespec in liburing, and have
a check to define it if we don't have it.

>> One thing that struck me about this approach - we then lose the ability to
>> differentiate between "don't want a timed timeout" with ts == NULL, vs
>> tv_sec and tv_nsec both being 0.
> 
> You could always define a special constant such as
> '#define IO_URING_TIMEOUT_NEVER -1ull' if you want to
> support for 'never wait if it's not already done' and 'wait indefinitely'.

That thought did occur to me, but that seems pretty ugly... The ts == NULL
vs ts != NULL and timeout set is a more well understood pattern.

-- 
Jens Axboe

