Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block pull request for 4.14-rc1
Message-ID: <1f069ba0-19bf-a7b3-3a65-78f7f20ddc65@kernel.dk>
Date: Fri, 8 Sep 2017 11:34:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

I ended up splitting the main pull request for this series into two,
mainly because of clashes between NVMe fixes that went into 4.13 after
the for-4.14 branches were split off. This pull request is mostly NVMe,
but not exclusively. In detail, it contains:

- Two pull request for NVMe changes from Christoph. Nothing new on the
  feature front, basically just fixes all over the map for the core
  bits, transport, rdma, etc.

- Series from Bart, cleaning up various bits in the BFQ scheduler.

- Series of bcache fixes, which has been lingering for a release or two.
  Coly sent this in, but patches from various people in this area.

- Set of patches for BFQ from Paolo himself, updating both documentation
  and fixing some corner cases in performance.

- Series from Omar, attempting to now get the 4k loop support correct.
  Our confidence level is higher this time.

- Series from Shaohua for loop as well, improving O_DIRECT performance
  and fixing a use-after-free.

Single merge conflict here, for nvme/rdma. Trivial to fixup, see my
for-next branch here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-next

if you want to see how I resolved it. Note that the for-next branch is
missing one late bcache fixup, so it's not identical to what you will
end up with after pulling this in.

Please pull!


  git://git.kernel.dk/linux-block.git for-4.14/block-postmerge


----------------------------------------------------------------
Arnav Dawn (2):
      nvme: add support for FW activation without reset
      nvme: define NVME_NSID_ALL

Bart Van Assche (5):
      bfq: Annotate fall-through in a switch statement
      bfq: Declare local functions static
      bfq: Check kstrtoul() return value
      bfq: Suppress compiler warnings about comparisons
      bfq: Use icq_to_bic() consistently

Byungchul Park (1):
      bcache: Don't reinvent the wheel but use existing llist API

Christoph Hellwig (7):
      nvmet: use NVME_NSID_ALL
      nvme: report more detailed status codes to the block layer
      nvme: allow calling nvme_change_ctrl_state from irq context
      nvme: remove unused struct nvme_ns fields
      nvme: remove nvme_revalidate_ns
      nvme: don't blindly overwrite identifiers on disk revalidate
      nvme: factor metadata handling out of __nvme_submit_user_cmd

Dan Carpenter (2):
      bcache: silence static checker warning
      bcache: Update continue_at() documentation

Daniel Verkamp (1):
      nvme-fabrics: generate spec-compliant UUID NQNs

Guan Junxiong (2):
      nvmet: fix the return error code of target if host is not allowed
      nvme-fabrics: log a warning if hostid is invalid

James Smart (2):
      nvme-fc: Reattach to localports on re-registration
      nvmet-fc: simplify sg list handling

Jan H. Schönherr (1):
      nvme: fix uninitialized prp2 value on small transfers

Jan Kara (1):
      bcache: Fix leak of bdev reference

Jens Axboe (3):
      Merge tag 'v4.13-rc7' into for-4.14/block-postmerge
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-4.14/block-postmerge
      Merge branch 'nvme-4.14' of git://git.infradead.org/nvme into for-4.14/block-postmerge

Johannes Thumshirn (2):
      nvmet-fcloop: remove ALL_OPTS define
      nvme-rdma: remove NVME_RDMA_MAX_SEGMENT_SIZE

Jon Derrick (1):
      nvme: add support for NVMe 1.3 Timestamp Feature

Keith Busch (3):
      nvme/pci: Use req_op to determine DIF remapping
      nvme: Make nvme user functions static
      nvme: Use metadata for passthrough commands

Martin K. Petersen (1):
      nvme: honor RTD3 Entry Latency for shutdowns

Martin Wilck (2):
      string.h: add memcpy_and_pad()
      nvmet: use memcpy_and_pad for identify sn/fr

Max Gurtovoy (3):
      nvme: add symbolic constants for CC identifiers
      nvme: rename AMS symbolic constants to fit specification
      nvme-rdma: Use unlikely macro in the fast path

Michael Lyle (1):
      bcache: fix bch_hprint crash and improve output

