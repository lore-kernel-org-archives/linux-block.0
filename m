Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.15 final
Message-ID: <4b6bed5f-dda4-359e-d9bc-d8d85818d742@kernel.dk>
Date: Tue, 9 Jan 2018 09:09:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes that should go into this release. This pull request
contains:

- An NVMe pull request from Christoph, with a few critical fixes for
  NVMe.

- A block drain queue fix from Ming.

- The concurrent lo_open/release fix for loop.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
James Smart (1):
      nvme-fcloop: avoid possible uninitialized variable warning

Jeff Lien (1):
      nvme: fix sector units when going between formats

Jens Axboe (1):
      Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus

Linus Torvalds (1):
      loop: fix concurrent lo_open/lo_release

Ming Lei (1):
      block: drain queue before waiting for q_usage_counter becoming zero

Minwoo Im (1):
      nvme-pci: move use_sgl initialization to nvme_init_iod()

Sagi Grimberg (2):
      nvme-rdma: fix concurrent reset and reconnect
      nvme-mpath: fix last path removal during traffic

 block/blk-core.c             |  9 +++++++--
 block/blk-mq.c               |  2 ++
 block/blk.h                  |  2 ++
 drivers/block/loop.c         | 10 ++++++++--
 drivers/nvme/host/core.c     |  7 ++++++-
 drivers/nvme/host/nvme.h     | 12 ++++++++++++
 drivers/nvme/host/pci.c      | 42 ++++++++++++++++++++----------------------
 drivers/nvme/host/rdma.c     | 14 +++++++++++++-
 drivers/nvme/target/fcloop.c |  2 +-
 9 files changed, 71 insertions(+), 29 deletions(-)

-- 
Jens Axboe
