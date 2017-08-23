Return-Path: <prvs=401b34db8=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/5] skd fixes for kernel v4.14
Date: Wed, 23 Aug 2017 10:56:28 -0700
Message-Id: <20170823175633.12680-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Code review resulted in five more patches for the skd (sTec s1120) kernel
driver. These patches have been tested on top of the for-next branch from this
morning of your block layer git repository. That means that Dan Carpenter's
patches were included in the kernel tree used for testing. Please consider
these patches for kernel v4.14.

Thanks,

Bart.

Bart Van Assche (5):
  block: Warn if blk_queue_rq_timed_out() is called for a blk-mq queue
  skd: Report completion mismatches once
  skd: Inline skd_process_request()
  skd: Avoid double completions in case of a timeout
  skd: Change default interrupt mode to MSI-X

 block/blk-settings.c     |  1 +
 drivers/block/skd_main.c | 68 ++++++++++++++++++------------------------------
 2 files changed, 27 insertions(+), 42 deletions(-)

-- 
2.14.0
