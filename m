Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C49C433EF
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B479E61A3D
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 13:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhKONFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhKONEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 08:04:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10254C061570
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 05:01:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m27so18991470lfj.12
        for <linux-block@vger.kernel.org>; Mon, 15 Nov 2021 05:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ+64SRQauFcOlmlsHvnN4CAfRmB3WwjZYBKGFOfDok=;
        b=ZhoFWjZR/BXB6NyA8iFUDnYiGVYK6g8+hKZwlXD8EJAXifuLdCn4pxoTzFWhPi9TF/
         IJ480o9rgjIcQ1eB4uGwr/0y3elyNy64LYssgG7aZLo4HmeNYvcjV5zQbJOg2t5TA9Xt
         zjbpWMSJZgBXoUQvw7xtm1CLZWWx8A8OpPRGb35/3g5T4zlAH5gShGuHEJk8crYDfLko
         b+brYe+WAGDuBtHl8eMF38FidWMBokaHH02F0ruWGvjQ0lYCelsGp0O/DzPwecPtE/Da
         QAPpoejtzI7ebcBUeewPAf4CccvUzi7Q9vEEn1HGW20b8ZRmOVI/N5f3ZHFFkMYG/zNp
         NqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ+64SRQauFcOlmlsHvnN4CAfRmB3WwjZYBKGFOfDok=;
        b=ndRAby2gSAgCtxz9I2vNcTPFk4kC3fB29vJxYhHelVE30TSrHqcIOPhE0+tqFETeXd
         R/i5myA2le7YdVSu1aLQs4urJslqJ8paSBs2MeO9wi0dPA4EggJKCMNfwFnZsnsjBcz9
         JuSJU/aHlmN+1xEUYffXiG3tiVuEk6cQIOqK7pDVCHjm29vabTX6sSOstotiqg0ZXLNy
         L7pWqsWpzRnkhhn1B/IGk2VvMHeNf08gjFgcwd7CHTZERTksSFJMhn08T7OZmk1kUsW4
         d/KPo7PNDyHwrZnbUrlgQfqHunsSqfNq5IqEVDqhq0LCzK5zswERvVU3D422G3cGjD1y
         JCkw==
X-Gm-Message-State: AOAM533Dr5rrv6UNfPQvsFvmZz2icdAHK47B6lze+6m22KkOITe3r6sP
        YAAtCXGrAxJDjhjUMzQ0ULnItzUmnXlSAnjJIwP75w==
X-Google-Smtp-Source: ABdhPJzYZ20F6rLoWHOA3gyjCPaIMAfFG+16ZqOa/obiKcV6YtWKrg8o9HN1rskFwm6J5og862UkGxh9rh5/CAWNZy4=
X-Received: by 2002:a05:6512:3251:: with SMTP id c17mr29697138lfr.440.1636981302946;
 Mon, 15 Nov 2021 05:01:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJpMwyixY_-AbMvtGGMBWBO3+oOEF9fuWHkYpLWDbXo3dcAGfg@mail.gmail.com>
 <YYsiqUpLdNtshZms@T590>
In-Reply-To: <YYsiqUpLdNtshZms@T590>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 15 Nov 2021 14:01:32 +0100
Message-ID: <CAJpMwyhv0ccnLc1YjJypGs6khar+GjfgmBUH_f-ugo9hpM1Pig@mail.gmail.com>
Subject: Re: Observing an fio hang with RNBD device in the latest v5.10.78
 Linux kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        sashal@kernel.org, jack@suse.cz, Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>, ming.lei@rehdat.com
Content-Type: multipart/mixed; boundary="00000000000011790005d0d369be"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--00000000000011790005d0d369be
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 10, 2021 at 2:39 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hello Haris,
>
> On Tue, Nov 09, 2021 at 10:32:32AM +0100, Haris Iqbal wrote:
> > Hi,
> >
> > We are observing an fio hang with the latest v5.10.78 Linux kernel
> > version with RNBD. The setup is as follows,
> >
> > On the server side, 16 nullblk devices.
> > On the client side, map those 16 block devices through RNBD-RTRS.
> > Change the scheduler for those RNBD block devices to mq-deadline.
> >
> > Run fios with the following configuration.
> >
> > [global]
> > description=Emulation of Storage Server Access Pattern
> > bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
> > fadvise_hint=0
> > rw=randrw:2
> > direct=1
> > random_distribution=zipf:1.2
> > time_based=1
> > runtime=60
> > ramp_time=1
> > ioengine=libaio
> > iodepth=128
> > iodepth_batch_submit=128
> > iodepth_batch_complete=128
> > numjobs=1
> > group_reporting
> >
> >
> > [job1]
> > filename=/dev/rnbd0
> > [job2]
> > filename=/dev/rnbd1
> > [job3]
> > filename=/dev/rnbd2
> > [job4]
> > filename=/dev/rnbd3
> > [job5]
> > filename=/dev/rnbd4
> > [job6]
> > filename=/dev/rnbd5
> > [job7]
> > filename=/dev/rnbd6
> > [job8]
> > filename=/dev/rnbd7
> > [job9]
> > filename=/dev/rnbd8
> > [job10]
> > filename=/dev/rnbd9
> > [job11]
> > filename=/dev/rnbd10
> > [job12]
> > filename=/dev/rnbd11
> > [job13]
> > filename=/dev/rnbd12
> > [job14]
> > filename=/dev/rnbd13
> > [job15]
> > filename=/dev/rnbd14
> > [job16]
> > filename=/dev/rnbd15
> >
> > Some of the fio threads hangs and the fio never finishes.
> >
> > fio fio.ini
> > job1: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job2: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job3: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job4: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job5: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job6: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job7: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job8: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job9: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job10: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job11: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job12: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job13: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job14: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job15: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > job16: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
> > 512B-64.0KiB, ioengine=libaio, iodepth=128
> > fio-3.12
> > Starting 16 processes
> > Jobs: 16 (f=12):
> > [m(3),/(2),m(5),/(1),m(1),/(1),m(3)][0.0%][r=130MiB/s,w=130MiB/s][r=14.7k,w=14.7k
> > IOPS][eta 04d:07h:4
> > Jobs: 15 (f=11):
> > [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][51.2%][r=7395KiB/s,w=6481KiB/s][r=770,w=766
> > IOPS][eta 01m:01s]
> > Jobs: 15 (f=11): [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][52.7%][eta 01m:01s]
> >
> > We checked the block devices, and there are requests waiting in their
> > fifo (not on all devices, just few whose corresponding fio threads are
> > hung).
> >
> > $ cat /sys/kernel/debug/block/rnbd0/sched/read_fifo_list
> > 00000000ce398aec {.op=READ, .cmd_flags=,
> > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > .internal_tag=209}
> > 000000005ec82450 {.op=READ, .cmd_flags=,
> > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > .internal_tag=210}
> >
> > $ cat /sys/kernel/debug/block/rnbd0/sched/write_fifo_list
> > 000000000c1557f5 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > .internal_tag=195}
> > 00000000fc6bfd98 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > .internal_tag=199}
> > 000000009ef7c802 {.op=WRITE, .cmd_flags=SYNC|IDLE,
> > .rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
> > .internal_tag=217}
>
> Can you post the whole debugfs log for rnbd0?
>
> (cd /sys/kernel/debug/block/rnbd0 && find . -type f -exec grep -aH . {} \;)

