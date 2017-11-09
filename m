Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:55704 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbdKINgG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 08:36:06 -0500
Received: by mail-it0-f67.google.com with SMTP id l196so10729938itl.4
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 05:36:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-10-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-10-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Nov 2017 14:36:05 +0100
Message-ID: <CAPDyKFpZOMMOkXCoiO4N4+dqppRuvkX+WRtMQfyrYMz0uheR+w@mail.gmail.com>
Subject: Re: [PATCH V13 09/10] mmc: block: blk-mq: Stop using card_busy_detect()
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

On 3 November 2017 at 14:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
> card_busy_detect() doesn't set a correct timeout, and it doesn't take care
> of error status bits. Stop using it for blk-mq.

I think this changelog isn't very descriptive. Could you please work
on that for the next version.

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/block.c | 117 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 109 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0c29b1d8d545..5c5ff3c34313 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1426,15 +1426,18 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
>         }
>  }
>
> -#define CMD_ERRORS                                                     \
> -       (R1_OUT_OF_RANGE |      /* Command argument out of range */     \
> -        R1_ADDRESS_ERROR |     /* Misaligned address */                \
> +#define CMD_ERRORS_EXCL_OOR                                            \
> +       (R1_ADDRESS_ERROR |     /* Misaligned address */                \
>          R1_BLOCK_LEN_ERROR |   /* Transferred block length incorrect */\
>          R1_WP_VIOLATION |      /* Tried to write to protected block */ \
>          R1_CARD_ECC_FAILED |   /* Card ECC failed */                   \
>          R1_CC_ERROR |          /* Card controller error */             \
>          R1_ERROR)              /* General/unknown error */
>
> +#define CMD_ERRORS                                                     \
> +       (CMD_ERRORS_EXCL_OOR |                                          \
> +        R1_OUT_OF_RANGE)       /* Command argument out of range */     \
> +
>  static void mmc_blk_eval_resp_error(struct mmc_blk_request *brq)
>  {
>         u32 val;
> @@ -1951,6 +1954,95 @@ static void mmc_blk_ss_read(struct mmc_queue *mq, struct request *req)
>         mqrq->retries = MMC_NO_RETRIES;
>  }
>
> +static inline bool mmc_blk_oor_valid(struct mmc_blk_request *brq)
> +{
> +       return !!brq->mrq.sbc;
> +}
> +
> +static inline u32 mmc_blk_stop_err_bits(struct mmc_blk_request *brq)
> +{
> +       return mmc_blk_oor_valid(brq) ? CMD_ERRORS : CMD_ERRORS_EXCL_OOR;
> +}
> +
> +static inline bool mmc_blk_in_tran_state(u32 status)
> +{
> +       /*
> +        * Some cards mishandle the status bits, so make sure to check both the
> +        * busy indication and the card state.
> +        */
> +       return status & R1_READY_FOR_DATA &&
> +              (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
> +}
> +
> +static unsigned int mmc_blk_clock_khz(struct mmc_host *host)
> +{
> +       if (host->actual_clock)
> +               return host->actual_clock / 1000;
> +
> +       /* Clock may be subject to a divisor, fudge it by a factor of 2. */
> +       if (host->ios.clock)
> +               return host->ios.clock / 2000;
> +
> +       /* How can there be no clock */
> +       WARN_ON_ONCE(1);
> +       return 100; /* 100 kHz is minimum possible value */
> +}
> +
> +static unsigned long mmc_blk_data_timeout_jiffies(struct mmc_host *host,
> +                                                 struct mmc_data *data)
> +{
> +       unsigned int ms = DIV_ROUND_UP(data->timeout_ns, 1000000);
> +       unsigned int khz;
> +
> +       if (data->timeout_clks) {
> +               khz = mmc_blk_clock_khz(host);
> +               ms += DIV_ROUND_UP(data->timeout_clks, khz);
> +       }
> +
> +       return msecs_to_jiffies(ms);
> +}
> +
> +static int mmc_blk_card_stuck(struct mmc_card *card, struct request *req,
> +                             u32 *resp_errs)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       struct mmc_data *data = &mqrq->brq.data;
> +       unsigned long timeout;
> +       u32 status;
> +       int err;
> +
> +       timeout = jiffies + mmc_blk_data_timeout_jiffies(card->host, data);
> +
> +       while (1) {
> +               bool done = time_after(jiffies, timeout);
> +
> +               err = __mmc_send_status(card, &status, 5);
> +               if (err) {
> +                       pr_err("%s: error %d requesting status\n",
> +                              req->rq_disk->disk_name, err);
> +                       break;
> +               }
> +
> +               /* Accumulate any response error bits seen */
> +               if (resp_errs)
> +                       *resp_errs |= status;
> +
> +               if (mmc_blk_in_tran_state(status))
> +                       break;
> +
> +               /* Timeout if the device never becomes ready */
> +               if (done) {
> +                       pr_err("%s: Card stuck in wrong state! %s %s\n",
> +                               mmc_hostname(card->host),
> +                               req->rq_disk->disk_name, __func__);
> +                       err = -ETIMEDOUT;
> +                       break;
> +               }
> +       }
> +
> +       return err;
> +}

The new function here, mmc_blk_card_stuck() looks very similar to
card_busy_detect().

Why can't you instead fixup card_busy_detect() so it behaves like the
new mmc_blk_card_stuck(), rather than re-implementing most of it?

> +
>  static void mmc_blk_rw_recovery(struct mmc_queue *mq, struct request *req)
>  {
>         int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
> @@ -2097,17 +2189,26 @@ static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
>  static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
>  {
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> -       bool gen_err = false;
> +       u32 status = 0;
>         int err;
>
>         if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
>                 return 0;
>
> -       err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req, &gen_err);
> +       err = mmc_blk_card_stuck(card, req, &status);
> +
> +       /*
> +        * Do not assume data transferred correctly if there are any error bits
> +        * set.
> +        */
> +       if (!err && status & mmc_blk_stop_err_bits(&mqrq->brq)) {
> +               mqrq->brq.data.bytes_xfered = 0;
> +               err = -EIO;
> +       }
>
> -       /* Copy the general error bit so it will be seen later on */
> -       if (gen_err)
> -               mqrq->brq.stop.resp[0] |= R1_ERROR;
> +       /* Copy the exception bit so it will be seen later on */
> +       if (mmc_card_mmc(card) && status & R1_EXCEPTION_EVENT)
> +               mqrq->brq.cmd.resp[0] |= R1_EXCEPTION_EVENT;
>
>         return err;
>  }
> --
> 1.9.1
>

Kind regards
Uffe
