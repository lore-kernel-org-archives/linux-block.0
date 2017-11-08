Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:47924 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdKHJa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:30:57 -0500
Received: by mail-it0-f41.google.com with SMTP id p138so6046020itp.2
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:30:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Nov 2017 10:30:55 +0100
Message-ID: <CACRpkdb2_D3WZZp2f2o+f+zc7R-jU=wfs7Ec1rppim0mTd-sDw@mail.gmail.com>
Subject: Re: [PATCH V13 08/10] mmc: block: blk-mq: Separate card polling from recovery
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

> Recovery is simpler to understand if it is only used for errors. Create a
> separate function for card polling.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This looks good but I can't see why it's not folded into
patch 3 already. This error handling is introduced there.

Yours,
Linus Walleij