Attached the logfile.

>
> >
> >
> > Potential points which fixes the hang
> >
> > 1) Using no scheduler (none) on the client side RNBD block devices
> > results in no hang.
> >
> > 2) In the fio config, changing the line "iodepth_batch_complete=128"
> > to the following fixes the hang,
> > iodepth_batch_complete_min=1
> > iodepth_batch_complete_max=128
> > OR,
> > iodepth_batch_complete=0
> >
> > 3) We also tracked down the version from which the hang started. The
> > hang started with v5.10.50, and the following commit was one which
> > results in the hang
> >
> > commit 512106ae2355813a5eb84e8dc908628d52856890
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Fri Jun 25 10:02:48 2021 +0800
> >
> >     blk-mq: update hctx->dispatch_busy in case of real scheduler
> >
> >     [ Upstream commit cb9516be7708a2a18ec0a19fe3a225b5b3bc92c7 ]
> >
> >     Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> >     starts to support io batching submission by using hctx->dispatch_busy.
> >
> >     However, blk_mq_update_dispatch_busy() isn't changed to update
> > hctx->dispatch_busy
> >     in that commit, so fix the issue by updating hctx->dispatch_busy in case
> >     of real scheduler.
> >
> >     Reported-by: Jan Kara <jack@suse.cz>
> >     Reviewed-by: Jan Kara <jack@suse.cz>
> >     Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> >     Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >     Link: https://lore.kernel.org/r/20210625020248.1630497-1-ming.lei@redhat.com
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 00d6ed2fe812..a368eb6dc647 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1242,9 +1242,6 @@ static void blk_mq_update_dispatch_busy(struct
> > blk_mq_hw_ctx *hctx, bool busy)
> >  {
> >         unsigned int ewma;
> >
> > -       if (hctx->queue->elevator)
> > -               return;
> > -
> >         ewma = hctx->dispatch_busy;
> >
> >         if (!ewma && !busy)
> >
> > We reverted the commit and tested and there is no hang.
> >
> > 4) Lastly, we tested newer version like 5.13, and there is NO hang in
> > that also. Hence, probably some other change fixed it.
>
> Can you observe the issue on v5.10? Maybe there is one pre-patch of commit cb9516be7708
> ("blk-mq: update hctx->dispatch_busy in case of real scheduler merged")
> which is missed to 5.10.y.

If you mean v5.10.0, then no, I see no hang there. As I mentioned
before, there is no hang till v5.10.49.

>
> And not remember that there is fix for commit cb9516be7708 in mainline.
>
> commit cb9516be7708 is merged to v5.14, instead of v5.13, did you test v5.14 or v5.15?
>
> BTW, commit cb9516be7708 should just affect performance, not supposed to cause
> hang.

True. It does look like that from the small code change.

I wasn't able to test in v5.14 and v5.15 because we are seeing some
other errors in those versions, most probably related to the
rdma-core/rxe driver.

>
> Thanks,
> Ming
>

PS: I am sending this again since I keep getting this notification
that the delivery failed for my last response.

--00000000000011790005d0d369be
Content-Type: application/octet-stream; name=debugfslog_rnbd0
Content-Disposition: attachment; filename=debugfslog_rnbd0
Content-Transfer-Encoding: base64
Content-ID: <f_kw0ocbil0>
X-Attachment-Id: f_kw0ocbil0

