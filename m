Return-Path: <BATV+c514c086e15523269d70+4869+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 22 Dec 2016 19:33:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk
Cc: keith.busch@intel.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [GIT PULL] NVMe updates
Message-ID: <20161222183340.GA29357@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below is the pull request for additional NVMe updates for 4.10.

The most significant one is that we've agreed on shared maintaince and
a common repository for the PCIe NVMe driver and NVMe over Fabrics.  The
target code still only has a subset of the maintainers but goes through
the same tree as well.  Keith, Sagi and me will take turns at collecting
patches and sending you pull requests.


The following changes since commit ba6d973f78eb62ffebb32f6ef3334fc9a3b33d22:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2016-12-20 15:48:34 -0800)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.10

for you to fetch changes up to 7c3a23b85cac5f3caa531f369c1e3a5f1a8b555f:

  nvmet/fcloop: remove some logically dead code performing redundant ret checks (2016-12-21 11:34:28 +0100)

----------------------------------------------------------------
Andy Lutomirski (1):
      nvme/scsi: Remove START STOP emulation

Christoph Hellwig (1):
      nvme: update maintainers information

Colin Ian King (1):
      nvmet/fcloop: remove some logically dead code performing redundant ret checks

Daniel Verkamp (1):
      nvmet: fix KATO offset in Set Features

James Smart (1):
      nvme/fc: correct some printk information

Johannes Thumshirn (1):
      nvme/fc: simplify error handling of nvme_fc_create_hw_io_queues

Keith Busch (2):
      nvme: simplify stripe quirk
      nvme/pci: Delete misleading queue-wrap comment

Max Gurtovoy (1):
      nvme/pci: Fix whitespace problem

 MAINTAINERS                     |  9 +++++++--
 drivers/nvme/host/core.c        | 17 ++---------------
 drivers/nvme/host/fc.c          | 19 ++++++++++---------
 drivers/nvme/host/nvme.h        |  1 -
 drivers/nvme/host/pci.c         | 15 ++++-----------
 drivers/nvme/host/scsi.c        | 27 ---------------------------
 drivers/nvme/target/admin-cmd.c |  4 +---
 drivers/nvme/target/fcloop.c    |  4 ++--
 8 files changed, 26 insertions(+), 70 deletions(-)
