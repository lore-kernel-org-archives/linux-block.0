Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C02C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3B2087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 13:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c54LAnKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfARNkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:40:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfARNkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 08:40:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so15065765wrs.8;
        Fri, 18 Jan 2019 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH+fVGaXnZpX1IM1vDhdAcQQqFNApzK+laDoHArjDGU=;
        b=c54LAnKyBd4w0VdJEVaCO++0sEyUiuZg0V/vtM64ma/333BYGQfxTokwqeMqjF6Z2u
         pcZYmJ9SyNzaEyXqCydLlZcRak8Kb8enZ2JhX4y6I6R+r19RA2Ajd2ecHzKtPLsOtTa7
         FTmWh2aeer5g5VqnNu5Zt3KvW+5K3ZTlmKdSvSRKPDZdYTUPAR3mmhQmqUYl40lMIR8k
         6IxehR1tNTZcDz9XiKVXRGU8SuULZhH2Uxyde7CUBgmmgWJ5FgMk63XIKZybzOT2DA5S
         fiYqnbd4fHk3y8rGUgnr9AQe8PhuxzJ6y51WTkeosuFllTMCLylzyvYA1a8U5xzOqvj+
         xbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH+fVGaXnZpX1IM1vDhdAcQQqFNApzK+laDoHArjDGU=;
        b=X/+8kpSFTiGoEY25uMKimrbY9kHbGV9ypfKz38bgcQ1rBPnBU9hdH/wc/2LAhIurDR
         h74hmhP0CHuDIAsS0k0mSxIR6TM1x9Qu7kxQNLatSk4GPukZQRx3LY/Y0E9be5yVHb9b
         HS4PS9twrQn5bJS9G3QKmvDcE6YZlqqlRHeBCHRqTvI45efnAETNRvK168cbSiqRQj9X
         /rnj5PtDzAwDQjDakkDXXC0lt4H1BXwVMqYRwvgK75W6sBMMdJBUUSEq2BByKNCkmmBj
         /7C/P0pVabbPlMgkdjxiF64m92HrM8ytUEnH0+4DbwI9WgZcg33bI6QAOlx8diDZdd39
         k5aA==
X-Gm-Message-State: AJcUukebpNpmIlA3mQXJUVAgbkOEfzPY+D1Ec+hvuSj5I+KPOIgcLDkV
        JaZ8iPvR3+X5jvqf4mHlpF+JAZwjZqeffMEkmy9j/bVq
X-Google-Smtp-Source: ALg8bN6MvjIlTI+lRRf68NHVSeRyoMmXXUKWRD2EJRnQUnQBFj3Pqbnp2NKZ616CzyZf9f0dGGuqmWgOPa2VvAB9+f8=
X-Received: by 2002:adf:ce02:: with SMTP id p2mr17894406wrn.185.1547818801940;
 Fri, 18 Jan 2019 05:40:01 -0800 (PST)
MIME-Version: 1.0
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
In-Reply-To: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 18 Jan 2019 21:39:49 +0800
Message-ID: <CACVXFVOwihuWJ9p52G_zEE7tw_BgEK7fnw3LgSJuG-FzWGT=ag@mail.gmail.com>
Subject: Re: dd hangs when reading large partitions
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, Jens Axboe <axboe@kernel.dk>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 8:11 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Hello,
>
> I'm running into an issue which I don't know how to debug.
> So I'm open to ideas and suggestions :-)
>
> On my arm64 board, I have enabled Universal Flash Storage support.
>
> I wanted to benchmark read performance, and noticed that the system
> locks up when I read partitions larger than 3.5 GB, unless I tell
> dd to use direct IO:
>
> *** WITH O_DIRECT ***
> # dd if=/dev/sda of=/dev/null bs=1M iflag=direct status=progress
> 57892929536 bytes (58 GB, 54 GiB) copied, 697.006 s, 83.1 MB/s
> 55256+0 records in
> 55256+0 records out
> 57940115456 bytes (58 GB, 54 GiB) copied, 697.575 s, 83.1 MB/s
>
> *** WITHOUT O_DIRECT ***
> # dd if=/dev/sda of=/dev/null bs=1M status=progress
> 3853516800 bytes (3.9 GB, 3.6 GiB) copied, 49.0002 s, 78.6 MB/s
>
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=2626
> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=2626
> rcu:    (detected by 7, t=5254 jiffies, g=-275, q=2)
> Task dump for CPU 1:
> kworker/1:1H    R  running task        0   675      2 0x0000002a
> Workqueue: kblockd blk_mq_run_work_fn
> Call trace:
>  __switch_to+0x168/0x1d0
>  0xffffffc0f6efbbc8
>  blk_mq_run_work_fn+0x28/0x40
>  process_one_work+0x208/0x470
>  worker_thread+0x48/0x460
>  kthread+0x128/0x130
>  ret_from_fork+0x10/0x1c
> Task dump for CPU 6:
> kthreadd        R  running task        0     2      0 0x0000002a
> Call trace:
>  __switch_to+0x168/0x1d0
>  0x5b36396f4e7d4000
>
>
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=10500
> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=10500
> rcu:    (detected by 7, t=21009 jiffies, g=-275, q=2)
> Task dump for CPU 1:
> kworker/1:1H    R  running task        0   675      2 0x0000002a
> Workqueue: kblockd blk_mq_run_work_fn
> Call trace:
>  __switch_to+0x168/0x1d0
>  0xffffffc0f6efbbc8
>  blk_mq_run_work_fn+0x28/0x40
>  process_one_work+0x208/0x470
>  worker_thread+0x48/0x460
>  kthread+0x128/0x130
>  ret_from_fork+0x10/0x1c
> Task dump for CPU 6:
> kthreadd        R  running task        0     2      0 0x0000002a
> Call trace:
>  __switch_to+0x168/0x1d0
>  0x5b36396f4e7d4000
>
>
> The system always hangs around the 3.6 GiB mark, wherever I start from.
> How can I debug this issue?

Maybe you can try to collect debugfs log first via the following command?

(cd /sys/kernel/debug/block/sda && find . -type f -exec grep -aH . {} \;)

BTW,  I have several questions on this report:

- what is the kernel version in your test?
- can you reproduce this issue on other disk(not UFS)?
- are there any tasks in 'D' state shown via 'ps -ax'? If yes, please dump their
stack trace.

Thanks,
Ming Lei
