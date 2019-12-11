Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C948C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135BB2077B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cCr0sQef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfLKR4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:56:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43955 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLKR4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 12:56:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id q16so1702836plr.10
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 09:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRVFD1bafqlop8KC5+QxgHkFA+nwAQB0BO4neWc6wjc=;
        b=cCr0sQefSABHhfJ3P9U7VB5H/PQSWJw8ud/yKF7kJDnOR4+q6d/UzFZpQrYMRaePCA
         5IH1xgPgEjLt+tPCTRNnBzuuO5/A9G9n8qMxnbK2ja/4RdR8sjoL5owoAQEWv2ekCISC
         itvCR/MJMizqrErrNFECv+gtD9GabTVf544GeSInEf37oiivpoWkhs4KSNqqPD4+/hkY
         1Aec5Lt1jmOFW15RaC6da4+9EQcnXH88b9t7ijZ4yyUeGQ+9CYc1ivHC4QD8IJyDYjb/
         BHveFajgqMOqBddfVh/nGfKxkk0GlZM1Qqen9+J11QD9r7QdZKvyrxgpR5t224WE8XgM
         bA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRVFD1bafqlop8KC5+QxgHkFA+nwAQB0BO4neWc6wjc=;
        b=tgfIS1786f2tFb7Dv3RMuKLqYJhvshki7ozJZlqcif+6J3qnFz8yoE24QyK5mluZeY
         qPy4ueTWs5oPDKIGV9WKXlOVZeKenIYulVLjTpdaG9ryxKIX3p0T2EldLRVd6N7wRvki
         IHV5o9RgB5iLJqISZeXD6fwuWnfZdbymkYA6lVDMX24bx9k+1bm40RHLHrdBd+Bh2d8V
         IbFCTVnjdm6GUxu0Vn3Yanttjt6lSjoYSY2tjU77nIBSUO3ZQ0rzfx8PgZdrdsQhuNSj
         wZjf8xA7r51XldYBb8EbVvYNUf3xjOgyk6EfkXtOeuUz/baM8gMglnZr2pWjky3TxE8g
         25EQ==
X-Gm-Message-State: APjAAAUJ5znLnKtD72rGKPMG0PsyDMlxqk0vBpjL/tHWZpy5BSd7uGfh
        2Van7EOf/R2bp9uBUjDKob8TGw==
X-Google-Smtp-Source: APXvYqz2694ck0q/LeJl/BvrY89F4L4D5BUbrojJ8dJkDVsPXXDfIJa17vY/zweqiHbYrHlJFVU4TA==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr4644864plb.138.1576086974488;
        Wed, 11 Dec 2019 09:56:14 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id h64sm3274153pje.2.2019.12.11.09.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:56:13 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
Date:   Wed, 11 Dec 2019 10:56:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 10:37 AM, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 7:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Comments appreciated! This should work on any standard file system,
>> using either the generic helpers or iomap. I have tested ext4 and xfs
>> for the right read/write behavior, but no further validation has been
>> done yet. Patches are against current git, and can also be found here:
> 
> I don't think this is conceptually wrong, but the implementation
> smells a bit.
> 
> I commented on the trivial part (the horrendous argument list to
> iomap_actor), but I wonder how much of the explicit invalidation is
> actually needed?

Agree on the other email on that part, if we continue on this path, then
I'll clean that up and shove the arguments in an actor struct.

> Because active invalidation really is a horrible horrible thing to do.
> It immediately means that you can't use this interface for normal
> everyday things that may actually cache perfectly fine.
> 
> What happens if you simply never _activate_ the page? Then they should
> get invalidated on their own, without impacting any other load - but
> only when there is _some_ memory pressure. They'll just stay on the
> inactive lru list, and get re-used quickly.
> 
> Note that there are two ways to activate a page: the "accessed while
> on the inactive list" will activate it, but these days we also have a
> "pre-activate" path in the workingset code (see workingset_refault()).
> 
> Even if you might also want an explicit invalidate path, I would like
> to hear what it looks like if you instead of - or in addition to -
> invalidating, have a "don't activate" flag.
> 
> We don't have all _that_ many places where we activate pages, and they
> should be easy to find (just grep for "SetPageActive()"), although the
> call chain may make it a bit painful to add a "don't do it for this
> access" kind of things.
> 
> But I think most of the regular IO call chains come through
> "mark_page_accessed()". So _that_ is the part you want to avoid (and
> maybe the workingset code). And that should be fairly straightforward,
> I think.

Sure, I can give that a go and see how that behaves.

> In fact, that you say that just a pure random read case causes lots of
> kswapd activity makes me think that maybe we've screwed up page
> activation in general, and never noticed (because if you have enough
> memory, you don't really see it that often)? So this might not be an
> io_ring issue, but an issue in general.

This is very much not an io_uring issue, you can see exactly the same
kind of behavior with normal buffered reads or mmap'ed IO. I do wonder
if streamed reads are as bad in terms of making kswapd go crazy, I
forget if I tested that explicitly as well.

I'll run some streamed and random read testing on both and see how they
behave, then report back.

-- 
Jens Axboe

