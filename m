Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/2] Make the zone locking information available in debugfs
Date: Tue, 27 Feb 2018 16:32:12 -0800
Message-Id: <20180228003214.3194-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

While analyzing the mq-deadline behavior for ZBC drives together with Damien
we noticed the following:
- That the request queue attribute methods are not contiguous in
  blk-mq-debugfs.c.
- That the information about which zones are locked is not yet available in
  debugfs.

Hence this patch series. Please consider this patch series for kernel v4.17.

Thanks,

Bart.

Bart Van Assche (2):
  blk-mq-debugfs: Reorder queue show and store methods
  blk-mq-debugfs: Show zone locking information

 block/blk-mq-debugfs.c | 134 +++++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 59 deletions(-)

-- 
2.16.2
