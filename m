Return-Path: <SRS0=aPd3=VR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB59C76188
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567042082A
	for <linux-block@archiver.kernel.org>; Sat, 20 Jul 2019 15:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd00AduP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfGTPOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:14:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39658 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGTPOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jul 2019 11:14:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so25483849qkc.6
        for <linux-block@vger.kernel.org>; Sat, 20 Jul 2019 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42PsDFzuxnnHU48dhKK7Jjl52MBjfUJSxCW2icQISQ8=;
        b=sd00AduPRGwGbo2Itm8OxxcNO/S6Zx1Imsk2wQtaCgijeaLLSIWOs6Mqcy0pBI097+
         lJqoii7/YMBe3XJVCWHtEA67Njtcp1TGfg8mi3ftkIkeF8D8BxDh2kMWHBmaDS1BxR59
         5xTkhMSReBVw4euKCvJU9+517xQgyWo1edywYOionLjY3MSVeMn/aczQ/cS1Jl9SKThE
         0NmeSy7X+ObHjJ1Ds/egQMdeAY5YQEhDfx5rJWGbYln2myiiOM6FvLxJ8S9zc/IUFtw5
         VBS0Qj1CDtncFLwKF+oh3n+A5BetNJAFPnSqU6Ya3lfSD09rPNWYardBF1PS73QNhivk
         5nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42PsDFzuxnnHU48dhKK7Jjl52MBjfUJSxCW2icQISQ8=;
        b=Qo2AZQt+z3gWvcIUPn6WzSfpaQE2BycsSypHfQLPJGL/4z0rDvOEvEyNsBR3DOJBs7
         VozJ7r166GcKsq/aa2rhGqP7LSySHBv6Pyo5GJPWGSJCxLIp+mnfwDP/29D+MLRp0ALP
         UDX5Vnvc2u3jCxWZNx3JNnbN2Sc617U2jmRZ10WGexJj9TfwtiPUXVVSYX8nLehOjRl2
         dLK+lXdAxdD9uvIMB0nnaLFIg4QiyoIvLSOZSyGx9baMGcW5Zj3gfO0uCh/M//nPBzoZ
         9dpxJVaNYEv9vUdrMSV5yumPsr5fxu89PpW99LKxWTrZaOfT/8YlhTG+U+u1lsoETOsB
         dp4A==
X-Gm-Message-State: APjAAAXQcCQPFzysXZEuh0dDN/OmtnZkopk0vjWNbqm7JPF1dNubcScF
        9NlDeTQaBc4otHiK2Nzv3+e5nzT/vItySdg01RW9rqJ/
X-Google-Smtp-Source: APXvYqx12ro/zevN31hqaLyEVE3NN/j8N6xi4RB6mq8oRzfoyvEKIYVmix3RZJItycwGkePXtkwMdWkxRhe9s2qGU1Y=
X-Received: by 2002:a37:ad0f:: with SMTP id f15mr38856896qkm.68.1563635655253;
 Sat, 20 Jul 2019 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <1563453840-19778-1-git-send-email-liuzhengyuan@kylinos.cn>
 <9b8f3de8-48c9-35e3-d985-00bad339b74d@kernel.dk> <0c992e5e-e7f7-6b25-9347-04ec90e3e106@kernel.dk>
 <5d3114d7.1c69fb81.fc097.122eSMTPIN_ADDED_BROKEN@mx.google.com> <60c4dd14-d353-1ce7-c1ae-7ac447b8adc3@kernel.dk>
In-Reply-To: <60c4dd14-d353-1ce7-c1ae-7ac447b8adc3@kernel.dk>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Sat, 20 Jul 2019 23:14:03 +0800
Message-ID: <CAOOPZo7XTf9-pvZ_yhS2cADe1o2Pym897JWbFAEm3WsuDMt=2g@mail.gmail.com>
Subject: Re: [RFC PATCH] io_uring: add a memory barrier before atomic_read
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>, source@stbuehler.de,
        linux-block@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 20, 2019 at 2:27 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/18/19 6:54 PM, Zhengyuan Liu wrote:
