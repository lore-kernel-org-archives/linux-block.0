Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35126C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE4220866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 14:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="odObGY3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEAOND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 10:13:03 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37963 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfEAOND (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 10:13:03 -0400
Received: by mail-it1-f196.google.com with SMTP id q19so9965494itk.3
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4B4xSIyntfRWfzLH+KStmmap7+7bDy3UyNWKReajOa0=;
        b=odObGY3A4A9IV+rwpK75r2ZxiuXFE2oY8fFavjdILzlWoPj40mlLaBJiLzrWRUEr5N
         jl5D4OKuUHgeYB5yRoNsKlybW2ZqqZsVfRBa0G49ew1bvqVIjOK5J8fdxIpefveAMm5F
         RixnR0MYPuudhaApQ73kriID7/6BXlD/TCS54XPnRO/6ZgZZCjERzcyFaFlx2NvyB9WV
         0rxhHnhM1QpBV+Q10ya0ZU7lNpl3LzCHIWyudLPvg+oi8MvuPTTjNDfLFD896xlBmXij
         +scbWgglP9mWoHK8CIr5SFqYoZaqV846FE9BP165egy0wFFQEBjyXwTYM8ebK0ENcHga
         Wfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4B4xSIyntfRWfzLH+KStmmap7+7bDy3UyNWKReajOa0=;
        b=k5mukUkoyitgBtc9N+v/rD4rJWCOhjpVd6uqrgkWKO4BeFNzMDXZRqfA16UUG4xnhS
         Cg2FRLox4baX19lSkXv9Nh3eaENitKaxp2kdLkwps50Vs9sL25rkUypVPrFvnpOqX9+l
         4rCThovUHteJIOpGsmETj8+V+ujnmKxIJA2L6yvCRDJQvGuPtthEEYhw/X0vN/idX46i
         VW07F7dIoBXGnKyWxI88OKIXm8xqnaFqNCAk8zR3F5VaGtYh0ta8GKtXtzTiC3bWfrH8
         T6+5NQSTLjM4mP/ZZjb1RxGWNRCFbw0rnrdRhNIdGXDHWvCriuew+nCBH3pKvL3IQTfS
         +nNQ==
X-Gm-Message-State: APjAAAV5xgUJq06Rfe+Fqm15yt3WXKncpOfAwfY6WecoW6+j3w9U3VKU
        I2SwnuTriAE9pK3jW3vuPRMFVw==
X-Google-Smtp-Source: APXvYqzNUoLg1N+S7Cof0JCH2Dv9rt45Rc2UlDkc7WTMdJ4YWNPpxJRi64viGoU8e3z5SRK084VqMg==
X-Received: by 2002:a24:c585:: with SMTP id f127mr8342722itg.159.1556719982107;
        Wed, 01 May 2019 07:13:02 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i72sm4086369itc.11.2019.05.01.07.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 07:13:00 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] require RWF_HIPRI for iopoll reads and
 writes
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190501115223.13296-1-source@stbuehler.de>
 <628e59c6-716f-5af3-c1dc-bf5cb9003105@kernel.dk>
 <3173f400-8efd-ec9a-6821-797a360e0c7c@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e65d73d-e694-15e8-cdd7-37ec19c5c42f@kernel.dk>
Date:   Wed, 1 May 2019 08:12:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3173f400-8efd-ec9a-6821-797a360e0c7c@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 7:40 AM, Stefan Bühler wrote:
> Hi,
> 
> On 01.05.19 14:43, Jens Axboe wrote:
>> On 5/1/19 5:52 AM, Stefan Bühler wrote:
>>> This makes the mapping RWF_HIPRI <-> IOCB_HIPRI <-> iopoll more
>>> consistent; it also allows supporting iopoll operations without
>>> IORING_SETUP_IOPOLL in the future.
>>
>> I don't want to make this change now. Additionally, it's never
>> going to be possible to support polled IO mixed with non-polled
>> IO on an io_uring instance, as that makes the wait part of IO
>> impossible to support without adding tracking of requests.
>>
>> As we can never mix them, it doesn't make a lot of sense to
>> request RWF_HIPRI for polled IO.
> 
> I'm not just new to memory ordering, I'm also new to kernel internals :)
> 
> To me it looks like iopoll is basically a busy-loop interface; it helps
> making things move forward more quickly, while they still might (or
> might not) finish on their own.

Right, the key there is that they might not. For NVMe and anything else
that has been updated, polled IO will not finish on its own. It must be
actively found and reaped.

> And io_do_iopoll simply loops over all requests and runs a single
> iteration for them, or, if there is only one request
> ("!poll_multi_file"), it tells it to spin internally.

Correct

> While there are multiple requests it can't spin in a single request
> anyway, and I don't see why it couldn't also check for completion of
> non-polled requests after looping over the polled requests (whether by
> only checking the CQ tail or actively tracking (why would that be bad?)
> the requests some other way).  This only means that as long there are
> non-polled requests pending it mustn't spin in a single request.
> 
> And if there are no polled-requests at all it could use io_cqring_wait.
> 
> So I don't see why it would be impossible to mix polled and non-polled
> IO requests.

It's not technically impossible, but it would be more inefficient to do
so. Adding per-request accounting would cost cycles, and the logic of
how to handle waiting/polling for a mixed workload would be interesting.
Hence it's simpler to simply disallow mixing polled and non polled IO.
There are no real benefits to allowing the mix and match of them.

-- 
Jens Axboe

