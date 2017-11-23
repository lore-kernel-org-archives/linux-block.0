Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:45490 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbdKWJl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 04:41:56 -0500
Received: by mail-it0-f52.google.com with SMTP id x13so9463398iti.4
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 01:41:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-2-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-2-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2017 10:41:55 +0100
Message-ID: <CACRpkdYJF3YC8_YcmBzYbtcu_1Fvj7_70Xfgy33Jp=QaomGQiw@mail.gmail.com>
Subject: Re: [PATCH V14 01/24] mmc: block: Fix missing blk_put_request()
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

> Ensure blk_get_request() is paired with blk_put_request().
>
> Fixes: 0493f6fe5bde ("mmc: block: Move boot partition locking into a driver op")
> Fixes: 627c3ccfb46a ("mmc: debugfs: Move block debugfs into block module")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Ah, me abusing the APIs, sorry for sloppiness.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Ulf I think this should be queued for fixes.

Yours,
Linus Walleij
