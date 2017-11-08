Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39855 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdKHOPL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Nov 2017 09:15:11 -0500
Subject: Re: [PATCH V13 05/10] mmc: cqhci: support for command queue enabled
 host
To: Linus Walleij <linus.walleij@linaro.org>
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
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-6-git-send-email-adrian.hunter@intel.com>
 <CACRpkdYY_a3fuayN3z5xn952t=YYJ8LA6wqXDtd=7ea03a187w@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <a9eb7e73-31b4-6ff6-4a0d-1416c938039b@intel.com>
Date: Wed, 8 Nov 2017 16:14:55 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdYY_a3fuayN3z5xn952t=YYJ8LA6wqXDtd=7ea03a187w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/11/17 11:22, Linus Walleij wrote:
> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>
>> This patch adds CMDQ support for command-queue compatible
>> hosts.
>>
>> Command queue is added in eMMC-5.1 specification. This
>> enables the controller to process upto 32 requests at
>> a time.
>>
>> Adrian Hunter contributed renaming to cqhci, recovery, suspend
>> and resume, cqhci_off, cqhci_wait_for_idle, and external timeout
>> handling.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> (...)
>> +config MMC_CQHCI
>> +       tristate "Command Queue Host Controller Interface support"
>> +       depends on HAS_DMA
> 
> If the CQE implementation depends on MQ, should this not
> also select MMC_MQ_DEFAULT?

No, there is no dependency on MMC_MQ_DEFAULT.

> 
> And if the CQE implementation depens on MQ, isn't it dangerous
> to even have a boot option to disable it?

No, there is no dependency on MMC_MQ_DEFAULT.

> 
> Again I push the point that things are easier to keep in line
> if we just support one block request path (MQ), sorry for
> hammering.
> 
>> +int cqhci_suspend(struct mmc_host *mmc)
>> +{
>> +       struct cqhci_host *cq_host = mmc->cqe_private;
>> +
>> +       if (cq_host->enabled)
>> +               __cqhci_disable(cq_host);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(cqhci_suspend);
>> +
>> +int cqhci_resume(struct mmc_host *mmc)
>> +{
>> +       /* Re-enable is done upon first request */
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(cqhci_resume);
> 
> Why would the CQE case require special suspend/resume
> functionality?

Seems like a very strange question. Obviously CQHCI has to be configured
after suspend.

Also please don't confuse CQE and CQHCI.  CQHCI is an implementation of a
CQE.  We currently do not expect to have another implementation, but it is
not impossible.

> 
> This seems two much like on the side CQE-silo engineering,
> just use the device .[runtime]_suspend/resume callbacks like
> everyone else, make it possible for the host to figure out
> if it is in CQE mode or not (I guess it should know already
> since cqhci .enable() has been called?) and handle it
> from there.

That is how it works!  The host controller has to decide how to handle
suspend / resume.

cqhci_suspend() / cqhci_resume() are helper functions that the host
controller can use, but doesn't have to.

> 
>> +struct cqhci_host_ops {
>> +       void (*dumpregs)(struct mmc_host *mmc);
>> +       void (*write_l)(struct cqhci_host *host, u32 val, int reg);
>> +       u32 (*read_l)(struct cqhci_host *host, int reg);
>> +       void (*enable)(struct mmc_host *mmc);
>> +       void (*disable)(struct mmc_host *mmc, bool recovery);
>> +};
>> +
>> +static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
>> +{
>> +       if (unlikely(host->ops->write_l))
>> +               host->ops->write_l(host, val, reg);
>> +       else
>> +               writel_relaxed(val, host->mmio + reg);
>> +}
> 
> Why would CQE hosts need special accessors and the rest
> of the host not need it?

Special accessors can be used to fix up registers that don't work exactly
the way the standard specified.

> 
> This seems to be a bit hackish "just for CQE" approach,
> abstract callbacks like ->dumpregs(), ->write_l() and
> ->read_l() seems to be something that should be in the
> generic struct mmc_host_ops and not tied to CQE, if
> needed at all.

They are nothing to do with CQE or mmc ops.  These are for hosts that have a
CQHCI compatible CQE.

> 
> ->enable and ->disable() for just CQE seem reasonable.
> But that leaves just two new ops.
> 
> So why not just put .cqe_enable() and .cqe_disable()
> ops into mmc_host_ops as optional and be done with it?

Ok so you are not understanding this at all.

As a CQE implementation, CQHCI interfaces with the upper layers through the
CQE ops etc.

But CQHCI also has to work with any host controller driver, so it needs an
interface for that, which is what cqhci_host_ops is for.  All the ops serve
useful purposes.

> 
>> +irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>> +                     int data_error);
>> +int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
>> +struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
>> +int cqhci_suspend(struct mmc_host *mmc);
>> +int cqhci_resume(struct mmc_host *mmc);
> 
> This seems overall too much bolted on the side.

The whole point is to prove a library that can work with any host controller
driver.  That means it must provide functions and callbacks.

> 
> I think the above approach to put any CQE-specific callbacks
> directly into the struct mmc_host_ops is way more viable.

Nothing to do with CQE.  This is CQHCI.  Please try to get the difference.

> 
> If special CQE init is needed, why a special cqhci_init()
> call? And cqhci_pltfm_init()? It's confusing. Can't
> you just call this by default from the core if the host is
> CQE capable? Ass a .cqhci_init() callback into mmc_host_ops
> if need be.

Yeah, so CQHCI is just one of theoretically any number of CQE
implementations.  This has nothing to do with the core.  It is entirely up
to the host driver.  cqhci_pltfm_init() allows the mmio space to be defined
by platform resources, whereas cqhci_init() does all the rest of the
initialization.

> 
> cqhci_irq() seems necessary though, I see something like this is
> probably necessary.
