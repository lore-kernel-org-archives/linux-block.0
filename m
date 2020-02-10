Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893CC352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 09:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E384A214DB
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 09:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/VmYLh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBJJWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:22:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41173 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBJJWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 04:22:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id d11so5786310qko.8;
        Mon, 10 Feb 2020 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4McWFHuhZIYieLna2S1luzgx2zYWjGOpx5Lx4d+d38=;
        b=l/VmYLh12cIlsgbpQbG9uih4//FNjiS4OCwIga8CNbw2IU7lyDSw3adr4a9L0naK73
         1v8AKU4R7aaCIy2S9K0gUYs8is+9PEJMH6RpB4SCv6OzCfMkaqPaZWzuwbjV2frHqoh1
         f0IaFTsFvnEoaKsQhs/dXOXrDiTxvCxSKhMfXg3tr3PwS+8eBcd6ofwk4XFnNK74SifE
         /q0MeY/CBI/9eFSozeGiMLSQJy8iV9hJdb3yqAr9WfZgi38dmlYXP/m7FCkeBg98y7fZ
         vJ2a9/Uh5eqummsMkAUyhvbQ0CW6cVrXUi8TZAnbcI/77g4lWxjwJE62yFxJRDV6pTaX
         zFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4McWFHuhZIYieLna2S1luzgx2zYWjGOpx5Lx4d+d38=;
        b=PpEF6dTeHWV4RZbGiCRKz5u4F9RuNqkIW4IKuZcMULC/LFtjHPky1gLNZ8hpWccA29
         DxjIXj1qMzgouqyYrPyRGmZ9OhXBRkH1BDtFOqU6q5fQRG6DzKhwW7JMXEBUmDag31cc
         Q8BpImHVnlI03rY2ztreBJumNmONT4Mo/S/smPIfxoWkleneJxw93ta1Fq9uwJn9KJRR
         izfSpkE6OovpnKNIyRRJi/jgXRhTZrHVzHwF+sQILfoT4yPoJfFNh1wt8qmOKbd3YLwp
         ocJBmivXEAUGFl6A62k8ZUT/6ApbXqlb2JqwT+qVHW9DoLMOfbR8+IrPN+LpU6OeLyxm
         WXtg==
X-Gm-Message-State: APjAAAU0pO0Cw+abP2T8kPvvCco90w/G8HcGX8aE3raPVOX3BrM2PUC4
        S1xzIgxPvS2oMevEmpkvDUgxrmQ6jiHQeBd09i8=
X-Google-Smtp-Source: APXvYqwKuRetvAGmDdbRgiZkukS+NuF+ys7uMfVQBKtnALO3Tg3m/iAoSP9ePH6u2K3ScxIpnr66UDQSXVWhE+hk3jM=
X-Received: by 2002:a37:8e03:: with SMTP id q3mr415235qkd.395.1581326524895;
 Mon, 10 Feb 2020 01:22:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579164455.git.baolin.wang7@gmail.com> <2fbdb13a61d0db6615b8fd11ddca9106e5417dae.1579164455.git.baolin.wang7@gmail.com>
In-Reply-To: <2fbdb13a61d0db6615b8fd11ddca9106e5417dae.1579164455.git.baolin.wang7@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 10 Feb 2020 17:21:53 +0800
Message-ID: <CADBw62q-TUv-m1QKZx0ZHhDpfUe3Wo9MaumdHw-N3y3uNd6NSA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] block: Change the dispatch_request() API to
 support batch requests
To:     axboe@kernel.dk, Paolo Valente <paolo.valente@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens and Paolo,

On Fri, Jan 17, 2020 at 1:25 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Now some SD/MMC host controllers can support packed command or packed request,
> that means we can package several requests to host controller at one time
> to improve performence.
>
> But the blk-mq always takes one request from the scheduler and dispatch it to
> the device, regardless of the driver or the scheduler, so there should only
> ever be one request in the local list in blk_mq_dispatch_rq_list(), that means
> the bd.last is always true and the driver can not use bd.last to decide if
> there are requests are pending now in hardware queue to help to package
> requests.
>
> Thus this is a preparation patch, which tries to change the dispatch_request()
> API to allow dispatching more than one request from the scheduler.

