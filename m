Return-Path: <prvs=407911b14=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/2] skd: Two additional patches for kernel v4.14
Date: Tue, 29 Aug 2017 08:32:08 -0700
Message-Id: <20170829153211.6257-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Further code review of the skd driver resulted in two additional
patches. Please consider these for kernel v4.14.

Thanks,

Bart.

Bart Van Assche (2):
  skd: Remove blk_queue_bounce_limit() call
  skd: Let the block layer core choose .nr_requests

 drivers/block/skd_main.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.14.1
