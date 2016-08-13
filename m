Return-Path: <axboe@kernel.dk>
To: torvalds@linuxfoundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.8-rc2
Message-ID: <c5fd6d08-900d-e194-9309-539d098639fc@kernel.dk>
Date: Fri, 12 Aug 2016 20:42:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes for 4.8-rc2. This pull request contains:

- A NVMe fix from Gabriel, fixing a suspend/resume issue on some
   setups.

- Addition of a few missing entries in the block queue sysfs
   documentation, from Joe.

- A fix for a sparse shadow warning for the bvec iterator, from
   Johannes.

- A writeback deadlock involving raid issuing barriers, and not flushing
   the plug when we wakeup the flusher threads. From Konstantin.

- A set of patches for the NVMe target/loop/rdma code, from Roland and
   Sagi.

Please pull!


   git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
       nvme: Suspend all queues before deletion

Jens Axboe (1):
       Merge branch 'nvmf-4.8-rc' of 
git://git.infradead.org/nvme-fabrics into for-linus

Joe Lawrence (1):
       doc: update block/queue-sysfs.txt entries

Johannes Berg (1):
       bvec: avoid variable shadowing warning

Konstantin Khlebnikov (1):
       mm, writeback: flush plugged IO in wakeup_flusher_threads()

Roland Dreier (1):
       nvme-rdma: Don't leak uninitialized memory in connect request 
private data

Sagi Grimberg (11):
       nvme-rdma: Queue ns scanning after a sucessful reconnection
       nvme-rdma: Fix device removal handling
       nvme-rdma: Remove duplicate call to nvme_remove_namespaces
       nvme-rdma: Free the I/O tags when we delete the controller
       nvme-loop: Remove duplicate call to nvme_remove_namespaces
       nvme-rdma: Make sure to shutdown the controller if we can
       nvmet-rdma: Correctly handle RDMA device hot removal
       nvmet-rdma: Don't use the inline buffer in order to avoid 
allocation for small reads
       nvmet: Fix controller serial number inconsistency
       nvme-rdma: start async event handler after reconnecting to a 
controller
       nvme-rdma: Remove unused includes

  Documentation/block/queue-sysfs.txt |  18 +++++++
  drivers/nvme/host/pci.c             |  20 +++-----
  drivers/nvme/host/rdma.c            |  83 ++++++++++++++++--------------
  drivers/nvme/target/admin-cmd.c     |   6 +--
  drivers/nvme/target/core.c          |   4 ++
  drivers/nvme/target/loop.c          |   4 +-
  drivers/nvme/target/nvmet.h         |   1 +
  drivers/nvme/target/rdma.c          | 100 
++++++++++++++++++++++++++----------
  fs/fs-writeback.c                   |   6 +++
  include/linux/bvec.h                |   3 +-
  10 files changed, 160 insertions(+), 85 deletions(-)

-- 
Jens Axboe
