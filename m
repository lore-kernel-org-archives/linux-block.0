Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Two block related fixes for 4.17-rc
Message-ID: <f4735ff5-4ead-c9ce-d7eb-b2ad9df979d9@kernel.dk>
Date: Thu, 24 May 2018 06:59:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Two fixes that should go into this release:

- A loop writeback error clearing fix from Jeff.

- The sr sense fix from myself.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180524


----------------------------------------------------------------
Jeff Layton (1):
      loop: clear wb_err in bd_inode when detaching backing file

Jens Axboe (1):
      sr: pass down correctly sized SCSI sense buffer

 drivers/block/loop.c    |  1 +
 drivers/scsi/sr_ioctl.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
Jens Axboe
