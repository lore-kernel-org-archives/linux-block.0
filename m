Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc1
Message-ID: <4cf76676-3c44-fdc5-7aa5-451810aba666@kernel.dk>
Date: Sat, 16 Jun 2018 09:05:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Collection of fixes that should go into -rc1. This pull request
contains:

- bsg_open vs bsg_unregister race fix (Anatoliy)

- NVMe pull request from Christoph, with fixes for regressions in this
  window, FC connect/reconnect path code unification, and a trace point
  addition.

- Timeout fix (Christoph)

- Removal of a few unused functions (Christoph)

- blk-mq tag_set reinit fix (Roman)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180616


----------------------------------------------------------------
Anatoliy Glagolev (1):
      bsg: fix race of bsg_open and bsg_unregister

Chaitanya Kulkarni (1):
      nvmet: free smart-log buffer after use

Christoph Hellwig (8):
      nvme: don't rely on the changed namespace list log
      blk-mq: don't time out requests again that are in the timeout handler
      nvme: remove nvme_reinit_tagset
      blk-mq: remove blk_mq_tagset_iter
      nvme-fabrics: refactor queue ready check
      nvme-fabrics: handle the admin-only case properly in nvmf_check_ready
      nvme-fabrics: fix and refine state checks in __nvmf_check_ready
      block: remov blk_queue_invalidate_tags

Hannes Reinecke (1):
      nvme: add bio remapping tracepoint

Israel Rukshin (1):
      nvme: fix NULL pointer dereference in nvme_init_subsystem

James Smart (3):
      nvme-fc: change controllers first connect to use reconnect path
      nvme-fc: remove reinit_request routine
      nvme-fc: fix nulling of queue data on reconnect

Jens Axboe (1):
      Merge branch 'nvme-4.18' of git://git.infradead.org/nvme into for-linus

Max Gurtovoy (1):
      nvme-rdma: fix error flow during mapping request data

Roman Pen (1):
      blk-mq: reinit q->tag_set_list entry only after grace period

 Documentation/block/biodoc.txt  |  15 +----
 block/blk-mq-tag.c              |  29 --------
 block/blk-mq.c                  |   8 ++-
 block/blk-tag.c                 |  22 ------
 block/bsg.c                     |  22 +++---
 drivers/nvme/host/core.c        |  48 ++++----------
 drivers/nvme/host/fabrics.c     |  86 +++++++++++-------------
 drivers/nvme/host/fabrics.h     |  14 +++-
 drivers/nvme/host/fc.c          | 144 ++++++++++++++++------------------------
 drivers/nvme/host/multipath.c   |   4 ++
 drivers/nvme/host/nvme.h        |   2 -
 drivers/nvme/host/rdma.c        |  38 ++++++++---
 drivers/nvme/target/admin-cmd.c |   4 +-
 drivers/nvme/target/loop.c      |   7 +-
 include/linux/blk-mq.h          |   2 -
 include/linux/blkdev.h          |   4 +-
 16 files changed, 174 insertions(+), 275 deletions(-)

-- 
Jens Axboe
