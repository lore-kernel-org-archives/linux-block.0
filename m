Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:49596 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdKHJWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Nov 2017 04:22:50 -0500
Received: by mail-it0-f65.google.com with SMTP id y15so6007018ita.4
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2017 01:22:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1509715220-31885-6-git-send-email-adrian.hunter@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com> <1509715220-31885-6-git-send-email-adrian.hunter@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 8 Nov 2017 10:22:49 +0100
Message-ID: <CACRpkdYY_a3fuayN3z5xn952t=YYJ8LA6wqXDtd=7ea03a187w@mail.gmail.com>
Subject: Re: [PATCH V13 05/10] mmc: cqhci: support for command queue enabled host
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

> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>
> This patch adds CMDQ support for command-queue compatible
> hosts.
>
> Command queue is added in eMMC-5.1 specification. This
> enables the controller to process upto 32 requests at
> a time.
>
> Adrian Hunter contributed renaming to cqhci, recovery, suspend
> and resume, cqhci_off, cqhci_wait_for_idle, and external timeout
> handling.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

(...)
> +config MMC_CQHCI
> +       tristate "Command Queue Host Controller Interface support"
> +       depends on HAS_DMA

If the CQE implementation depends on MQ, should this not
also select MMC_MQ_DEFAULT?

And if the CQE implementation depens on MQ, isn't it dangerous
to even have a boot option to disable it?

Again I push the point that things are easier to keep in line
if we just support one block request path (MQ), sorry for
hammering.

> +int cqhci_suspend(struct mmc_host *mmc)
> +{
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +
> +       if (cq_host->enabled)
> +               __cqhci_disable(cq_host);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(cqhci_suspend);
> +
> +int cqhci_resume(struct mmc_host *mmc)
> +{
> +       /* Re-enable is done upon first request */
> +       return 0;
> +}
> +EXPORT_SYMBOL(cqhci_resume);

Why would the CQE case require special suspend/resume
functionality?

This seems two much like on the side CQE-silo engineering,
just use the device .[runtime]_suspend/resume callbacks like
everyone else, make it possible for the host to figure out
if it is in CQE mode or not (I guess it should know already
since cqhci .enable() has been called?) and handle it
from there.

> +struct cqhci_host_ops {
> +       void (*dumpregs)(struct mmc_host *mmc);
> +       void (*write_l)(struct cqhci_host *host, u32 val, int reg);
> +       u32 (*read_l)(struct cqhci_host *host, int reg);
> +       void (*enable)(struct mmc_host *mmc);
> +       void (*disable)(struct mmc_host *mmc, bool recovery);
> +};
> +
> +static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
> +{
> +       if (unlikely(host->ops->write_l))
> +               host->ops->write_l(host, val, reg);
> +       else
> +               writel_relaxed(val, host->mmio + reg);
> +}

Why would CQE hosts need special accessors and the rest
of the host not need it?

This seems to be a bit hackish "just for CQE" approach,
abstract callbacks like ->dumpregs(), ->write_l() and
->read_l() seems to be something that should be in the
generic struct mmc_host_ops and not tied to CQE, if
needed at all.

->enable and ->disable() for just CQE seem reasonable.
But that leaves just two new ops.

So why not just put .cqe_enable() and .cqe_disable()
ops into mmc_host_ops as optional and be done with it?

> +irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
> +                     int data_error);
> +int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
> +struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
> +int cqhci_suspend(struct mmc_host *mmc);
> +int cqhci_resume(struct mmc_host *mmc);

This seems overall too much bolted on the side.

I think the above approach to put any CQE-specific callbacks
directly into the struct mmc_host_ops is way more viable.

If special CQE init is needed, why a special cqhci_init()
call? And cqhci_pltfm_init()? It's confusing. Can't
you just call this by default from the core if the host is
CQE capable? Ass a .cqhci_init() callback into mmc_host_ops
if need be.

cqhci_irq() seems necessary though, I see something like this is
probably necessary.

Yours,
Linus Walleij
