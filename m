Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34757 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdK1TX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Nov 2017 14:23:58 -0500
Received: by mail-io0-f195.google.com with SMTP id s19so1091224ioa.1
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2017 11:23:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpicjrRPi0YeJTq29BeG_H_nK2w1_=pPjESdS_SeyjU_A@mail.gmail.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYVUj4=z9jANGjHtYGUhWqM6Hxo_Mr2rRvBSbQZMMP_RQ@mail.gmail.com> <CAPDyKFpicjrRPi0YeJTq29BeG_H_nK2w1_=pPjESdS_SeyjU_A@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 28 Nov 2017 20:23:57 +0100
Message-ID: <CAPDyKFrwv9uCd4q3XdzBzCebwcy+kS+SwNWdReN0+wDXUcJKiw@mail.gmail.com>
Subject: Re: [PATCH V14 00/24] mmc: Add Command Queue support
To: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: Paolo Valente <paolo.valente@linaro.org>,
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

[...]

>>> While we should look at changing blk-mq to give better workqueue performance,
>>> a bigger gain is likely to be made by adding a new host API to enable the
>>> next already-prepared request to be issued directly from within ->done()
>>> callback of the current request.
>
> I assume that is taken care of by adding the new host cap
> (MMC_CAP_DIRECT_COMPLETE).
>
> So, then it's just a matter of adopting all host drivers, and when we
> are done with that, we can remove that cap. :-)

Ehh, I realize that this not what you really propose, but rather this
is a next step of improvement. Anyway.

[...]

Kind regards
Uffe
