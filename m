Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:55710 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdKFIkA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Nov 2017 03:40:00 -0500
Received: by mail-it0-f41.google.com with SMTP id l196so4187101itl.4
        for <linux-block@vger.kernel.org>; Mon, 06 Nov 2017 00:40:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-3-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-3-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 Nov 2017 09:39:58 +0100
Message-ID: <CACRpkdZvLV7cmyKz=DgQj7jM_o=Ns1GFt1vGWaUZezSwYxVQ4w@mail.gmail.com>
Subject: Re: [PATCH V13 02/10] mmc: block: Add error-handling comments
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

> Add error-handling comments to explain what would also be done for blk-mq
> if it used the legacy error-handling.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Safe to apply right now, during -rc8 as well.

Yours,
Linus Walleij
