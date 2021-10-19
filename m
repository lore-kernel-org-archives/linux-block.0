Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97948C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A35F6135E
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 11:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJSLfd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSLfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 07:35:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123DAC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 04:33:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so6748830lfu.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0s+MRa6BbcGpvsOlUlfmhtY9CK4scvdiwFF9cElhZw=;
        b=zJOeEH7mVlODgtA1ytsYcL3oVpI65df6qTKVbqOcxDintMSOXA/cJZFOs0Rp4hnxjX
         BwBKo2n6mtkVpHNsZi8qzn4MxXDhnauDlquTDk4u5YFRst/QkIkxGzm/P3iaDTYpPQOp
         aM0RU0mwV4kFO5EeS4R6XNVROYiAeo/4wk7tQnLMHnlM1Nw/UVbFFRiKJaolD2ddDDgi
         EiCOIZyEMOcqTstavrKBSRLT6daDBBTqcogaOyRctlHT34RcwVCnARGPufUKBYH6omuV
         h9Nk+Y2TRQcjYe5ACk2M5lphSu8T8jJ4VaHiti6V8QK64wa+I3vhGF97fYFMLf7OSKwf
         3SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0s+MRa6BbcGpvsOlUlfmhtY9CK4scvdiwFF9cElhZw=;
        b=Ae7ydCYv0bbMQj4swyhBm+yP7q7XR/G09/NLOIFw1gGzo8yXmOES7vebSEGjsTrHyL
         dRvyAtpyyZAQthqD8Jyqqy+4L0ANtLQWw9Ojhd3blIQmRp1CMbnPKHJzZfKSpUyG5g/0
         RYPrHTkJOT+QfQpDmh89+0Tu1leAPVkuZ4BtBzYco7ZV86AbuZ5Ods2VHoThxAeq5CDM
         4WWeilqWtI+WsgXQfn0SCkfYon39ND6yymDUlizBu75TDZwbNarBrZktVeqD35qNDxUQ
         ane2Lq+Lwg+AQ3d6EpEEg9KlmheoMeo+jWuB5de/4vyhBE21JmCCYhhSxGvlYTIr0+IH
         XQ8g==
X-Gm-Message-State: AOAM530k4kESzxfLUVr+bQTQOfWFZ7LguV7xdepUZjk+ODFjEVefmVpk
        G2IitF/XHntPCyaCRQGSrWyXebohribQRdfBqQmooA==
X-Google-Smtp-Source: ABdhPJyvzlbeUg5nknswT9fRpzEBgAq1CRwBL30gDpwapLO2KcPflPXRFhVEQ3HDIidxz2Pe4GPMCZnb/ylSOve+v+8=
X-Received: by 2002:a19:e307:: with SMTP id a7mr5396888lfh.358.1634643198337;
 Tue, 19 Oct 2021 04:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211018135559.244400-1-bigeasy@linutronix.de> <20211018135559.244400-3-bigeasy@linutronix.de>
In-Reply-To: <20211018135559.244400-3-bigeasy@linutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 13:32:42 +0200
Message-ID: <CAPDyKFrnmevHeCZ3Fb3XCOx6cHvEv6b3ktYdU-WAnuuq8L4kXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: Use blk_mq_complete_request_direct().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Adrian

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

Thanks for working on this!

I have looped in Adrian, to allow him to provide us with his input too.

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

So it seems we would benefit from knowing the context here, right?

At this point, what you suggest seems like a reasonable way forward
(assuming atomic context), but in a next step we could potentially add
a non-atomic helper function for mmc host drivers to call, when that
is suitable. Would that make sense you think?

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

Kind regards
Uffe
