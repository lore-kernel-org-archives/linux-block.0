Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:54416 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdKHJiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:38:08 -0500
Received: by mail-io0-f177.google.com with SMTP id e89so5278137ioi.11
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:38:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-11-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-11-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Nov 2017 10:38:07 +0100
Message-ID: <CACRpkdZNcd7Nu2dAajqBcn44c05jY76BUNOM5vBPzfhVub_HhQ@mail.gmail.com>
Subject: Re: [PATCH V13 10/10] mmc: block: blk-mq: Stop using legacy recovery
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

> There are only a few things the recovery needs to do. Primarily, it just
> needs to:
>         Determine the number of bytes transferred
>         Get the card back to transfer state
>         Determine whether to retry
>
> There are also a couple of additional features:
>         Reset the card before the last retry
>         Read one sector at a time
>
> The legacy code spent much effort analyzing command errors, but commands
> fail fast, so it is simpler just to give all command errors the same number
> of retries.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I have nothing against the patch as such. In fact something
like this makes a lot of sense (to me).

But this just makes mmc_blk_rw_recovery() look really nice.

And leaves a very ugly mmc_blk_issue_rw_rq() with the legacy
error handling in-tree.

The former function isn't even named with some *mq* infix
making it clear that the new recovery path only happens
in the MQ case.

If newcomers read this code in the MMC stack they will
just tear their hair, scream and run away. Even faster than
before.

How are they supposed to know which functions are used on
which path? Run ftrace?

This illustrates firmly why we need to refactor and/or kill off
the old block layer interface *first* then add MQ on top.

Yours,
Linus Walleij
