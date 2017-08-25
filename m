Return-Path: <prvs=403a468a2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/4] Four more patches for the sTec s1120 driver (skd)
Date: Fri, 25 Aug 2017 14:24:10 -0700
Message-Id: <20170825212414.28322-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

The previous series of patches for the sTec s1120 driver was followed by two
requests from Christoph to reorganize the code slightly and one report from
Dan Carpenter with a (false positive) Smatch report. This patch series
addresses that feedback and includes a fourth patch I came up with
myself. Please consider these patches for kernel v4.14.

Thanks,

Bart.

Bart Van Assche (4):
  skd: Rename skd_softirq_done() into skd_complete_rq()
  skd: Inline skd_end_request()
  skd: Make it easier for static analyzers to analyze skd_free_disk()
  skd: Remove SKD_ID_INCR

 drivers/block/skd_main.c | 57 +++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

-- 
2.14.1