Li9zY2hlZC9zdGFydmVkOjAKLi9zY2hlZC9iYXRjaGluZzo3Ci4vc2NoZWQvd3JpdGVfbmV4dF9y
cTowMDAwMDAwMDk0ZGE2M2ViIHsub3A9V1JJVEUsIC5jbWRfZmxhZ3M9U1lOQ3xJRExFLCAucnFf
ZmxhZ3M9U09SVEVEfEVMVlBSSVZ8SU9fU1RBVHxIQVNIRUQsIC5zdGF0ZT1pZGxlLCAudGFnPS0x
LCAuaW50ZXJuYWxfdGFnPTM1fQouL3NjaGVkL3dyaXRlX2ZpZm9fbGlzdDowMDAwMDAwMDk0ZGE2
M2ViIHsub3A9V1JJVEUsIC5jbWRfZmxhZ3M9U1lOQ3xJRExFLCAucnFfZmxhZ3M9U09SVEVEfEVM
VlBSSVZ8SU9fU1RBVHxIQVNIRUQsIC5zdGF0ZT1pZGxlLCAudGFnPS0xLCAuaW50ZXJuYWxfdGFn
PTM1fQouL3NjaGVkL3dyaXRlX2ZpZm9fbGlzdDowMDAwMDAwMDViY2EyOGI5IHsub3A9V1JJVEUs
IC5jbWRfZmxhZ3M9U1lOQ3xJRExFLCAucnFfZmxhZ3M9U09SVEVEfEVMVlBSSVZ8SU9fU1RBVHxI
QVNIRUQsIC5zdGF0ZT1pZGxlLCAudGFnPS0xLCAuaW50ZXJuYWxfdGFnPTQxfQouL3NjaGVkL3dy
aXRlX2ZpZm9fbGlzdDowMDAwMDAwMDk0MTUxODY2IHsub3A9V1JJVEUsIC5jbWRfZmxhZ3M9U1lO
Q3xJRExFLCAucnFfZmxhZ3M9U09SVEVEfEVMVlBSSVZ8SU9fU1RBVHxIQVNIRUQsIC5zdGF0ZT1p
ZGxlLCAudGFnPS0xLCAuaW50ZXJuYWxfdGFnPTQzfQouL3NjaGVkL3dyaXRlX2ZpZm9fbGlzdDow
MDAwMDAwMGI4Yjg3MDE4IHsub3A9V1JJVEUsIC5jbWRfZmxhZ3M9U1lOQ3xJRExFLCAucnFfZmxh
Z3M9U09SVEVEfEVMVlBSSVZ8SU9fU1RBVHxIQVNIRUQsIC5zdGF0ZT1pZGxlLCAudGFnPS0xLCAu
aW50ZXJuYWxfdGFnPTQ5fQouL3NjaGVkL3dyaXRlX2ZpZm9fbGlzdDowMDAwMDAwMDY1MGFiMmY1
IHsub3A9V1JJVEUsIC5jbWRfZmxhZ3M9U1lOQ3xJRExFLCAucnFfZmxhZ3M9U09SVEVEfEVMVlBS
SVZ8SU9fU1RBVHxIQVNIRUQsIC5zdGF0ZT1pZGxlLCAudGFnPS0xLCAuaW50ZXJuYWxfdGFnPTJ9
Ci4vcnFvcy93YnQvd2JfYmFja2dyb3VuZDo0Ci4vcnFvcy93YnQvd2Jfbm9ybWFsOjgKLi9ycW9z
L3didC91bmtub3duX2NudDowCi4vcnFvcy93YnQvbWluX2xhdF9uc2VjOjIwMDAwMDAKLi9ycW9z
L3didC9pbmZsaWdodDowOiBpbmZsaWdodCAwCi4vcnFvcy93YnQvaW5mbGlnaHQ6MTogaW5mbGln
aHQgMAouL3Jxb3Mvd2J0L2luZmxpZ2h0OjI6IGluZmxpZ2h0IDAKLi9ycW9zL3didC9pZDowCi4v
cnFvcy93YnQvZW5hYmxlZDoxCi4vcnFvcy93YnQvY3Vycl93aW5fbnNlYzowCi4vaGN0eDMvY3B1
My9jb21wbGV0ZWQ6Njk4NyAwCi4vaGN0eDMvY3B1My9tZXJnZWQ6MAouL2hjdHgzL2NwdTMvZGlz
cGF0Y2hlZDo2OTg3IDAKLi9oY3R4My90eXBlOmRlZmF1bHQKLi9oY3R4My9kaXNwYXRjaF9idXN5
OjUKLi9oY3R4My9hY3RpdmU6MAouL2hjdHgzL3J1bjo3NTE0Ci4vaGN0eDMvcXVldWVkOjY5ODcK
Li9oY3R4My9kaXNwYXRjaGVkOiAgICAgICAwCTQ4NTEKLi9oY3R4My9kaXNwYXRjaGVkOiAgICAg
ICAxCTI2ODUKLi9oY3R4My9kaXNwYXRjaGVkOiAgICAgICAyCTIxNwouL2hjdHgzL2Rpc3BhdGNo
ZWQ6ICAgICAgIDQJMjcwCi4vaGN0eDMvZGlzcGF0Y2hlZDogICAgICAgOAkxNjMKLi9oY3R4My9k
aXNwYXRjaGVkOiAgICAgIDE2CTMxCi4vaGN0eDMvZGlzcGF0Y2hlZDogICAgICAzMisJMAouL2hj
dHgzL2lvX3BvbGw6Y29uc2lkZXJlZD0wCi4vaGN0eDMvaW9fcG9sbDppbnZva2VkPTAKLi9oY3R4
My9pb19wb2xsOnN1Y2Nlc3M9MAouL2hjdHgzL3NjaGVkX3RhZ3NfYml0bWFwOjAwMDAwMDAwOiAw
MDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAKLi9oY3R4My9zY2hlZF90YWdz
X2JpdG1hcDowMDAwMDAxMDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAw
Ci4vaGN0eDMvc2NoZWRfdGFnczpucl90YWdzPTI1NgouL2hjdHgzL3NjaGVkX3RhZ3M6bnJfcmVz
ZXJ2ZWRfdGFncz0wCi4vaGN0eDMvc2NoZWRfdGFnczphY3RpdmVfcXVldWVzPTAKLi9oY3R4My9z
Y2hlZF90YWdzOmJpdG1hcF90YWdzOgouL2hjdHgzL3NjaGVkX3RhZ3M6ZGVwdGg9MjU2Ci4vaGN0
eDMvc2NoZWRfdGFnczpidXN5PTAKLi9oY3R4My9zY2hlZF90YWdzOmNsZWFyZWQ9MTk1Ci4vaGN0
eDMvc2NoZWRfdGFnczpiaXRzX3Blcl93b3JkPTY0Ci4vaGN0eDMvc2NoZWRfdGFnczptYXBfbnI9
NAouL2hjdHgzL3NjaGVkX3RhZ3M6YWxsb2NfaGludD17NiwgMjQ1LCA0MSwgMTQxfQouL2hjdHgz
L3NjaGVkX3RhZ3M6d2FrZV9iYXRjaD04Ci4vaGN0eDMvc2NoZWRfdGFnczp3YWtlX2luZGV4PTAK
Li9oY3R4My9zY2hlZF90YWdzOndzX2FjdGl2ZT0wCi4vaGN0eDMvc2NoZWRfdGFnczp3cz17Ci4v
aGN0eDMvc2NoZWRfdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDMv
c2NoZWRfdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDMvc2NoZWRf
dGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDMvc2NoZWRfdGFnczoJ
ey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDMvc2NoZWRfdGFnczoJey53YWl0
X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDMvc2NoZWRfdGFnczoJey53YWl0X2NudD04
LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDMvc2NoZWRfdGFnczoJey53YWl0X2NudD04LCAud2Fp
dD1pbmFjdGl2ZX0sCi4vaGN0eDMvc2NoZWRfdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFj
dGl2ZX0sCi4vaGN0eDMvc2NoZWRfdGFnczp9Ci4vaGN0eDMvc2NoZWRfdGFnczpyb3VuZF9yb2Jp
bj0wCi4vaGN0eDMvc2NoZWRfdGFnczptaW5fc2hhbGxvd19kZXB0aD00Mjk0OTY3Mjk1Ci4vaGN0
eDMvdGFnc19iaXRtYXA6MDAwMDAwMDA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMAouL2hjdHgzL3RhZ3NfYml0bWFwOjAwMDAwMDEwOiAwMDAwIDAwMDAgMDAwMCAwMDAw
IDAwMDAgMDAwMCAwMDAwIDAwMDAKLi9oY3R4My90YWdzX2JpdG1hcDowMDAwMDAyMDogMDAwMCAw
MDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDMvdGFnc19iaXRtYXA6MDAw
MDAwMzA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMAouL2hjdHgzL3Rh
Z3M6bnJfdGFncz01MTIKLi9oY3R4My90YWdzOm5yX3Jlc2VydmVkX3RhZ3M9MAouL2hjdHgzL3Rh
Z3M6YWN0aXZlX3F1ZXVlcz0wCi4vaGN0eDMvdGFnczpiaXRtYXBfdGFnczoKLi9oY3R4My90YWdz
OmRlcHRoPTUxMgouL2hjdHgzL3RhZ3M6YnVzeT0wCi4vaGN0eDMvdGFnczpjbGVhcmVkPTQ1OAou
L2hjdHgzL3RhZ3M6Yml0c19wZXJfd29yZD02NAouL2hjdHgzL3RhZ3M6bWFwX25yPTgKLi9oY3R4
My90YWdzOmFsbG9jX2hpbnQ9ezE2OCwgMjUzLCAyNDYsIDM2OX0KLi9oY3R4My90YWdzOndha2Vf
YmF0Y2g9OAouL2hjdHgzL3RhZ3M6d2FrZV9pbmRleD03Ci4vaGN0eDMvdGFnczp3c19hY3RpdmU9
MAouL2hjdHgzL3RhZ3M6d3M9ewouL2hjdHgzL3RhZ3M6CXsud2FpdF9jbnQ9OCwgLndhaXQ9aW5h
Y3RpdmV9LAouL2hjdHgzL3RhZ3M6CXsud2FpdF9jbnQ9OCwgLndhaXQ9aW5hY3RpdmV9LAouL2hj
dHgzL3RhZ3M6CXsud2FpdF9jbnQ9OCwgLndhaXQ9aW5hY3RpdmV9LAouL2hjdHgzL3RhZ3M6CXsu
d2FpdF9jbnQ9OCwgLndhaXQ9aW5hY3RpdmV9LAouL2hjdHgzL3RhZ3M6CXsud2FpdF9jbnQ9OCwg
LndhaXQ9aW5hY3RpdmV9LAouL2hjdHgzL3RhZ3M6CXsud2FpdF9jbnQ9OCwgLndhaXQ9aW5hY3Rp
dmV9LAouL2hjdHgzL3RhZ3M6CXsud2FpdF9jbnQ9OCwgLndhaXQ9aW5hY3RpdmV9LAouL2hjdHgz
L3RhZ3M6CXsud2FpdF9jbnQ9OCwgLndhaXQ9aW5hY3RpdmV9LAouL2hjdHgzL3RhZ3M6fQouL2hj
dHgzL3RhZ3M6cm91bmRfcm9iaW49MAouL2hjdHgzL3RhZ3M6bWluX3NoYWxsb3dfZGVwdGg9NDI5
NDk2NzI5NQouL2hjdHgzL2N0eF9tYXA6MDAwMDAwMDA6IDAwCi4vaGN0eDMvZmxhZ3M6YWxsb2Nf
cG9saWN5PUZJRk8gU0hPVUxEX01FUkdFfFRBR19RVUVVRV9TSEFSRUQKLi9oY3R4Mi9jcHUyL2Nv
bXBsZXRlZDo0NTg1IDAKLi9oY3R4Mi9jcHUyL21lcmdlZDowCi4vaGN0eDIvY3B1Mi9kaXNwYXRj
aGVkOjQ1OTAgMAouL2hjdHgyL3R5cGU6ZGVmYXVsdAouL2hjdHgyL2Rpc3BhdGNoX2J1c3k6NQou
L2hjdHgyL2FjdGl2ZTowCi4vaGN0eDIvcnVuOjQ2NDQKLi9oY3R4Mi9xdWV1ZWQ6NDU5MAouL2hj
dHgyL2Rpc3BhdGNoZWQ6ICAgICAgIDAJMjc2MQouL2hjdHgyL2Rpc3BhdGNoZWQ6ICAgICAgIDEJ
MTk2NgouL2hjdHgyL2Rpc3BhdGNoZWQ6ICAgICAgIDIJMTE5Ci4vaGN0eDIvZGlzcGF0Y2hlZDog
ICAgICAgNAkxNTMKLi9oY3R4Mi9kaXNwYXRjaGVkOiAgICAgICA4CTc5Ci4vaGN0eDIvZGlzcGF0
Y2hlZDogICAgICAxNgkyNQouL2hjdHgyL2Rpc3BhdGNoZWQ6ICAgICAgMzIrCTQKLi9oY3R4Mi9p
b19wb2xsOmNvbnNpZGVyZWQ9MAouL2hjdHgyL2lvX3BvbGw6aW52b2tlZD0wCi4vaGN0eDIvaW9f
cG9sbDpzdWNjZXNzPTAKLi9oY3R4Mi9zY2hlZF90YWdzX2JpdG1hcDowMDAwMDAwMDogMDQwMCAw
MDAwIDA4MGEgMDIwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDIvc2NoZWRfdGFnc19iaXRt
YXA6MDAwMDAwMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMAouL2hj
dHgyL3NjaGVkX3RhZ3M6bnJfdGFncz0yNTYKLi9oY3R4Mi9zY2hlZF90YWdzOm5yX3Jlc2VydmVk
X3RhZ3M9MAouL2hjdHgyL3NjaGVkX3RhZ3M6YWN0aXZlX3F1ZXVlcz0wCi4vaGN0eDIvc2NoZWRf
dGFnczpiaXRtYXBfdGFnczoKLi9oY3R4Mi9zY2hlZF90YWdzOmRlcHRoPTI1NgouL2hjdHgyL3Nj
aGVkX3RhZ3M6YnVzeT01Ci4vaGN0eDIvc2NoZWRfdGFnczpjbGVhcmVkPTIyMgouL2hjdHgyL3Nj
aGVkX3RhZ3M6Yml0c19wZXJfd29yZD02NAouL2hjdHgyL3NjaGVkX3RhZ3M6bWFwX25yPTQKLi9o
Y3R4Mi9zY2hlZF90YWdzOmFsbG9jX2hpbnQ9ezIwOSwgOTEsIDUwLCAyMTh9Ci4vaGN0eDIvc2No
ZWRfdGFnczp3YWtlX2JhdGNoPTgKLi9oY3R4Mi9zY2hlZF90YWdzOndha2VfaW5kZXg9MAouL2hj
dHgyL3NjaGVkX3RhZ3M6d3NfYWN0aXZlPTAKLi9oY3R4Mi9zY2hlZF90YWdzOndzPXsKLi9oY3R4
Mi9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4Mi9zY2hl
ZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4Mi9zY2hlZF90YWdz
Ogl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4Mi9zY2hlZF90YWdzOgl7Lndh
aXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4Mi9zY2hlZF90YWdzOgl7LndhaXRfY250
PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4Mi9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53
YWl0PWluYWN0aXZlfSwKLi9oY3R4Mi9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWlu
YWN0aXZlfSwKLi9oY3R4Mi9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZl
fSwKLi9oY3R4Mi9zY2hlZF90YWdzOn0KLi9oY3R4Mi9zY2hlZF90YWdzOnJvdW5kX3JvYmluPTAK
Li9oY3R4Mi9zY2hlZF90YWdzOm1pbl9zaGFsbG93X2RlcHRoPTQyOTQ5NjcyOTUKLi9oY3R4Mi90
YWdzX2JpdG1hcDowMDAwMDAwMDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAw
MDAwCi4vaGN0eDIvdGFnc19iaXRtYXA6MDAwMDAwMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAwMDAwIDAwMDAgMDAwMAouL2hjdHgyL3RhZ3NfYml0bWFwOjAwMDAwMDIwOiAwMDAwIDAwMDAg
MDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAKLi9oY3R4Mi90YWdzX2JpdG1hcDowMDAwMDAz
MDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDIvdGFnczpu
cl90YWdzPTUxMgouL2hjdHgyL3RhZ3M6bnJfcmVzZXJ2ZWRfdGFncz0wCi4vaGN0eDIvdGFnczph
Y3RpdmVfcXVldWVzPTAKLi9oY3R4Mi90YWdzOmJpdG1hcF90YWdzOgouL2hjdHgyL3RhZ3M6ZGVw
dGg9NTEyCi4vaGN0eDIvdGFnczpidXN5PTAKLi9oY3R4Mi90YWdzOmNsZWFyZWQ9NDc3Ci4vaGN0
eDIvdGFnczpiaXRzX3Blcl93b3JkPTY0Ci4vaGN0eDIvdGFnczptYXBfbnI9OAouL2hjdHgyL3Rh
Z3M6YWxsb2NfaGludD17NTEwLCAzMjcsIDEwNiwgNTA3fQouL2hjdHgyL3RhZ3M6d2FrZV9iYXRj
aD04Ci4vaGN0eDIvdGFnczp3YWtlX2luZGV4PTQKLi9oY3R4Mi90YWdzOndzX2FjdGl2ZT0wCi4v
aGN0eDIvdGFnczp3cz17Ci4vaGN0eDIvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2
ZX0sCi4vaGN0eDIvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDIv
dGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDIvdGFnczoJey53YWl0
X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDIvdGFnczoJey53YWl0X2NudD04LCAud2Fp
dD1pbmFjdGl2ZX0sCi4vaGN0eDIvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0s
Ci4vaGN0eDIvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDIvdGFn
czoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDIvdGFnczp9Ci4vaGN0eDIv
dGFnczpyb3VuZF9yb2Jpbj0wCi4vaGN0eDIvdGFnczptaW5fc2hhbGxvd19kZXB0aD00Mjk0OTY3
Mjk1Ci4vaGN0eDIvY3R4X21hcDowMDAwMDAwMDogMDAKLi9oY3R4Mi9mbGFnczphbGxvY19wb2xp
Y3k9RklGTyBTSE9VTERfTUVSR0V8VEFHX1FVRVVFX1NIQVJFRAouL2hjdHgxL2NwdTEvY29tcGxl
dGVkOjU3NDIgMAouL2hjdHgxL2NwdTEvbWVyZ2VkOjAKLi9oY3R4MS9jcHUxL2Rpc3BhdGNoZWQ6
NTc0MiAwCi4vaGN0eDEvdHlwZTpkZWZhdWx0Ci4vaGN0eDEvZGlzcGF0Y2hfYnVzeTo3Ci4vaGN0
eDEvYWN0aXZlOjAKLi9oY3R4MS9ydW46NTU3NAouL2hjdHgxL3F1ZXVlZDo1NzQyCi4vaGN0eDEv
ZGlzcGF0Y2hlZDogICAgICAgMAkzNDQ0Ci4vaGN0eDEvZGlzcGF0Y2hlZDogICAgICAgMQkyMDg4
Ci4vaGN0eDEvZGlzcGF0Y2hlZDogICAgICAgMgkxOTMKLi9oY3R4MS9kaXNwYXRjaGVkOiAgICAg
ICA0CTI0MAouL2hjdHgxL2Rpc3BhdGNoZWQ6ICAgICAgIDgJMTIxCi4vaGN0eDEvZGlzcGF0Y2hl
ZDogICAgICAxNgkzMQouL2hjdHgxL2Rpc3BhdGNoZWQ6ICAgICAgMzIrCTAKLi9oY3R4MS9pb19w
b2xsOmNvbnNpZGVyZWQ9MAouL2hjdHgxL2lvX3BvbGw6aW52b2tlZD0wCi4vaGN0eDEvaW9fcG9s
bDpzdWNjZXNzPTAKLi9oY3R4MS9zY2hlZF90YWdzX2JpdG1hcDowMDAwMDAwMDogMDAwMCAwMDAw
IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDEvc2NoZWRfdGFnc19iaXRtYXA6
MDAwMDAwMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMAouL2hjdHgx
L3NjaGVkX3RhZ3M6bnJfdGFncz0yNTYKLi9oY3R4MS9zY2hlZF90YWdzOm5yX3Jlc2VydmVkX3Rh
Z3M9MAouL2hjdHgxL3NjaGVkX3RhZ3M6YWN0aXZlX3F1ZXVlcz0wCi4vaGN0eDEvc2NoZWRfdGFn
czpiaXRtYXBfdGFnczoKLi9oY3R4MS9zY2hlZF90YWdzOmRlcHRoPTI1NgouL2hjdHgxL3NjaGVk
X3RhZ3M6YnVzeT0wCi4vaGN0eDEvc2NoZWRfdGFnczpjbGVhcmVkPTIyOAouL2hjdHgxL3NjaGVk
X3RhZ3M6Yml0c19wZXJfd29yZD02NAouL2hjdHgxL3NjaGVkX3RhZ3M6bWFwX25yPTQKLi9oY3R4
MS9zY2hlZF90YWdzOmFsbG9jX2hpbnQ9ezE1LCAxNzYsIDI1LCAyMDN9Ci4vaGN0eDEvc2NoZWRf
dGFnczp3YWtlX2JhdGNoPTgKLi9oY3R4MS9zY2hlZF90YWdzOndha2VfaW5kZXg9MAouL2hjdHgx
L3NjaGVkX3RhZ3M6d3NfYWN0aXZlPTAKLi9oY3R4MS9zY2hlZF90YWdzOndzPXsKLi9oY3R4MS9z
Y2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MS9zY2hlZF90
YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MS9zY2hlZF90YWdzOgl7
LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MS9zY2hlZF90YWdzOgl7LndhaXRf
Y250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MS9zY2hlZF90YWdzOgl7LndhaXRfY250PTgs
IC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MS9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0
PWluYWN0aXZlfSwKLi9oY3R4MS9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0
aXZlfSwKLi9oY3R4MS9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwK
Li9oY3R4MS9zY2hlZF90YWdzOn0KLi9oY3R4MS9zY2hlZF90YWdzOnJvdW5kX3JvYmluPTAKLi9o
Y3R4MS9zY2hlZF90YWdzOm1pbl9zaGFsbG93X2RlcHRoPTQyOTQ5NjcyOTUKLi9oY3R4MS90YWdz
X2JpdG1hcDowMDAwMDAwMDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAw
Ci4vaGN0eDEvdGFnc19iaXRtYXA6MDAwMDAwMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAw
MDAwIDAwMDAgMDAwMAouL2hjdHgxL3RhZ3NfYml0bWFwOjAwMDAwMDIwOiAwMDAwIDAwMDAgMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAKLi9oY3R4MS90YWdzX2JpdG1hcDowMDAwMDAzMDog
MDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDEvdGFnczpucl90
YWdzPTUxMgouL2hjdHgxL3RhZ3M6bnJfcmVzZXJ2ZWRfdGFncz0wCi4vaGN0eDEvdGFnczphY3Rp
dmVfcXVldWVzPTAKLi9oY3R4MS90YWdzOmJpdG1hcF90YWdzOgouL2hjdHgxL3RhZ3M6ZGVwdGg9
NTEyCi4vaGN0eDEvdGFnczpidXN5PTAKLi9oY3R4MS90YWdzOmNsZWFyZWQ9NTEyCi4vaGN0eDEv
dGFnczpiaXRzX3Blcl93b3JkPTY0Ci4vaGN0eDEvdGFnczptYXBfbnI9OAouL2hjdHgxL3RhZ3M6
YWxsb2NfaGludD17MjUzLCAyNDgsIDM5MSwgMjcyfQouL2hjdHgxL3RhZ3M6d2FrZV9iYXRjaD04
Ci4vaGN0eDEvdGFnczp3YWtlX2luZGV4PTYKLi9oY3R4MS90YWdzOndzX2FjdGl2ZT0wCi4vaGN0
eDEvdGFnczp3cz17Ci4vaGN0eDEvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0s
Ci4vaGN0eDEvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDEvdGFn
czoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDEvdGFnczoJey53YWl0X2Nu
dD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDEvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1p
bmFjdGl2ZX0sCi4vaGN0eDEvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4v
aGN0eDEvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDEvdGFnczoJ
ey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDEvdGFnczp9Ci4vaGN0eDEvdGFn
czpyb3VuZF9yb2Jpbj0wCi4vaGN0eDEvdGFnczptaW5fc2hhbGxvd19kZXB0aD00Mjk0OTY3Mjk1
Ci4vaGN0eDEvY3R4X21hcDowMDAwMDAwMDogMDAKLi9oY3R4MS9mbGFnczphbGxvY19wb2xpY3k9
RklGTyBTSE9VTERfTUVSR0V8VEFHX1FVRVVFX1NIQVJFRAouL2hjdHgwL2NwdTAvY29tcGxldGVk
Ojk0MjQgMAouL2hjdHgwL2NwdTAvbWVyZ2VkOjAKLi9oY3R4MC9jcHUwL2Rpc3BhdGNoZWQ6OTQy
NCAwCi4vaGN0eDAvdHlwZTpkZWZhdWx0Ci4vaGN0eDAvZGlzcGF0Y2hfYnVzeTo3Ci4vaGN0eDAv
YWN0aXZlOjAKLi9oY3R4MC9ydW46OTU0NQouL2hjdHgwL3F1ZXVlZDo5NDI0Ci4vaGN0eDAvZGlz
cGF0Y2hlZDogICAgICAgMAk2MDUyCi4vaGN0eDAvZGlzcGF0Y2hlZDogICAgICAgMQkzNDM1Ci4v
aGN0eDAvZGlzcGF0Y2hlZDogICAgICAgMgkyNzIKLi9oY3R4MC9kaXNwYXRjaGVkOiAgICAgICA0
CTM3NAouL2hjdHgwL2Rpc3BhdGNoZWQ6ICAgICAgIDgJMjE2Ci4vaGN0eDAvZGlzcGF0Y2hlZDog
ICAgICAxNgk0OQouL2hjdHgwL2Rpc3BhdGNoZWQ6ICAgICAgMzIrCTEKLi9oY3R4MC9pb19wb2xs
OmNvbnNpZGVyZWQ9MAouL2hjdHgwL2lvX3BvbGw6aW52b2tlZD0wCi4vaGN0eDAvaW9fcG9sbDpz
dWNjZXNzPTAKLi9oY3R4MC9zY2hlZF90YWdzX2JpdG1hcDowMDAwMDAwMDogMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDAvc2NoZWRfdGFnc19iaXRtYXA6MDAw
MDAwMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMAouL2hjdHgwL3Nj
aGVkX3RhZ3M6bnJfdGFncz0yNTYKLi9oY3R4MC9zY2hlZF90YWdzOm5yX3Jlc2VydmVkX3RhZ3M9
MAouL2hjdHgwL3NjaGVkX3RhZ3M6YWN0aXZlX3F1ZXVlcz0wCi4vaGN0eDAvc2NoZWRfdGFnczpi
aXRtYXBfdGFnczoKLi9oY3R4MC9zY2hlZF90YWdzOmRlcHRoPTI1NgouL2hjdHgwL3NjaGVkX3Rh
Z3M6YnVzeT0wCi4vaGN0eDAvc2NoZWRfdGFnczpjbGVhcmVkPTIzMwouL2hjdHgwL3NjaGVkX3Rh
Z3M6Yml0c19wZXJfd29yZD02NAouL2hjdHgwL3NjaGVkX3RhZ3M6bWFwX25yPTQKLi9oY3R4MC9z
Y2hlZF90YWdzOmFsbG9jX2hpbnQ9ezE5NiwgMTUyLCAxNzQsIDJ9Ci4vaGN0eDAvc2NoZWRfdGFn
czp3YWtlX2JhdGNoPTgKLi9oY3R4MC9zY2hlZF90YWdzOndha2VfaW5kZXg9MAouL2hjdHgwL3Nj
aGVkX3RhZ3M6d3NfYWN0aXZlPTAKLi9oY3R4MC9zY2hlZF90YWdzOndzPXsKLi9oY3R4MC9zY2hl
ZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MC9zY2hlZF90YWdz
Ogl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MC9zY2hlZF90YWdzOgl7Lndh
aXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MC9zY2hlZF90YWdzOgl7LndhaXRfY250
PTgsIC53YWl0PWluYWN0aXZlfSwKLi9oY3R4MC9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53
YWl0PWluYWN0aXZlfSwKLi9oY3R4MC9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWlu
YWN0aXZlfSwKLi9oY3R4MC9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZl
fSwKLi9oY3R4MC9zY2hlZF90YWdzOgl7LndhaXRfY250PTgsIC53YWl0PWluYWN0aXZlfSwKLi9o
Y3R4MC9zY2hlZF90YWdzOn0KLi9oY3R4MC9zY2hlZF90YWdzOnJvdW5kX3JvYmluPTAKLi9oY3R4
MC9zY2hlZF90YWdzOm1pbl9zaGFsbG93X2RlcHRoPTQyOTQ5NjcyOTUKLi9oY3R4MC90YWdzX2Jp
dG1hcDowMDAwMDAwMDogMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4v
aGN0eDAvdGFnc19iaXRtYXA6MDAwMDAwMTA6IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAw
IDAwMDAgMDAwMAouL2hjdHgwL3RhZ3NfYml0bWFwOjAwMDAwMDIwOiAwMDAwIDAwMDAgMDAwMCAw
MDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAKLi9oY3R4MC90YWdzX2JpdG1hcDowMDAwMDAzMDogMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwCi4vaGN0eDAvdGFnczpucl90YWdz
PTUxMgouL2hjdHgwL3RhZ3M6bnJfcmVzZXJ2ZWRfdGFncz0wCi4vaGN0eDAvdGFnczphY3RpdmVf
cXVldWVzPTAKLi9oY3R4MC90YWdzOmJpdG1hcF90YWdzOgouL2hjdHgwL3RhZ3M6ZGVwdGg9NTEy
Ci4vaGN0eDAvdGFnczpidXN5PTAKLi9oY3R4MC90YWdzOmNsZWFyZWQ9NTExCi4vaGN0eDAvdGFn
czpiaXRzX3Blcl93b3JkPTY0Ci4vaGN0eDAvdGFnczptYXBfbnI9OAouL2hjdHgwL3RhZ3M6YWxs
b2NfaGludD17MTE2LCAxMjQsIDMxNSwgNDc4fQouL2hjdHgwL3RhZ3M6d2FrZV9iYXRjaD04Ci4v
aGN0eDAvdGFnczp3YWtlX2luZGV4PTUKLi9oY3R4MC90YWdzOndzX2FjdGl2ZT0wCi4vaGN0eDAv
dGFnczp3cz17Ci4vaGN0eDAvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4v
aGN0eDAvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDAvdGFnczoJ
ey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDAvdGFnczoJey53YWl0X2NudD04
LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDAvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFj
dGl2ZX0sCi4vaGN0eDAvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0
eDAvdGFnczoJey53YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDAvdGFnczoJey53
YWl0X2NudD04LCAud2FpdD1pbmFjdGl2ZX0sCi4vaGN0eDAvdGFnczp9Ci4vaGN0eDAvdGFnczpy
b3VuZF9yb2Jpbj0wCi4vaGN0eDAvdGFnczptaW5fc2hhbGxvd19kZXB0aD00Mjk0OTY3Mjk1Ci4v
aGN0eDAvY3R4X21hcDowMDAwMDAwMDogMDAKLi9oY3R4MC9mbGFnczphbGxvY19wb2xpY3k9RklG
TyBTSE9VTERfTUVSR0V8VEFHX1FVRVVFX1NIQVJFRAouL3dyaXRlX2hpbnRzOmhpbnQwOiAwCi4v
d3JpdGVfaGludHM6aGludDE6IDAKLi93cml0ZV9oaW50czpoaW50MjogMAouL3dyaXRlX2hpbnRz
OmhpbnQzOiAwCi4vd3JpdGVfaGludHM6aGludDQ6IDAKLi9zdGF0ZTpTQU1FX0NPTVB8Tk9OUk9U
fElPX1NUQVR8U0FNRV9GT1JDRXxJTklUX0RPTkV8V0N8RlVBfFNUQVRTfFJFR0lTVEVSRUR8Tk9X
QUlUCi4vcG1fb25seTowCi4vcG9sbF9zdGF0OnJlYWQgICg1MTIgQnl0ZXMpOiBzYW1wbGVzPTAK
Li9wb2xsX3N0YXQ6d3JpdGUgKDUxMiBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxfc3RhdDpyZWFk
ICAoMTAyNCBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxfc3RhdDp3cml0ZSAoMTAyNCBCeXRlcyk6
IHNhbXBsZXM9MAouL3BvbGxfc3RhdDpyZWFkICAoMjA0OCBCeXRlcyk6IHNhbXBsZXM9MAouL3Bv
bGxfc3RhdDp3cml0ZSAoMjA0OCBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxfc3RhdDpyZWFkICAo
NDA5NiBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxfc3RhdDp3cml0ZSAoNDA5NiBCeXRlcyk6IHNh
bXBsZXM9MAouL3BvbGxfc3RhdDpyZWFkICAoODE5MiBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxf
c3RhdDp3cml0ZSAoODE5MiBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxfc3RhdDpyZWFkICAoMTYz
ODQgQnl0ZXMpOiBzYW1wbGVzPTAKLi9wb2xsX3N0YXQ6d3JpdGUgKDE2Mzg0IEJ5dGVzKTogc2Ft
cGxlcz0wCi4vcG9sbF9zdGF0OnJlYWQgICgzMjc2OCBCeXRlcyk6IHNhbXBsZXM9MAouL3BvbGxf
c3RhdDp3cml0ZSAoMzI3NjggQnl0ZXMpOiBzYW1wbGVzPTAKLi9wb2xsX3N0YXQ6cmVhZCAgKDY1
NTM2IEJ5dGVzKTogc2FtcGxlcz0wCi4vcG9sbF9zdGF0OndyaXRlICg2NTUzNiBCeXRlcyk6IHNh
bXBsZXM9MAo=
--00000000000011790005d0d369be--
