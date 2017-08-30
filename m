Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36433 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdH3NOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 09:14:23 -0400
Received: by mail-io0-f169.google.com with SMTP id g33so4868880ioj.3
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 06:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503665035-16231-2-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com> <1503665035-16231-2-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Aug 2017 15:14:22 +0200
Message-ID: <CAPDyKFpH7k7tTYSsMZpy25YJ4U8-Nz3_jhO8-RmvpjyqXsd0=w@mail.gmail.com>
Subject: Re: [PATCH V6 01/12] mmc: core: Move mmc_start_areq() declaration
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
> mmc_start_areq() is an internal mmc core API. Move the declaration
> accordingly.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.h  | 6 ++++++
>  include/linux/mmc/core.h | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 55f543fd37c4..ca861091a776 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -107,6 +107,12 @@ static inline void mmc_unregister_pm_notifier(struct mmc_host *host) { }
>  void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq);
>  bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq);
>
> +struct mmc_async_req;
> +
> +struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
> +                                    struct mmc_async_req *areq,
> +                                    enum mmc_blk_status *ret_stat);
> +
>  int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>                 unsigned int arg);
>  int mmc_can_erase(struct mmc_card *card);
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index bf1788a224e6..178f699ac172 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -165,11 +165,7 @@ struct mmc_request {
>  };
>
>  struct mmc_card;
> -struct mmc_async_req;
>
> -struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
> -                               struct mmc_async_req *areq,
> -                               enum mmc_blk_status *ret_stat);
>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                 int retries);
> --
> 1.9.1
>
