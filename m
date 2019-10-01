Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C40C352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA4121A4A
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 18:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GARLG2Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfJASIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:08:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45327 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbfJASIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 14:08:20 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so50308254iot.12
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XTOX0LQOUFg1m/meFnFguM93CeUXC33Mlpt/kQ0ZE0=;
        b=GARLG2Ouib+fEjPWYSCXvvfu3OfCRZi730mbD0+dZ186MBMZHSPxwhotmH5XCSHR8P
         bPbRXnddKRjogEM4mAXSW2f6vOT0Q2waddY7qfzP6AtPJ5PYjJm89fP423Oa3J0DUVt3
         4epIL2EUS0N2LO+lwKRz9mtfDHbLNCxbUurulgOghvlp+Rd9mVNrj4d+GpA+iDzzpP+x
         tu9+IegCJllRbIlMJDlXxdybnHMYc2slMt66yvF4a+OcVvBZwP3SX4PeqaeruYAZgWVo
         ZCwfqvGpecrHjjfKZymPt3JYUbXeKdfqMp3WKZSQd9VFvp+nEShxNlVJAMBCBwDGMp6j
         tqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XTOX0LQOUFg1m/meFnFguM93CeUXC33Mlpt/kQ0ZE0=;
        b=E7Rgwu+2UZuMmcbnDKpgrzB5beFtnYclOJ+Z6sy1+wA81RH25w1RCp7GcKsHWiScbC
         YnbDZ8el7Bm3kybW1OOqRwG3QYzclLz2SY50QUO3/jxaIQdKncgYrHKbhKa6ZUJ7916C
         U7iTE30Z3jGhGxA2Epdh8HJ3eXxzPApp5GXPGMKQAAacLAaCEU7YNehWFf8N640xnNWE
         r1rDulQO09jTLQoW6Nm8nbKSbkVPpbk11UW9MvMo8clKPBbAiTfibZvDm2Vl0PMgco1l
         ZvNyIHM8rtjH7MrXzdiLvI15oWGkW4aq6iWaAsp5QLgNQ7T8RKs2Z5Nny7TNVjo/jtDU
         FUPw==
X-Gm-Message-State: APjAAAUHCtwqwo3I52PnIoxBImbCXwKXGyMJsnKdH9HPNHeP7N/8Yrfa
        O2B/0//ONSKMaC36HatyIFkfTg==
X-Google-Smtp-Source: APXvYqyYmHX6/zLaE9okaUhuWyOFD2Ih0X+Dl7fjQ0c7EaHsFKjqIA19qZuoFdj+AKRw1Tu3DrRmJQ==
X-Received: by 2002:a92:5a14:: with SMTP id o20mr27872935ilb.71.1569953299642;
        Tue, 01 Oct 2019 11:08:19 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm7181020iob.80.2019.10.01.11.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 11:08:18 -0700 (PDT)
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
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
 <874l0stpog.fsf@oldenburg2.str.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc4fc8dc-0a6b-19a2-e85b-71fd1ad4c4ca@kernel.dk>
Date:   Tue, 1 Oct 2019 12:08:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l0stpog.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/19 10:07 AM, Florian Weimer wrote:
> * Arnd Bergmann:
> 
>> On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 10/1/19 8:09 AM, Jens Axboe wrote:
>>>> On 9/30/19 2:20 PM, Arnd Bergmann wrote:
>>>>> All system calls use struct __kernel_timespec instead of the old struct
>>>>> timespec, but this one was just added with the old-style ABI. Change it
>>>>> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
>>>>> the need for compat handlers on 32-bit architectures.
>>>>>
>>>>> Any user space caller will have to use __kernel_timespec now, but this
>>>>> is unambiguous and works for any C library regardless of the time_t
>>>>> definition. A nicer way to specify the timeout would have been a less
>>>>> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
>>>>> change that as this would impact both 32-bit and 64-bit users.
>>>>
>>>> Thanks for catching that, Arnd. Applied.
>>>
>>> On second thought - since there appears to be no good 64-bit timespec
>>> available to userspace, the alternative here is including on in liburing.
>>
>> What's wrong with using __kernel_timespec? Just the name?
>> I suppose liburing could add a macro to give it a different name
>> for its users.
> 
> Yes, mostly the name.
> 
> __ names are reserved for the C/C++ implementation (which does not
> include the kernel).  __kernel_timespec looks like an internal kernel
> type to the uninitiated, not a UAPI type.
> 
> Once we have struct timespec64 in userspace, you also end up with
> copying stuff around or introducing aliasing violations.
> 
> I'm not saying those concerns are valid, but you asked what's wrong with
> it. 8-)

FWIW, I do agree, __kernel_timespec sounds like an internal type, not
something apps should be using. timespec64 works a lot better for that.
Oh well.

-- 
Jens Axboe

