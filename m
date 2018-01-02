Return-Path: <prvs=533ff182d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/2] Two bug fixes for the pktcdvd driver
Date: Tue,  2 Jan 2018 11:39:46 -0800
Message-Id: <20180102193948.22656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series fixes two bugs in the pktcdvd driver. The second patch fixes
a recently introduced regression while the first patch fixes a regression that
was introduced a long time ago. Please consider these patches for the upstream
kernel.

Thanks,

Bart.

Bart Van Assche (2):
  pktcdvd: Fix pkt_setup_dev() error path
  pktcdvd: Fix a recently introduced NULL pointer dereference

 drivers/block/pktcdvd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.15.1
