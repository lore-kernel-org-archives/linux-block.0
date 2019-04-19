Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9D8C10F14
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 01:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677EC214DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 01:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHJMuPkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDSBAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 21:00:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55875 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfDSBAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 21:00:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so4635757wmf.5;
        Thu, 18 Apr 2019 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zIgJ9xwOuL2QTs3qKBmHCDLkdWKXNCXSosesw+y8uY=;
        b=aHJMuPkzTRZVjAy9b45FH7SwrfuOZQyMOg9bXmrVb1inuPVWRt2AqnezzZOhbbpreL
         VF9i7AUyngjt3wSjaL4m5mFFN9/fCYZxkHAZcNv49+Jcm0lEhTgAwFsDZKuHRUTEItX6
         9nje8CIeXJHJPd16Jzmj1L2qGBe1gvbCR0voJqFlFF14qD5LA+1kR//84xL1E9ZIBi0v
         qs1IE9mzP324j0cxp5sCl27xYm+zefj9y0jYoJq9biCNDc4J8m+gjrB6Dwow1zbwJsz4
         iOA8ykS7aWtso+xOwBbCPhBiCcPUlapk79lKsoQXIqwiYowvCTnAnc3XmO87sT09TVhI
         Qt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zIgJ9xwOuL2QTs3qKBmHCDLkdWKXNCXSosesw+y8uY=;
        b=pzGJ8gDeIfHK8bj2wESXxsdAif8cvmlhgJS40TqFHK/kwaH+QrGuvsU9JBCJ5DXNXi
         pOfYgOmsaS0fzi9YUO60thy4rB0dMY2tyfunx0hsI4F9HTQqPTrAGqP/bpMAHFyFubRK
         3RP6ISCVpqjCX9ZAr7JsXUPczOw0z1iYdtkilo6m61se1uXtOLglvY+Ifx4lX9wp7H+3
         mb9ROpT6t/CglDqOj8bLtuQaRfldOQC1LiWj8aR1VJO0mUmTJVamAeyz9ads9ICRDAgI
         XToPAHjKhCOlCRGXcmZEwQU2CMPCYVQSId/mzF7rKqcqVHGM5DVzUKCNRLw8sIv/aWYy
         FY9w==
X-Gm-Message-State: APjAAAWNFcnCeSYgYBvpdjgRhbHGpF+Z1VT76l0vJyzIouoF84/tH9Kc
        XCCpIZAgkNaUpihO5ICIAF0jH4hb0O/CT16CBIA=
X-Google-Smtp-Source: APXvYqyQ2sElSldk7O2WrrKn70M680Ej19vKI/RoWZQzRvxhaZUlrAmSfI3WwB5w8vpbLNSEt9UiJEAQsnTCMKMRDMU=
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr665573wmg.79.1555635651889;
 Thu, 18 Apr 2019 18:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <1555606721-17679-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1555606721-17679-1-git-send-email-linux@roeck-us.net>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 19 Apr 2019 09:00:39 +0800
