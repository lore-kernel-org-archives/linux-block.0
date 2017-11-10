Return-Path: <BATV+b9f22be6cf688ae68bc2+5192+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 10 Nov 2017 15:34:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 4.15
Message-ID: <20171110143407.zapukx3fhfcr4fm5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

another round of NVMe updates for 4.15.

The biggest items are:

 - native multipath support (me + Hannes)
 - userspace notifications for AENs (Keith)
 - obey the command effects log page (Keith)

in addition to that lots of fixes from a wide variety of people.

The following changes since commit 7d1dff993252366cc5e21e07b80072d323628363:

  blktrace: fix unlocked registration of tracepoints (2017-11-07 09:42:10 -0700)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.15

for you to fetch changes up to b119d90862842a055ff78ca54953d430da314808:

  nvme: expose subsys attribute to sysfs (2017-11-10 12:16:19 +0100)

----------------------------------------------------------------
Christoph Hellwig (14):
      nvme: move the dying queue check from cancel to completion
      nvme: always unregister the integrity profile in __nvme_revalidate_disk
      nvme: don't pass struct nvme_ns to nvme_init_integrity
      nvme: don't pass struct nvme_ns to nvme_config_discard
      nvme: set the chunk size before freezing the queue
      nvme: split __nvme_revalidate_disk
      nvme: fix and clarify the check for missing metadata
      nvmet: better data length validation
      nvmet: kill nvmet_inline_bio_init
      nvme: track subsystems
      nvme: introduce a nvme_ns_ids structure
      nvme: track shared namespaces
      nvme: implement multipath access to nvme subsystems
      nvme: also expose the namespace identification sysfs files for mpath nodes

Hannes Reinecke (3):
      block: create 'slaves' and 'holders' entries for hidden gendisks
      nvme: create 'slaves' and 'holders' entries for hidden controllers
      nvme: expose subsys attribute to sysfs

Israel Rukshin (1):
      nvmet-rdma: update queue list during ib_device removal

James Smart (3):
      nvme-fc: fix localport resume using stale values
      nvme-fc: decouple ns references from lldd references
      lpfc: tie in to new dev_loss_tmo interface in nvme transport

Javier Gonz�lez (2):
      nvme: compare NQN string with right size
      nvme: fix eui_show() print format

Keith Busch (7):
      nvme: factor get log into a helper
      nvme: check admin passthru command effects
      nvme: centralize AEN defines
      nvme-fc: remove unused "queue_size" field
      nvme: remove handling of multiple AEN requests
      nvme: unexport starting async event work
      nvme: send uevent for some asynchronous events

Max Gurtovoy (1):
      nvme-rdma: fix nvme_rdma_create_queue_ib error flow

Ming Lei (1):
      nvme-pci: avoid dereference of symbol from unloaded module

Minwoo Im (1):
      nvmet: fix comment typos in admin-cmd.c

Sagi Grimberg (2):
      nvmet: remove redundant memset if failed to get_smart_log failed
      nvmet: remove redundant local variable

 block/genhd.c                   |   14 +-
 drivers/nvme/host/Kconfig       |    9 +
 drivers/nvme/host/Makefile      |    1 +
 drivers/nvme/host/core.c        | 1050 ++++++++++++++++++++++++++++++---------
 drivers/nvme/host/fabrics.c     |    4 +-
 drivers/nvme/host/fc.c          |  143 ++++--
 drivers/nvme/host/lightnvm.c    |   14 +-
 drivers/nvme/host/multipath.c   |  291 +++++++++++
 drivers/nvme/host/nvme.h        |  138 ++++-
 drivers/nvme/host/pci.c         |   21 +-
 drivers/nvme/host/rdma.c        |   21 +-
 drivers/nvme/target/admin-cmd.c |   21 +-
 drivers/nvme/target/core.c      |   10 +
 drivers/nvme/target/fc.c        |   32 +-
 drivers/nvme/target/io-cmd.c    |   18 +-
 drivers/nvme/target/loop.c      |   19 +-
 drivers/nvme/target/nvmet.h     |    4 +
 drivers/nvme/target/rdma.c      |   16 +-
 drivers/scsi/lpfc/lpfc_attr.c   |    5 +
 include/linux/nvme.h            |   30 ++
 20 files changed, 1456 insertions(+), 405 deletions(-)
 create mode 100644 drivers/nvme/host/multipath.c
