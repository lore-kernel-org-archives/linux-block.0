Return-Path: <BATV+ae98862b1fe7eae610af+5156+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 5 Oct 2017 18:36:54 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 4.14-rc4
Message-ID: <20171005163654.walnk7642obfyjp6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

A trivial one-liner from Martin to fix the visible of the uuid attr,
and another one (originally from Abhishek Shah, rewritten by me) to
fix the CMB addresses passed back to the controller in case of a system
that remaps BAR addresses between host and device.

The following changes since commit a5f3d8a5eaaf917878f07998e6f1ea46024e6bab:

  bcache: use llist_for_each_entry_safe() in __closure_wake_up() (2017-09-27 14:54:49 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to 8969f1f8291762c13147c1ba89d46238af01675b:

  nvme-pci: Use PCI bus address for data/queues in CMB (2017-10-04 11:42:53 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: Use PCI bus address for data/queues in CMB

Martin Wilck (1):
      nvme: fix visibility of "uuid" ns attribute

 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/pci.c  | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)
