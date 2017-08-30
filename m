Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33424 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdH3NOb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 09:14:31 -0400
Received: by mail-io0-f172.google.com with SMTP id s101so4959873ioe.0
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2017 06:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503665035-16231-4-git-send-email-adrian.hunter@intel.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com> <1503665035-16231-4-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Aug 2017 15:14:29 +0200
Message-ID: <CAPDyKFqn0yjM55QdojqPGiSJB_ccPxNX4U2rvoP7c+g1Maej9w@mail.gmail.com>
Subject: Re: [PATCH V6 03/12] mmc: host: Add CQE interface
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
> Add CQE host operations, capabilities, and host members.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I have now replaced the previous version with this one, applied for
next! Thanks!

Kind regards
Uffe

> ---
>  include/linux/mmc/core.h |  6 ++++++
>  include/linux/mmc/host.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 178f699ac172..927519385482 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -156,6 +156,12 @@ struct mmc_request {
>         struct completion       completion;
>         struct completion       cmd_completion;
>         void                    (*done)(struct mmc_request *);/* completion function */
> +       /*
> +        * Notify uppers layers (e.g. mmc block driver) that recovery is needed
> +        * due to an error associated with the mmc_request. Currently used only
> +        * by CQE.
> +        */
> +       void                    (*recovery_notifier)(struct mmc_request *);
>         struct mmc_host         *host;
>
>         /* Allow other commands during this ongoing data transfer or busy wait */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e92629518f68..f3f2d07feb2a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -162,6 +162,50 @@ struct mmc_host_ops {
>                                   unsigned int direction, int blk_size);
>  };
>
> +struct mmc_cqe_ops {
> +       /* Allocate resources, and make the CQE operational */
> +       int     (*cqe_enable)(struct mmc_host *host, struct mmc_card *card);
> +       /* Free resources, and make the CQE non-operational */
> +       void    (*cqe_disable)(struct mmc_host *host);
> +       /*
> +        * Issue a read, write or DCMD request to the CQE. Also deal with the
> +        * effect of ->cqe_off().
> +        */
> +       int     (*cqe_request)(struct mmc_host *host, struct mmc_request *mrq);
> +       /* Free resources (e.g. DMA mapping) associated with the request */
> +       void    (*cqe_post_req)(struct mmc_host *host, struct mmc_request *mrq);
> +       /*
> +        * Prepare the CQE and host controller to accept non-CQ commands. There
> +        * is no corresponding ->cqe_on(), instead ->cqe_request() is required
> +        * to deal with that.
> +        */
> +       void    (*cqe_off)(struct mmc_host *host);
> +       /*
> +        * Wait for all CQE tasks to complete. Return an error if recovery
> +        * becomes necessary.
> +        */
> +       int     (*cqe_wait_for_idle)(struct mmc_host *host);
> +       /*
> +        * Notify CQE that a request has timed out. Return false if the request
> +        * completed or true if a timeout happened in which case indicate if
> +        * recovery is needed.
> +        */
> +       bool    (*cqe_timeout)(struct mmc_host *host, struct mmc_request *mrq,
> +                              bool *recovery_needed);
> +       /*
> +        * Stop all CQE activity and prepare the CQE and host controller to
> +        * accept recovery commands.
> +        */
> +       void    (*cqe_recovery_start)(struct mmc_host *host);
> +       /*
> +        * Clear the queue and call mmc_cqe_request_done() on all requests.
> +        * Requests that errored will have the error set on the mmc_request
> +        * (data->error or cmd->error for DCMD).  Requests that did not error
> +        * will have zero data bytes transferred.
> +        */
> +       void    (*cqe_recovery_finish)(struct mmc_host *host);
> +};
> +
>  struct mmc_async_req {
>         /* active mmc request */
>         struct mmc_request      *mrq;
> @@ -303,6 +347,8 @@ struct mmc_host {
>  #define MMC_CAP2_HS400_ES      (1 << 20)       /* Host supports enhanced strobe */
>  #define MMC_CAP2_NO_SD         (1 << 21)       /* Do not send SD commands during initialization */
>  #define MMC_CAP2_NO_MMC                (1 << 22)       /* Do not send (e)MMC commands during initialization */
> +#define MMC_CAP2_CQE           (1 << 23)       /* Has eMMC command queue engine */
> +#define MMC_CAP2_CQE_DCMD      (1 << 24)       /* CQE can issue a direct command */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> @@ -386,6 +432,13 @@ struct mmc_host {
>         int                     dsr_req;        /* DSR value is valid */
>         u32                     dsr;    /* optional driver stage (DSR) value */
>
> +       /* Command Queue Engine (CQE) support */
> +       const struct mmc_cqe_ops *cqe_ops;
> +       void                    *cqe_private;
> +       int                     cqe_qdepth;
> +       bool                    cqe_enabled;
> +       bool                    cqe_on;
> +
>         unsigned long           private[0] ____cacheline_aligned;
>  };
>
> --
> 1.9.1
>
