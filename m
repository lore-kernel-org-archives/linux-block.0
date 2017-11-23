Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36694 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbdKWJ6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 04:58:01 -0500
Received: by mail-io0-f181.google.com with SMTP id 79so18539357ioi.3
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2017 01:58:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511271770-3444-4-git-send-email-adrian.hunter@intel.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-4-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Nov 2017 10:58:00 +0100
Message-ID: <CACRpkdYZ=emHSLOUvTL6qeHiQdGJjLjUMMyoY2eupsqCy_3QQQ@mail.gmail.com>
Subject: Re: [PATCH V14 03/24] mmc: core: Do not leave the block driver in a
 suspended state
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

> The block driver must be resumed if the mmc bus fails to suspend the card.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Also looks like a clear candidate for fixes.

Yours,
Linus Walleij
