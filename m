Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.18-rc4
Message-ID: <b947a82f-0450-cba5-ee3a-c4dc787ffc6d@kernel.dk>
Date: Fri, 6 Jul 2018 19:21:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Two minor fixes for this series:

- Add LOOP_SET_BLOCK_SIZE as compat ioctl (Evan Green)

- drbd use-after-free fix (Lars Ellenberg)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180706


----------------------------------------------------------------
Evan Green (1):
      loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl

Lars Ellenberg (1):
      drbd: fix access after free

 drivers/block/drbd/drbd_worker.c | 2 +-
 drivers/block/loop.c             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
Jens Axboe
