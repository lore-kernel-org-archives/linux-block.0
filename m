Return-Path: <prvs=708eb8c04=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/3] Fix blk_mq_end_request() and blk_end_request() for WRITE SAME
Date: Mon, 25 Jun 2018 17:10:06 -0700
Message-Id: <20180626001009.16557-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This series of three patches fixes a crash in the block layer core that I
encountered while retesting the SRP tests in blktests. Please consider these
patches for kernel v4.19.

Thanks,

Bart.

Bart Van Assche (3):
  block: Fix blk_rq_payload_bytes()
  sd: Remove the __data_len hack for WRITE SAME again
  block: Fix blk_end_request_all() for WRITE SAME requests

 block/blk-core.c       | 31 ++++++++++++++++++++++++-------
 block/blk-mq.c         |  2 +-
 block/blk.h            |  2 ++
 drivers/scsi/sd.c      | 18 +-----------------
 include/linux/blkdev.h | 14 +++++++++-----
 5 files changed, 37 insertions(+), 30 deletions(-)

-- 
2.17.1
