Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:46228 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdJBIaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 04:30:14 -0400
Received: by mail-io0-f178.google.com with SMTP id d16so4119843ioj.3
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 01:30:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-10-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-10-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Oct 2017 10:30:13 +0200
Message-ID: <CAPDyKFqgQPRNYHcG=8RF6mjoEjC8A12GFfESSvNEY4XnyunUNA@mail.gmail.com>
Subject: Re: [PATCH V9 09/15] mmc: core: Add parameter use_blk_mq
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

On 22 September 2017 at 14:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Until mmc has blk-mq support fully implemented and tested, add a
> parameter use_blk_mq, default to false unless config option MMC_MQ_DEFAULT
> is selected.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/Kconfig      | 11 +++++++++++
>  drivers/mmc/core/core.c  |  7 +++++++
>  drivers/mmc/core/core.h  |  2 ++
>  drivers/mmc/core/host.c  |  2 ++
>  drivers/mmc/core/host.h  |  4 ++++
>  include/linux/mmc/host.h |  1 +
>  6 files changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index ec21388311db..98202934bd29 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -12,6 +12,17 @@ menuconfig MMC
>           If you want MMC/SD/SDIO support, you should say Y here and
>           also to your specific host controller driver.
>
> +config MMC_MQ_DEFAULT
> +       bool "MMC: use blk-mq I/O path by default"
> +       depends on MMC && BLOCK
> +       ---help---
> +         This option enables the new blk-mq based I/O path for MMC block
> +         devices by default.  With the option the mmc_core.use_blk_mq
> +         module/boot option defaults to Y, without it to N, but it can
> +         still be overridden either way.
> +
> +         If unsure say N.
> +
>  if MMC
>
>  source "drivers/mmc/core/Kconfig"
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2ff614d4ffac..10d7101164e4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -66,6 +66,13 @@
>  bool use_spi_crc = 1;
>  module_param(use_spi_crc, bool, 0);
>
> +#ifdef CONFIG_MMC_MQ_DEFAULT
> +bool mmc_use_blk_mq = true;
> +#else
> +bool mmc_use_blk_mq = false;
> +#endif
> +module_param_named(use_blk_mq, mmc_use_blk_mq, bool, S_IWUSR | S_IRUGO);
> +
>  static int mmc_schedule_delayed_work(struct delayed_work *work,
>                                      unsigned long delay)
>  {
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index ba5a8fea0dc2..159b2ca301ec 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -35,6 +35,8 @@ struct mmc_bus_ops {
>         int (*reset)(struct mmc_host *);
>  };
>
> +extern bool mmc_use_blk_mq;
> +
>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
>  void mmc_detach_bus(struct mmc_host *host);
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index ad88deb2e8f3..b624dbb6cd15 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -398,6 +398,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         host->max_blk_size = 512;
>         host->max_blk_count = PAGE_SIZE / 512;
>
> +       host->use_blk_mq = mmc_use_blk_mq;
> +
>         return host;
>  }
>
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 77d6f60d1bf9..170fe5947087 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -69,6 +69,10 @@ static inline bool mmc_card_hs400es(struct mmc_card *card)
>         return card->host->ios.enhanced_strobe;
>  }
>
> +static inline bool mmc_host_use_blk_mq(struct mmc_host *host)
> +{
> +       return host->use_blk_mq;
> +}
>
>  #endif
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c296f4351c1d..9109265fe529 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -378,6 +378,7 @@ struct mmc_host {
>         unsigned int            doing_retune:1; /* re-tuning in progress */
>         unsigned int            retune_now:1;   /* do re-tuning at next req */
>         unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
> +       unsigned int            use_blk_mq:1;   /* use blk-mq */
>
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
> --
> 1.9.1
>
