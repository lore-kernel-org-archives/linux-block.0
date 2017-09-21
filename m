Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:47666 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdIUJBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 05:01:42 -0400
Received: by mail-io0-f170.google.com with SMTP id e189so9415641ioa.4
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 02:01:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 21 Sep 2017 11:01:41 +0200
Message-ID: <CAPDyKFr-XbMOmOkz1yXwmG1t=77eSsUO2kU7kKV0V1wrfcmWKg@mail.gmail.com>
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
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
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 13 September 2017 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is V8 of the hardware command queue patches without the software
> command queue patches, now using blk-mq and now with blk-mq support for
> non-CQE I/O.
>
> After the unacceptable debacle of the last release cycle, I expect an
> immediate response to these patches.
>
> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
> 2% drop in sequential read speed but no change to sequential write.
>
> Non-CQE blk-mq showed a 3% decrease in sequential read performance.  This
> seemed to be coming from the inferior latency of running work items compared
> with a dedicated thread.  Hacking blk-mq workqueue to be unbound reduced the
> performance degradation from 3% to 1%.
>
> While we should look at changing blk-mq to give better workqueue performance,
> a bigger gain is likely to be made by adding a new host API to enable the
> next already-prepared request to be issued directly from within ->done()
> callback of the current request.

Adrian, I am reviewing this series, however let me comment on each
change individually.

I have also run some test on my ux500 board and enabling the blkmq
path via the new MMC Kconfig option. My idea was to run some iozone
comparisons between the legacy path and the new blkmq path, but I just
couldn't get to that point because of the following errors.

I am using a Kingston 4GB SDHC card, which is detected and mounted
nicely. However, when I decide to do some writes to the card I get the
following errors.

root@ME:/mnt/sdcard dd if=/dev/zero of=testfile bs=8192 count=5000 conv=fsync
[  463.714294] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  464.722656] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  466.081481] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  467.111236] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  468.669647] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  469.685699] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  471.043334] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  472.052337] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  473.342651] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  474.323760] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  475.544769] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  476.539031] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  477.748474] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!
[  478.724182] mmci-pl18x 80126000.sdi0_per1: error during DMA transfer!

I haven't yet got the point of investigating this any further, and
unfortunate I have a busy schedule with traveling next week. I will do
my best to look into this as soon as I can.

Perhaps you have some ideas?

Kind regards
Uffe

