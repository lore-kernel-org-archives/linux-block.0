Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170510082418.10513-6-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org> <20170510082418.10513-6-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 May 2017 11:21:32 +0200
Message-ID: <CAPDyKFrK6ba5AxSv4ygbqt3cfLumak9FWHNbye0nq35ZxppWbA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mmc: block: move multi-ioctl() to use block layer
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 10 May 2017 at 10:24, Linus Walleij <linus.walleij@linaro.org> wrote:
> This switches also the multiple-command ioctl() call to issue
> all ioctl()s through the block layer instead of going directly
> to the device.
>
> We extend the passed argument with an argument count and loop
> over all passed commands in the ioctl() issue function called
> from the block layer.
>
> By doing this we are again loosening the grip on the big host
> lock, since two calls to mmc_get_card()/mmc_put_card() are
> removed.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I have reviewed the series and it looks good to me. Some minor
nitpicks was all I found, please address them then we can apply this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 38 +++++++++++++++++++++++++-------------
>  drivers/mmc/core/queue.h |  3 ++-
>  2 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 640db4f57a31..152de904d5e4 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -563,6 +563,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>                              struct mmc_ioc_cmd __user *ic_ptr)
>  {
>         struct mmc_blk_ioc_data *idata;
> +       struct mmc_blk_ioc_data *idatas[1];
>         struct mmc_blk_data *md;
>         struct mmc_queue *mq;
>         struct mmc_card *card;
> @@ -600,7 +601,9 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>         req = blk_get_request(mq->queue,
>                 idata->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
>                 __GFP_RECLAIM);
> -       req_to_mq_rq(req)->idata = idata;
> +       idatas[0] = idata;
> +       req_to_mq_rq(req)->idata = idatas;
> +       req_to_mq_rq(req)->ioc_count = 1;
>         blk_execute_rq(mq->queue, NULL, req, 0);
>         ioc_err = req_to_mq_rq(req)->ioc_result;
>         err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
> @@ -622,14 +625,17 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>  static void mmc_blk_ioctl_cmd_issue(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_queue_req *mq_rq;
> -       struct mmc_blk_ioc_data *idata;
>         struct mmc_card *card = mq->card;
>         struct mmc_blk_data *md = mq->blkdata;
>         int ioc_err;
> +       int i;
>
>         mq_rq = req_to_mq_rq(req);
> -       idata = mq_rq->idata;
> -       ioc_err = __mmc_blk_ioctl_cmd(card, md, idata);
> +       for (i = 0; i < mq_rq->ioc_count; i++) {
> +               ioc_err = __mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
> +               if (ioc_err)
> +                       break;
> +       }
>         mq_rq->ioc_result = ioc_err;
>
>         /* Always switch back to main area after RPMB access */
> @@ -646,8 +652,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>         struct mmc_ioc_cmd __user *cmds = user->cmds;
>         struct mmc_card *card;
>         struct mmc_blk_data *md;
> +       struct mmc_queue *mq;
>         int i, err = 0, ioc_err = 0;
>         __u64 num_of_cmds;
> +       struct request *req;
>
>         /*
>          * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> @@ -689,21 +697,25 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>                 goto cmd_done;
>         }
>
> -       mmc_get_card(card);
> -
> -       for (i = 0; i < num_of_cmds && !ioc_err; i++)
> -               ioc_err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
> -
> -       /* Always switch back to main area after RPMB access */
> -       if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
> -               mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
>
> -       mmc_put_card(card);
> +       /*
> +        * Dispatch the ioctl()s into the block request queue.
> +        */
> +       mq = &md->queue;
> +       req = blk_get_request(mq->queue,
> +               idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
> +               __GFP_RECLAIM);
> +       req_to_mq_rq(req)->idata = idata;
> +       req_to_mq_rq(req)->ioc_count = num_of_cmds;
> +       blk_execute_rq(mq->queue, NULL, req, 0);
> +       ioc_err = req_to_mq_rq(req)->ioc_result;
>
>         /* copy to user if data and response */
>         for (i = 0; i < num_of_cmds && !err; i++)
>                 err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
>
> +       blk_put_request(req);
> +
>  cmd_done:
>         mmc_blk_put(md);
>  cmd_err:
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index aeb3408dc85e..7015df6681c3 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -42,7 +42,8 @@ struct mmc_queue_req {
>         unsigned int            bounce_sg_len;
>         struct mmc_async_req    areq;
>         int                     ioc_result;
> -       struct mmc_blk_ioc_data *idata;
> +       struct mmc_blk_ioc_data **idata;
> +       unsigned int            ioc_count;
>  };
>
>  struct mmc_queue {
> --
> 2.9.3
>
