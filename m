Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40814 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759948AbdACRbS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2017 12:31:18 -0500
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        baolin.wang@linaro.org, riteshh@codeaurora.org, arnd@arndb.de,
        zhang.chunyan@linaro.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH PoCv2 0/2] mmc: add blk-mq support
Date: Tue, 03 Jan 2017 18:30:16 +0100
Message-id: <1483464618-16133-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170103173113epcas5p3bcc48e614ca71c27917a966640321138@epcas5p3.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

It prints a lot of scheduling while atomic warnings during
boot, lacks error handling and is otherwise incomplete but
boots successully on my Odroid-XU3 board.  I hope that it
is useful to somebody.

The differences between these patches and Linus' RFD patch:
- request completion is handled from the IRQ handler
  (or tasklet context as happens in dw_mmc host driver)
- adds blk-mq code while leaving old code still in place
- based on top of on Adrian's queue handling cleanups
- no support for qdepth == 2 at the moment

The patchset is based on top of commit "mmc: block:
Introduce queue semantics" from swcmdq branch by Adrian
Hunter:

  http://git.infradead.org/users/ahunter/linux-sdhci.git
  (swcmdq branch
   commit 7a1cdc218dac843ebb4eac6d3fd24d54ba30a5b0)

The complete patchset can be found at:

  https://github.com/bzolnier/linux.git mmc-blk-mq-pocv2

Changes since PoC version
(http://www.spinics.net/lists/linux-mmc/msg39351.html):
- removed most of the debugging code
- reworked the blk-mq code to be an add-on instead of
  rewrite
- ported over newer swcmdq branch version
- reverted shared mmc queue changes from swcmdq as they
  break mmc-mq currently
- dropped support for qdepth == 2 as it hasn't survived
  the forward porting (it was ugly & not optimal anyway,
  rewrite to try hwqueue == 2 idea is on TODO)
- misc cleanups

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (2):
  Revert "mmc: queue: Share mmc request array between partitions"
  mmc-mq: initial blk-mq support

 drivers/mmc/core/block.c    | 115 ++++++++++-----
 drivers/mmc/core/block.h    |   3 +-
 drivers/mmc/core/bus.c      |   3 +-
 drivers/mmc/core/core.c     | 120 +++++++++++++++-
 drivers/mmc/core/mmc_test.c |  16 ++-
 drivers/mmc/core/queue.c    | 344 +++++++++++++++++++++++++-------------------
 drivers/mmc/core/queue.h    |   7 +-
 include/linux/mmc/card.h    |   5 -
 include/linux/mmc/core.h    |  12 ++
 9 files changed, 421 insertions(+), 204 deletions(-)

-- 
1.9.1

