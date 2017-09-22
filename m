Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:49091 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbdIVODR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 10:03:17 -0400
Received: by mail-it0-f53.google.com with SMTP id m123so1449579ita.3
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 07:03:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-2-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-2-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Sep 2017 16:03:16 +0200
Message-ID: <CACRpkdaV86WeJ3VgmXP0+1Z8mVv1oo4bsijYOhES0TkXL-=eAg@mail.gmail.com>
Subject: Re: [PATCH V9 01/15] mmc: core: Remove unnecessary host claim
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

On Fri, Sep 22, 2017 at 2:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Callers already have the host claimed, so remove the unnecessary
> calls to mmc_claim_host() and mmc_release_host().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Good catch.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
