Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.11-rc
Message-ID: <1352f555-5243-718b-0407-339b61bfa564@kernel.dk>
Date: Fri, 24 Mar 2017 08:12:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A few fixes for the current series that should go into -rc4. This pull
request contains:

- A fix for a potential corruption of un-started requests from Ming.

- A blk-stat fix from Omar, ensuring we flush the stat batch before
  checking nr_samples.

- A set of fixes from Sagi for the nvmeof family.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'nvme-4.11-rc' of git://git.infradead.org/nvme into for-linus

Ming Lei (1):
      blk-mq: don't complete un-started request in timeout handler

Omar Sandoval (1):
      blk-stat: fix blk_stat_sum() if all samples are batched

Sagi Grimberg (5):
      nvme-loop: fix a possible use-after-free when destroying the admin queue
      nvmet: confirm sq percpu has scheduled and switched to atomic
      nvmet-rdma: Fix a possible uninitialized variable dereference
      nvme-rdma: handle cpu unplug when re-establishing the controller
      nvme-loop: handle cpu unplug when re-establishing the controller

 block/blk-mq.c              | 11 +-----
 block/blk-stat.c            |  4 +-
 drivers/nvme/host/rdma.c    | 28 +++++++-------
 drivers/nvme/target/core.c  | 11 +++++-
 drivers/nvme/target/loop.c  | 90 +++++++++++++++++++++++++--------------------
 drivers/nvme/target/nvmet.h |  1 +
 drivers/nvme/target/rdma.c  |  8 ++--
 7 files changed, 82 insertions(+), 71 deletions(-)

-- 
Jens Axboe
