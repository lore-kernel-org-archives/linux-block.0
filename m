Return-Path: <BATV+ddb2dc36ce72650543b9+5395+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 1 Jun 2018 14:50:45 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 4.18
Message-ID: <20180601125045.GA27290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below is another set of NVMe updates for 4.18.  Besides the usual bug fixes
this includes more feature completness in terms of AEN and log page handling
on the target.

The following changes since commit 5de815a7eedfacf593817ef34634eaa9b75a1482:

  block: remove parent device reference from struct bsg_class_device (2018-05-29 13:00:25 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.18

for you to fetch changes up to 30d90964e7b80a0723921e8b464c5ceda7297a7b:

  nvme: use the changed namespaces list log to clear ns data changed AENs (2018-06-01 14:37:35 +0200)

----------------------------------------------------------------
Christoph Hellwig (12):
      nvme-pci: simplify __nvme_submit_cmd
      nvme-loop: add support for multiple ports
      nvme-fabrics: allow internal passthrough command on deleting controllers
      nvme.h: untangle AEN notice definitions
      nvme.h: add the changed namespace list log
      nvmet: add a new nvmet_zero_sgl helper
      nvmet: split log page implementation
      nvmet: implement the changed namespaces log
      nvmet: add AEN configuration support
      nvmet: mask pending AENs
      nvme: mark nvme_queue_scan static
      nvme: use the changed namespaces list log to clear ns data changed AENs

Hannes Reinecke (2):
      nvme.h: add AEN configuration symbols
      nvme: submit AEN event configuration on startup

James Smart (1):
      nvme: allow duplicate controller if prior controller being deleted

Keith Busch (1):
      nvme-pci: Rate limit the nvme timeout warnings

Wei Yongjun (2):
      nvmet: fix a typo in nvmet_file_ns_enable()
      nvmet: fix error return code in nvmet_file_ns_enable()

 drivers/nvme/host/core.c          | 115 +++++++++++++++++++++++++-------
 drivers/nvme/host/fabrics.c       |  79 +++++++++-------------
 drivers/nvme/host/fabrics.h       |   4 +-
 drivers/nvme/host/nvme.h          |   4 +-
 drivers/nvme/host/pci.c           |  39 +++++------
 drivers/nvme/target/admin-cmd.c   | 133 +++++++++++++++++++++-----------------
 drivers/nvme/target/core.c        |  73 ++++++++++++++++++---
 drivers/nvme/target/io-cmd-file.c |  10 ++-
 drivers/nvme/target/loop.c        |  48 ++++++++------
 drivers/nvme/target/nvmet.h       |  23 ++++++-
 include/linux/nvme.h              |  16 ++++-
 11 files changed, 351 insertions(+), 193 deletions(-)
