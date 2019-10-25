Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6ACA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC64222BD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="duXG1RTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJYQ5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:57:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45331 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633159AbfJYQ5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:57:22 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so3157186iot.12
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5pSGcxvGK5oP1IzZ6MvQUjfgBRIVbr1nCRtFhGB+l/g=;
        b=duXG1RTDxWIMYQGeJPrnpPXYv0P9L6mQbFSR2slgjVGBwz6IVjvu7wuAwvset9ZtzV
         6jvmifH2vXVRG6AAjK86eT2Xz2Z/j4apGTbLMUAsQmuowPTsdXgQyctz1HWL1odKHcC0
         uIv0E+gToGvtWjykUoPOxM8CT46Ym0CYklc+ARNcwJwr06H1zrMj/oZl2r4HOlw7Kf+q
         4Vhn8Po11/ajYvBykrEjyA5r1KpMQPhcAaMrdaYaSMOn2t8c/0WJc9qEzTdu3iqZCCL/
         smuw5THimoIjHilWHV25SgbPr9o4M2vGMuZB4tgoYWk5N/YgIYIU5miMuU+Y5Ck+TZ1s
         iGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5pSGcxvGK5oP1IzZ6MvQUjfgBRIVbr1nCRtFhGB+l/g=;
        b=eG5opfgV3H1WNbGTt9mhTaGV8tBF/425C9S8/M3HBYLPXHcL11un2Ig1YiT5Oaz9+B
         cQ6gG9ka3cLoARCwTaVddi/9MLAz/eZANI7U7eT1XyvgP2X8NLSoHis7WQdazKDeGhk8
         xgbch4lLBFHMuro2dF8tS20kWmTtoXLmGWBkuXqWpAzMRBE4DQ/khrt7hPT0w5M1oBfi
         HyfzVBYblqs0suKZOb8Rg1O7IwNEGHSvcy/3OGC6QZNmuisylAbUEdPumcWw+ylbCuZr
         iTnaA9HsoSfJZjAhfe4iC9ioEwjTXfvSv6Vl2k/I8zu8Qohh5lmCRxDQf4//VYaDc5XC
         dVhg==
X-Gm-Message-State: APjAAAXC5+x2VY2ipwojmgGV77Y8L/10As1nZ7asCTFFpKAXlNB9ye+k
        KwwZy5wlGVYhZb0fG1dIHInHDQ==
X-Google-Smtp-Source: APXvYqyUpEp9ixe20yDGImEZLQS+sG7eIycZtte66x8PZp9xJWJA7yk5nLnfMKLdeOUFkdwFPmBODw==
X-Received: by 2002:a05:6602:2581:: with SMTP id p1mr4644702ioo.32.1572022640231;
        Fri, 25 Oct 2019 09:57:20 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r13sm421723ilo.35.2019.10.25.09.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:57:19 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
 <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
 <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0d8a8e1-18dc-8090-037c-e5baf9bd45c3@kernel.dk>
Date:   Fri, 25 Oct 2019 10:57:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e5a6f77a-3404-0dc8-ac6e-584737d71a33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 10:55 AM, Pavel Begunkov wrote:
> On 25/10/2019 19:44, Jens Axboe wrote:
>> On 10/25/19 10:40 AM, Pavel Begunkov wrote:
>>> On 25/10/2019 19:32, Jens Axboe wrote:
>>>> On 10/25/19 10:27 AM, Jens Axboe wrote:
>>>>> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>>>>>> On 25/10/2019 19:03, Jens Axboe wrote:
>>>>>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>>>>>> I found 2 problems with __io_sequence_defer().
>>>>>>>>
>>>>>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>>>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>>>>>>>> it can be maliciously changed.
>>>>>>>>
>>>>>>>> see sent liburing test (test/defer *_hung()), which left an unkillable
>>>>>>>> process for me
>>>>>>>
>>>>>>> OK, how about the below. I'll split this in two, as it's really two
>>>>>>> separate fixes.
>>>>>> cached_sq_dropped is good, but I was concerned about cached_cq_overflow.
>>>>>> io_cqring_fill_event() can be called in async, so shouldn't we do some
>>>>>> synchronisation then?
>>>>>
>>>>> We should probably make it an atomic just to be on the safe side, I'll
>>>>> update the series.
>>>>
>>>> Here we go, patch 1:
>>>>
>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=f2a241f596ed9e12b7c8f960e79ccda8053ea294
>>>>
>>>> patch 2:
>>>>
>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=b7d0297d2df5bfa0d1ecf9d6c66d23676751ef6a
>>>>
>>> 1. submit rqs (not yet completed)
>>> 2. poll_list is empty, inflight = 0
>>> 3. async completed and placed into poll_list
>>>
>>> So, poll_list is not empty, but we won't get to polling again.
>>> At least until someone submitted something.
>>
>> But if they are issued, the will sit in ->poll_list as well. That list
>> holds both "submitted, but pending" and completed entries.
>>
> Missed it, then should work. Thanks!

Glad we agree :-)

>> + ret = iters = 0;
> A small suggestion, could we just initialise it in declaration
> to be a bit more concise?
> e.g. int ret = 0, iters = 0;
> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> And let me test it as both patches are ready.

Sure, I'll make that change and add your reviewed-by. Thanks!

-- 
Jens Axboe

