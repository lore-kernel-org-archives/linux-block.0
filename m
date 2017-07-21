Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <4fd596b4-82d3-b064-9a67-8269c7377f24@kernel.dk>
Date: Fri, 21 Jul 2017 09:19:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Small set of fixes for -rc2 - two fixes for BFQ, documentation and code,
and a removal of an unused variable in nbd. Outside of that, a small
collection of fixes from the usual crew on the nvme side. Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: fix byte swapping in the streams code
      nvmet-fc: fix byte swapping in nvmet_fc_ls_create_association

Christophe JAILLET (1):
      nvme-pci: Fix an error handling path in 'nvme_probe()'

David Wayne Fugate (1):
      nvme-pci: add another device ID with stripe quirk

Hou Tao (2):
      bfq: fix typos in comments about B-WF2Q+ algorithm
      bfq: dispatch request to prevent queue stalling after the request completion

Johannes Thumshirn (3):
      nvmet: prefix version configfs file with attr
      nvmet: Move serial number from controller to subsystem
      nvmet: preserve controller serial number between reboots

Kefeng Wang (1):
      nbd: kill unused ret in recv_work

Keith Busch (1):
      nvme-pci: Remove nvme_setup_prps BUG_ON

Martin Wilck (1):
      nvmet: don't report 0-bytes in serial number

 block/bfq-iosched.c             |  3 +++
 block/bfq-iosched.h             |  2 +-
 block/bfq-wf2q.c                |  2 +-
 drivers/block/nbd.c             |  2 --
 drivers/nvme/host/core.c        |  2 +-
 drivers/nvme/host/pci.c         | 43 ++++++++++++++++++++++++++++++-----------
 drivers/nvme/target/admin-cmd.c | 16 +++++++++++++--
 drivers/nvme/target/configfs.c  | 30 ++++++++++++++++++++++++----
 drivers/nvme/target/core.c      |  5 ++---
 drivers/nvme/target/fc.c        |  8 ++++----
 drivers/nvme/target/nvmet.h     |  2 +-
 include/linux/nvme.h            | 14 +++++++-------
 12 files changed, 92 insertions(+), 37 deletions(-)

-- 
Jens Axboe
