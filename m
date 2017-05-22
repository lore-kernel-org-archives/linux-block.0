Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170519133732.27470-6-linus.walleij@linaro.org>
References: <20170519133732.27470-1-linus.walleij@linaro.org> <20170519133732.27470-6-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 May 2017 09:42:24 +0200
Message-ID: <CAPDyKFqzjv-C1SWh9_QD+LsHCMeg=R8nSeNgBsbPJ725PSMmDg@mail.gmail.com>
Subject: Re: [PATCH 5/6] mmc: debugfs: Move card status retrieveal into the
 block layer
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 19 May 2017 at 15:37, Linus Walleij <linus.walleij@linaro.org> wrote:
> The debugfs file "status" (in e.g. /debug/mmc3/mmc3:0001) is
> only available if and only if the card used is an (e)MMC or
> SD card, not for SDIO, as can be seen from this guard in
> mmc_add_card_debugfs();
>
> if (mmc_card_mmc(card) || mmc_card_sd(card))
>   (...create debugfs "status" entry...)
>
> Further this debugfs entry suffers from all the same starvation
> issues as the other userspace things, under e.g. a heavy
> dd operation.
>
> It is therefore logical to move this over to the block layer
> when it is enabled, using the new custom requests and issue
> it using the block request queue.
>
> This makes this debugfs card access land under the request
> queue host lock instead of orthogonally taking the lock.
>
> Tested during heavy dd load by cat:in the status file. We
> add IS_ENABLED() guards and keep the code snippet just
> issueing the card status as a static inline in the header
> so we can still have card status working when the block
> layer is compiled out.

Seems like a bit of re-factoring/cleanup could help here as
preparation step. I just posted a patch [1] cleaning up how the mmc
block layer fetches the card's status.

Perhaps that could at least simplify a bit for $subject patch,
especially since it also makes mmc_send_status() being exported.

>
> Keeping two copies of mmc_dbg_card_status_get() around
> seems to be a necessary evil to be able to have the MMC/SD
> stack working with the block layer disabled: under these
> circumstances, the code must simply take another path.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c   | 28 ++++++++++++++++++++++++++++
>  drivers/mmc/core/block.h   | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/debugfs.c | 15 ++-------------
>  drivers/mmc/core/queue.h   |  2 ++
>  4 files changed, 69 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 52635120a0a5..8858798d1349 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1191,6 +1191,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>         struct mmc_queue_req *mq_rq;
>         struct mmc_card *card = mq->card;
>         struct mmc_blk_data *md = mq->blkdata;
> +       u32 status;
>         int ret;
>         int i;
>
> @@ -1219,6 +1220,11 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>                         card->ext_csd.boot_ro_lock |=
>                                 EXT_CSD_BOOT_WP_B_PWR_WP_EN;
>                 break;
> +       case MMC_DRV_OP_GET_CARD_STATUS:
> +               ret = mmc_send_status(card, &status);
> +               if (!ret)
> +                       ret = status;
> +               break;
>         default:
>                 pr_err("%s: unknown driver specific operation\n",
>                        md->disk->disk_name);
> @@ -1968,6 +1974,28 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>                 mmc_put_card(card);
>  }
>
> +/* Called from debugfs for MMC/SD cards */
> +int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
> +{
> +       struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
> +       struct mmc_queue *mq = &md->queue;
> +       struct request *req;
> +       int ret;
> +
> +       /* Ask the block layer about the card status */
> +       req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
> +       req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
> +       blk_execute_rq(mq->queue, NULL, req, 0);
> +       ret = req_to_mmc_queue_req(req)->drv_op_result;
> +       if (ret >= 0) {
> +               *val = ret;
> +               ret = 0;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(mmc_blk_card_status_get);
> +
>  static inline int mmc_blk_readonly(struct mmc_card *card)
>  {
>         return mmc_card_readonly(card) ||
> diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
> index 860ca7c8df86..1e26755a864b 100644
> --- a/drivers/mmc/core/block.h
> +++ b/drivers/mmc/core/block.h
> @@ -1,9 +1,46 @@
>  #ifndef _MMC_CORE_BLOCK_H
>  #define _MMC_CORE_BLOCK_H
>
> +#include <linux/kconfig.h>
> +#include "core.h"
> +#include "mmc_ops.h"
> +
>  struct mmc_queue;
>  struct request;
>
> +#if IS_ENABLED(CONFIG_MMC_BLOCK)

What wrong with a regular ifdefs stubs? Why do you need IS_ENABLED()?

> +
>  void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);

I don't get what mmc_blk_issue_rq() has to do with this change? Could
you please explain?

> +int mmc_blk_card_status_get(struct mmc_card *card, u64 *val);
> +
> +#else
> +
> +/*
> + * Small stub functions to be used when the block layer is not
> + * enabled, e.g. for pure SDIO without MMC/SD configurations.
> + */
> +
> +static inline void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
> +{
> +       return;
> +}
> +
> +static inline int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
> +{
> +       u32 status;
> +       int ret;
> +
> +       mmc_get_card(card);
> +
> +       ret = mmc_send_status(card, &status);
> +       if (!ret)
> +               *val = status;
> +
> +       mmc_put_card(card);
> +
> +       return ret;
> +}
> +
> +#endif /* IS_ENABLED(CONFIG_MMC_BLOCK) */
>
>  #endif
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index a1fba5732d66..ce5b921c7d96 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -19,6 +19,7 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>
> +#include "block.h"
>  #include "core.h"
>  #include "card.h"
>  #include "host.h"
> @@ -283,19 +284,7 @@ void mmc_remove_host_debugfs(struct mmc_host *host)
>
>  static int mmc_dbg_card_status_get(void *data, u64 *val)
>  {
> -       struct mmc_card *card = data;
> -       u32             status;
> -       int             ret;
> -
> -       mmc_get_card(card);
> -
> -       ret = mmc_send_status(data, &status);
> -       if (!ret)
> -               *val = status;
> -
> -       mmc_put_card(card);
> -
> -       return ret;
> +       return mmc_blk_card_status_get(data, val);
>  }
>  DEFINE_SIMPLE_ATTRIBUTE(mmc_dbg_card_status_fops, mmc_dbg_card_status_get,
>                 NULL, "%08llx\n");
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 361b46408e0f..2b39717453a5 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -36,10 +36,12 @@ struct mmc_blk_request {
>   * enum mmc_drv_op - enumerates the operations in the mmc_queue_req
>   * @MMC_DRV_OP_IOCTL: ioctl operation
>   * @MMC_DRV_OP_BOOT_WP: write protect boot partitions
> + * @MMC_DRV_OP_GET_CARD_STATUS: get card status
>   */
>  enum mmc_drv_op {
>         MMC_DRV_OP_IOCTL,
>         MMC_DRV_OP_BOOT_WP,
> +       MMC_DRV_OP_GET_CARD_STATUS,
>  };
>
>  struct mmc_queue_req {
> --
> 2.9.3
>

Hmm, this thing seems a bit upside-down.

Currently it's possible to build the mmc block device driver as a
module. In cases like this, accessing the card debugs node to request
the card's status, would trigger a call to mmc_blk_card_status_get().
How would that work when the mmc block device driver isn't loaded and
probed?

It seems like the life cycle of the card debugfs node is now being
controlled as when the mmc block device driver has been successfully
probed. We need to deal with that somehow.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/9739663/
