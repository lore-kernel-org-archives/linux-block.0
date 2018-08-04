Return-Path: <BATV+1b4ddcc4854f3835cb1f+5459+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sat, 4 Aug 2018 10:43:54 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: nvme updates for 4.19
Message-ID: <20180804084354.GA26103@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

This conatains the support for TP4004, Asymmetric Namespace Access,
which makes NVMe multipathing usable in practice.

The following changes since commit cdcdcaae8450a975e7d07e1bfec21f9b8c016d0c:

  scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices (2018-07-26 15:49:43 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.19

for you to fetch changes up to b369b30cf510fe94d8884837039362e2ec223cec:

  nvmet: use Retain Async Event bit to clear AEN (2018-07-27 19:14:31 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: use Retain Async Event bit to clear AEN

Christoph Hellwig (9):
      nvme.h: add support for the log specific field
      nvme.h: add ANA definitions
      nvme: simplify the API for getting log pages
      nvme: remove nvme_req_needs_failover
      nvme: add ANA support
      nvmet: keep a port pointer in nvmet_ctrl
      nvmet: track and limit the number of namespaces per subsystem
      nvmet: add minimal ANA support
      nvmet: support configuring ANA groups

 drivers/nvme/host/core.c        |  77 +++++----
 drivers/nvme/host/lightnvm.c    |   5 +-
 drivers/nvme/host/multipath.c   | 349 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h        |  61 +++++--
 drivers/nvme/target/admin-cmd.c | 104 +++++++++++-
 drivers/nvme/target/configfs.c  | 190 ++++++++++++++++++++++
 drivers/nvme/target/core.c      |  71 +++++++-
 drivers/nvme/target/nvmet.h     |  53 +++++-
 include/linux/nvme.h            |  52 +++++-
 9 files changed, 884 insertions(+), 78 deletions(-)
