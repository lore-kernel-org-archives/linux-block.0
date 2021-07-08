Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D856C07E9C
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227F7613C1
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhGHPET convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:04:19 -0400
Received: from mta-tor-003.bell.net ([209.71.212.30]:20950 "EHLO
        cmx-torrgo001.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229738AbhGHPES (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 11:04:18 -0400
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [67.71.147.238]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 60C8868801068702
X-CM-Envelope: MS4xfGyTTt95LmJz41oxT9430AOjrGfolv8+y88Ts31Mm1ggFI+mKrxElxz4+y5RQmpxz6amPnn8VN9U+OACfxSyJA11/YdDx+KK4jSqRhUqbx1UGos0AWgI
 8WuoRSwDv2b0aY9sdjDriuUkxDDigFnp7TX/mvFx5Ck+7MwqN7OFCDNepW4VxNP9k2iOToxk4OyZJVqYUE8O9RoFg0s9eXmwLFE6mk/wK85sw1N8DECRyOnq
 K85h4eNkNBZfwPuWnfx6kj26vGAExfyLrfKGlm/yaL7T5HNE4bJePQm/9lkW3bwNyldShbPvVWTd4O31UbaF5eTGjrncYTuY2ynnvGm1BXv/Tv4iRlrUTDVz
 q3vT0X+qNKAQJeYciqGeE7C8p+8QQtJopAHGgJFZdXFG4cMz9UEMHnvI8YP+1ntQf1dyxdDaiya+t/KlAK9An467xvbL2jvY/0owXRE1L81d97L7sZe+DbB/
 DuBciMBVICGUkgJSjeFf0v+/GAto7CjcyzMPyztbL9UX2z8HyVc7z8MKpLLA34LlNZz635kniYrCYOKC
X-CM-Analysis: v=2.4 cv=Udwy9IeN c=1 sm=1 tr=0 ts=60e7134c
 a=/cPhanApxV8nRKTAyWrE3w==:117 a=/cPhanApxV8nRKTAyWrE3w==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=GfkpTtF8mnDkJo9QkI0A:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (67.71.147.238) by cmx-torrgo001.bell.net (5.8.716.03) (authenticated as dave.anglin@bell.net)
        id 60C8868801068702; Thu, 8 Jul 2021 11:01:32 -0400
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
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
 <bece0f60-b19e-5601-3bd9-c899c3d4cd93@gmx.de>
 <CAK8P3a0x4gba+syLqjBDG0634FNDNRTvDm4dQ9p_fmgSXBUiig@mail.gmail.com>
From:   John David Anglin <dave.anglin@bell.net>
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
Message-ID: <3453ec06-fc62-81e4-33e9-88afd51f50f9@bell.net>
Date:   Thu, 8 Jul 2021 11:01:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0x4gba+syLqjBDG0634FNDNRTvDm4dQ9p_fmgSXBUiig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-07-08 7:37 a.m., Arnd Bergmann wrote:
>>> I think setting it to 2048 is rather excessive,
>> Since parisc needs roughly twice the frame (and stack) size as x86,
>> 2048 seemed logical since that's the double of what's used on x86.
>> Of course we can reduce it, e.g. to 1536.
> But it doesn't use twice as much for large functions at all. The stack
> frame for a small function is much larger, so you need a larger kernel
> stack to allow for deely nested call chains, but the frame for single
> function with large variables is only a bit larger as most of it is used up
> by those variables.
Correct.  In the 32-bit target, the stack alignment is 64 bytes.  This is the main reason functions
with small stacks use more stack than on x86.  There's also the frame marker that needs to be
reserved.  In the 64-bit target, the stack alignment is 16 bytes.  However, the minimum allocation
is quite large because of frame marker, 8 call registers and the argument pointer slots.  If a function
uses a significant number of local variables, there shouldn't be much difference in stack size.

Dave

-- 
John David Anglin  dave.anglin@bell.net


