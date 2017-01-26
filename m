Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37030 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbdAZIHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 03:07:21 -0500
Received: by mail-wm0-f47.google.com with SMTP id c206so70399734wme.0
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 00:07:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jan 2017 09:07:19 +0100
Message-ID: <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: block: command issue cleanups
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 24 January 2017 at 11:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> The function mmc_blk_issue_rw_rq() is hopelessly convoluted and
> need to be refactored to it can be understood by humans.
>
> In the process I found some weird magic return values passed
> around for no good reason.
>
> Things are more readable after this.
>
> This work is done towards the goal of breaking the function in
> two parts: one just submitting the requests and one checking the
> result and possibly resubmitting the command on error, so we
> can make the usual path (non-errorpath) smooth and quick, and
> be called directly when the driver completes a request.
>
> That in turn is a prerequisite for proper blk-mq integration
> with the MMC/SD stack.
>
> All that comes later.
>
> Linus Walleij (6):
>   mmc: block: break out mmc_blk_rw_cmd_abort()
>   mmc: block: break out mmc_blk_rw_start_new()
>   mmc: block: do not assign mq_rq when aborting command
>   mmc: block: inline command abortions
>   mmc: block: introduce new_areq and old_areq
>   mmc: block: stop passing around pointless return values
>
>  drivers/mmc/core/block.c | 108 ++++++++++++++++++++++++++---------------------
>  drivers/mmc/core/block.h |   2 +-
>  2 files changed, 60 insertions(+), 50 deletions(-)
>
> --
> 2.9.3
>

Thanks, applied for next!

Kind regards
Uffe
