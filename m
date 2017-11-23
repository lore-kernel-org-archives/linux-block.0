Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:44655 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbdKWN1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:27:08 -0500
Received: by mail-io0-f180.google.com with SMTP id w127so26620545iow.11
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 05:27:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-7-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-7-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2017 14:27:07 +0100
Message-ID: <CACRpkdZ2UHjsLJMLVqr-UzLLhgesJrBEHymh_AgiKzj6WAU3Tg@mail.gmail.com>
Subject: Re: [PATCH V14 06/24] mmc: block: Simplify cleaning up the queue
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

> Use blk_cleanup_queue() to shutdown the queue when the driver is removed,
> and instead get an extra reference to the queue to prevent the queue being
> freed before the final mmc_blk_put().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This is way more elegant.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
