Return-Path: <ulf.hansson@linaro.org>
Return-Path: <ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Paolo Valente <paolo.valente@linaro.org>,
	linux-block@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 0/3] mmc: core: Prepare mmc host locking for blk-mq
Date: Thu, 11 May 2017 14:38:59 +0200
Message-Id: <1494506343-28572-1-git-send-email-ulf.hansson@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The current APIs, mmc_claim|release_host() doesn't play well when the mmc block
device driver tries to convert to blk-mq. In principle we need a re-claiming
possibility of the host from the mmc block device driver, and to know when to
release the host, need to keep track of a reference count instead.

This series, so far untested, implements the idea from above. Sent as an RFC
just to get peoples opinion of whether this is an approach that could work.

Ulf Hansson (3):
  mmc: sdio: Don't use abort-able claim host method from SDIO IRQ thread
  mmc: core: Remove redundant abort-able claim host API
  mmc: core: Allow mmc block device to re-claim the host

 drivers/mmc/core/core.c     | 33 ++++++++++++++-------------------
 drivers/mmc/core/core.h     | 10 ++--------
 drivers/mmc/core/sdio_irq.c | 10 ++++++----
 include/linux/mmc/host.h    |  2 +-
 4 files changed, 23 insertions(+), 32 deletions(-)

-- 
2.7.4
