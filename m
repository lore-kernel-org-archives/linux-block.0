Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_ADSP_ALL,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1987EC282E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD33205F4
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="WCGkr346"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfDSSrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:47:15 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:51518 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbfDSSrJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:47:09 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 789DFC00419;
        Fri, 19 Apr 2019 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1555666172;
        bh=AHb8CfQKOWGlFL1TtrlxatFU+ygEfS3Ocl22J8lbLcQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=WCGkr346HaALa904NhulADDOFxfbycYGTYOLrAUAjxRw6m3aCA5Ka7aONziZsibCB
         dJiwnsEAAuex9nwc7tYfGEsd3uYUytrxLEjrfCIU0eSC8viFRfWxLj/pbkkV7GATAW
         yezqOz6U5+TDUtscxjoJ2hafujgTeU8P3yrb1xhE=
Subject: Re: io_uring memory ordering (and broken queue-is-full checks)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <608965d0-84e0-4d96-8835-afab2b6f2a1a@stbuehler.de>
 <03cdf146-12a7-95de-eb78-31cd7df4bb44@kernel.dk>
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Message-ID: <54496e17-97de-9f9a-9972-c448226bb768@stbuehler.de>
Date:   Fri, 19 Apr 2019 11:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <03cdf146-12a7-95de-eb78-31cd7df4bb44@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 17.04.19 17:02, Jens Axboe wrote:
> [...]
>
> Care to turn the pseudo code into a real patch? Would be easier to
> digest. But thanks for taking a look at this!

Fair enough; I'm working on it.

I'll start with the actual bugs, and will try to cleanup unneeded
barriers/docs later.

>> The "userspace" liburing looks even worse.  For starters,
>> `io_uring_get_completion` cannot safely return a pointer to the CQ entry
>> *AND* increment head: you need to actually read the entry before
>> incrementing head.
> 
> That's a good point, we should actually have this split in two to avoid
> the case where the kernel will then fill in a new entry for us.

I see you already did so in the liburing repo.

When going through liburing code again, I noticed io_uring_submit
assumes there might be pending submission entries in the SQ queue.

But those entries are not "reserved" in the SQE queue; so
io_uring_get_sqe might overwrite SQE data that isn't read by the kernel
through SQ yet.

Is there any motivation behind the indirection?  I see two possible ideas:
- allocate fixed SQE entries for operations, and just add them to SQ
  when needed
- have multiple threads fill SQE in parallel, and only add them to SQ
  when done

Are those actually worth the cost?

liburing doesn't look like it is going to take advantage of it, and the
library I'm writing in Rust right now isn't going to either (actually
even using a fixed sq_ndx == sqe_ndx mapping, i.e. it'll only write
sq->array on startup).

At least consider documenting the motivation :)

>> Last but not least the kernel side has two lines it checks whether a
>> queue is full or not and uses `tail + 1 == head`: this is only true if
>> there were U32_MAX entries in the queue.  You should check `(tail -
>> head) == SIZE` instead.
> 
> Good catch, this is a leftover from when the rings were indeed capped by
> the mask of the entries. I've fixed this one and pushed it out, and
> added a liburing test case for it as well.

I think you missed the second one in io_uring_poll (looking at your
for-linus branch), so I will send a patch for that too.

cheers,
Stefan
