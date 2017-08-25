Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754704AbdHYMua (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 08:50:30 -0400
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
Subject: [PATCH V6 00/12] mmc: Add Command Queue support
Date: Fri, 25 Aug 2017 15:43:43 +0300
Message-Id: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi

Here is V6 of the hardware command queue patches without the software
command queue patches.  Patches "mmc: host: Add CQE interface" and
"mmc: core: Turn off CQE before sending commands" have been applied to Ulf's
next branch.  "mmc: host: Add CQE interface" needs to be dropped in favour
of the new version.

HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
2% drop in sequential read speed but no change to sequential write.

We need to start with the legacy block API because people want to backport
CQ to earlier kernels (we really need to get features upstream more
quickly), but blk-mq has been evolving a lot (e.g. elevator support), so
backporters face having either something quite different from upstream or
trying to backport great chunks of the block layer.

We also don't know how blk-mq will perform so it would be prudent to start
with support for both the legacy API and blk-mq (as scsi does) so that we
can find out first.

RFC patches to support blk-mq can be found here:
	https://marc.info/?l=linux-block&m=150349582124880


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


Adrian Hunter (11):
      mmc: core: Move mmc_start_areq() declaration
      mmc: block: Fix block status codes
      mmc: host: Add CQE interface
      mmc: core: Turn off CQE before sending commands
      mmc: core: Add support for handling CQE requests
      mmc: mmc: Enable Command Queuing
      mmc: mmc: Enable CQE's
      mmc: block: Use local variables in mmc_blk_data_prep()
      mmc: block: Prepare CQE data
      mmc: block: Add CQE support
      mmc: sdhci-pci: Add CQHCI support for Intel GLK

Venkat Gopalakrishnan (1):
      mmc: cqhci: support for command queue enabled host

 drivers/mmc/core/block.c          |  246 +++++++-
 drivers/mmc/core/block.h          |    7 +
 drivers/mmc/core/bus.c            |    7 +
 drivers/mmc/core/core.c           |  172 +++++-
 drivers/mmc/core/core.h           |   10 +
 drivers/mmc/core/mmc.c            |   29 +
 drivers/mmc/core/queue.c          |  270 ++++++++-
 drivers/mmc/core/queue.h          |   43 +-
 drivers/mmc/host/Kconfig          |   14 +
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/cqhci.c          | 1154 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h          |  240 ++++++++
 drivers/mmc/host/sdhci-pci-core.c |  154 ++++-
 include/linux/mmc/core.h          |   10 +-
 include/linux/mmc/host.h          |   55 ++
 15 files changed, 2381 insertions(+), 31 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci.c
 create mode 100644 drivers/mmc/host/cqhci.h


Regards
Adrian
