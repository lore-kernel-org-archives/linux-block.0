Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170510082418.10513-5-linus.walleij@linaro.org>
References: <20170510082418.10513-1-linus.walleij@linaro.org> <20170510082418.10513-5-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 May 2017 11:15:07 +0200
Message-ID: <CAPDyKFp+m84kRtUPvqTseQTvySRGpe8f43uVRvJQSRL7Kt-fKw@mail.gmail.com>
Subject: Re: [PATCH 4/5] mmc: block: move single ioctl() commands to block requests
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 10 May 2017 at 10:24, Linus Walleij <linus.walleij@linaro.org> wrote:
> This wraps single ioctl() commands into block requests using
> the custom block layer request types REQ_OP_DRV_IN and
> REQ_OP_DRV_OUT.
>
> By doing this we are loosening the grip on the big host lock,
> since two calls to mmc_get_card()/mmc_put_card() are removed.
>
> We are storing the ioctl() in/out argument as a pointer in
> the per-request struct mmc_blk_request container. Since we
> now let the block layer allocate this data, blk_get_request()
> will allocate it for us and we can immediately dereference
> it and use it to pass the argument into the block layer.
>
> Tested on the ux500 with the userspace:
> mmc extcsd read /dev/mmcblk3
> resulting in a successful EXTCSD info dump back to the
> console.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 56 ++++++++++++++++++++++++++++++++++++++----------

[...]

> @@ -1854,7 +1882,13 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>                 goto out;
>         }
>
> -       if (req && req_op(req) == REQ_OP_DISCARD) {
> +       if (req &&
> +           (req_op(req) == REQ_OP_DRV_IN || req_op(req) == REQ_OP_DRV_OUT)) {
> +               /* complete ongoing async transfer before issuing ioctl()s */
> +               if (mq->qcnt)
> +                       mmc_blk_issue_rw_rq(mq, NULL);
> +               mmc_blk_ioctl_cmd_issue(mq, req);
> +       } else if (req && req_op(req) == REQ_OP_DISCARD) {

While you are at it, would you mind converting this if-else-if to a
switch clause instead?

[...]

Kind regards
Uffe
