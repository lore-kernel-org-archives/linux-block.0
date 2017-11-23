Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37481 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdKWNWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:22:35 -0500
Received: by mail-it0-f68.google.com with SMTP id m191so10278542itg.2
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 05:22:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-5-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-5-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2017 14:22:34 +0100
Message-ID: <CACRpkdZeGXTNesoBZ5DRroHeEmVS+fkBW0BOgN69X3jXWhgSWA@mail.gmail.com>
Subject: Re: [PATCH V14 04/24] mmc: block: Ensure that debugfs files are removed
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
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 21, 2017 at 2:42 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> The card is not necessarily being removed, but the debugfs files must be
> removed when the driver is removed, otherwise they will continue to exist
> after unbinding the card from the driver. e.g.
>
>   # echo "mmc1:0001" > /sys/bus/mmc/drivers/mmcblk/unbind
>   # cat /sys/kernel/debug/mmc1/mmc1\:0001/ext_csd
>   [  173.634584] BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
>   [  173.643356] IP: mmc_ext_csd_open+0x5e/0x170
>
> A complication is that the debugfs_root may have already been removed, so
> check for that too.
>
> Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I was assuming debugfs would always be removed from debugfs.c
using debugfs_remove_recursive(card->debugfs_root) but that
doesn't work for this case where we bin/unbind the block layer
interactively, sorry for missing it :(

Ulf: I think this can go in as an *early* fix as well, say after -rc1.

Yours,
Linus Walleij
