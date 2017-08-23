Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18403 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbdHWNnj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 09:43:39 -0400
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: [PATCH RFC 0/3] mmc: block: Add blk-mq support for CQE
Date: Wed, 23 Aug 2017 16:37:05 +0300
Message-Id: <1503495428-11999-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi

Here is an example of using blk-mq with a host that has an eMMC Command
Queue Engine (CQE).

Points to note:
	- it is a bit rough, lacks explanation, patches need splitting up
	- does seem to work, but not tested properly
	- uses BLK_MQ_F_BLOCKING

BLK_MQ_F_BLOCKING is used for a number of reasons:

1. Since v4.12 if a queue has only 1 hw queue (and mmc only ever has 1),
then requests are never issued directly (refer blk_mq_make_request()) which
means there is no practical advantage not to use BLK_MQ_F_BLOCKING

2. CQE only supports reads / writes so the CQE implementation makes use of
the existing non-CQE code for discards and flushes - which are both
blocking at this time.

3. blk-mq has no support for runtime pm and mmc runtime pm is blocking

4. host claiming is blocking

5. existing synchronization does not support requests being issued
simultaneously

One small concern is that the block layer workqueue runs with elevated
priority (WQ_HIGHPRI).  It is not clear to me whether that might be
undesirable on the occasion mmc is polling, for example mmc_poll_for_busy()
when the host implements host->ops->card_busy()


Adrian Hunter (3):
      mmc: core: Add parameter use_blk_mq
      mmc: core: Introduce host claiming by context
      mmc: block: Add blk-mq support for CQE

 drivers/mmc/Kconfig      |  11 ++
 drivers/mmc/core/block.c |  88 ++++++++++--
 drivers/mmc/core/block.h |   2 +
 drivers/mmc/core/core.c  | 116 ++++++++++++++-
 drivers/mmc/core/core.h  |  10 ++
 drivers/mmc/core/host.c  |   2 +
 drivers/mmc/core/host.h  |   4 +
 drivers/mmc/core/queue.c | 363 +++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/queue.h |   4 +
 include/linux/mmc/host.h |   8 +-
 10 files changed, 545 insertions(+), 63 deletions(-)


Regards
Adrian
