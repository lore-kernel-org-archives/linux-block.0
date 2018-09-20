Return-Path: <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Storage fixes for 4.19-rc5
Message-ID: <23e4fede-4dc5-ab36-fc83-bf0509cab12b@kernel.dk>
Date: Thu, 20 Sep 2018 15:50:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Greg,

Three fixes that should go into this series. This pull request
contains:

- Fix for leaking kernel pointer in floppy ioctl (Andy Whitcroft)

- NVMe pull request from Christoph, and a single ANA log page fix
  (Hannes)

- Regression fix for libata qd32 support, where we trigger an illegal
  active command transition. This fixes a CD-ROM detection issue that
  was reported, but could also trigger premature completion of the
  internal tag (me)


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180920


----------------------------------------------------------------
Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Hannes Reinecke (1):
      nvme: count all ANA groups for ANA Log page

Jens Axboe (2):
      libata: mask swap internal and hardware tag
      Merge branch 'nvme-4.19' of git://git.infradead.org/nvme into for-linus

 drivers/ata/libata-core.c       | 14 ++++++++++++--
 drivers/block/floppy.c          |  3 +++
 drivers/nvme/target/admin-cmd.c |  4 ++++
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
Jens Axboe
