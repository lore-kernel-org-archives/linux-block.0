Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] NVMe fix for 4.15
Message-ID: <3e0917ee-0487-1cf1-73e7-d66b06273aa2@kernel.dk>
Date: Sun, 14 Jan 2018 10:45:45 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Just a single fix for nvme over fabrics that should go into 4.15.
Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Ewan D. Milne (1):
      nvme-fabrics: initialize default host->id in nvmf_host_default()

Jens Axboe (1):
      Merge branch 'nvme-4.15' of git://git.infradead.org/nvme into for-linus

 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Jens Axboe
