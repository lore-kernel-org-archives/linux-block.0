Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv6 0/3] Deprecate DAC960 driver
Date: Wed, 17 Oct 2018 17:25:10 +0200
Message-Id: <20181017152513.136526-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

as we're trying to get rid of the remaining request_fn drivers here's
a patchset to move the DAC960 driver to the SCSI stack.
As per request from hch I've split up the driver into two new SCSI
drivers called 'myrb' and 'myrs'.

The 'myrb' driver only supports the earlier (V1) firmware interface, which
doesn't have a SCSI interface for the logical drives; for those I've added
a (pretty rudimentary, admittedly) SCSI translation for them.

The 'myrs' driver supports the newer (V2) firmware interface, which is
SCSI based and doesn't need the translation layer.

And the weird proc interface from DAC960 has been converted to sysfs attributes.

Tested with eXtremeRAID 1100 (for V1 Firmware) and Mylex AcceleRAID 170
(for V2 Firmware).

Changes to v5:
- Include review from Christoph

Changes to v4:
- checkpatch fixes
- Remove remaining camel case naming
- Include reviews from Christoph
- More codingstyle fixes

Changes to v3:
- Rename structures to match the general codingstyle
- Replace typedefs

Changes to v2:
- Move to dma_pool API
- Fixup 0-day build issues
- Add myrb_biosparam
- Dropped patch merged with upstream

Changes to v1:
- Split into two drivers
- Improve scanning for V1 firmware interface

Hannes Reinecke (3):
  myrb: Add Mylex RAID controller (block interface)
  myrs: Add Mylex RAID controller (SCSI interface)
  drivers/block: Remove DAC960 driver

 Documentation/blockdev/README.DAC960 |  756 ----
 MAINTAINERS                          |    7 +
 drivers/block/DAC960.c               | 7229 ----------------------------------
 drivers/block/DAC960.h               | 4414 ---------------------
 drivers/block/Kconfig                |   12 -
 drivers/block/Makefile               |    1 -
 drivers/scsi/Kconfig                 |   30 +
 drivers/scsi/Makefile                |    2 +
 drivers/scsi/myrb.c                  | 3656 +++++++++++++++++
 drivers/scsi/myrb.h                  |  958 +++++
 drivers/scsi/myrs.c                  | 3267 +++++++++++++++
 drivers/scsi/myrs.h                  | 1134 ++++++
 12 files changed, 9054 insertions(+), 12412 deletions(-)
 delete mode 100644 Documentation/blockdev/README.DAC960
 delete mode 100644 drivers/block/DAC960.c
 delete mode 100644 drivers/block/DAC960.h
 create mode 100644 drivers/scsi/myrb.c
 create mode 100644 drivers/scsi/myrb.h
 create mode 100644 drivers/scsi/myrs.c
 create mode 100644 drivers/scsi/myrs.h

-- 
2.16.4
