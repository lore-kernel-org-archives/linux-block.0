Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2718C43219
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE0C205ED
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 21:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="m5uuBlDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfD0VHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 17:07:38 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:41784 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfD0VHh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 17:07:37 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 936FFC00AD7;
        Sat, 27 Apr 2019 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556399256;
        bh=N8tvkvqtYCLFxVEc/E5xqEQfLjIZxIdBM2aDrK3b9Lo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=m5uuBlDaaDyUux9ZVy7l/vZZV8ei2z7tDRCeG/m0baWn829tTKziLQ1Jy5mQG7kKg
         PfGbkiKX+nNykHGTE48+w1UvG5Qk550e0rqZvY1/cPYiO1o3qal9ln4pC1x2LP86md
         f7CQYcbouRjNfyUcx/dTXnBHs1uIvG6vTO11uYZE=
Subject: Re: io_uring: closing / release
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Message-ID: <87f76da1-5525-086e-7a9c-3bdb2ad12188@stbuehler.de>
Date:   Sat, 27 Apr 2019 23:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 23.04.19 22:31, Jens Axboe wrote:
> On 4/23/19 1:06 PM, Stefan Bühler wrote:
>> I have one other question: is there any way to cancel an IO read/write
>> operation? I don't think closing io_uring has any effect, what about
>> closing the files I'm reading/writing?  (Adding cancelation to kiocb
>> sounds like a non-trivial task; and I don't think it already supports it.)
> 
> There is no way to do that. If you look at existing aio, nobody supports
> that either. Hence io_uring doesn't export any sort of cancellation outside
> of the poll case where we can handle it internally to io_uring.
> 
> If you look at storage, then generally IO doesn't wait around in the stack,
> it's issued. Most hardware only supports queue abort like cancellation,
> which isn't useful at all.
> 
> So I don't think that will ever happen.
> 
>> So cleanup in general seems hard to me: do I have to wait for all
>> read/write operations to complete so I can safely free all buffers
>> before I close the event loop?
> 
> The ring exit waits for IO to complete already.

I now understand at least how that part is working;
io_ring_ctx_wait_and_kill calls wait_for_completion(&ctx->ctx_done),
which only completes after all references are gone; each pending job
keeps a reference.

But wait_for_completion is not interruptible; so if there are "stuck"
jobs even root can't kill the task (afaict) anymore.

Once e.g. readv is working on pipes/sockets (I have some local patches
here for that), you can easily end up in a situation where a
socketpair() or a pipe() is still alive, but the read will never finish
(I can trigger this problem with an explicit close(uring_fd), not sure
how to observe this on process exit).

For a socketpair() even both ends could be kept alive by never ending
read jobs.

Using wait_for_completion seems like a really bad idea to me; this is a
problem for io_uring_register too.

cheers,
Stefan