Omar Sandoval (5):
      loop: get rid of lo_blocksize
      loop: set physical block size to PAGE_SIZE
      loop: add ioctl for changing logical block size
      loop: fold loop_switch() into callers
      loop: set physical block size to logical block size

Omri Mann (1):
      nvmet: add support for reporting the host identifier

Paolo Valente (5):
      block, bfq: make lookup_next_entity push up vtime on expirations
      block, bfq: remove direct switch to an entity in higher class
      block, bfq: guarantee update_next_in_service always returns an eligible entity
      doc, block, bfq: fix some typos and remove stale stuff
      doc, block, bfq: better describe how to properly configure bfq

Roland Dreier (1):
      nvme-fabrics: Convert nvmf_transports_mutex to an rwsem

Sagi Grimberg (13):
      nvme-rdma: move nvme_rdma_configure_admin_queue code location
      nvme: Add admin_tagset pointer to nvme_ctrl
      nvme-rdma: move tagset allocation to a dedicated routine
      nvme-rdma: disable the controller on resets
      nvme-rdma: don't free tagset on resets
      nvme-rdma: reuse configure/destroy_admin_queue
      nvme-rdma: introduce configure/destroy io queues
      nvme-rdma: stop queues instead of simply flipping their state
      nvme-rdma: rename nvme_rdma_init_queue to nvme_rdma_alloc_queue
      nvme-rdma: introduce nvme_rdma_start_queue
      nvme-rdma: cleanup error path in controller reset
      nvme-rdma: call ops->reg_read64 instead of nvmf_reg_read64
      nvme: fix identify namespace logging

Shaohua Li (4):
      block/loop: set hw_sectors
      block/loop: allow request merge for directio mode
      block/loop: fix use after free
      block/loop: remove unused field

Tang Junhui (7):
      bcache: fix sequential large write IO bypass
      bcache: do not subtract sectors_to_gc for bypassed IO
      bcache: gc does not work when triggering by manual command
      bcache: correct cache_dirty_target in __update_writeback_rate()
      bcache: increase the number of open buckets
      bcache: fix for gc and write-back race
      bcache: initialize dirty stripes in flash_dev_run()

Tony Asleson (1):
      bcache: Correct return value for sysfs attach errors


 Documentation/block/bfq-iosched.txt |  144 ++++-----
 block/bfq-cgroup.c                  |   18 -
 block/bfq-iosched.c                 |   75 +++-
 block/bfq-iosched.h                 |    4 
 block/bfq-wf2q.c                    |   91 +++--
 drivers/block/loop.c                |  193 ++++++------
 drivers/block/loop.h                |    8 
 drivers/md/bcache/alloc.c           |    4 
 drivers/md/bcache/bcache.h          |    1 
 drivers/md/bcache/closure.c         |   15 
 drivers/md/bcache/closure.h         |    4 
 drivers/md/bcache/request.c         |   12 
 drivers/md/bcache/super.c           |   10 
 drivers/md/bcache/sysfs.c           |   19 +
 drivers/md/bcache/util.c            |   50 ++-
 drivers/md/bcache/writeback.c       |   20 -
 drivers/md/bcache/writeback.h       |   21 +
 drivers/nvme/host/core.c            |  339 +++++++++++++++------
 drivers/nvme/host/fabrics.c         |   23 -
 drivers/nvme/host/fc.c              |  145 ++++++---
 drivers/nvme/host/nvme.h            |   17 -
 drivers/nvme/host/pci.c             |    9 
 drivers/nvme/host/rdma.c            |  564 ++++++++++++++++++------------------
 drivers/nvme/target/admin-cmd.c     |   33 +-
 drivers/nvme/target/configfs.c      |    2 
 drivers/nvme/target/core.c          |   15 
 drivers/nvme/target/fabrics-cmd.c   |    1 
 drivers/nvme/target/fc.c            |   48 ---
 drivers/nvme/target/fcloop.c        |    3 
 drivers/nvme/target/loop.c          |    1 
 drivers/nvme/target/nvmet.h         |    1 
 include/linux/nvme-fc-driver.h      |    2 
 include/linux/nvme.h                |   37 +-
 include/linux/string.h              |   30 +
 include/uapi/linux/loop.h           |    1 
 35 files changed, 1143 insertions(+), 817 deletions(-)


-- 
Jens Axboe
