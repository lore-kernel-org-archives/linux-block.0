Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9850AC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4E760EB1
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 16:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhJYQGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhJYQGK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 12:06:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80EC061767
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 09:03:48 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso15612553otp.5
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbCxhkAJVaNO1dQNE2uJt3FO0RzSKF+3IACvnUzKPVY=;
        b=JzYQwbjmOn2TXlPx53cYt3yh2Hy+3qTTGKRdQDMqfmSUFUHRUqU0LhI9saO43sep6u
         iiW0Rzno8Rh70KcFPuoDEAk5NwpHoc3f3sncS96FGOJpR2etGwKmOaVl+47I8uHH78LA
         /f8Y/BZCHwgGlOkOVmtPV94cx65+CXEvE3OIssLtiEIsT/7NVFQIJn53MjK3DlC3uH1o
         QFRr8Fk/OCnG+uFuB8rVsseuJv3kQ2K2FhAwW+mARUpio0K2QsD11PAovGWcNzaJfTd9
         Z2KE4dDLI/dQDOZDFTWjt7DgV4N5JSfKmS33QSfATgkHHqjhQL8mHyaDFmXr5Fzb9orD
         yUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbCxhkAJVaNO1dQNE2uJt3FO0RzSKF+3IACvnUzKPVY=;
        b=M3VEBI6kHndBC2nNgBtaPoh5/uXsBUdeInNf8dWFmsXTWrjD2IuK81XkxMKo0WtXBN
         Re6cvxWHE37Rzw727DbY1G/W+hHRuQxY1ZR4ScNyNIoahFJvHQ4QxmIVb2YLQiWQxrna
         mqF3F4QjiJ2s5kiU9oiPPhYdy1Fsr6fsIwTxGSU1ChgBSoJeTIGLdhMnZTBlazDhrtHw
         IZJGoihKtFJIjcz+HlV/gzhOTlYUOdxRKxfYUeh6XHkRZGKMlMd+VnA0/1DsMe/meWPp
         tDrWRfg4YpP1kZxE45Ww/G9/TwHZa9tZMpAbIKBYuy3H7nQZM6/dMv2dplcH7NT4uHEY
         IgYg==
X-Gm-Message-State: AOAM5317H2EtFmj04y8V9MTN+DiNBt2joLEKWnWJQCsT4bstBSuv1r/B
        BHgCyJnSsIlWtSypIEaw51NQQCzZwLHA0r2aN94PWFF0AU8uKg==
X-Google-Smtp-Source: ABdhPJyQJgxGdAYLo/5PxG/pFX+ODAk9ay2jei/14PjdYP+ULPo6jpMiPcgLX5LIgcVihvuWEgH7d/utg/BcpBsL7PY=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr14054877otb.92.1635177827057;
 Mon, 25 Oct 2021 09:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000089871905cf2b7d09@google.com> <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
 <CANpmjNO1kTswzGp03o_=wMiFekXoq-kvDCy+zKSP3r5+EeOvMg@mail.gmail.com> <b5dd012d-531e-a2ae-18b0-dc2300246298@kernel.dk>
In-Reply-To: <b5dd012d-531e-a2ae-18b0-dc2300246298@kernel.dk>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Oct 2021 18:03:35 +0200
Message-ID: <CANpmjNNVh65W00BBRFWwUDp0F4+8RXnU7azqxbpiLuvuev6xEQ@mail.gmail.com>
Subject: Re: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 25 Oct 2021 at 17:40, Jens Axboe <axboe@kernel.dk> wrote:
> On 10/25/21 8:29 AM, Marco Elver wrote:
> > On Mon, 25 Oct 2021 at 15:36, Jens Axboe <axboe@kernel.dk> wrote:
> > [...]
> >>> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
> >>>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
> >>>  blk_mq_put_tag+0x82/0x90
> >>>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
> >>>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
> >>>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
> >>>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
> >>>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
> >>>  blk_complete_reqs block/blk-mq.c:584 [inline]
> >>>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
> >>>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
> >>>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
> >>>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
> >>>  kthread+0x262/0x280 kernel/kthread.c:319
> >>>  ret_from_fork+0x1f/0x30
> >>>
> >>> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
> >>>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
> >>>  blk_mq_put_tag+0x82/0x90
> >>>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
> >>>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
> >>>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
> >>>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
> >>>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
> >>>  blk_complete_reqs block/blk-mq.c:584 [inline]
> >>>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
> >>>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
> >>>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
> >>>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
> >>>  kthread+0x262/0x280 kernel/kthread.c:319
> >>>  ret_from_fork+0x1f/0x30
> >>
> >> This is just a per-cpu alloc hint, it's racy by nature. What's the
> >> preferred way to silence these?
> >
> > That was my guess, but couldn't quite say. We started looking at
> > write/write races as more likely to be harmful (vs. just read/write),
> > and are inclined to let syzbot send out more of such reports. Marking
> > intentional ones would be ideal so we'll be left with the
> > unintentional ones.
> >
> > I would probably use WRITE_ONCE(), just to make sure the compiler
> > doesn't play games here; or if the code is entirely tolerant to even
> > the compiler miscompiling things, wrap the thing in data_race().
>
> It's entirely tolerant, so something like this would do it?

Yup, looks reasonable,

Acked-by: Marco Elver <elver@google.com>

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index c6e2f1f2c4d2..2709ab825499 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -631,7 +631,7 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>  static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, int tag)
>  {
>         if (likely(!sb->round_robin && tag < sb->depth))
> -               *per_cpu_ptr(sb->alloc_hint, cpu) = tag;
> +               data_race(*per_cpu_ptr(sb->alloc_hint, cpu) = tag);
>  }
>
>  void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
>
> --
> Jens Axboe
>
