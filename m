Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33666 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdAWQDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 11:03:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170123140643.32805-1-glider@google.com>
References: <20170123140643.32805-1-glider@google.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Mon, 23 Jan 2017 19:03:39 +0300
Message-ID: <CAPAsAGwii6zLJHf+jZ4zE8_mSgdAWHOEu-d_wXfgrkGJMRzNYQ@mail.gmail.com>
Subject: Re: [PATCH] block: Initialize cfqq->ioprio_class in cfq_get_queue()
To: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Konstantin Serebryany <kcc@google.com>, axboe@fb.com,
        tahsin@google.com, LKML <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

2017-01-23 17:06 GMT+03:00 Alexander Potapenko <glider@google.com>:
> KMSAN (KernelMemorySanitizer, a new error detection tool) reports use of
> uninitialized memory in cfq_init_cfqq():
>
> ==================================================================
> BUG: KMSAN: use of unitialized memory
> ...
> Call Trace:
>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>  [<ffffffff8202ac97>] dump_stack+0x157/0x1d0 lib/dump_stack.c:51
>  [<ffffffff813e9b65>] kmsan_report+0x205/0x360 ??:?
>  [<ffffffff813eabbb>] __msan_warning+0x5b/0xb0 ??:?
>  [<     inline     >] cfq_init_cfqq block/cfq-iosched.c:3754
>  [<ffffffff8201e110>] cfq_get_queue+0xc80/0x14d0 block/cfq-iosched.c:3857
> ...
> origin:
>  [<ffffffff8103ab37>] save_stack_trace+0x27/0x50 arch/x86/kernel/stacktrace.c:67
>  [<ffffffff813e836b>] kmsan_internal_poison_shadow+0xab/0x150 ??:?
>  [<ffffffff813e88ab>] kmsan_poison_slab+0xbb/0x120 ??:?
>  [<     inline     >] allocate_slab mm/slub.c:1627
>  [<ffffffff813e533f>] new_slab+0x3af/0x4b0 mm/slub.c:1641
>  [<     inline     >] new_slab_objects mm/slub.c:2407
>  [<ffffffff813e0ef3>] ___slab_alloc+0x323/0x4a0 mm/slub.c:2564
>  [<     inline     >] __slab_alloc mm/slub.c:2606
>  [<     inline     >] slab_alloc_node mm/slub.c:2669
>  [<ffffffff813dfb42>] kmem_cache_alloc_node+0x1d2/0x1f0 mm/slub.c:2746
>  [<ffffffff8201d90d>] cfq_get_queue+0x47d/0x14d0 block/cfq-iosched.c:3850
> ...
> ==================================================================
> (the line numbers are relative to 4.8-rc6, but the bug persists
> upstream)
>
> The uninitialized struct cfq_queue is created by kmem_cache_alloc_node()
> and then passed to cfq_init_cfqq(), which accesses cfqq->ioprio_class
> before it's initialized.
>

struct cfq_queue is zero initialized (__GFP_ZERO).
The warning is false-positive.
