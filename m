Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195F0C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82E205C9
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cusvIhK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfDQPC5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:02:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39980 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfDQPC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 11:02:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so12132691pgl.7
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/bdURoKtW/8u/5a4jn4szuT8P44Pm8NPSNVYrBF3e+E=;
        b=cusvIhK0qkq8TkLjtnhm4k9zRNb2gZua9DutW3WKkaPqoHp8qRW3rDVrw2CgaX83Nd
         vntZggEMgqrrM3usUKSjX0PnJ4kUE5cLWlYajwKc7A5kFNvw4SAWRwTYbQUt5yXDhhOz
         NnZvBODAWTBq0hgII89cKF5h1GQL6x+bjQctV6EaLuyCv7uUc8U+25GYKZU9XhOhIS96
         C2UY64otiyHsphmLAXJ7M4B1BmNK7RM+61FC8BSaswp+FBrhPfaawt5JqObM6HODGobx
         IeBWOQiOn/FwHuD2zFcLqzARCoF0yzIafXgauFBp6D4rOut5NHT98CubkBoK3BPtSu0/
         MnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bdURoKtW/8u/5a4jn4szuT8P44Pm8NPSNVYrBF3e+E=;
        b=mkGVCihRnd46faIJ3QFTzXXeo5+nYBn7TFtdYvRzDTQmqASkhOW2lrRSnH41ufleY0
         X1yFZFvzZO28oSSruJUwDENK0aUbiUEV8ga87crTXHuAbNjAixQ3BEwrsJUtH6VJwPmf
         P1LZOZu6mmVXBX2LQWgT4EvuTZRigdKjlVPubCoMBJ2qjdEW9nvre8xF02QZrRof+o9Q
         xRdfmejLazymsqC2gY94LG3BnqR6O0uc9BDXGQ4OFpPj7MijuIDeiR/jsxrMPmEebkiw
         SueA59Q7/LsoCKgfgsPwlDyO2eeGJ8Yk1ZKLYB8FBfY4tIZKr7gRYYpu9YCIJKO4jcEP
         XRuQ==
X-Gm-Message-State: APjAAAXc9tUO53m7Qj5Xq/OOtxEHF2FFOrOyp/lu3cSxaWoTWd8LrxRc
        Jq+ye4vsfKCS4DbrXcnDkTijwQ==
X-Google-Smtp-Source: APXvYqxwvjyoUL315ejEjTsI1SDgvZbwSxhwzEgwH0ZyMOo+R6OOU5F2SmKNg7BzIo/qqNPfLEQYgA==
X-Received: by 2002:a63:e004:: with SMTP id e4mr84164795pgh.344.1555513375754;
        Wed, 17 Apr 2019 08:02:55 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u62sm106364650pfa.124.2019.04.17.08.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:02:54 -0700 (PDT)
Subject: Re: io_uring memory ordering (and broken queue-is-full checks)
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <608965d0-84e0-4d96-8835-afab2b6f2a1a@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03cdf146-12a7-95de-eb78-31cd7df4bb44@kernel.dk>
Date:   Wed, 17 Apr 2019 09:02:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <608965d0-84e0-4d96-8835-afab2b6f2a1a@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/19 10:44 AM, Stefan Bühler wrote:
> Hi all,
> 
> For the record my review was done with commit 4443f8e6ac:
>     Merge tag 'for-linus-20190412' of git://git.kernel.dk/linux-block
> 
> I'm also rather new to memory ordering problems.
> 
> I didn't look into whether the CQ and the SQ need to be synced in any
> way to prevent CQ overflows; my apologies if I deemed barriers
> unnecessary if they were designed for this (to be honest though: such
> barriers should be documented accordingly).
> 
> All in all the io_uring memory ordering instructions look rather broken
> to me.
> 
> This starts with the initial description at the top of io_uring.c:
> 
>> [...] When the application reads the CQ ring
>> tail, it must use an appropriate smp_rmb() to order with the smp_wmb()
>> the kernel uses after writing the tail. Failure to do so could cause a
>> delay in when the application notices that completion events available.
>> This isn't a fatal condition. [...]
> 
> I disagree: a read barrier before reading tail is not useful, and a read
> barrier afterwards is NOT optional, otherwise you might read old CQ
> entries (this is NOT the same as getting completion events "late" - you
> get broken ones).  `smp_load_acquire(tail)` is the correct choice imho
> (although we don't need the store ordering).
> 
> The kernel already uses the matching `smp_store_release` to write the CQ
> tail; the `smp_wmb()` following it is imho not needed.
> 
>> [...] Likewise, the application must use an
>> appropriate smp_wmb() both before writing the SQ tail, and after writing
>> the SQ tail. The first one orders the sqe writes with the tail write, and
>> the latter is paired with the smp_rmb() the kernel will issue before
>> reading the SQ tail on submission.
> 
> The write barrier before is required of course, but the one after is not
> needed imho; what would it order against? Userspace doesn't have
> significant writes after it.
> 
> Again imho the correct choice here would be `smp_store_release` to write
> the tail (although we don't need the store ordering).
> 
> Now to the actual code:
> 
> `io_get_cqring` uses a read barrier before reading the CQ head; this
> looks unnecessary to me.  I'd again use `smp_load_acquire(head)` here,
> but I guess as the conditional depends on the load of head subsequent
> stores might already be ordered.
> 
> `io_get_sqring` too uses a read barrier before reading the SQ tail,
> which looks unnecessary to me.  But this time the following reads *need*
> to be ordered after reading the SQ tail, so either a read barrier after
> reading SQ tail or `smp_load_acquire(tail)` is needed.
> 
> The `smp_wmb()` at the end of `io_get_sqring` is not needed imho; the
> store to `dropped` only needs to be visible once SQ head gets written,
> which uses `smp_store_release` and already syncs previous stores.
> 
> Setting `IORING_SQ_NEED_WAKEUP` in `io_sq_thread` needs a full barrier
> (`smp_mb()`) afterwards though: the store to flags needs to come before
> the load of the SQ tail.  The existing `smp_wmb()` in `io_sq_thread` and
> the `smp_rmb()` in `io_get_sqring` are NOT a full barrier (afaik).
> (This needs a full barrier in userspace too to check for.)
> 
> Resetting `IORING_SQ_NEED_WAKEUP` doesn't need any barrier though: it is
> best effort anyway, and an additional wakeup must not break anything.
> 
> `io_cqring_wait`: imho this can return even when `min_events` is not
> fulfilled (because userspace might read from the queue just before it
> returns).  So the only important thing is that it doesn't block once
> `min_events` events have been queued in CQ.
> 
> It uses read barriers before `io_cqring_events`: the first one isn't
> needed because it isn't critical (and there is nothing to sync with),
> and `prepare_to_wait` already includes a full barrier.

Care to turn the pseudo code into a real patch? Would be easier to
digest. But thanks for taking a look at this!

> The "userspace" liburing looks even worse.  For starters,
> `io_uring_get_completion` cannot safely return a pointer to the CQ entry
> *AND* increment head: you need to actually read the entry before
> incrementing head.

That's a good point, we should actually have this split in two to avoid
the case where the kernel will then fill in a new entry for us.

> Last but not least the kernel side has two lines it checks whether a
> queue is full or not and uses `tail + 1 == head`: this is only true if
> there were U32_MAX entries in the queue.  You should check `(tail -
> head) == SIZE` instead.

Good catch, this is a leftover from when the rings were indeed capped by
the mask of the entries. I've fixed this one and pushed it out, and
added a liburing test case for it as well.


-- 
Jens Axboe

