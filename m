Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.13-rc5
Message-ID: <a5c92e41-d981-b7d1-a70b-c0aa939b9538@kernel.dk>
Date: Fri, 11 Aug 2017 12:44:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

A set of fixes that should go into this series. This pull request
contains:

- Fix from Bart for blk-mq requeue queue running, preventing a continued
  loop of run/restart.

- Fix for a bio/blk-integrity issue, in two parts. One from Christoph,
  fixing where verification happens, and one from Milan, for a NULL
  profile.

- NVMe pull request, most of the changes being for nvme-fc, but also a
  few trivial core/pci fixes.

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Bart Van Assche (1):
      block: Make blk_mq_delay_kick_requeue_list() rerun the queue at a quiet time

Christoph Hellwig (1):
      bio-integrity: only verify integrity on the lowest stacked driver

James Smart (2):
      nvmet_fc: add defer_req callback for deferment of cmd buffer return
      lpfc: support nvmet_fc defer_rcv callback

Jens Axboe (1):
      Merge branch 'nvme-4.13' of git://git.infradead.org/nvme into for-linus

Keith Busch (1):
      nvme: fix nvme reset command timeout handling

Kwan (Hingkwan) Huen-SSI (1):
      nvme: fix directive command numd calculation

Martin Wilck (1):
      nvme: strip trailing 0-bytes in wwid_show

Max Gurtovoy (1):
      nvme-pci: fix CMB sysfs file removal in reset path

Milan Broz (1):
      bio-integrity: Fix regression if profile verify_fn is NULL

 block/bio-integrity.c            |   6 +-
 block/blk-mq.c                   |   4 +-
 drivers/nvme/host/core.c         |  35 +++++--
 drivers/nvme/host/pci.c          |  18 ++--
 drivers/nvme/target/fc.c         | 212 +++++++++++++++++++++++++++++++++------
 drivers/scsi/lpfc/lpfc_attr.c    |   4 +-
 drivers/scsi/lpfc/lpfc_debugfs.c |   5 +-
 drivers/scsi/lpfc/lpfc_nvmet.c   |  30 ++++++
 drivers/scsi/lpfc/lpfc_nvmet.h   |   1 +
 include/linux/nvme-fc-driver.h   |   7 ++
 10 files changed, 267 insertions(+), 55 deletions(-)

-- 
Jens Axboe
