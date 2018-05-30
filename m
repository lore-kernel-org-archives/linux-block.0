Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single fix for 4.17 final
Message-ID: <45b1ff4f-fc6b-255f-fef4-7e7aecc2b573@kernel.dk>
Date: Wed, 30 May 2018 14:11:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just a single fix that should make it into this release,
fixing a regression with T10-DIF on NVMe. Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20180530


----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'nvme-4.17' of git://git.infradead.org/nvme into for-linus

Max Gurtovoy (1):
      nvme: fix extended data LBA supported setting

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe
