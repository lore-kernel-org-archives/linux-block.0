Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdH1OeA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 10:34:00 -0400
Date: Mon, 28 Aug 2017 16:33:43 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme update for Linux 4.14
Message-ID: <20170828143343.evhchzfzam3whgwm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

below is the current set of NVMe updates for Linux 4.14.

The biggest bit comes from Sagi and refactors the RDMA driver to prepare
for more code sharing in the setup and teardown path.  But we have various
features and bug fixes from a lot of people as well.

The following changes since commit 16a5a480f067f945fd27bf91ffdce3f959b0d4b6:

  nvmet-fc: correct use after free on list teardown (2017-08-16 10:06:18 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to 16edd3d0272368eee5cac13356787c1f4d4eb255:

  nvme: honor RTD3 Entry Latency for shutdowns (2017-08-28 16:29:29 +0200)

----------------------------------------------------------------
Arnav Dawn (2):
      nvme: add support for FW activation without reset
      nvme: define NVME_NSID_ALL

Christoph Hellwig (1):
      nvmet: use NVME_NSID_ALL

Guan Junxiong (2):
      nvmet: fix the return error code of target if host is not allowed
      nvme-fabrics: log a warning if hostid is invalid

James Smart (2):
      nvme-fc: Reattach to localports on re-registration
      nvmet-fc: simplify sg list handling

Jan H. Sch�nherr (1):
      nvme: fix uninitialized prp2 value on small transfers

Johannes Thumshirn (2):
      nvmet-fcloop: remove ALL_OPTS define
      nvme-rdma: remove NVME_RDMA_MAX_SEGMENT_SIZE

Jon Derrick (1):
      nvme: add support for NVMe 1.3 Timestamp Feature

Martin K. Petersen (1):
      nvme: honor RTD3 Entry Latency for shutdowns

Martin Wilck (2):
      string.h: add memcpy_and_pad()
      nvmet: use memcpy_and_pad for identify sn/fr

Max Gurtovoy (3):
      nvme: add symbolic constants for CC identifiers
      nvme: rename AMS symbolic constants to fit specification
      nvme-rdma: Use unlikely macro in the fast path

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

 drivers/nvme/host/core.c        | 120 ++++++++-
 drivers/nvme/host/fabrics.c     |   1 +
 drivers/nvme/host/fc.c          | 145 ++++++++---
 drivers/nvme/host/nvme.h        |   4 +
 drivers/nvme/host/pci.c         |   5 +-
 drivers/nvme/host/rdma.c        | 559 ++++++++++++++++++++--------------------
 drivers/nvme/target/admin-cmd.c |  16 +-
 drivers/nvme/target/configfs.c  |   2 +-
 drivers/nvme/target/core.c      |  15 +-
 drivers/nvme/target/fc.c        |  48 +---
 drivers/nvme/target/fcloop.c    |   3 -
 drivers/nvme/target/loop.c      |   1 +
 include/linux/nvme-fc-driver.h  |   2 +-
 include/linux/nvme.h            |  37 ++-
 include/linux/string.h          |  30 +++
 15 files changed, 600 insertions(+), 388 deletions(-)
