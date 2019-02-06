Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D30C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B092175B
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 12:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTd/RhRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfBFMBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:01:37 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46469 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMBh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 07:01:37 -0500
Received: by mail-vk1-f194.google.com with SMTP id j23so1534085vke.13
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnhJUdyNkHRrDznoGM+m6Jk0sGiK02WRu0A0rf2rWLI=;
        b=BTd/RhRXqsD9wHYIzSpUr+wzxkvIlKkJwb2/YC2FMG79kR0x8wSew6PsHpy+nuEEi8
         zW7LwQYomCtM3bq+AtqDESuB63CcA9SJUDbcQs4/41I7Q0xKFHXpEf9rSDk/upalUcVs
         qsq99lrvpzf63jtTuaqWcohefnJzIr9HgDewTHbnQiw8AfropmqLeQbx9pOW141tP8PH
         4g/UiosPlbFDHsR7NfQ2d8dj1ExS1tSfGh7xt9ro1SK7eoUuA9ifLHxNeltqU1SEqwgr
         4feOMPNHcFlCO6sFEGVEnxPcplLnRDwrSaWjXN1jvGSXaO0NS0frYG01wj/zdbg//C3p
         BFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnhJUdyNkHRrDznoGM+m6Jk0sGiK02WRu0A0rf2rWLI=;
        b=XIZrzuArEW1EVKZyv4iMh+8KeYSKquLHISycK3626prIBpvRroJzrvk8XImevmghSY
         1+9UTsrDQyzghFUQFhl46YMUbITGyPfGaEKZWCqeuStRJ7nijivRBGF7Y7NG3LPU9oXL
         f5o28KxHVMNY4l+5e12T5/ii4K6sk+cgXX6FEE+nOt45nH5VO7Vsx76moZSMWUSf4rjT
         QyGBiW9OidpMoCUEuo6nP9JziZ9rIJCltdUzp4+N1yHBbJFE14ev3gi3X+EtyHM6PBaS
         bH+gndQadqUnYmfCJigsFhqf0w/l5wgwx8LierB/eeBJqMAUJKkAKgXsfbNuQ4Ij1WM/
         kw8Q==
X-Gm-Message-State: AHQUAuZBQM3hmqoA0qt7bkkMgryR5oy/Pd7Xlvy3Fcfyix7d6wPq+T0b
        rpE/8o0MGGVYe0FetvWcXXxmVXkQzMn6HCSNtMn6Cg==
X-Google-Smtp-Source: AHgI3IYxYE+QFC5RecC8z/7P7Gp+sK2n3x8W9Xejzq5ok+J5NOintcwSXtb0gbsR7Zrfr/o0lBpvQehBw68LFx3/Lu0=
X-Received: by 2002:a1f:1408:: with SMTP id 8mr2715819vku.36.1549454495517;
 Wed, 06 Feb 2019 04:01:35 -0800 (PST)
MIME-Version: 1.0
References: <1549385523-20521-1-git-send-email-zhays@lexmark.com>
In-Reply-To: <1549385523-20521-1-git-send-email-zhays@lexmark.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Feb 2019 13:00:59 +0100
Message-ID: <CAPDyKFofTMGXfp1sKgv1Z6OSEyM9e78B-+3qZ=a6s3s2aNWybg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: handle complete_work on separate workqueue
To:     Zachary Hays <zhays@lexmark.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Adrian, Linus

On Tue, 5 Feb 2019 at 17:53, Zachary Hays <zhays@lexmark.com> wrote:
>
> The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
> This generates a rescuer thread for that queue that will trigger when
> the CPU is under heavy load and collect the uncompleted work.
>
> In the case of mmc, this creates the possibility of a deadlock as
> other blk-mq work is also run on the same queue. For example:
>
> - worker 0 claims the mmc host
> - worker 1 attempts to claim the host
> - worker 0 schedules complete_work to release the host
> - rescuer thread is triggered after time-out and collects the dangling
>   work
> - rescuer thread attempts to complete the work in order starting with
>   claim host
> - the task to release host is now blocked by a task to claim it and
>   will never be called
>

Adrian, I need your help to understand more of this. The above
description doesn't add up to me.

In principle, already when "worker 1 attempts to claim the host" as
described above, it should succeed and should *not* need to wait for
the host to be released. Right?

The hole point with the commit 6c0cedd1ef95 ("mmc: core: Introduce
host claiming by context"), was to allow the mmc host to be
re-claimable for blk I/O requests, no matter from what worker/thread
the claim/release is done from.

Is it not working as expected you think? What am I missing here?

> The above results in multiple hung tasks that lead to failures to boot.

Of course, during boot there is also a card detect work running in
parallel with blk I/O requests. This work is being punted to the
"system_freezable_wq" and it claims/releases the host as well.

Perhaps, that could have something to do with the problem....

>
> Handling complete_work on a separate workqueue avoids this by keeping
> the work completion tasks separate from the other blk-mq work. This
> allows the host to be released without getting blocked by other tasks
> attempting to claim the host.
>
> Signed-off-by: Zachary Hays <zhays@lexmark.com>
> ---
>  drivers/mmc/core/block.c | 10 +++++++++-
>  include/linux/mmc/card.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index aef1185f383d..14f3fdb8c6bb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2112,7 +2112,7 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>                 if (waiting)
>                         wake_up(&mq->wait);
>                 else
> -                       kblockd_schedule_work(&mq->complete_work);
> +                       queue_work(mq->card->complete_wq, &mq->complete_work);
>
>                 return;
>         }
> @@ -2924,6 +2924,13 @@ static int mmc_blk_probe(struct mmc_card *card)
>
>         mmc_fixup_device(card, mmc_blk_fixups);
>
> +       card->complete_wq = alloc_workqueue("mmc_complete",
> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +       if (unlikely(!card->complete_wq)) {
> +               pr_err("Failed to create mmc completion workqueue");
> +               return -ENOMEM;
> +       }
> +
>         md = mmc_blk_alloc(card);
>         if (IS_ERR(md))
>                 return PTR_ERR(md);
> @@ -2987,6 +2994,7 @@ static void mmc_blk_remove(struct mmc_card *card)
>         pm_runtime_put_noidle(&card->dev);
>         mmc_blk_remove_req(md);
>         dev_set_drvdata(&card->dev, NULL);
> +       destroy_workqueue(card->complete_wq);
>  }
>
>  static int _mmc_blk_suspend(struct mmc_card *card)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index de7377815b6b..8ef330027b13 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -308,6 +308,7 @@ struct mmc_card {
>         unsigned int    nr_parts;
>
>         unsigned int            bouncesz;       /* Bounce buffer size */
> +       struct workqueue_struct *complete_wq;   /* Private workqueue */
>  };
>
>  static inline bool mmc_large_sector(struct mmc_card *card)
> --
> 2.7.4
>

So this change seems to solve the problem, which is really great.
However, I think we really need to understand what goes wrong, before
we apply this as fix.

Unfortunate, I am also in busy period, so I need a couple of more days
before I can help out running tests.

Kind regards
Uffe
