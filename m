Return-Path: <BATV+2dc78907d834c9be7da5+5132+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 11 Sep 2017 08:46:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.14
Message-ID: <20170911154601.GA32239@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

below are a few small fixes for the current merge window:

 - fix string.h compilation failures with the new memcpy_and_pad
   helper (Martin Wilck)
 - fix incorrect dereference of a PCI data structure in the lightnvm
   support code (me)
 - HMB fixes (Akinobu Mita and me)

The following changes since commit 40a5fce495715c48c2e02668144e68a507ac5a30:

  nvme-fabrics: generate spec-compliant UUID NQNs (2017-09-01 09:48:01 +0200)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to 47256a9529757b56f6ffca09c9fcf778ce61f0f5:

  string.h: un-fortify memcpy_and_pad (2017-09-11 13:56:09 +0200)

----------------------------------------------------------------
Akinobu Mita (1):
      nvme-pci: use appropriate initial chunk size for HMB allocation

Christoph Hellwig (4):
      nvme: fix lightnvm check
      nvme-pci: fix host memory buffer allocation fallback
      nvme-pci: propagate (some) errors from host memory buffer setup
      nvme-pci: implement the HMB entry number and size limitations

Martin Wilck (1):
      string.h: un-fortify memcpy_and_pad

 drivers/nvme/host/core.c     | 11 ++++---
 drivers/nvme/host/lightnvm.c | 26 ----------------
 drivers/nvme/host/nvme.h     | 13 +++++---
 drivers/nvme/host/pci.c      | 74 ++++++++++++++++++++++++++++++--------------
 include/linux/nvme.h         |  4 ++-
 include/linux/string.h       | 15 ++-------
 6 files changed, 70 insertions(+), 73 deletions(-)
