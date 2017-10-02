Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:53039 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdJBIat (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 04:30:49 -0400
Received: by mail-it0-f46.google.com with SMTP id c195so6472733itb.1
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 01:30:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-13-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-13-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Oct 2017 10:30:47 +0200
Message-ID: <CAPDyKFpWFOBuv9khnn4tmx49KTuXKGk8P+BqCCJ9rjTvsACioA@mail.gmail.com>
Subject: Re: [PATCH V9 12/15] mmc: core: Export mmc_retune_hold_now() and mmc_retune_release()
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

On 22 September 2017 at 14:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Export mmc_retune_hold_now() and mmc_retune_release() so they can be used
> by the block driver.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I decided to squash patch 10/11/12 as those are all related to the
same problem when porting to blkmq.

So, thanks - applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 7 +------
>  drivers/mmc/core/host.h | 7 ++++++-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b624dbb6cd15..1539ce0da196 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -111,12 +111,6 @@ void mmc_retune_hold(struct mmc_host *host)
>         host->hold_retune += 1;
>  }
>
> -void mmc_retune_hold_now(struct mmc_host *host)
> -{
> -       host->retune_now = 0;
> -       host->hold_retune += 1;
> -}
> -
>  void mmc_retune_release(struct mmc_host *host)
>  {
>         if (host->hold_retune)
> @@ -124,6 +118,7 @@ void mmc_retune_release(struct mmc_host *host)
>         else
>                 WARN_ON(1);
>  }
> +EXPORT_SYMBOL(mmc_retune_release);
>
>  int mmc_retune(struct mmc_host *host)
>  {
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 170fe5947087..6eaf558e62d6 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -19,12 +19,17 @@
>  void mmc_retune_enable(struct mmc_host *host);
>  void mmc_retune_disable(struct mmc_host *host);
>  void mmc_retune_hold(struct mmc_host *host);
> -void mmc_retune_hold_now(struct mmc_host *host);
>  void mmc_retune_release(struct mmc_host *host);
>  int mmc_retune(struct mmc_host *host);
>  void mmc_retune_pause(struct mmc_host *host);
>  void mmc_retune_unpause(struct mmc_host *host);
>
> +static inline void mmc_retune_hold_now(struct mmc_host *host)
> +{
> +       host->retune_now = 0;
> +       host->hold_retune += 1;
> +}
> +
>  static inline void mmc_retune_recheck(struct mmc_host *host)
>  {
>         if (host->hold_retune <= 1)
> --
> 1.9.1
>
