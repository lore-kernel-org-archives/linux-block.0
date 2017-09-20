Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:46000 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdITJAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Sep 2017 05:00:24 -0400
Received: by mail-it0-f48.google.com with SMTP id v19so1919006ite.0
        for <linux-block@vger.kernel.org>; Wed, 20 Sep 2017 02:00:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505302814-19313-2-git-send-email-adrian.hunter@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com> <1505302814-19313-2-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Sep 2017 11:00:22 +0200
Message-ID: <CAPDyKFr+A-Zs9RRUFx6LO2rYGw4FTMMA_jH_NWL3iENdYgez0g@mail.gmail.com>
Subject: Re: [PATCH V8 01/14] mmc: core: Introduce host claiming by context
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 13 September 2017 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Currently the host can be claimed by a task.  Change this so that the host
> can be claimed by a context that may or may not be a task.  This provides
> for the host to be claimed by a block driver queue to support blk-mq, while
> maintaining compatibility with the existing use of mmc_claim_host().

As stated earlier, I think this is a good approach, which allows us to
move forward.

Some comments below, most related how to avoid us from adding more
wrapper functions.

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/core/core.h  |  6 ++++
>  include/linux/mmc/host.h |  7 +++-
>  3 files changed, 97 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 66c9cf49ad2f..09fdc467b804 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -832,9 +832,38 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
>  }
>  EXPORT_SYMBOL(mmc_align_data_size);
>
> +/*
> + * Allow claiming an already claimed host if the context is the same or there is
> + * no context but the task is the same.
> + */
> +static inline bool mmc_ctx_matches(struct mmc_host *host, struct mmc_ctx *ctx,
> +                                  struct task_struct *task)
> +{
> +       return host->claimer == ctx ||
> +              (!ctx && task && host->claimer->task == task);
> +}
> +
> +static inline void mmc_ctx_set_claimer(struct mmc_host *host,
> +                                      struct mmc_ctx *ctx,
> +                                      struct task_struct *task)
> +{
> +       if (!host->claimer) {
> +               if (ctx)
> +                       host->claimer = ctx;
> +               else
> +                       host->claimer = &host->default_ctx;
> +       }
> +       if (task)
> +               host->claimer->task = task;
> +}
> +
>  /**
> - *     __mmc_claim_host - exclusively claim a host
> + *     __mmc_ctx_task_claim_host - exclusively claim a host
>   *     @host: mmc host to claim
> + *     @ctx: context that claims the host or NULL in which case the default
> + *     context will be used
> + *     @task: task that claims the host or NULL in which case @ctx must be
> + *     provided
>   *     @abort: whether or not the operation should be aborted
>   *
>   *     Claim a host for a set of operations.  If @abort is non null and
> @@ -842,7 +871,8 @@ unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
>   *     that non-zero value without acquiring the lock.  Returns zero
>   *     with the lock held otherwise.
>   */
> -int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
> +static int __mmc_ctx_task_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
> +                                    struct task_struct *task, atomic_t *abort)
>  {
>         DECLARE_WAITQUEUE(wait, current);
>         unsigned long flags;
> @@ -856,7 +886,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>         while (1) {
>                 set_current_state(TASK_UNINTERRUPTIBLE);
>                 stop = abort ? atomic_read(abort) : 0;
> -               if (stop || !host->claimed || host->claimer == current)
> +               if (stop || !host->claimed || mmc_ctx_matches(host, ctx, task))
>                         break;
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 schedule();
> @@ -865,7 +895,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>         set_current_state(TASK_RUNNING);
>         if (!stop) {
>                 host->claimed = 1;
> -               host->claimer = current;
> +               mmc_ctx_set_claimer(host, ctx, task);
>                 host->claim_cnt += 1;
>                 if (host->claim_cnt == 1)
>                         pm = true;
> @@ -879,8 +909,19 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>
>         return stop;
>  }
> +
> +int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
> +{
> +       return __mmc_ctx_task_claim_host(host, NULL, current, abort);
> +}
>  EXPORT_SYMBOL(__mmc_claim_host);

There is currently only two users of __mmc_claim_host().

Instead of adding yet another layer of wrapper functions, let's keep
the existing __mmc_claim_host(), but change its definition to take the
new parameters. Then change the existing two users.

>
> +void mmc_ctx_claim_host(struct mmc_host *host, struct mmc_ctx *ctx)
> +{
> +       __mmc_ctx_task_claim_host(host, ctx, NULL, NULL);
> +}
> +EXPORT_SYMBOL(mmc_ctx_claim_host);

There is no need to make this an exported function, better to keep it
static and only to core.c.

As a matter of fact, I suggest you remove this function altogether,
and just call __mmc_claim_host(), with the new parameters, from
mmc_ctx_get_card().

> +
>  /**
>   *     mmc_release_host - release a host
>   *     @host: mmc host to release
> @@ -888,18 +929,17 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>   *     Release a MMC host, allowing others to claim the host
>   *     for their operations.
>   */
> -void mmc_release_host(struct mmc_host *host)
> +static void __mmc_release_host(struct mmc_host *host)
>  {
>         unsigned long flags;
>
> -       WARN_ON(!host->claimed);
> -
>         spin_lock_irqsave(&host->lock, flags);
>         if (--host->claim_cnt) {
>                 /* Release for nested claim */
>                 spin_unlock_irqrestore(&host->lock, flags);
>         } else {
>                 host->claimed = 0;
> +               host->claimer->task = NULL;
>                 host->claimer = NULL;
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 wake_up(&host->wq);
> @@ -907,8 +947,23 @@ void mmc_release_host(struct mmc_host *host)
>                 pm_runtime_put_autosuspend(mmc_dev(host));
>         }
>  }
> +
> +void mmc_release_host(struct mmc_host *host)
> +{
> +       WARN_ON(!host->claimed);
> +
> +       __mmc_release_host(host);
> +}
>  EXPORT_SYMBOL(mmc_release_host);
>
> +void mmc_ctx_release_host(struct mmc_host *host, struct mmc_ctx *ctx)
> +{
> +       WARN_ON(!host->claimed || host->claimer != ctx);
> +
> +       __mmc_release_host(host);
> +}
> +EXPORT_SYMBOL(mmc_ctx_release_host);

>From the same reasoning as above, I think this should be converted to
a static function.

Or more preferably, remove it altogether, and just call
__mmc_release_host() from mmc_ctx_put_card().

> +
>  /*
>   * This is a helper function, which fetches a runtime pm reference for the
>   * card device and also claims the host.
> @@ -921,6 +976,17 @@ void mmc_get_card(struct mmc_card *card)
>  EXPORT_SYMBOL(mmc_get_card);
>
>  /*
> + * This is a helper function, which fetches a runtime pm reference for the
> + * card device and also claims the host for the mmc context.
> + */
> +void mmc_ctx_get_card(struct mmc_card *card, struct mmc_ctx *ctx)
> +{
> +       pm_runtime_get_sync(&card->dev);
> +       mmc_ctx_claim_host(card->host, ctx);
> +}
> +EXPORT_SYMBOL(mmc_ctx_get_card);

Again, please avoid adding yet another layer of wrapper functions.

Instead change the existing mmc_get_card() to take the parameter and
then change the existing three users of it.

> +
> +/*
>   * This is a helper function, which releases the host and drops the runtime
>   * pm reference for the card device.
>   */
> @@ -933,6 +999,18 @@ void mmc_put_card(struct mmc_card *card)
>  EXPORT_SYMBOL(mmc_put_card);
>
>  /*
> + * This is a helper function, which releases the host and drops the runtime
> + * pm reference for the card device.
> + */
> +void mmc_ctx_put_card(struct mmc_card *card, struct mmc_ctx *ctx)
> +{
> +       mmc_ctx_release_host(card->host, ctx);
> +       pm_runtime_mark_last_busy(&card->dev);
> +       pm_runtime_put_autosuspend(&card->dev);
> +}
> +EXPORT_SYMBOL(mmc_ctx_put_card);

Ditto.

> +
> +/*
>   * Internal function that does the actual ios call to the host driver,
>   * optionally printing some debug output.
>   */
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index ca861091a776..a294c836a143 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -144,4 +144,10 @@ static inline void mmc_claim_host(struct mmc_host *host)
>         __mmc_claim_host(host, NULL);
>  }
>
> +void mmc_ctx_claim_host(struct mmc_host *host, struct mmc_ctx *ctx);
> +void mmc_ctx_release_host(struct mmc_host *host, struct mmc_ctx *ctx);
> +
> +void mmc_ctx_get_card(struct mmc_card *card, struct mmc_ctx *ctx);
> +void mmc_ctx_put_card(struct mmc_card *card, struct mmc_ctx *ctx);
> +
>  #endif
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f3f2d07feb2a..228a493c3b25 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -255,6 +255,10 @@ struct mmc_supply {
>         struct regulator *vqmmc;        /* Optional Vccq supply */
>  };
>
> +struct mmc_ctx {
> +       struct task_struct *task;
> +};
> +
>  struct mmc_host {
>         struct device           *parent;
>         struct device           class_dev;
> @@ -388,8 +392,9 @@ struct mmc_host {
>         struct mmc_card         *card;          /* device attached to this host */
>
>         wait_queue_head_t       wq;
> -       struct task_struct      *claimer;       /* task that has host claimed */
> +       struct mmc_ctx          *claimer;       /* context that has host claimed */
>         int                     claim_cnt;      /* "claim" nesting count */
> +       struct mmc_ctx          default_ctx;    /* default context */
>
>         struct delayed_work     detect;
>         int                     detect_change;  /* card detect flag */
> --
> 1.9.1
>

Kind regards
Uffe
