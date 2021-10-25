Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E269C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7082E60EFF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhJYOce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJYOcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 10:32:33 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E11C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:30:11 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bk18so15763854oib.8
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecXjdeuJlerx+ehZLpdS9uH72mGz1gRkt8PH2iIoiyc=;
        b=fgTudzKro276crsTGJpTyeoaB6sAoJ8XDuI+R0PiyVw/UZkgembqtSpXJruu/I3WdJ
         GqP3gQPgvpBVg73g5TN4GHQW6RvBpLIMl8SCGRQ0xgarpr39VSGNsobtfOCvJW0TEdiZ
         dXPMKznjHlCVrLFQr1TLGcn5RTBmRqjCxc0F6P3A7GeTzSiTLApvozJFv4WM7InQVJFv
         qZrKjSsVMvHiN0s58JzCECwX+Akow+FOWh3ZUUI63jtUhB8QRMNhBO8LTo3HE2XFNmXr
         oMVywlcPGl3VnRyd+KB9xWKre3utI99r0QMuJxPnk9Kcp23UzZYBMJb5BXPbFkv2sYLM
         99yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecXjdeuJlerx+ehZLpdS9uH72mGz1gRkt8PH2iIoiyc=;
        b=fs3Rv+iCMNVny1IWUmlmj7KMLBsSW2mztLsgNs+43/qDdURE9PXwF7jtDfwSa3zd7S
         n1fHaBZGQtamc5RIQPV4WIOxPaA6amE7t96+tjaMeiyjH36AZgZOxEgm1gcbsphKRfmd
         oSiaMOxksJA5EIUysAy349XlEXkcQKiMnRWbWyTMsoiFDZFI4rugODVXnPbWeLM9r49c
         pxQPj174+cDxKRW/egAegFLjsJeZiYtE0GuCXJ3fQD5G7v/aGDI/pqNEQxU8S4DwdJvq
         fGU+l39ahJ+UQVSw1d7QBktsG7aG6dLZZijleyWFoHEqpn75fr+T+k2aT/p9sXTHTQsm
         1R+Q==
X-Gm-Message-State: AOAM532KDo9BdQZRzltmpP8/ptXvDHH/EMbl45HZIjd1zjk7jeTTv3p1
        WXsPyxFZfUUQdlJRV/EESeXfHQmDjvSyHmXLmpWTMQ==
X-Google-Smtp-Source: ABdhPJxiMfXQeHoEbqfro5PPSN/sZ5fupF/PtRxrPbin+qhcUk7QSAU+7CiaIHIXYL9S4/Xy09CVmTg7RA3En0WJmMI=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr12234154oil.65.1635172209605;
 Mon, 25 Oct 2021 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000089871905cf2b7d09@google.com> <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
In-Reply-To: <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Oct 2021 16:29:57 +0200
Message-ID: <CANpmjNO1kTswzGp03o_=wMiFekXoq-kvDCy+zKSP3r5+EeOvMg@mail.gmail.com>
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

On Mon, 25 Oct 2021 at 15:36, Jens Axboe <axboe@kernel.dk> wrote:
[...]
> > write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
> >  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
> >  blk_mq_put_tag+0x82/0x90
> >  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
> >  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
> >  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
> >  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
> >  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
> >  blk_complete_reqs block/blk-mq.c:584 [inline]
> >  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
> >  __do_softirq+0x12c/0x26e kernel/softirq.c:558
> >  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
> >  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
> >  kthread+0x262/0x280 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30
> >
> > write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
> >  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
> >  blk_mq_put_tag+0x82/0x90
> >  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
> >  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
> >  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
> >  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
> >  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
> >  blk_complete_reqs block/blk-mq.c:584 [inline]
> >  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
> >  __do_softirq+0x12c/0x26e kernel/softirq.c:558
> >  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
> >  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
> >  kthread+0x262/0x280 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30
>
> This is just a per-cpu alloc hint, it's racy by nature. What's the
> preferred way to silence these?

That was my guess, but couldn't quite say. We started looking at
write/write races as more likely to be harmful (vs. just read/write),
and are inclined to let syzbot send out more of such reports. Marking
intentional ones would be ideal so we'll be left with the
unintentional ones.

I would probably use WRITE_ONCE(), just to make sure the compiler
doesn't play games here; or if the code is entirely tolerant to even
the compiler miscompiling things, wrap the thing in data_race().

[ A summary of a bunch of recommendations currently lives here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
]

Thanks,
-- Marco
