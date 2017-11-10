Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/12 v5] Multiqueue for MMC/SD
Date: Fri, 10 Nov 2017 11:01:31 +0100
Message-Id: <20171110100143.12256-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This is the fifth iteration of this patch set.

I *HOPE* that we can scrap this patch set and merge Adrian's
patches instead, because they also bring CQE support which is
nice. I had some review comments on his series, mainly that
it needs to kill off the legacy block layer code path that
noone likes anyway.

So this is mainly an academic and inspirational exercise.
Whatever remains of this refactoring, if anything, I can
certainly do on top of Adrian's patches as well.

What changed since v4 is the error path, since Adrian pointed
out that the error handling seems to be fragile. It was indeed
fragile... To make sure things work properly I have run long
test rounds with fault injection, essentially:

Enable FAULT_INJECTION, FAULT_INJECTION_DEBUG_FS,
       FAIL_MMC_REQUEST
cd /debug/mmc3/fail_mmc_request/
echo 1 > probability
echo -1 > times

Then running a dd to the card, also increased the error rate
to 10% and completed tests successfully, but at this error
rate the MMC stack sometimes exceeds the retry limit and the
dd command fails (as is appropriate).

Removing a card during I/O does not work well however :/
So I guess I would need to work on that if this series should
continue. (Hopefully unlikely.)


Linus Walleij (12):
  mmc: core: move the asynchronous post-processing
  mmc: core: add a workqueue for completing requests
  mmc: core: replace waitqueue with worker
  mmc: core: do away with is_done_rcv
  mmc: core: do away with is_new_req
  mmc: core: kill off the context info
  mmc: queue: simplify queue logic
  mmc: block: shuffle retry and error handling
  mmc: queue: stop flushing the pipeline with NULL
  mmc: queue/block: pass around struct mmc_queue_req*s
  mmc: block: issue requests in massive parallel
  mmc: switch MMC/SD to use blk-mq multiqueueing v5

 drivers/mmc/core/block.c    | 557 +++++++++++++++++++++++---------------------
 drivers/mmc/core/block.h    |   5 +-
 drivers/mmc/core/bus.c      |   1 -
 drivers/mmc/core/core.c     | 217 ++++++++++-------
 drivers/mmc/core/core.h     |  11 +-
 drivers/mmc/core/host.c     |   1 -
 drivers/mmc/core/mmc_test.c |  31 +--
 drivers/mmc/core/queue.c    | 252 ++++++++------------
 drivers/mmc/core/queue.h    |  16 +-
 include/linux/mmc/core.h    |   3 +-
 include/linux/mmc/host.h    |  31 +--
 11 files changed, 557 insertions(+), 568 deletions(-)

-- 
2.13.6