>
>
> Changes since V7:
>         Re-based
>       mmc: core: Introduce host claiming by context
>         Slightly simplified
>       mmc: core: Add parameter use_blk_mq
>         New patch.
>       mmc: core: Remove unnecessary host claim
>         New patch.
>       mmc: core: Export mmc_start_bkops()
>         New patch.
>       mmc: core: Export mmc_start_request()
>         New patch.
>       mmc: block: Add CQE and blk-mq support
>         Add blk-mq support for non_CQE requests
>
> Changes since V6:
>       mmc: core: Introduce host claiming by context
>         New patch.
>       mmc: core: Move mmc_start_areq() declaration
>         Dropped because it has been applied
>       mmc: block: Fix block status codes
>         Dropped because it has been applied
>       mmc: host: Add CQE interface
>         Dropped because it has been applied
>       mmc: core: Turn off CQE before sending commands
>         Dropped because it has been applied
>       mmc: block: Factor out mmc_setup_queue()
>         New patch.
>       mmc: block: Add CQE support
>         Drop legacy support and add blk-mq support
>
> Changes since V5:
>         Re-based
>       mmc: core: Add mmc_retune_hold_now()
>         Dropped because it has been applied
>       mmc: core: Add members to mmc_request and mmc_data for CQE's
>         Dropped because it has been applied
>       mmc: core: Move mmc_start_areq() declaration
>         New patch at Ulf's request
>       mmc: block: Fix block status codes
>         Another un-related patch
>       mmc: host: Add CQE interface
>         Move recovery_notifier() callback to struct mmc_request
>       mmc: core: Add support for handling CQE requests
>         Roll __mmc_cqe_request_done() into mmc_cqe_request_done()
>         Move function declarations requested by Ulf
>       mmc: core: Remove unused MMC_CAP2_PACKED_CMD
>         Dropped because it has been applied
>       mmc: block: Add CQE support
>         Add explanation to commit message
>         Adjustment for changed recovery_notifier() callback
>       mmc: cqhci: support for command queue enabled host
>         Adjustment for changed recovery_notifier() callback
>       mmc: sdhci-pci: Add CQHCI support for Intel GLK
>         Add DCMD capability for Intel controllers except GLK
>
> Changes since V4:
>       mmc: core: Add mmc_retune_hold_now()
>         Add explanation to commit message.
>       mmc: host: Add CQE interface
>         Add comments to callback declarations.
>       mmc: core: Turn off CQE before sending commands
>         Add explanation to commit message.
>       mmc: core: Add support for handling CQE requests
>         Add comments as requested by Ulf.
>       mmc: core: Remove unused MMC_CAP2_PACKED_CMD
>         New patch.
>       mmc: mmc: Enable Command Queuing
>         Adjust for removal of MMC_CAP2_PACKED_CMD.
>         Add a comment about Packed Commands.
>       mmc: mmc: Enable CQE's
>         Remove un-necessary check for MMC_CAP2_CQE
>       mmc: block: Use local variables in mmc_blk_data_prep()
>         New patch.
>       mmc: block: Prepare CQE data
>         Adjust due to "mmc: block: Use local variables in mmc_blk_data_prep()"
>         Remove priority setting.
>         Add explanation to commit message.
>       mmc: cqhci: support for command queue enabled host
>         Fix transfer descriptor setting in cqhci_set_tran_desc() for 32-bit DMA
>
> Changes since V3:
>         Adjusted ...blk_end_request...() for new block status codes
>         Fixed CQHCI transaction descriptor for "no DCMD" case
>
> Changes since V2:
>         Dropped patches that have been applied.
>         Re-based
>         Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"
>
> Changes since V1:
>
>         "Share mmc request array between partitions" is dependent
>         on changes in "Introduce queue semantics", so added that
>         and block fixes:
>
>         Added "Fix is_waiting_last_req set incorrectly"
>         Added "Fix cmd error reset failure path"
>         Added "Use local var for mqrq_cur"
>         Added "Introduce queue semantics"
>
> Changes since RFC:
>
>         Re-based on next.
>         Added comment about command queue priority.
>         Added some acks and reviews.
>
>
> Adrian Hunter (13):
>       mmc: core: Introduce host claiming by context
>       mmc: core: Add support for handling CQE requests
>       mmc: mmc: Enable Command Queuing
>       mmc: mmc: Enable CQE's
>       mmc: block: Use local variables in mmc_blk_data_prep()
>       mmc: block: Prepare CQE data
>       mmc: block: Factor out mmc_setup_queue()
>       mmc: core: Add parameter use_blk_mq
>       mmc: core: Remove unnecessary host claim
>       mmc: core: Export mmc_start_bkops()
>       mmc: core: Export mmc_start_request()
>       mmc: block: Add CQE and blk-mq support
>       mmc: sdhci-pci: Add CQHCI support for Intel GLK
>
> Venkat Gopalakrishnan (1):
>       mmc: cqhci: support for command queue enabled host
>
>  drivers/mmc/Kconfig               |   11 +
>  drivers/mmc/core/block.c          |  777 ++++++++++++++++++++++++-
>  drivers/mmc/core/block.h          |    8 +
>  drivers/mmc/core/bus.c            |    7 +
>  drivers/mmc/core/core.c           |  265 ++++++++-
>  drivers/mmc/core/core.h           |   14 +
>  drivers/mmc/core/host.c           |    2 +
>  drivers/mmc/core/host.h           |    4 +
>  drivers/mmc/core/mmc.c            |   29 +
>  drivers/mmc/core/mmc_ops.c        |    6 +-
>  drivers/mmc/core/queue.c          |  479 +++++++++++++--
>  drivers/mmc/core/queue.h          |   54 +-
>  drivers/mmc/host/Kconfig          |   14 +
>  drivers/mmc/host/Makefile         |    1 +
>  drivers/mmc/host/cqhci.c          | 1154 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h          |  240 ++++++++
>  drivers/mmc/host/sdhci-pci-core.c |  154 ++++-
>  include/linux/mmc/host.h          |   10 +-
>  18 files changed, 3146 insertions(+), 83 deletions(-)
>  create mode 100644 drivers/mmc/host/cqhci.c
>  create mode 100644 drivers/mmc/host/cqhci.h
>
>
> Regards
> Adrian
