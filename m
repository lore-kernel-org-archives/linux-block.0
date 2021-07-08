Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D05C07E99
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 09:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A18619CB
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 09:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGHJcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 05:32:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:54109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhGHJci (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jul 2021 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625736584;
        bh=8kHVJRXooFfRe+q2fG2IcWE5oAzcpJoXFZwcURMNHHE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iAtVF+UXERbGpY0Gg/aWy5E5rPcg973k2Idl2OG5ZwBEx2+9Uv09LMHo0HQ1nqflP
         xFyie7CKbD47NpiJAG7aBnVft0e0Q6NSf4XHlhGAbZQLlfbJ/GWyeSN6OArZepbX4E
         7Adx/f4NQ0v3QDuBwfVjgIkUeN2jYDrMoy2xPl+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.175.26]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1l9JhE2dgC-00s72h; Thu, 08
 Jul 2021 11:29:44 +0200
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bernardo Innocenti <bernie@develer.com>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
 <20210706205927.4407-1-abd.masalkhi@gmail.com>
 <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
 <YOWt2swxONAvhesH@ls3530>
 <CAK8P3a1EFuqgZGdpWzib3RxFf6TXCy_CUTZx2ekd0wTbdNdoxg@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <bece0f60-b19e-5601-3bd9-c899c3d4cd93@gmx.de>
