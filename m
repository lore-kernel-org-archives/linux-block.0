Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B8ECE587
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFDF21855
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a6Su93qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfJAPwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:52:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40684 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfJAPwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 11:52:30 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so49151484iof.7
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aYzikBcGz30F8nxgz2XYTBSTQs7V2hCd/C6EA7NzpBk=;
        b=a6Su93qUP+aKyezqwC9e8cP4OQnwhhnemV2uK/QN4Ile1m1o0yOByD+BVJWzXTeIKS
         4jtRnMyN2qbrCqIAxTfsUCwFdf8K5lmSdlrmTVkRecw7gzRn+RApQZPWRB7yt0xYAVkc
         rhHSpEiJ4g+XxGJZgWmM8PYbb1ulOU68ftoamqHBQvRMEMvuIr02AfyLIVM8/+ytBVi+
         iG1SWMcdsNMRBl4FMysO3n7jDF7xX50TXDrY7VTp0aPJIaVM53eNV3HTO83dVOhWqtRx
         Z3WmAI7l1pgYHnlm5AxO++P0SJi7gVYXQcBADI50RBZp0PruiuGgrA52vcM46ZEAu7Or
         jPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aYzikBcGz30F8nxgz2XYTBSTQs7V2hCd/C6EA7NzpBk=;
        b=cixUyyr3RY5cSPkh4pZvorARozqxV539sOJ1+bfqLAX4lwDhYSdmPYd1zcJoMtX4Pf
         H/m6YzA/hRfPkH13TCPPNmjOa00WtwyKbLyQPngyyEVJUbjQK6R1ZNcG/aD/8arm4PX6
         qEAE6K749c7FZ+by+CHeYTD5E0Wl4/2m8ei/CNdi/TMwdldmobMgaKsHU6zupp9UB+cp
         I80oXDwsUPsWgmGgKR8M3JJH+7M1H8HK5tFSPPocMW75e1Lr6JAvFXHdK5RGriKYJ/yU
         mgadlvf7oqXNrrFL6/4ATRl134DHpIqgKMImVEuZ0RdfgIaPZ4oAReQUhuz9NBwvb+QR
         fOKg==
X-Gm-Message-State: APjAAAUSLJX7sb+rGB1hk1/EtXBhr1CQ6HMUOehrpk7u8fjjfnwXDCYx
        thACq9U3V/PqlAe/unRFhtbYOg==
X-Google-Smtp-Source: APXvYqzkyMvVedyfH87M6gwxSqGv62VcC/XAQUXbYPhwOc1GlVZzp8RgT74MDCZTAAXmRssujm0OPQ==
X-Received: by 2002:a02:cc53:: with SMTP id i19mr25466044jaq.10.1569945149751;
        Tue, 01 Oct 2019 08:52:29 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z10sm6873815iog.41.2019.10.01.08.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:52:28 -0700 (PDT)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca0a5bbe-c20e-d5be-110e-942c604ad2d7@kernel.dk>
Date:   Tue, 1 Oct 2019 09:52:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/19 9:49 AM, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/1/19 8:09 AM, Jens Axboe wrote:
>>> On 9/30/19 2:20 PM, Arnd Bergmann wrote:
>>>> All system calls use struct __kernel_timespec instead of the old struct
>>>> timespec, but this one was just added with the old-style ABI. Change it
>>>> now to enforce the use of __kernel_timespec, avoiding ABI confusion and
>>>> the need for compat handlers on 32-bit architectures.
>>>>
>>>> Any user space caller will have to use __kernel_timespec now, but this
>>>> is unambiguous and works for any C library regardless of the time_t
>>>> definition. A nicer way to specify the timeout would have been a less
>>>> ambiguous 64-bit nanosecond value, but I suppose it's too late now to
>>>> change that as this would impact both 32-bit and 64-bit users.
>>>
>>> Thanks for catching that, Arnd. Applied.
>>
>> On second thought - since there appears to be no good 64-bit timespec
>> available to userspace, the alternative here is including on in liburing.
> 
> What's wrong with using __kernel_timespec? Just the name?
> I suppose liburing could add a macro to give it a different name
> for its users.

Just that it seems I need to make it available through liburing on
systems that don't have it yet. Not a big deal, though.

>> That seems kinda crappy in terms of API, so why not just use a 64-bit nsec
>> value as you suggest? There's on released kernel with this feature yet, so
>> there's nothing stopping us from just changing the API to be based on
>> a single 64-bit nanosecond timeout.
> 
> Certainly fine with me.
> 
>> +       timeout = READ_ONCE(sqe->addr);
>>          hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>>          req->timeout.timer.function = io_timeout_fn;
>> -       hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
>> +       hrtimer_start(&req->timeout.timer, ns_to_ktime(timeout),
> 
> It seems a little odd to use the 'addr' field as something that's not
> an address,
> and I'm not sure I understand the logic behind when you use a READ_ONCE()
> as opposed to simply accessing the sqe the way it is done a few lines
> earlier.
> 
> The time handling definitely looks good to me.

One thing that struck me about this approach - we then lose the ability to
differentiate between "don't want a timed timeout" with ts == NULL, vs
tv_sec and tv_nsec both being 0.

I think I'll stuck with that you had and just use __kernel_timespec in
liburing.

-- 
Jens Axboe

