Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:43991 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdKHJ2q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:28:46 -0500
Received: by mail-io0-f171.google.com with SMTP id 134so5268762ioo.0
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:28:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-8-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-8-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Nov 2017 10:28:44 +0100
Message-ID: <CACRpkdb_ggnC6tguEajiiyMaC=NiNQ-pdOydNJ5w69HgQ05SmQ@mail.gmail.com>
Subject: Re: [PATCH V13 07/10] mmc: block: blk-mq: Add support for direct completion
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

> For blk-mq, add support for completing requests directly in the ->done
> callback. That means that error handling and urgent background operations
> must be handled by recovery_work in that case.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I tried enabling this on my MMC host (mmci) but I got weird
DMA error messages when I did.

I guess this has not been tested on a non-DMA-coherent
system?

I think I might be seeing this because the .pre and .post
callbacks need to be strictly sequenced, and this is
maybe not taken into account here? Isn't there as risk
that the .post callback of the next request is called before
the .post callback of the previous request has returned
for example?

Yours,
Linus Walleij
