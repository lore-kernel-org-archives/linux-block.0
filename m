Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE5C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470220857
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 11:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8ZzhQUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfBHLxT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:53:19 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34268 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHLxT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 06:53:19 -0500
Received: by mail-vs1-f66.google.com with SMTP id f20so1947648vsr.1
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bVUBL7w6eCUrdAZMyqDpAvR8FooEj6Yt+iybPeWqGA=;
        b=w8ZzhQUuplcbtiVGKvB1sIq+3UXmY2cKJ/WGGR6RptLmHw28QYzAz9a5WPZfW6CZGv
         GjcZregYR59S7mLIVsmLCt52zZwz9PvPT2QBNQ0XJFM+L2h6R6YAE5MkeRG5aSddWsS4
         LxLUAlMTkWhIFSsO3QX9NLcJqI00agNXDF7jlbK+CIWk8zF6icHUmwwOYPFWxPRAUXtr
         kNs5KAnHmMAq1IEicaimiPksumPljEX+O+z4r1PezbeBIlG+8kkaECNjceiXmx0GQ8Qv
         xwvXUMyQXvktO0eaaD5tXdlqVaRrZy9KR6ePv/ACaQuEvOn/QzHmlBVtSE7NFHlVutnK
         oFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bVUBL7w6eCUrdAZMyqDpAvR8FooEj6Yt+iybPeWqGA=;
        b=MXbdVS8ws/dt9L8DI0PZebYkk3sn6QVg7KruBra84ssZaZAI3UdC7bgp93aKSJ8fS9
         xKw7+e4WYx1Rdk96BZncZrt14ETxvZHBk95d7tR3mvIkcs1N//8IXnib1hJhkOBUbOci
         IgZWkir3TUxH42cCs0B5W71DToOGtEtIV316fmuxC1do/clV885evwZpeaNxYIxmZsht
         3o3jwDfj79tf5RPIhpeQYPUJGHph1pLML+/EF1aDxw1SeE6W7KsAhGp7o/XGTReQ0kOR
         Ptrrl7BGKBoo4MLVpqwRjuRARhp0jyRI2jbbb5TrqAIvFRPEkEEjxfJbIBsRVPe0ERg7
         aOWQ==
X-Gm-Message-State: AHQUAub6Rf1cFlV5AV+RIeQMKi25MpyXZDjrbkHccYQhNMrSBAU9VCcY
        zJ0xHxdEYsW5cRYKagdH2ByyvGhEMSOd5dErfR168A==
X-Google-Smtp-Source: AHgI3IYastQ/7QKI3Mgr2yA901IjhKr3cf6K6FPtnrbc0zx/FNxsvvB4ITBqL+To9X9fxnnMRghuSTNZuAt1ETA+HqQ=
X-Received: by 2002:a67:b245:: with SMTP id s5mr8526346vsh.200.1549626798190;
 Fri, 08 Feb 2019 03:53:18 -0800 (PST)
MIME-Version: 1.0
References: <CAPDyKFrC4QjfrarvjRYCKYqoi7A1QOz_fQLnrOFocXARTP1kWA@mail.gmail.com>
 <1549551788-2572-1-git-send-email-zhays@lexmark.com>
In-Reply-To: <1549551788-2572-1-git-send-email-zhays@lexmark.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Feb 2019 12:52:42 +0100
Message-ID: <CAPDyKFowFLRVnVGU29Di1QpyvsQQVZN_AQVmoyfBFGxsjxgjsw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: block: handle complete_work on separate workqueue
To:     Zachary Hays <zhays@lexmark.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 7 Feb 2019 at 16:55, Zachary Hays <zhays@lexmark.com> wrote:
>
> The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
> This generates a rescuer thread for that queue that will trigger when
> the CPU is under heavy load and collect the uncompleted work.
>
> In the case of mmc, this creates the possibility of a deadlock when
> there are multiple partitions on the device as other blk-mq work is
> also run on the same queue. For example:
>
> - worker 0 claims the mmc host to work on partition 1
> - worker 1 attempts to claim the host for partition 2 but has to wait
>   for worker 0 to finish
> - worker 0 schedules complete_work to release the host
> - rescuer thread is triggered after time-out and collects the dangling
>   work
> - rescuer thread attempts to complete the work in order starting with
>   claim host
> - the task to release host is now blocked by a task to claim it and
>   will never be called
>
> The above results in multiple hung tasks that lead to failures to
> mount partitions.
>
> Handling complete_work on a separate workqueue avoids this by keeping
> the work completion tasks separate from the other blk-mq work. This
> allows the host to be released without getting blocked by other tasks
> attempting to claim the host.
>
> Signed-off-by: Zachary Hays <zhays@lexmark.com>

Applied for fixes and by adding a fixes+stable tag.

Thanks Zachary for fixing this non-trivial problem! And thanks also to
Adrian/Christoph for your valuable input to this (feel free to reply
with your reviewed-by tag).

Kind regards
Uffe


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
