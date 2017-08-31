Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbdHaMDd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 08:03:33 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH V7 00/10] mmc: Add Command Queue support
Date: Thu, 31 Aug 2017 14:56:46 +0300
Message-Id: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi

Here is V7 of the hardware command queue patches without the software
command queue patches, now using blk-mq.

HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
2% drop in sequential read speed but no change to sequential write.


Changes since V6:
      mmc: core: Introduce host claiming by context
	New patch.
      mmc: core: Move mmc_start_areq() declaration
	Dropped because it has been applied
      mmc: block: Fix block status codes
	Dropped because it has been applied
      mmc: host: Add CQE interface
	Dropped because it has been applied
      mmc: core: Turn off CQE before sending commands
	Dropped because it has been applied
      mmc: block: Factor out mmc_setup_queue()
	New patch.
      mmc: block: Add CQE support
	Drop legacy support and add blk-mq support

Changes since V5:
	Re-based
      mmc: core: Add mmc_retune_hold_now()
	Dropped because it has been applied
      mmc: core: Add members to mmc_request and mmc_data for CQE's
	Dropped because it has been applied
      mmc: core: Move mmc_start_areq() declaration
	New patch at Ulf's request
      mmc: block: Fix block status codes
	Another un-related patch
      mmc: host: Add CQE interface
	Move recovery_notifier() callback to struct mmc_request
      mmc: core: Add support for handling CQE requests
	Roll __mmc_cqe_request_done() into mmc_cqe_request_done()
	Move function declarations requested by Ulf
      mmc: core: Remove unused MMC_CAP2_PACKED_CMD
	Dropped because it has been applied
      mmc: block: Add CQE support
	Add explanation to commit message
	Adjustment for changed recovery_notifier() callback
      mmc: cqhci: support for command queue enabled host
	Adjustment for changed recovery_notifier() callback
      mmc: sdhci-pci: Add CQHCI support for Intel GLK
	Add DCMD capability for Intel controllers except GLK

Changes since V4:
      mmc: core: Add mmc_retune_hold_now()
	Add explanation to commit message.
      mmc: host: Add CQE interface
	Add comments to callback declarations.
      mmc: core: Turn off CQE before sending commands
	Add explanation to commit message.
      mmc: core: Add support for handling CQE requests
	Add comments as requested by Ulf.
      mmc: core: Remove unused MMC_CAP2_PACKED_CMD
	New patch.
      mmc: mmc: Enable Command Queuing
	Adjust for removal of MMC_CAP2_PACKED_CMD.
	Add a comment about Packed Commands.
      mmc: mmc: Enable CQE's
	Remove un-necessary check for MMC_CAP2_CQE
      mmc: block: Use local variables in mmc_blk_data_prep()
	New patch.
      mmc: block: Prepare CQE data
	Adjust due to "mmc: block: Use local variables in mmc_blk_data_prep()"
	Remove priority setting.
	Add explanation to commit message.
      mmc: cqhci: support for command queue enabled host
	Fix transfer descriptor setting in cqhci_set_tran_desc() for 32-bit DMA

Changes since V3:
	Adjusted ...blk_end_request...() for new block status codes
	Fixed CQHCI transaction descriptor for "no DCMD" case

Changes since V2:
	Dropped patches that have been applied.
	Re-based
	Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"

Changes since V1:

	"Share mmc request array between partitions" is dependent
	on changes in "Introduce queue semantics", so added that
	and block fixes:

	Added "Fix is_waiting_last_req set incorrectly"
	Added "Fix cmd error reset failure path"
	Added "Use local var for mqrq_cur"
	Added "Introduce queue semantics"

Changes since RFC:

	Re-based on next.
	Added comment about command queue priority.
	Added some acks and reviews.


Adrian Hunter (9):
      mmc: core: Introduce host claiming by context
      mmc: core: Add support for handling CQE requests
      mmc: mmc: Enable Command Queuing
      mmc: mmc: Enable CQE's
      mmc: block: Use local variables in mmc_blk_data_prep()
      mmc: block: Prepare CQE data
      mmc: block: Factor out mmc_setup_queue()
      mmc: block: Add CQE support
      mmc: sdhci-pci: Add CQHCI support for Intel GLK

Venkat Gopalakrishnan (1):
      mmc: cqhci: support for command queue enabled host

 drivers/mmc/core/block.c          |  260 ++++++++-
 drivers/mmc/core/block.h          |    7 +
 drivers/mmc/core/bus.c            |    7 +
 drivers/mmc/core/core.c           |  272 ++++++++-
 drivers/mmc/core/core.h           |   12 +
 drivers/mmc/core/mmc.c            |   29 +
 drivers/mmc/core/queue.c          |  438 ++++++++++++--
 drivers/mmc/core/queue.h          |   46 +-
 drivers/mmc/host/Kconfig          |   14 +
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/cqhci.c          | 1154 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h          |  240 ++++++++
 drivers/mmc/host/sdhci-pci-core.c |  154 ++++-
 include/linux/mmc/host.h          |    9 +-
 14 files changed, 2567 insertions(+), 76 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci.c
 create mode 100644 drivers/mmc/host/cqhci.h


Regards
Adrian
