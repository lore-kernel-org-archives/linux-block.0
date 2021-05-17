Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C102C433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13E061074
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 12:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhEQMvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhEQMvJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 08:51:09 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F25C061573
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 05:49:53 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q6so2995407qvb.2
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlsNU2ligv/TIt6tqFHJ1ilb9r5vG7LEjQVUSS3/pS8=;
        b=DEaIx5MPBTHEf+xaDgTV5TJyqnSM2yfwZGaiFTzorMqB1Pp1jbBoXmY4PS1v91kha3
         IIft2NRUSYyEb/BEkT0n12aATKKOyQJtz/KvsflBkQo+0SW5COYVHnGKQhHonAVn1vkw
         q5EcQHPSeeBp5/ZwXBZmdjaBb48rwGpQHLmzVAn181l1H0YIC+hI/6/VKy1pYrhDLGYW
         XHUFPluJSJyO7avnIGuYLLoQXSL+wiFYGcGUCq4DZPWcCtqbRJaKajT0/OfeDuveziN6
         PKfQZes4UEMkNdWZl14j8LA/PO8DjSsLqLS0HDA+sQh6X9S8LE67l7TLwy76W0lxZLpd
         7t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlsNU2ligv/TIt6tqFHJ1ilb9r5vG7LEjQVUSS3/pS8=;
        b=jhn+GKFAs/kIfjXbnhfPkK+ombhw6uMiD8/cXIKm3LMpXWLs9M4SUYyTMClSrgKdUx
         NNPubqhCbGA4uQFYFK2UE7NlG2J1W/ogBa5Rgc+8v9/9XwEwe9k3rQB8SknfekqXfA0t
         /Nm3akJQTqmEhyDlG6Ct1irhpSmpoUJx4PPbPGHbc8np3xX0+dbnnlSEx2rY999H2tFm
         6NQhFysrEkwHpMZQ6VqA3RiE/5Am41d7ljeYvem042zUctKeBvfurtPLvRZ9VbC8VkpD
         Q8Rjjq6KvIsfZ9bdlnk+VPU3EFkHCAtThMThboKwZCvUeLBqq2GJKYsDhGbkaO0nD7oj
         Bl0A==
X-Gm-Message-State: AOAM5316M2N0+pdLxB23bXb/WZlrZnj2CNZm4cEVXh5hhAOr/ChsahVe
        lnNAWtu3mty4luun1xC6DwUgsHD1RFpeAcgycuRNrw==
X-Google-Smtp-Source: ABdhPJxAv5IbTZ81kDE7BgK+G4iuu8uB3qTYH5dMaZY8kkl0+2lZvXJ7ynVwmNvfL4jCX0ooZUQpc6J2prerySX+rPU=
X-Received: by 2002:a05:6214:6f1:: with SMTP id bk17mr20486174qvb.37.1621255792082;
 Mon, 17 May 2021 05:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006d129905c284e02d@google.com> <20210517112815.GA11490@lst.de>
In-Reply-To: <20210517112815.GA11490@lst.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 May 2021 14:49:40 +0200
Message-ID: <CACT4Y+aYuzUoQT8zfvtPksiR8bXWea=S=FgqOAvh5r45HWqQ1A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in blk_rq_append_bio
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+1c24e3484e48799b2333@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 17, 2021 at 1:28 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This was fixed just a little later with "block: remove an incorrect check from
> blk_rq_append_bio"

Hi Christoph,

Thanks for checking, let's tell syzbot:

#syz fix: block: remove an incorrect check from blk_rq_append_bio



> On Mon, May 17, 2021 at 04:27:20AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5103a5be Add linux-next specific files for 20210407
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17b28e36d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c278e8a8a7f47f4c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1c24e3484e48799b2333
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1232b5c9d00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17971a36d00000
> >
> > The issue was bisected to:
> >
> > commit 393bb12e00580aaa23356504eed38d8f5571153a
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Wed Mar 31 07:30:01 2021 +0000
> >
> >     block: stop calling blk_queue_bounce for passthrough requests
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134e9381d00000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ce9381d00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=174e9381d00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+1c24e3484e48799b2333@syzkaller.appspotmail.com
> > Fixes: 393bb12e0058 ("block: stop calling blk_queue_bounce for passthrough requests")
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 25 at block/blk-map.c:488 blk_rq_append_bio+0x565/0x680 block/blk-map.c:488
> > Modules linked in:
> > CPU: 0 PID: 25 Comm: kworker/u4:1 Not tainted 5.12.0-rc6-next-20210407-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events_unbound async_run_entry_fn
> > RIP: 0010:blk_rq_append_bio+0x565/0x680 block/blk-map.c:488
> > Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 de 00 00 00 48 8b 44 24 10 48 89 98 a0 00 00 00 45 31 e4 e9 3f fe ff ff e8 6b 3e bc fd <0f> 0b 41 bc ea ff ff ff e9 2d fe ff ff c7 44 24 08 00 00 00 00 e9
> > RSP: 0018:ffffc90000dff6d0 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: ffff888011cbb900 RSI: ffffffff83b7ea55 RDI: 0000000000000003
> > RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
> > R10: ffffffff83b7e568 R11: 0000000000000000 R12: 0000000000000001
> > R13: 0000000000000008 R14: ffff88801c86e400 R15: ffff88801c86e400
> > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fb8501cc930 CR3: 0000000023c21000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  blk_rq_map_kern+0x5db/0x750 block/blk-map.c:653
> >  __scsi_execute+0x4c1/0x600 drivers/scsi/scsi_lib.c:224
> >  scsi_execute_req include/scsi/scsi_device.h:462 [inline]
> >  read_capacity_10+0x112/0x690 drivers/scsi/sd.c:2442
> >  sd_read_capacity drivers/scsi/sd.c:2519 [inline]
> >  sd_revalidate_disk.isra.0+0x206c/0x7c00 drivers/scsi/sd.c:3203
> >  sd_probe+0x9e5/0x1140 drivers/scsi/sd.c:3459
> >  really_probe+0x291/0xf60 drivers/base/dd.c:576
> >  driver_probe_device+0x298/0x410 drivers/base/dd.c:763
> >  __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
> >  bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
> >  __device_attach_async_helper+0x1c9/0x290 drivers/base/dd.c:896
> >  async_run_entry_fn+0x9d/0x550 kernel/async.c:127
> >  process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
> >  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
> >  kthread+0x3b1/0x4a0 kernel/kthread.c:292
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
