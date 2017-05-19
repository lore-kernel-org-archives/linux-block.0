Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] More MMC block core refactorings
Date: Fri, 19 May 2017 15:37:26 +0200
Message-Id: <20170519133732.27470-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This series builds on top of the previous series that created
custom DRV_OP requests for ioctl() operations in MMC.

The first patch is a suggestion from Christoph, the second
builds infrastructure for issuing more, currently orthogonal
custom operations through the block layer.

The first operation we move over is pretty uncontroversial
and straight-forward: it is the operation that
write-protect-locks the boot partitions from sysfs. This
is now done through the block layer so we do not need
to congest and starve in the big MMC lock.

The last two patches are more contoversial: they move the
two debugfs accesses for reading card status and EXT CSD
over to using the block layer funnel *if* *present*.

So if the block layer is configured out, these will still
issue operations directly and take the big MMC lock.

The patch series is fully ABI safe: any scripts or code
using the debugfs with or without the block layer will
still work.

However this leaves the mmc_card_get() locks in the block.h
header for the !CONFIG_MMC_BLOCK case and I'm not really happy
to keep them around, the idea is to terminate them.

Ways forward after these patches:

- Simply remove the debugfs files for status and ext_csd if
  the block layer is not there. The debugfs is not ABI after
  all, and there is an ioctl() to do the same job, and
  that is what mmc-utils is using.

- Simply remove the debugfs files for status and ext_csd
  completely - and require users to switch to using the
  ioctl() mmc-utils way of doing things if they want to
  inspect their MMC/SD cards.

- Wait and see: when I get to removing the big MMC lock from
  SDIO I will anyway have to deal with this mess since
  the big lock is no more a block layer problem, but a
  problem with the entire MMC/SD/SDIO stack.

In any case: these patches fixes the starvation of the
boot partition locking and the debugfs access when using
the block layer heavily at the same time.

Linus Walleij (6):
  mmc: block: remove req back pointer
  mmc: block: Tag DRV_OPs with a driver operation type
  mmc: block: Move DRV OP issue function
  mmc: block: Move boot partition locking into a driver op
  mmc: debugfs: Move card status retrieveal into the block layer
  mmc: debugfs: Move EXT CSD debugfs acces to block layer

 drivers/mmc/core/block.c   | 168 ++++++++++++++++++++++++++++++++-------------
 drivers/mmc/core/block.h   |  49 +++++++++++++
 drivers/mmc/core/debugfs.c |  19 +----
 drivers/mmc/core/queue.c   |  13 ++--
 drivers/mmc/core/queue.h   |  27 +++++++-
 5 files changed, 200 insertions(+), 76 deletions(-)

-- 
2.9.3
