Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final block fixes for 4.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <730d0183-e197-ec7b-fc73-a5365ddbace5@kernel.dk>
Date: Fri, 21 Apr 2017 08:21:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A couple of last minute fixes for regressions in this cycle. More
specifically:

- Two patches from Andy, adjusting the NVMe APST quirks to avoid some
  issues specific to one Toshiba drive, and some variant of Samsung
  on two specific Dell laptops.

- A fix for mtip32xx, turning off mq scheduling on that device. We
  have a real fix for this, but it's too late in the cycle. Thankfully
  we already have a NO_SCHED flag we can apply here. A prep patch for
  this is ensuring that we honor the NO_SCHED flag when attempting to
  online switch schedulers, previsouly we only did so for drive load
  time. From Ming.

- Fixing an oops in blk-mq polling with scheduling attached. This one
  is easily reproducible, it would be a shame to release 4.11 with
  that issue. From me.

I'd prefer not having to send in patches at this point in time, but
the above are all things that have regressed in this cycle and the
fixes are relatively straight forward. Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Andy Lutomirski (2):
      nvme: Adjust the Samsung APST quirk
      nvme: Quirk APST off on "THNSF5256GPUK TOSHIBA"

Jens Axboe (1):
      blk-mq: fix potential oops with polling and blk-mq scheduler

Ming Lei (2):
      block: respect BLK_MQ_F_NO_SCHED
      mtip32xx: pass BLK_MQ_F_NO_SCHED

 block/blk-mq.c                    | 11 ++++++++++-
 block/elevator.c                  | 12 ++++++++++--
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/nvme/host/core.c          | 23 +++++++++++++++--------
 drivers/nvme/host/nvme.h          |  5 +++++
 drivers/nvme/host/pci.c           | 26 +++++++++++++++++++++++++-
 6 files changed, 66 insertions(+), 13 deletions(-)

-- 
Jens Axboe
