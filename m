Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:55265 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdIVLXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 07:23:49 -0400
Received: by mail-it0-f47.google.com with SMTP id e134so993381ite.3
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 04:23:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505302814-19313-2-git-send-email-adrian.hunter@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com> <1505302814-19313-2-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Sep 2017 13:23:48 +0200
Message-ID: <CACRpkdbf3vvaXQchKws-0vhKh6dL66u_tU4itP1Yx0AKeD+FDg@mail.gmail.com>
Subject: Re: [PATCH V8 01/14] mmc: core: Introduce host claiming by context
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

On Wed, Sep 13, 2017 at 1:40 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Currently the host can be claimed by a task.  Change this so that the host
> can be claimed by a context that may or may not be a task.  This provides
> for the host to be claimed by a block driver queue to support blk-mq, while
> maintaining compatibility with the existing use of mmc_claim_host().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I think this is a reasonable intermediate step as well.
I am working to kill off the "big MMC host lock" by the following
plan:

DONE:
- Convert all ioctl() ops to custom block layer requests (done)
- Convert all debugfs ops to custom block layer requests (done)
- Convert RPMB access to a character device to avoid one
  partition switch (just merged)

REMAINS:
- Convert boot and "general" partitions to be part of the main
  block device. Because they are. (This is really tricky and
  may require changes in the core kernel partition handling.)
- Delete the dual mode card support. (No-one seems to be
  using it.)
- Split the world in block access and SDIO with something
  like a simple mutex: either the host is a block device OR
  it is SDIO, and that state has the same lifetime as a card,
  since they are now either block devices or SDIO not both
  at the same time.
- Implement a lighter lock for SDIO host claiming.
- Now the lock should be gone...

As you can see it is not entirely trivial :/

Linus
