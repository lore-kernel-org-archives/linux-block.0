Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:38640 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdKWJ4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 04:56:21 -0500
Received: by mail-io0-f195.google.com with SMTP id h205so25350303iof.5
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 01:56:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-3-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-3-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2017 10:56:19 +0100
Message-ID: <CACRpkdaVVfVY1WAKbY_pM-r8Hvd_OUUchuuNC5+W4BQQvrSfuQ@mail.gmail.com>
Subject: Re: [PATCH V14 02/24] mmc: block: Check return value of blk_get_request()
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

> blk_get_request() can fail, always check the return value.
>
> Fixes: 0493f6fe5bde ("mmc: block: Move boot partition locking into a driver op")
> Fixes: 3ecd8cf23f88 ("mmc: block: move multi-ioctl() to use block layer")
> Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
> Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
This should also go into fixes I think.

I guess this particular sloppiness was due to modeling the code on
drivers/ide/* which doesn't check the return value either.

I should go and fix that :/

Yours,
Linus Walleij
