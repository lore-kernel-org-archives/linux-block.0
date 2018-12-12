Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF95C6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC7220672
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVxIexH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC7220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLLATT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:19:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36411 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLLATS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:19:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so4139871wmj.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxiXd2FZVEOskGqXT9nuTGyViqFWQhg4F1jZMrKQVig=;
        b=TVxIexH4BNhaguUtGywghMnYmWYT5WBNlQUilR02jsNz4uY2bVkZpaVoy6hOsMcT7D
         +zRruGfxPwJj19G2Nt2VZ+RL4zQIFgPf+iUJ/LCqckmzvmHHcyu6kOk2PtDg4czK67j6
         6pbaH+SSFicyDvWjetJN4rSqbXeyxUIQse03PkscIGRdVKAdtRwXZFLKriFtJv4S2Zlk
         xWsQUL8M+QbkkXXx2kwJ+0e304Xav5G2HsQtvbGZsGdHzdkOrktcdYSBdYs7dVO6uAxV
         UfhqFRQcXHIRlq2qBV0LJuS9A7wQurIcJJ2j6zsjM9qi9SaPwa0GDuiuU3O0qKQhthZd
         8fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxiXd2FZVEOskGqXT9nuTGyViqFWQhg4F1jZMrKQVig=;
        b=BPKha2KeCUI5hs372DBNcsxroJ+2Q3q7vZv8S5iyUroNt2Nv6Fsz+a2ecjgWwHCsnF
         FVz1RW6T4T4jvwsH6wuydIY77EYq3YUA6IJpgvncSsxk5lk3kkwNmV2i1AC5qooNHVmF
         SDQcy84m3eDRrEh7uEfAEPLrPHpgYCKdZkIOdbiNOMeWohVmHslHtKyauRQyKvCb1fJj
         s4kCtTyz+sEIXIE8dINo5/PKsoaSPadGPLRuYTCEMin9GhgibNaLHjMEdLtLPhFXZaq3
         T4eZkrCQRsuIBRuBmCfKFdqgR3wrbBUxAPSvLtmSHDZjefzirU5N+6oTgNSvEJ6nlLgz
         jc6A==
X-Gm-Message-State: AA+aEWYLohnM3OYgGEnxrC/0fIrzTQs2MqxLZUyVOej5ol8sSYqdJ+3q
        Pzy15oxlB0WDsYn2idwvnT1cCPnO2ooPulvi4Ww=
X-Google-Smtp-Source: AFSGD/Wgo5vS4bJm+KLivHJ05O6ZxRb14UtURqjeMMAFacci4GgXWiK7vDEdGoJTWjHu0m32Hifr21qo4oB26WqI/aQ=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr4048432wml.61.1544573956570;
 Tue, 11 Dec 2018 16:19:16 -0800 (PST)
MIME-Version: 1.0
References: <1544569107.185366.391.camel@acm.org> <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
In-Reply-To: <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 12 Dec 2018 08:19:04 +0800
Message-ID: <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com>
Subject: Re: for-next hangs on test srp/012
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 8:04 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/11/18 3:58 PM, Bart Van Assche wrote:
> > Hi Jens,
> >
> > If I run the following subset of blktests:
> >
> >   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> >
> > against today's for-next branch (commit dd2bf2df85a7) then after some
> > time the following hang is reported:
> >
> > INFO: task fio:14869 blocked for more than 120 seconds.
> >       Not tainted 4.20.0-rc6-dbg+ #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > fio             D25272 14869  14195 0x00000000
> > Call Trace:
> >  __schedule+0x401/0xe50
> >  schedule+0x4e/0xd0
> >  io_schedule+0x21/0x50
> >  blk_mq_get_tag+0x46d/0x640
> >  blk_mq_get_request+0x7c0/0xa00
> >  blk_mq_make_request+0x241/0xa70
> >  generic_make_request+0x411/0x950
> >  submit_bio+0x9b/0x250
> >  blkdev_direct_IO+0x7fb/0x870
> >  generic_file_direct_write+0x119/0x210
> >  __generic_file_write_iter+0x11c/0x280
> >  blkdev_write_iter+0x13c/0x220
> >  aio_write+0x204/0x310
> >  io_submit_one+0x9c6/0xe70
> >  __x64_sys_io_submit+0x115/0x340
> >  do_syscall_64+0x71/0x210
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > When that hang occurs my list-pending-block-requests script does not show
> > any pending requests:
> >
> > # list-pending-block-requests
> > dm-0
> > loop0
> > loop1
> > loop2
> > loop3
> > loop4
> > loop5
> > loop6
> > loop7
> > nullb0
> > nullb1
> > sda
> > sdb
> > sdc
> > sdd
> > vda
> > vdb
> >
> > Enabling fail_if_no_path mode did not resolve the hang so I don't think
> > that the root cause is in any of the dm drivers used in this test:
> >
> > # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
> > 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
> >
> > The same test passes against kernel v4.20-rc6.
>
> What device is this being run on?

I saw this issue on usb storage too.

Seems it is introduced by commit ea86ea2cdced ("sbitmap: ammortize cost of
clearing bits"). When the IO hang happens, .cleared is 2, and .busy is 0 on
the sched_tag's sbitmap queue.

thanks,
Ming Lei
