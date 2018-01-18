Return-Path: <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Two NVMe fixes for 4.15 final
Message-ID: <658dee58-3a24-a1b8-20a8-ab1362e56619@kernel.dk>
Date: Thu, 18 Jan 2018 11:05:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Linus,

Two important fixes for the sgl support for nvme that is new in this
series. Please pull.


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: take sglist coalescing in dma_map_sg into account

Keith Busch (1):
      nvme-pci: check segement valid for SGL use

 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
Jens Axboe
