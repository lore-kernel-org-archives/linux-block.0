Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:44811 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935920AbdIZXtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2017 19:49:01 -0400
Received: by mail-it0-f54.google.com with SMTP id d192so9663114itd.1
        for <linux-block@vger.kernel.org>; Tue, 26 Sep 2017 16:49:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-13-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-13-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Sep 2017 01:49:00 +0200
Message-ID: <CACRpkdbjFJoZNCe5EJdOHEircO_Cvt6LOsoQcXcY9wBS8NNWjA@mail.gmail.com>
Subject: Re: [PATCH V9 12/15] mmc: core: Export mmc_retune_hold_now() and mmc_retune_release()
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

On Fri, Sep 22, 2017 at 2:37 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Export mmc_retune_hold_now() and mmc_retune_release() so they can be used
> by the block driver.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Actually you convert mmc_retune_hold_now() into a static inline, so the commit
message is a bit ambigous but who cares.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
