Return-Path: <BATV+0eb41a859d58214bb3da+5409+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 15 Jun 2018 15:13:01 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.18
Message-ID: <20180615131301.2teay6o7c2jrqxtw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Fix various little regressions introduced in this merge window, plus
a rework of the fibre channel connect and reconnect path to share the
code instead of having separate sets of bugs.  Last but not least a
trivial trace point addition from Hannes.


The following changes since commit 190b02ed79e08983bf62d47c05945c1b06a3d7d5:

  block: fix use-after-free in block flush handling (2018-06-09 06:37:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.18

for you to fetch changes up to 35897b920c8ab5e23331ad429e0aa235528c63ba:

  nvme-fabrics: fix and refine state checks in __nvmf_check_ready (2018-06-15 11:21:00 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: free smart-log buffer after use

Christoph Hellwig (6):
      nvme: don't rely on the changed namespace list log
      nvme: remove nvme_reinit_tagset
      blk-mq: remove blk_mq_tagset_iter
      nvme-fabrics: refactor queue ready check
      nvme-fabrics: handle the admin-only case properly in nvmf_check_ready
      nvme-fabrics: fix and refine state checks in __nvmf_check_ready

Hannes Reinecke (1):
      nvme: add bio remapping tracepoint

Israel Rukshin (1):
      nvme: fix NULL pointer dereference in nvme_init_subsystem

James Smart (3):
      nvme-fc: change controllers first connect to use reconnect path
      nvme-fc: remove reinit_request routine
      nvme-fc: fix nulling of queue data on reconnect

Max Gurtovoy (1):
      nvme-rdma: fix error flow during mapping request data

 block/blk-mq-tag.c              |  29 --------
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
 11 files changed, 154 insertions(+), 224 deletions(-)
