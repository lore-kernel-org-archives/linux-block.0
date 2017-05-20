Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.12-rc2
Message-ID: <fa8c8e9b-3c23-ac92-56b7-037efeb8b405@kernel.dk>
Date: Sat, 20 May 2017 17:07:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A small collection of fixes that should go into this cycle. This pull
request contains:

- A pull request from Christoph for NVMe, which ended up being manually
  applied to avoid pulling in newer bits in master. Mostly fibre channel
  fixes from James, but also a few fixes from Jon and Vijay

- A pull request from Konrad, with just a single fix for xen-blkback
  from Gustavo.

- A fuseblk bdi fix from Jan, fixing a regression in this series with
  the dynamic backing devices.

- A blktrace fix from Shaohua, replacing sscanf() with kstrtoull().

- A request leak fix for drbd from Lars, fixing a regression in the last
  series with the kref changes. This will go to stable as well.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Gustavo A. R. Silva (1):
      block: xen-blkback: add null check to avoid null pointer dereference

James Smart (4):
      nvme-fc: correct port role bits
      nvme-fc: require target or discovery role for fc-nvme targets
      nvme-fc: stop queues on error detection
      nvmet-fc: remove target cpu scheduling flag

Jan Kara (1):
      fuseblk: Fix warning in super_setup_bdi_name()

Jens Axboe (1):
      Merge branch 'stable/for-jens-4.12' of git://git.kernel.org/.../konrad/xen into for-linus

Jon Derrick (1):
      nvme: unmap CMB and remove sysfs file in reset path

Lars Ellenberg (1):
      drbd: fix request leak introduced by locking/atomic, kref: Kill kref_sub()

Shaohua Li (1):
      blktrace: fix integer parse

Vijay Immanuel (1):
      nvmet: release the sq ref on rdma read errors

 drivers/block/drbd/drbd_req.c      | 27 +++++++++++++++------------
 drivers/block/xen-blkback/xenbus.c |  8 +++++---
 drivers/nvme/host/fc.c             | 10 ++++++++++
 drivers/nvme/host/pci.c            |  7 ++++++-
 drivers/nvme/target/core.c         |  6 ++++++
 drivers/nvme/target/fc.c           |  4 +---
 drivers/nvme/target/fcloop.c       |  1 -
 drivers/nvme/target/nvmet.h        |  1 +
 drivers/nvme/target/rdma.c         |  1 +
 drivers/scsi/lpfc/lpfc_nvmet.c     |  1 -
 fs/fuse/inode.c                    |  9 ++++++++-
 include/linux/nvme-fc-driver.h     | 16 ++++------------
 kernel/trace/blktrace.c            |  4 ++--
 13 files changed, 59 insertions(+), 36 deletions(-)

-- 
Jens Axboe