Date:   Thu, 8 Jul 2021 11:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1EFuqgZGdpWzib3RxFf6TXCy_CUTZx2ekd0wTbdNdoxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jv53KzQXouaw43xDUVZe3MwZlNLqqXC3spNXZNGSBaTRtIYIU/P
 aS/Lb+E3LGgU+Avl4W21Fq34cyiQeTn3d2a24zRfGT0g0zV+qvkSikgXd1U9fUpee3eWFHI
 EwVzQ7cbt96fURKSXfMr+mbb1HAgQhAGfHs0icOC1/I9ilZAsmrzVlL5AYh1NOdQM6gDVmG
 dwlXQvwAs/vHorNPSQ74A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q2RolDHnw2A=:QtIXFuu5fYsg56jwXJP6W1
 Vdu9WQHtNVmXh0pAvLM3sXdzeupJN4hA+tzmydiDGeCTW6hoNrLLKAEAHWC6tuAYG0dOtXD+m
 6x//VMcheR3f2886octSE/+wXuFB0gQZtQjVYk3OEDN/yLALu35Fu8H3WinLqUYdR88dUKefT
 YBp1qG6/O863t8hQfbcIzi8g650EZ+YAr1TudF7urfRxKvEASREco4UTIvm5CttmUBqsTdFGN
 i/Ux4KaQW22W40ihoDE+2WQ7NU8/0lciPOm+E0Ul6fcSg2w623Mz1G7HmRIsAnhmWYPuxBOkM
 G1M4FvntXaLw3kuCi3Ta4hjGm9bRRnw1Rcyv8ZQ+fkDee+1Gal+AWPaa6uOOWQcqUgVfR3UaS
 b8XCPs1nW9vvNHo4l14JcJ7AAxe7oS7+mi0lVcl0wv8D9yFIl7F9e8uIjYn+szUtW4gM8N3yp
 Zg5JyMktMf2f4KyxXMnKL3zsaw4Jf28JHUdxfe0bnBtdybrb5QxuRyxbhndSItWh2nf+Zf8qh
 c2OlQUG4/XyPKy9KhfsJi94eYoK7x27cOfg27MvWSCh1f2WCJ8uQEvLUUfXxk9FgISwybF3TW
 iRQU1cj4MfN5BBN/rbrMHtmeGI7wXL/6TfnpKGs+ynJd6uYJiXeBLb+j6gs6lzl5FXPVHSCHQ
 aRBgjRavq8LIgznn1AMkBgFw2L7b8KWKK9VkLbiyFxh0qsKDV7cu5i6Mi3DPy/GTBh0OsTunb
 lN9y2dYsPGkNgfocoe+VjXCAXm1X5qUEZC407PhuKW46CXrdjDNwdbLsRMCt9J7ewcKXKB7ym
 ZtYJ8uKQAIw4X8m43TDS8yGxC59nXGIiwFBYpAZnZ9V6vbpQ6QAjYkWw4XHTAESCdG/OumXSN
 ibwU5IalHr+lflYuRh3PS3kheSsT+RfMh/+/5dSxQqSiu6XSpTqMvCCGbxZ+f7viePFr2Z5F4
 Ve3bwo81D8QkWyS3C0OeV/iEov7NqfnsQtgKHvPvy04xGIJYLJnKe2g24w7O5nq2EeOgf6vvb
 xAyby6vU2q9R7gcWDRBSpy9dpRZJ09K6ObpUWIfY30w60v5Yx9SN1tfVjqgcV/X6/tn1Vs9zI
 ds5Yv7cuL6cEQ+D9h42eaojziVlOGsc4iof
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/21 10:39 PM, Arnd Bergmann wrote:
> On Wed, Jul 7, 2021 at 3:36 PM Helge Deller <deller@gmx.de> wrote:
>> * Arnd Bergmann <arnd@arndb.de>:
>>> My first thought was this was a result of -finline-functions getting
>>> enabled by default in gcc-10, but enabling it on gcc-9 did not
>>> help here. It's likely that the gcc behavior was fixed in the process
>>> of enabling the more aggressive inliner by default though.
>>>
>>> I also tried building genhd.o for every architecture that has
>>> gcc-9.4 support and did not find the problem anywhere except
>>> on parisc.
>>>
>>> Using CONFIG_CC_OPTIMIZE_FOR_SIZE did solve the
>>> problem for me (frame size down to 164 bytes), but I could not
>>> pinpoint a specific -f option that fixes it for -O2. Maybe we can
>>> simply change the defconfig here? 32-bit parisc systems are
>>> probably memory limited enough that building a -Os kernel
>>> is a good idea anyway. 64-bit parisc already builds with -Os
>>> but does not see the warning with -O2 either.
>>
>> I agree that the simplest solution is to increase the default value for
>> parisc here.
>> On parisc we have a 32k stack (either 1x32k or 2x16k when using IRQ
>> stacks). I increased the default value to 1280 in 2017, but as can be
>> seen here this isn't sufficient. Either way, we have an active runtime
>> check for stack overflows which has never triggered yet, so let's just
>> remove the compiler warning by increasing the value to 2048. Patch is
>> below.
>>
>> [PATCH] parisc: Increase gcc stack frame check to 2048 for 32- and 64-b=
it
>>
>> parisc uses much bigger frames than other architectures, so increase th=
e
>> stack frame check value to 2048 to avoid compiler warnings.
>
> I think setting it to 2048 is rather excessive,

Since parisc needs roughly twice the frame (and stack) size as x86,
2048 seemed logical since that's the double of what's used on x86.
Of course we can reduce it, e.g. to 1536.

> and it would make you miss other real bugs. What I suggested was to
> change the defconfig to use CONFIG_CC_OPTIMIZE_FOR_SIZE instead.

But then you still will see those warnings in case you choose to not
optize for size.

> The reasoning for the 1280 byte limit on parisc is that it needs a few e=
xtra
> bytes for its larger stack frames, and 1024 for the other 32-bit archite=
ctures
> is only there because anything smaller warns for a handful of functions
> that are fine-tuned to need slightly less than that, when the call chain
> is predictable and using less would impact performance.
>
> I actually think we should reduce the warning limit for 64-bit architect=
ures
> to 1280 bytes as well, but that triggers a couple of warnings that still
> need to be resolved first. In almost all cases, a kernel function needin=
g
> more than 512 bytes is an indication of either a bug in the kernel, or
> (rarely) in the compiler.

or bad coding, e.g. huge local variables ot too much nesting of local func=
tions.

Helge
