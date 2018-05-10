Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org
Subject: [PATCHSET v3 0/9] blk-mq-sched and sbitmap shallow depth
Date: Thu, 10 May 2018 10:24:18 -0600
Message-Id: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Found another issue in sbitmap around our wake batch accounting.
See the last patch for details.

This series passes my testing. The sbitmap change was improved
by Omar, I swapped in his patch instead.

You can also find this series here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-4.18/iosched

 block/bfq-iosched.c     |  113 +++++++++++++++++++++++++-----------------------
 block/bfq-iosched.h     |    6 --
 block/blk-mq.c          |    6 +-
 block/kyber-iosched.c   |    3 +
 include/linux/sbitmap.h |   29 ++++++++++++
 lib/sbitmap.c           |   69 ++++++++++++++++++++++-------
 6 files changed, 148 insertions(+), 78 deletions(-)

-- 
Jens Axboe
