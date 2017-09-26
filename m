Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:44362 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030485AbdIZPdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2017 11:33:02 -0400
Received: by mail-it0-f51.google.com with SMTP id d192so8739384itd.1
        for <linux-block@vger.kernel.org>; Tue, 26 Sep 2017 08:33:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-5-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-5-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 26 Sep 2017 17:33:01 +0200
Message-ID: <CACRpkda06Q++dvYspU7vRdB=5qY11ec+LjwnpeG=mUm4G2EAwg@mail.gmail.com>
Subject: Re: [PATCH V9 04/15] mmc: mmc: Enable Command Queuing
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

> Enable the Command Queue if the host controller supports a command queue
> engine. It is not compatible with Packed Commands, so make a note of that in the
> comment.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
