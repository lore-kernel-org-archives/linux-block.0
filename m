Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:55600 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937074AbdIZPhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2017 11:37:19 -0400
Received: by mail-it0-f46.google.com with SMTP id 4so3334886itv.4
        for <linux-block@vger.kernel.org>; Tue, 26 Sep 2017 08:37:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-8-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-8-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 26 Sep 2017 17:37:17 +0200
Message-ID: <CACRpkdaeAnAV6GeC14PzyYWzSY0kd6ixHsdDdRR_6K5z-iNz_Q@mail.gmail.com>
Subject: Re: [PATCH V9 07/15] mmc: block: Prepare CQE data
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

> Enhance mmc_blk_data_prep() to support CQE requests. That means adding
> some things that for non-CQE requests would be encoded into the command
> arguments - such as the block address, reliable-write flag, and data tag
> flag. Also the request tag is needed to provide the command queue task id,
> and a comment is added to explain the future possibility of defining a
> priority.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
