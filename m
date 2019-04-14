Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96191C10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5507120896
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="CzvkC8fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfDNQwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:52:02 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:50604 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfDNQwC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 12:52:02 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 12:52:00 EDT
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id CD96DC02FCA;
        Sun, 14 Apr 2019 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1555260262;
        bh=3XyFFBlNKwOQ7hscmO0AEmqi5+VPmigYe4kWSMklXrg=;
        h=To:From:Subject:Date:From;
        b=CzvkC8foTOp/7XA8p3txdYi9bd6UHlRju0INHJmtP9s68TsBjhtxEec3ITbuMZdWJ
         DdvZ3yUx4vWTknilm4NHluHN5KwX26N2s+LNqhheLvgEvudj/Y0RuqOpmjgoLnK3mj
         pYS+rxs3pFYYO66FR8A0ONp1pUE+3S7ByovS1oY4=
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Subject: io_uring memory ordering (and broken queue-is-full checks)
Message-ID: <608965d0-84e0-4d96-8835-afab2b6f2a1a@stbuehler.de>
Date:   Sun, 14 Apr 2019 18:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

For the record my review was done with commit 4443f8e6ac:
    Merge tag 'for-linus-20190412' of git://git.kernel.dk/linux-block

I'm also rather new to memory ordering problems.

I didn't look into whether the CQ and the SQ need to be synced in any
way to prevent CQ overflows; my apologies if I deemed barriers
unnecessary if they were designed for this (to be honest though: such
barriers should be documented accordingly).

All in all the io_uring memory ordering instructions look rather broken
to me.

This starts with the initial description at the top of io_uring.c:

> [...] When the application reads the CQ ring
> tail, it must use an appropriate smp_rmb() to order with the smp_wmb()
> the kernel uses after writing the tail. Failure to do so could cause a
> delay in when the application notices that completion events available.
> This isn't a fatal condition. [...]

I disagree: a read barrier before reading tail is not useful, and a read
barrier afterwards is NOT optional, otherwise you might read old CQ
entries (this is NOT the same as getting completion events "late" - you
get broken ones).  `smp_load_acquire(tail)` is the correct choice imho
(although we don't need the store ordering).

The kernel already uses the matching `smp_store_release` to write the CQ
tail; the `smp_wmb()` following it is imho not needed.

> [...] Likewise, the application must use an
> appropriate smp_wmb() both before writing the SQ tail, and after writing
> the SQ tail. The first one orders the sqe writes with the tail write, and
> the latter is paired with the smp_rmb() the kernel will issue before
> reading the SQ tail on submission.

The write barrier before is required of course, but the one after is not
needed imho; what would it order against? Userspace doesn't have
significant writes after it.

Again imho the correct choice here would be `smp_store_release` to write
the tail (although we don't need the store ordering).

Now to the actual code:

`io_get_cqring` uses a read barrier before reading the CQ head; this
looks unnecessary to me.  I'd again use `smp_load_acquire(head)` here,
but I guess as the conditional depends on the load of head subsequent
stores might already be ordered.

`io_get_sqring` too uses a read barrier before reading the SQ tail,
which looks unnecessary to me.  But this time the following reads *need*
to be ordered after reading the SQ tail, so either a read barrier after
reading SQ tail or `smp_load_acquire(tail)` is needed.

The `smp_wmb()` at the end of `io_get_sqring` is not needed imho; the
store to `dropped` only needs to be visible once SQ head gets written,
which uses `smp_store_release` and already syncs previous stores.

Setting `IORING_SQ_NEED_WAKEUP` in `io_sq_thread` needs a full barrier
(`smp_mb()`) afterwards though: the store to flags needs to come before
the load of the SQ tail.  The existing `smp_wmb()` in `io_sq_thread` and
the `smp_rmb()` in `io_get_sqring` are NOT a full barrier (afaik).
(This needs a full barrier in userspace too to check for.)

Resetting `IORING_SQ_NEED_WAKEUP` doesn't need any barrier though: it is
best effort anyway, and an additional wakeup must not break anything.

`io_cqring_wait`: imho this can return even when `min_events` is not
fulfilled (because userspace might read from the queue just before it
returns).  So the only important thing is that it doesn't block once
`min_events` events have been queued in CQ.

It uses read barriers before `io_cqring_events`: the first one isn't
needed because it isn't critical (and there is nothing to sync with),
and `prepare_to_wait` already includes a full barrier.

The `smp_rmb()` in `io_uring_poll` actually looks correct; imho
`poll_wait` should include a read barrier (lots of usages look like they
assume it does), but I couldn't find it.  The other end `wq_has_sleeper`
has a full memory barrier to sync with, and the `smp_wmb()` in
`io_commit_cqring` preceding it is not needed imho.


The "userspace" liburing looks even worse.  For starters,
`io_uring_get_completion` cannot safely return a pointer to the CQ entry
*AND* increment head: you need to actually read the entry before
incrementing head.


Last but not least the kernel side has two lines it checks whether a
queue is full or not and uses `tail + 1 == head`: this is only true if
there were U32_MAX entries in the queue.  You should check `(tail -
head) == SIZE` instead.

cheers,
Stefan

PS: I'm not subscribed to the lists, so please keep me in CC when you
expect me to read it :)

PPS:

I came up with some pseudo-code for the basic queue handling (as I think
it should look like), maybe this helps:

queue writer (writes tail, reads head):

```
    cached_head := load_acquire(p_head)
    while want_write_more_entries() && (local_tail - cached_head) < SIZE:
        entry[MASKED(local_tail++)] = ...
    store_release(p_tail, local_tail)

    // userspace: if we need to check whether kernel thread is sleeping
    // and needs wakeup (IORING_SETUP_SQPOLL)
    smp_barrier(); // tail store vs flags load: both read and write barrier
    if load(p_flags) & NEED_WAKEUP:
        wakeup_kernel_thread()
```

queue reader (writes head, reads tail):

```
    cached_tail := load_acquire(tail)
handle_entries:
    while want_read_more_entries() && local_head != cached_tail:
        yield entry[MASKED(local_head++)]
    store_release(p_head, local_head)

    // kernel side: sq read thread (IORING_SETUP_SQPOLL) can go sleeping;
    // userspace checks flag *after* storing tail whether a wakeup is needed
    prepare_to_wait(...);
    flags |= NEED_WAKEUP
    smp_barrier(); // flags store vs tail load: both read and write barrier
    cached_tail := load_acquire(tail)
    if local_head != cached_tail:
        flags &= ~NEED_WAKEUP
        goto handle_entries
    else:
        sleep()
```
