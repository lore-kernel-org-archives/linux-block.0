Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:46730 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964845AbdIZXmT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2017 19:42:19 -0400
Received: by mail-it0-f42.google.com with SMTP id d192so5137758itd.1
        for <linux-block@vger.kernel.org>; Tue, 26 Sep 2017 16:42:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506083824-4024-10-git-send-email-adrian.hunter@intel.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com> <1506083824-4024-10-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Sep 2017 01:42:17 +0200
Message-ID: <CACRpkdZWtSHxQfkgZZDvzX562Jy_KenP__ruszLoeKKn+AkKig@mail.gmail.com>
Subject: Re: [PATCH V9 09/15] mmc: core: Add parameter use_blk_mq
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

> Until mmc has blk-mq support fully implemented and tested, add a
> parameter use_blk_mq, default to false unless config option MMC_MQ_DEFAULT
> is selected.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

> +config MMC_MQ_DEFAULT
> +       bool "MMC: use blk-mq I/O path by default"
> +       depends on MMC && BLOCK

I would say:
default y

Why not. SCSI is starting to enable this by default so IMO we should
not take the
intermediate step of having this as optional. Otherwise it never gets tested.

Set it to default y and after two kernel releases, if nothing happens, we simply
delete the old block layer path.

> +#ifdef CONFIG_MMC_MQ_DEFAULT
> +bool mmc_use_blk_mq = true;
> +#else
> +bool mmc_use_blk_mq = false;
> +#endif
> +module_param_named(use_blk_mq, mmc_use_blk_mq, bool, S_IWUSR | S_IRUGO);

Are people really modprobing this so it needs to be a module parameter?

Maybe I'm the only developer stupid enough to just recompile and reboot
the whole kernel, I guess this makes sense if you're testing on the same
machine you're developing on (no cross-compilation and remote target)
which I guess is what some Intel people are doing with their laptops.

Yours,
Linus Walleij
