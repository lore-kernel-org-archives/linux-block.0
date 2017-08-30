Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33912 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdH3NMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 09:12:52 -0400
Received: by mail-io0-f176.google.com with SMTP id n71so4932202iod.1
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 06:12:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503665035-16231-3-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com> <1503665035-16231-3-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Aug 2017 15:12:50 +0200
Message-ID: <CAPDyKFqj6+wj-DCo115s+MRvY1MhfihJGX1nCyyEnTUCcrtRCA@mail.gmail.com>
Subject: Re: [PATCH V6 02/12] mmc: block: Fix block status codes
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 25 August 2017 at 14:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Commit 2a842acab109 ("block: introduce new block status code type") changed
> the error type but not in patches merged through the mmc tree, like
> commit 0493f6fe5bde ("mmc: block: Move boot partition locking into a driver
> op"). Fix one error code that is incorrect and also use BLK_STS_OK in
> preference to 0.
>
> Fixes: 17ece345a042 ("Merge tag 'mmc-v4.13' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0eebc2f726c3..2f00d11adfa9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1223,7 +1223,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>                 break;
>         }
>         mq_rq->drv_op_result = ret;
> -       blk_end_request_all(req, ret);
> +       blk_end_request_all(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>  }
>
>  static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
> @@ -1728,9 +1728,9 @@ static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
>                 if (err)
>                         req_pending = old_req_pending;
>                 else
> -                       req_pending = blk_end_request(req, 0, blocks << 9);
> +                       req_pending = blk_end_request(req, BLK_STS_OK, blocks << 9);
>         } else {
> -               req_pending = blk_end_request(req, 0, brq->data.bytes_xfered);
> +               req_pending = blk_end_request(req, BLK_STS_OK, brq->data.bytes_xfered);
>         }
>         return req_pending;
>  }
> --
> 1.9.1
>