> >
> > On 7/19/19 12:43 AM, Jens Axboe wrote:
> >> On 7/18/19 9:41 AM, Jens Axboe wrote:
> >>> On 7/18/19 6:44 AM, Zhengyuan Liu wrote:
> >>>> There is a hang issue while using fio to do some basic test. The issue can
> >>>> been easily reproduced using bellow scripts:
> >>>>
> >>>>             while true
> >>>>             do
> >>>>                     fio  --ioengine=io_uring  -rw=write -bs=4k -numjobs=1 \
> >>>>                          -size=1G -iodepth=64 -name=uring   --filename=/dev/zero
> >>>>             done
> >>>>
> >>>> After serveral minutes, maybe more, fio would block at
> >>>> io_uring_enter->io_cqring_wait in order to waiting for previously committed
> >>>> sqes to be completed and cann't return to user anymore until we send a SIGTERM
> >>>> to fio. After got SIGTERM, fio turns to hang at io_ring_ctx_wait_and_kill with
> >>>> a backtrace like this:
> >>>>
> >>>>             [54133.243816] Call Trace:
> >>>>             [54133.243842]  __schedule+0x3a0/0x790
> >>>>             [54133.243868]  schedule+0x38/0xa0
> >>>>             [54133.243880]  schedule_timeout+0x218/0x3b0
> >>>>             [54133.243891]  ? sched_clock+0x9/0x10
> >>>>             [54133.243903]  ? wait_for_completion+0xa3/0x130
> >>>>             [54133.243916]  ? _raw_spin_unlock_irq+0x2c/0x40
> >>>>             [54133.243930]  ? trace_hardirqs_on+0x3f/0xe0
> >>>>             [54133.243951]  wait_for_completion+0xab/0x130
> >>>>             [54133.243962]  ? wake_up_q+0x70/0x70
> >>>>             [54133.243984]  io_ring_ctx_wait_and_kill+0xa0/0x1d0
> >>>>             [54133.243998]  io_uring_release+0x20/0x30
> >>>>             [54133.244008]  __fput+0xcf/0x270
> >>>>             [54133.244029]  ____fput+0xe/0x10
> >>>>             [54133.244040]  task_work_run+0x7f/0xa0
> >>>>             [54133.244056]  do_exit+0x305/0xc40
> >>>>             [54133.244067]  ? get_signal+0x13b/0xbd0
> >>>>             [54133.244088]  do_group_exit+0x50/0xd0
> >>>>             [54133.244103]  get_signal+0x18d/0xbd0
> >>>>             [54133.244112]  ? _raw_spin_unlock_irqrestore+0x36/0x60
> >>>>             [54133.244142]  do_signal+0x34/0x720
> >>>>             [54133.244171]  ? exit_to_usermode_loop+0x7e/0x130
> >>>>             [54133.244190]  exit_to_usermode_loop+0xc0/0x130
> >>>>             [54133.244209]  do_syscall_64+0x16b/0x1d0
> >>>>             [54133.244221]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>
> >>>> The reason is that we had added a req to ctx->pending_async at the very end, but
> >>>> it got no chance to be processed anymore. How could this be happened?
> >>>>
> >>>>             fio#cpu0                                        wq#cpu1
> >>>>
> >>>>             io_add_to_prev_work                    io_sq_wq_submit_work
> >>>>
> >>>>               atomic_read() <<< 1
> >>>>
> >>>>                                                       atomic_dec_return() << 1->0
> >>>>                                                       list_empty();    <<< true;
> >>>>
> >>>>               list_add_tail()
> >>>>               atomic_read() << 0 or 1?
> >>>>
> >>>> As was said in atomic_ops.rst, atomic_read does not guarantee that the runtime
> >>>> initialization by any other thread is visible yet, so we must take care of that
> >>>> with a proper implicit or explicit memory barrier;
> >>> Thanks for looking at this and finding this issue, it does looks like a problem.
> >>> But I'm not sure about the fix. Shouldn't we just need an smp_mb__after_atomic()
> >>> on the atomic_dec_return() side of things? Like the below.
> >>>
> >>>
> >>> diff --git a/fs/io_uring.c b/fs/io_uring.c
> >>> index 5ec06e5ba0be..3c2a6f88a6b0 100644
> >>> --- a/fs/io_uring.c
> >>> +++ b/fs/io_uring.c
> >>> @@ -1881,6 +1881,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
> >>>              */
> >>>             if (async_list) {
> >>>                     ret = atomic_dec_return(&async_list->cnt);
> >>> +           smp_mb__after_atomic();
> >>>                     while (!ret && !list_empty(&async_list->list)) {
> >>>                             spin_lock(&async_list->lock);
> >>>                             atomic_inc(&async_list->cnt);
> >>> @@ -1894,6 +1895,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
> >>>                                     goto restart;
> >>>                             }
> >>>                             ret = atomic_dec_return(&async_list->cnt);
> >>> +                   smp_mb__after_atomic();
> >>>                     }
> >>>             }
> >>>
> >>>
> >> I don't think this is enough, I actually think your fix is the most
> >> appropriate. I will apply it, thank you!
> >>
> >
> > Hi, Jens.
> > I have tested you fix and the issue still existed. Actually the
> > implementation of atomic_dec_return has been implicitly surrounded
> > already by mb()  and as I know, smp_mb__after/before_atomic are not
> > suitable for atomic_t operation which does not return a value.
>
> We aren't guaranteed to see the atomic_dec_return() update if it happens
> at the same time. So we can either force ordering with the smp_mb(), or
> we can do something ala:
>
>         if (!atomic_sub_return(0, &list->cnt)) {
>                 ...
>
> io_add_to_prev_work() to achieve the same sort of effect. That should
> work as well.

Yeah,  but I'd prefer smp_mb(), since atomic_sub_return(0, &list->cnt) isn't
such clear.

Thanks.
>
> --
> Jens Axboe
>
