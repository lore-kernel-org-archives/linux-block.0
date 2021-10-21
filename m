Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A300C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A51061221
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 19:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhJUTss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhJUTso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 15:48:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84216C0613B9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 12:46:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so1157042lfd.1
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNIcVIgUzaYpY3A6fcbKgS9qwdI5Wr5HY9fdPyib42A=;
        b=kwgZ72iHNgSZ9cB17w0kNtyJwRm4TsX61EERnsx38nJGCeSOlC1qZgHS1U+++6TpJj
         KZtQBaUiIPRb5D8Fw08jOECIvkwpxFxdph3J+JIfZVkG/jfCCty7daPMosclDXV5lKKF
         2Lw1zWcDeeFaB9pyQeaurQDyZULUnBFjIGz0fTAOb77NMyXnPlb48WjMtxYb9tmDErdu
         AXtywiunOeh+B1zs2QO9xI1tGz7LpKTSuyi5C3dCBskRk1eDdOwvJZlrpO7g3qnN2xMb
         ZWt+XS6IapCP/UUe1STaN+ujhpi52i1ERRZnTyj3qbEOk5a1rnFc1WjFeMfRKoO2NltE
         rZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNIcVIgUzaYpY3A6fcbKgS9qwdI5Wr5HY9fdPyib42A=;
        b=FnyDDakp0v11Gnvgw5DjvqrKK0XH3zXuCoCs7AkunJW4p6X/yT4rsradBoqBMfdPTk
         34tah3xbw2zYO5dx4TiW/32+fH+woTeuTC2JY2YgtI9jldKcuwH7eQI2JKwgqMdahXkH
         LqICkyMVXLF4C7X3P09Qr2j/hfpApwqPm2vCTDVHp2xl8UIhoZ17aEz2m23ntf7TXCkh
         ZQ4Top5+eh8n0twiIqdTZBqeT3CtAT2piNTYmPcoLj4m8GowOICkgnb8Uk4bXOtnLJBg
         Gx0qcMvv35B+KoyT2g8+vrRijVovBiXSLxeRJtKcO3umxbFuSsLt/Q9aNUuB5pGyS0Rt
         PWPA==
X-Gm-Message-State: AOAM533kQzz3VGbE/HC0LOIl5DRptwz+QqIevy+iw3gUte3qGoZVXvg7
        oXSgBF1+Xsr75RiF67+9ALDDs+J3XXXXzN+aY74YfQ==
X-Google-Smtp-Source: ABdhPJzKdKS1zsPFnhRBDRCeNfkHWULi7EPtZkghY+VZnP4oQRlPe62/uFAvhJoeg/v+iV/Ri06o99PSh87qK3ELtFw=
X-Received: by 2002:a05:6512:3254:: with SMTP id c20mr6210542lfr.254.1634845584852;
 Thu, 21 Oct 2021 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211018135559.244400-1-bigeasy@linutronix.de> <20211018135559.244400-3-bigeasy@linutronix.de>
In-Reply-To: <20211018135559.244400-3-bigeasy@linutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 21:45:48 +0200
Message-ID: <CAPDyKFqBMfPvHp8fHj65Pw+apAx14A6Z6+QOhRAXPHM_OnNA1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: Use blk_mq_complete_request_direct().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Oct 2021 at 15:56, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The completion callback for the sdhci-pci device is invoked from a
> kworker.
> I couldn't identify in which context is mmc_blk_mq_req_done() invoke but
> the remaining caller are from invoked from preemptible context. Here it
> would make sense to complete the request directly instead scheduling
> ksoftirqd for its completion.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Jens, will you funnel this via your tree?

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 431af5e8be2f8..7d6b43fe52e8a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2051,7 +2051,8 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
>                 mmc_put_card(mq->card, &mq->ctx);
>  }
>
> -static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
> +                               bool can_sleep)
>  {
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>         struct mmc_request *mrq = &mqrq->brq.mrq;
> @@ -2063,10 +2064,14 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
>          * Block layer timeouts race with completions which means the normal
>          * completion path cannot be used during recovery.
>          */
> -       if (mq->in_recovery)
> +       if (mq->in_recovery) {
>                 mmc_blk_mq_complete_rq(mq, req);
> -       else if (likely(!blk_should_fake_timeout(req->q)))
> -               blk_mq_complete_request(req);
> +       } else if (likely(!blk_should_fake_timeout(req->q))) {
> +               if (can_sleep)
> +                       blk_mq_complete_request_direct(req, mmc_blk_mq_complete);
> +               else
> +                       blk_mq_complete_request(req);
> +       }
>
>         mmc_blk_mq_dec_in_flight(mq, req);
>  }
> @@ -2087,7 +2092,7 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq)
>
>         mmc_blk_urgent_bkops(mq, mqrq);
>
> -       mmc_blk_mq_post_req(mq, req);
> +       mmc_blk_mq_post_req(mq, req, true);
>  }
>
>  static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
> @@ -2106,7 +2111,7 @@ static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
>         if (prev_req)
>                 *prev_req = mq->complete_req;
>         else
> -               mmc_blk_mq_post_req(mq, mq->complete_req);
> +               mmc_blk_mq_post_req(mq, mq->complete_req, true);
>
>         mq->complete_req = NULL;
>
> @@ -2178,7 +2183,8 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>         mq->rw_wait = false;
>         wake_up(&mq->wait);
>
> -       mmc_blk_mq_post_req(mq, req);
> +       /* context unknown */
> +       mmc_blk_mq_post_req(mq, req, false);
>  }
>
>  static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
> @@ -2238,7 +2244,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
>         err = mmc_start_request(host, &mqrq->brq.mrq);
>
>         if (prev_req)
> -               mmc_blk_mq_post_req(mq, prev_req);
> +               mmc_blk_mq_post_req(mq, prev_req, true);
>
>         if (err)
>                 mq->rw_wait = false;
> --
> 2.33.0
>
