Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA5C43461
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 00:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08C320715
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 00:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slc8Bflm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIPA7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPA7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 20:59:00 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DAAC06174A
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 17:59:00 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v60so4075989ybi.10
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GumsKctWdK1GViBxPek+KPM/MIvDLDzdzrfgCE5hWs=;
        b=slc8Bflm37ZjTIx0pABw+CTUSsp9Y4BZuheSgEBbtB9DbkR+fIiIxcKCC93tvruDyb
         ZYq7zmdAym1mO/Bvmo3nPGbDfveRM1q088ke1nHp/lyYFDwls0uEjXmbV+YxfwH3XaEY
         K5kT+CIP7q6/93oIWXuBnb8/WxmGIc7nr2U9nhoqYRs++D2VfOml86tCQOYCHZatGphm
         WqKQ4wJ2ytXP5JYe0u6SYnJt90CDF3w7XKwCZIY80u79Xruxjo0dj3dl1trHOdxvjQQ2
         5syodf64br1duI4wF0ZEJyJUAJ9hN2P5hl52nPWb8TRtT1IgyQSU/uN1BoriEdWE6uRk
         7naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GumsKctWdK1GViBxPek+KPM/MIvDLDzdzrfgCE5hWs=;
        b=ZboZ9fMxfdNzM9j/kU10eZB5wVz+UB+dQM+pERIbKxxcW1EPw4iBYMZhP/QuTpC+bx
         ViBaTevJCDu5p9SEyBJF60H/O8THwlev7YoPh1X2jrCCC5x96UVSDcfDUI2a9sFpnlAC
         0XaEj9kCd3BRxbHYst0e2+EwWyTYKg1TrSerSesqZIoP5bBXA5C/yqFUOlE6iADts05B
         KW/r9dKg3y51ljG/5lAlj1I7VzeFuKTXzar/9bprW+UKwCgL4Evkb/cZULk1sEPY7wNl
         OfLukt+B/V7OWQR7qBRxOsdD337NdEKTb8vKvp6I42iq6ApCpHCapfmmSX56TZ2rnmll
         /gPw==
X-Gm-Message-State: AOAM530N6pJX61MXn4aCI4BxqjAPtQpJsxnplPD2qbiZNftqO9GMwLYA
        MVppoKNvoqupijC18b2bnwm7vVv0iNvsNqGnlIM=
X-Google-Smtp-Source: ABdhPJzerd/Exq95HwbFI6kX4dwKcMhD0viojBdSwj7wIjIfdbGbNlLCuP3F2tIs36M2Eoz8lLD5Jll/BNzX76BQEFg=
X-Received: by 2002:a5b:287:: with SMTP id x7mr31350023ybl.144.1600217939536;
 Tue, 15 Sep 2020 17:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <1600092759-17779-1-git-send-email-ppvk@codeaurora.org>
In-Reply-To: <1600092759-17779-1-git-send-email-ppvk@codeaurora.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 16 Sep 2020 08:58:48 +0800
Message-ID: <CACVXFVMiyEs_4nReSQvupih58LU9++C-APYcfmRQarr6bUZgxA@mail.gmail.com>
Subject: Re: [PATCH V1] block: Fix use-after-free issue while accessing
 ioscheduler lock
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        stummala@codeaurora.org, sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 14, 2020 at 10:14 PM Pradeep P V K <ppvk@codeaurora.org> wrote:
>
> Observes below crash while accessing (use-after-free) lock member
> of bfq data.
>
> context#1                       context#2
>                                 process_one_work()
> kthread()                       blk_mq_run_work_fn()
> worker_thread()                  ->__blk_mq_run_hw_queue()
> process_one_work()                ->blk_mq_sched_dispatch_requests()
> __blk_release_queue()               ->blk_mq_do_dispatch_sched()
> ->__elevator_exit()
>   ->blk_mq_exit_sched()
>     ->exit_sched()
>       ->kfree()
>                                        ->bfq_dispatch_request()
>                                          ->spin_unlock_irq(&bfqd->lock)
>
> This is because of the kblockd delayed work that might got scheduled
> around blk_release_queue() and accessed use-after-free member of
> bfq_data.
>
> 240.212359:   <2> Unable to handle kernel paging request at
> virtual address ffffffee2e33ad70
> ...
> 240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
> 240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
> 240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
> 240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
> ...
> Call trace:
> 240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
> 240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
> 240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
> 240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
> 240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
> 240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
> 240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
> 240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
> 240.212963:   <2>  process_one_work+0x280/0x460
> 240.212973:   <2>  worker_thread+0x27c/0x4dc
> 240.212986:   <2>  kthread+0x160/0x170
>
> Fix this by cancelling the delayed work if any before elevator exits.
>
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  block/blk-sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 81722cd..e4a9aac 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -779,6 +779,8 @@ static void blk_release_queue(struct kobject *kobj)
>  {
>         struct request_queue *q =
>                 container_of(kobj, struct request_queue, kobj);
> +       struct blk_mq_hw_ctx *hctx;
> +       int i;

Please move the above two lines to the branch of 'if (queue_is_mq(q)) '.

>
>         might_sleep();
>
> @@ -788,9 +790,11 @@ static void blk_release_queue(struct kobject *kobj)
>
>         blk_free_queue_stats(q->stats);
>
> -       if (queue_is_mq(q))
> +       if (queue_is_mq(q)) {
>                 cancel_delayed_work_sync(&q->requeue_work);
> -
> +               queue_for_each_hw_ctx(q, hctx, i)
> +                       cancel_delayed_work_sync(&hctx->run_work);
> +       }

Now the 'cancel_delayed_work_sync' from blk_mq_hw_sysfs_release() can
be killed meantime.

We have to call cancel_delayed_work_sync when reqeuest queue's
refcount drops to zero, otherwise
new run queue may be started somewhere, so feel free to add the
reviewed-by after the above two
comments are addressed.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
