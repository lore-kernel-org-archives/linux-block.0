Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org
Subject: [PATCHSET v2 0/7] blk-mq-sched and sbitmap shallow depth
Date: Wed,  9 May 2018 14:49:20 -0600
Message-Id: <1525898967-13425-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Omar had some valid complaints about the previous patchset, mostly
around the fact that we should not be updating depths on a per-IO
basis.  He's right. In fact, BFQ oddly enough does it from the
->limit_depth hook, but the shallow depth counts remain static.

This series cleans that up the ->limit_depth() handling, and keeps it
out of the hot path.

Mike, this should (still) fix your hangs with BFQ. This series is
(functionally) identical to the bundled up version I sent you earlier.

 block/bfq-iosched.c     |  113 +++++++++++++++++++++++++-----------------------
 block/bfq-iosched.h     |    6 --
 block/blk-mq.c          |    6 +-
 block/kyber-iosched.c   |    3 +
 include/linux/sbitmap.h |   11 ++++
 lib/sbitmap.c           |   19 +++++++-
 6 files changed, 95 insertions(+), 63 deletions(-)

-- 
Jens Axboe
