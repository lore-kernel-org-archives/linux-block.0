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
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] mmc: core: modernize ioctl() requests
Date: Wed, 10 May 2017 10:24:13 +0200
Message-Id: <20170510082418.10513-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This is a series that starts to untangle the MMC "big host lock",
i.e. what is taken by issueing mmc_claim_host() which usually happens
through mmc_get_card().

The host lock is standing in the way of a bunch of modernizations,
because the block layer interface takes this lock when a new request
arrives, then will not release it until the queue is empty, which
is detected by getting NULL from blk_fetch_request().

This does not work with the new MQ block layer because it issues
requests asynchrously and there is no way of telling if the submit
queue is empty or not. Block requests must always be served. Trying
to introduce an interface for figuring out if the queue is empty
is probably generally a bad idea as it will require cross-talk
between all CPUs and then we hit Amdahl's Law again when scaling
upwards with CPUs.

So Arnd Bergmann suggested that whatever parallel requests the
host lock is protecting, maybe these requests can be funneled
through the block layer itself?

It turns out that most block drivers already do this, by using the
"special" block requests REQ_OP_DRV_IN and REQ_OP_DRV_OUT. And
it is what we should have done from the beginning.

To do this, the per-request extra data (which I think is also
referred to as "tag") need to be handled the same way that all
other block drivers do it: allocate it through the block layer.
In the MMC stack, this extra per-request data (tag) is called
struct mmc_queue_req.

So the second patch convert to using the generic block layer
mechanism to allocate tags. This makes the core simpler IMO and
that is why the patch series has negative line count. We move
stuff over to the block layer.

The first patch cleans out bounce buffer configurability and
move that to be a property of the host rather than a Kconfig option
in order to make it cleaner to do the rest of the refactorings.

The last two patches moves the ioctl() calls over to use the
new per-request tags and removes two instances of mmc_get_card(),
so we start to untangle the big host lock.

This approach can be used to get rid of the debugfs mmc_get_card()
as well but I want to start with the ioctl()s.

It already fixes a problem: userspace and the block layer could
essentially starve each other by bombing requests from either
block access or ioctl() congesting the host lock. With this,
ioctl() operations get scheduled by the block layer with
everything else. Not that I know how the block layer prioritizes
REQ_OP_DRV_IN and REQ_OP_DRV_OUT requests, but I am confident
it does a better job than the first-come-first-served host lock.

This drives a truck through mine and Adrians patch sets for
multiqueue and command queueing respectively, but I think that
both of our patch series will get easier to implement if we
exploit these patches as a base for future work, so if they can
get positive reviews and does not make everything explode, I
would suggest we merge them as a starter for the v4.13 kernel
cycle.

Linus Walleij (5):
  mmc: core: Delete bounce buffer Kconfig option
  mmc: core: Allocate per-request data using the block layer core
  mmc: block: Tag is_rpmb as bool
  mmc: block: move single ioctl() commands to block requests
  mmc: block: move multi-ioctl() to use block layer

 drivers/mmc/core/Kconfig  |  18 ----
 drivers/mmc/core/block.c  | 126 +++++++++++++++----------
 drivers/mmc/core/queue.c  | 235 ++++++++++++----------------------------------
 drivers/mmc/core/queue.h  |  26 +++--
 drivers/mmc/host/cavium.c |   3 +
 drivers/mmc/host/pxamci.c |   6 ++
 include/linux/mmc/card.h  |   2 -
 include/linux/mmc/host.h  |   1 +
 8 files changed, 161 insertions(+), 256 deletions(-)

-- 
2.9.3
