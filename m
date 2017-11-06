Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:55427 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdKFIiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2017 03:38:16 -0500
Received: by mail-it0-f68.google.com with SMTP id l196so4182260itl.4
        for <linux-block@vger.kernel.org>; Mon, 06 Nov 2017 00:38:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-2-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-2-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 Nov 2017 09:38:15 +0100
Message-ID: <CACRpkdZxZ0Dc2XxtRmREF-_J-ii2nWEn9vuX5peijUk82rbsQg@mail.gmail.com>
Subject: Re: [PATCH V13 01/10] mmc: core: Add parameter use_blk_mq
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Until mmc has blk-mq support fully implemented and tested, add a
> parameter use_blk_mq, default to false unless config option MMC_MQ_DEFAULT
> is selected.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
(...)

> +config MMC_MQ_DEFAULT
> +       bool "MMC: use blk-mq I/O path by default"
> +       depends on MMC && BLOCK

default y

The reason being: I want it to be tested, I want it to be deployed.
We should rather use it as a fallback option if something turns out
to be problematic with MQ which, at this point, is highly unlikely.

> +++ b/include/linux/mmc/host.h
> @@ -380,6 +380,7 @@ struct mmc_host {
>         unsigned int            doing_retune:1; /* re-tuning in progress */
>         unsigned int            retune_now:1;   /* do re-tuning at next req */
>         unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
> +       unsigned int            use_blk_mq:1;   /* use blk-mq */

unsigned int foo:1 is really a weird way of saying "bool".

We should just fix it I guess, but it's another patch.

Yours,
Linus Walleij