Do you have any comments for patch 1 and patch 2 in this patch set? Thanks.

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  block/bfq-iosched.c      |   12 +++++++++---
>  block/blk-mq-sched.c     |   15 ++++-----------
>  block/kyber-iosched.c    |   20 +++++++++++++-------
>  block/mq-deadline.c      |   12 +++++++++---
>  include/linux/elevator.h |    2 +-
>  5 files changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ad4af4a..decabc4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4774,7 +4774,8 @@ static inline void bfq_update_dispatch_stats(struct request_queue *q,
>                                              bool idle_timer_disabled) {}
>  #endif /* CONFIG_BFQ_CGROUP_DEBUG */
>
> -static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> +static int bfq_dispatch_requests(struct blk_mq_hw_ctx *hctx,
> +                                struct list_head *list)
>  {
>         struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
>         struct request *rq;
> @@ -4796,7 +4797,12 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>         bfq_update_dispatch_stats(hctx->queue, rq, in_serv_queue,
>                                   idle_timer_disabled);
>
> -       return rq;
> +       if (!rq)
> +               return 0;
> +
> +       list_add(&rq->queuelist, list);
> +
> +       return 1;
>  }
>
>  /*
> @@ -6772,7 +6778,7 @@ static ssize_t bfq_low_latency_store(struct elevator_queue *e,
>                 .finish_request         = bfq_finish_requeue_request,
>                 .exit_icq               = bfq_exit_icq,
>                 .insert_requests        = bfq_insert_requests,
> -               .dispatch_request       = bfq_dispatch_request,
> +               .dispatch_requests      = bfq_dispatch_requests,
>                 .next_request           = elv_rb_latter_request,
>                 .former_request         = elv_rb_former_request,
>                 .allow_merge            = bfq_allow_bio_merge,
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index ca22afd..f49f9d9 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -90,28 +90,21 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>         struct request_queue *q = hctx->queue;
>         struct elevator_queue *e = q->elevator;
>         LIST_HEAD(rq_list);
> +       int ret;
>
>         do {
> -               struct request *rq;
> -
>                 if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
>                         break;
>
>                 if (!blk_mq_get_dispatch_budget(hctx))
>                         break;
>
> -               rq = e->type->ops.dispatch_request(hctx);
> -               if (!rq) {
> +               ret = e->type->ops.dispatch_requests(hctx, &rq_list);
> +               if (ret == 0) {
>                         blk_mq_put_dispatch_budget(hctx);
>                         break;
>                 }
>
> -               /*
> -                * Now this rq owns the budget which has to be released
> -                * if this rq won't be queued to driver via .queue_rq()
> -                * in blk_mq_dispatch_rq_list().
> -                */
> -               list_add(&rq->queuelist, &rq_list);
>         } while (blk_mq_dispatch_rq_list(q, &rq_list, true));
>  }
>
> @@ -171,7 +164,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  {
>         struct request_queue *q = hctx->queue;
>         struct elevator_queue *e = q->elevator;
> -       const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
> +       const bool has_sched_dispatch = e && e->type->ops.dispatch_requests;
>         LIST_HEAD(rq_list);
>
>         /* RCU or SRCU read lock is needed before checking quiesced flag */
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 34dcea0..8f58434 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -796,12 +796,13 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
>         return NULL;
>  }
>
> -static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
> +static int kyber_dispatch_requests(struct blk_mq_hw_ctx *hctx,
> +                                  struct list_head *list)
>  {
>         struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>         struct kyber_hctx_data *khd = hctx->sched_data;
>         struct request *rq;
> -       int i;
> +       int i, ret = 0;
>
>         spin_lock(&khd->lock);
>
> @@ -811,8 +812,11 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
>          */
>         if (khd->batching < kyber_batch_size[khd->cur_domain]) {
>                 rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
> -               if (rq)
> +               if (rq) {
> +                       list_add(&rq->queuelist, list);
> +                       ret = 1;
>                         goto out;
> +               }
>         }
>
>         /*
> @@ -832,14 +836,16 @@ static struct request *kyber_dispatch_request(struct blk_mq_hw_ctx *hctx)
>                         khd->cur_domain++;
>
>                 rq = kyber_dispatch_cur_domain(kqd, khd, hctx);
> -               if (rq)
> +               if (rq) {
> +                       list_add(&rq->queuelist, list);
> +                       ret = 1;
>                         goto out;
> +               }
>         }
>
> -       rq = NULL;
>  out:
>         spin_unlock(&khd->lock);
> -       return rq;
> +       return ret;
>  }
>
>  static bool kyber_has_work(struct blk_mq_hw_ctx *hctx)
> @@ -1020,7 +1026,7 @@ static int kyber_batching_show(void *data, struct seq_file *m)
>                 .finish_request = kyber_finish_request,
>                 .requeue_request = kyber_finish_request,
>                 .completed_request = kyber_completed_request,
> -               .dispatch_request = kyber_dispatch_request,
> +               .dispatch_requests = kyber_dispatch_requests,
>                 .has_work = kyber_has_work,
>         },
>  #ifdef CONFIG_BLK_DEBUG_FS
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b490f47..9fbffba 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -378,7 +378,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   * different hardware queue. This is because mq-deadline has shared
>   * state for all hardware queues, in terms of sorting, FIFOs, etc.
>   */
> -static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
> +static int dd_dispatch_requests(struct blk_mq_hw_ctx *hctx,
> +                               struct list_head *list)
>  {
>         struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>         struct request *rq;
> @@ -387,7 +388,12 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>         rq = __dd_dispatch_request(dd);
>         spin_unlock(&dd->lock);
>
> -       return rq;
> +       if (!rq)
> +               return 0;
> +
> +       list_add(&rq->queuelist, list);
> +
> +       return 1;
>  }
>
>  static void dd_exit_queue(struct elevator_queue *e)
> @@ -774,7 +780,7 @@ static void deadline_dispatch_stop(struct seq_file *m, void *v)
>  static struct elevator_type mq_deadline = {
>         .ops = {
>                 .insert_requests        = dd_insert_requests,
> -               .dispatch_request       = dd_dispatch_request,
> +               .dispatch_requests      = dd_dispatch_requests,
>                 .prepare_request        = dd_prepare_request,
>                 .finish_request         = dd_finish_request,
>                 .next_request           = elv_rb_latter_request,
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 901bda3..a65bf5d 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -42,7 +42,7 @@ struct elevator_mq_ops {
>         void (*prepare_request)(struct request *, struct bio *bio);
>         void (*finish_request)(struct request *);
>         void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
> -       struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
> +       int (*dispatch_requests)(struct blk_mq_hw_ctx *, struct list_head *);
>         bool (*has_work)(struct blk_mq_hw_ctx *);
>         void (*completed_request)(struct request *, u64);
>         void (*requeue_request)(struct request *);
> --
> 1.7.9.5
>