Message-ID: <CACVXFVOLr6aWq9PMqHO8pJAou9JLsaq8AhK=w7a=XW+1Pdc1XQ@mail.gmail.com>
Subject: Re: [PATCH -next] block: Warn if page offset is equal to or larger
 than page size
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 19, 2019 at 12:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Prior to commit 8a96a0e40810 ("block: rewrite blk_bvec_map_sg to avoid a
> nth_page call"), it was valid to call blk_bvec_map_sg() with an offset
> equal to or larger than the page size. blk_bvec_map_sg() would then adjust
> page and offset by calling bvec_nth_page(). This is no longer possible.
> Large offsets are now directly passed without validation to sg_set_page().
> This results in data corruption and crashes such as the following,
> observed when trying to boot arm:vexpress from mmc.

The issue is in scatterlist code, which claims(and is supposed) to support
>=PAGE_SIZE offset and start page. However, there is bug somewhere.

>
> Kernel panic - not syncing: Attempted to kill init!  exitcode=0x0000000b
> CPU: 0 PID: 1 Comm: init Tainted: G        W
> 5.1.0-rc5-next-20190418-dirty #1
> Hardware name: ARM-Versatile Express
> [<c0313188>] (unwind_backtrace) from [<c030d920>] (show_stack+0x10/0x14)
> [<c030d920>] (show_stack) from [<c10daad8>] (dump_stack+0xb4/0xc8)
> [<c10daad8>] (dump_stack) from [<c03485fc>] (panic+0x110/0x328)
> [<c03485fc>] (panic) from [<c034d550>] (do_exit+0xbfc/0xc08)
> [<c034d550>] (do_exit) from [<c034e608>] (do_group_exit+0x3c/0xbc)
> [<c034e608>] (do_group_exit) from [<c035ace8>] (get_signal+0x13c/0x9c4)
> [<c035ace8>] (get_signal) from [<c030cd3c>] (do_work_pending+0x1a8/0x5e0)
> [<c030cd3c>] (do_work_pending) from [<c030106c>] (slow_work_pending+0xc/0x20)
>
> The above does not help at all when trying to track down the problem.
> Let's at least add a warning to generate a traceback. The crash will
> still be observed, but at least we'll have a hint what is causing it.
> With this patch applied, we'll see something like the following
> prior to the crash.
>
> WARNING: CPU: 0 PID: 84 at block/blk-merge.c:480 blk_rq_map_sg+0x3cc/0x6ac
> page offset 19456 larger than page size 4096
> Modules linked in:
> CPU: 0 PID: 84 Comm: kworker/0:1H Not tainted 5.1.0-rc5-next-20190418-dirty #1
> Hardware name: ARM-Versatile Express
> Workqueue: kblockd blk_mq_run_work_fn
> [<c0313188>] (unwind_backtrace) from [<c030d920>] (show_stack+0x10/0x14)
> [<c030d920>] (show_stack) from [<c10daad8>] (dump_stack+0xb4/0xc8)
> [<c10daad8>] (dump_stack) from [<c03483ac>] (__warn+0xe0/0xf8)
> [<c03483ac>] (__warn) from [<c0348410>] (warn_slowpath_fmt+0x4c/0x70)
> [<c0348410>] (warn_slowpath_fmt) from [<c078fb5c>] (blk_rq_map_sg+0x3cc/0x6ac)
> [<c078fb5c>] (blk_rq_map_sg) from [<c0eadeec>] (mmc_blk_data_prep+0x1b0/0x2c8)
> [<c0eadeec>] (mmc_blk_data_prep) from [<c0eae054>] (mmc_blk_rw_rq_prep+0x50/0x178)
> [<c0eae054>] (mmc_blk_rw_rq_prep) from [<c0eb145c>] (mmc_blk_mq_issue_rq+0x294/0x880)
> [<c0eb145c>] (mmc_blk_mq_issue_rq) from [<c0eb1e78>] (mmc_mq_queue_rq+0x128/0x230)
> [<c0eb1e78>] (mmc_mq_queue_rq) from [<c07957f8>] (blk_mq_dispatch_rq_list+0x3b4/0x5e0)
> [<c07957f8>] (blk_mq_dispatch_rq_list) from [<c079ab3c>] (blk_mq_do_dispatch_sched+0x70/0x10c)
> [<c079ab3c>] (blk_mq_do_dispatch_sched) from [<c079b238>] (blk_mq_sched_dispatch_requests+0x11c/0x198)
> [<c079b238>] (blk_mq_sched_dispatch_requests) from [<c0793e20>] (__blk_mq_run_hw_queue+0xe0/0x170)
> [<c0793e20>] (__blk_mq_run_hw_queue) from [<c03665d8>] (process_one_work+0x284/0x6b4)
> [<c03665d8>] (process_one_work) from [<c0367914>] (worker_thread+0x44/0x528)
> [<c0367914>] (worker_thread) from [<c036cc6c>] (kthread+0x15c/0x164)
> [<c036cc6c>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xc58d5fb0 to 0xc58d5ff8)
> 5fa0:                                     00000000 00000000 00000000 00000000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace ef7077b559d20ddc ]---
>
> This patch is needed even if the call from mmc_blk_data_prep() is fixed.
> We'll have to expect further problems from callers who are not aware about
> the API change. Those problems will be difficult to track down without
> extra information.
>
> Use WARN_ONCE to report the problem. If the problem is seen, it may be
> seen many times, and we don't want to flood the kernel log with repeated
> messages.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I don't know if there are situations where offset >= PAGE_SIZE
> is acceptable. A quick comparison with current mainline did not report
> any instances where offset >= PAGE_SIZE is passed to sg_set_page().
> I do see a number of warnings triggered by this patch in -next
> (for example with alpha, m68k, ppc64, and riscv64 emulations) which
> do not (or not immediately) result in a crash.
>
> If there is a different / better means to detect a problem, please
> let me know and I'll be happy to adjust the patch accordingly.
>
>  block/blk-merge.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 247b17f2a0f6..9432cd88bd7e 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -475,6 +475,10 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
>                 unsigned offset = bvec->bv_offset + total;
>                 unsigned len = min(get_max_segment_size(q, offset), nbytes);
>
> +               WARN_ONCE(offset >= PAGE_SIZE,
> +                         "page offset %u larger than or equal to page size %ld\n",
> +                         offset, PAGE_SIZE);
> +
>                 *sg = blk_next_sg(sg, sglist);
>                 sg_set_page(*sg, bvec->bv_page, len, offset);

No, it shouldn't be difficult to trigger >= PAGE_SIZE offset, and it
is definitely
correct.


Thanks,
Ming Lei
