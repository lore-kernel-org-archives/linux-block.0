Return-Path: <prvs=750bc9d11=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/2] CFQ: Suppress W=1 compiler warnings
Date: Tue,  7 Aug 2018 16:17:27 -0700
Message-Id: <20180807231729.30308-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series suppresses the compiler warnings that are reported when
building the CFQ I/O scheduler with W=1. Please consider these patches for
kernel v4.19.

Thanks,

Bart.

Bart Van Assche (2):
  cfq: Annotate fall-through in a switch statement
  cfq: Suppress compiler warnings about comparisons

 block/cfq-iosched.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.18.0
