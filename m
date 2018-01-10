Return-Path: <prvs=541b0d852=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v3 0/2] Rework blk_mq_mark_tag_wait()
Date: Wed, 10 Jan 2018 13:41:20 -0800
Message-Id: <20180110214122.15452-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This patch series reworks the blk_mq_mark_tag_wait() implementation and also
fixes a race condition in that function. Please consider these two patches for
kernel v4.16.

Thanks,

Bart.

Changes compared to v3:
- Reworked patch 1/2 such that it uses if (...) ...; ... instead of
  if (...) ... else ... as proposed by Jens.

Changes compared to v1:
- Split a single patch into two patches to make reviewing easier.
- The race fix does no longer use prepare_to_wait() / finish_wait().

Bart Van Assche (2):
  blk-mq: Reduce the number of if-statements in blk_mq_mark_tag_wait()
  blk-mq: Fix a race condition in blk_mq_mark_tag_wait()

 block/blk-mq.c | 72 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

-- 
2.15.1
