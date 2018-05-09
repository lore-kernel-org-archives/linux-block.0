Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	efault@gmx.de,
	paolo.valente@linaro.org
Subject: [PATCHSET 0/3] blk-mq-sched and sbitmap shallow depth
Date: Wed,  9 May 2018 09:36:01 -0600
Message-Id: <1525880164-11943-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Mike has been running into an issue with BFQ, where things grind
to a halt. This is because of how BFQ limits the shallow depth. If
it ends up limiting it to something low that is smaller than the
wake batch sizing for sbitmap, we can run into cases where we
never wake up folks waiting for a tag. The end result is an idle
system with no IO pending, but with tasks waiting for a tag with
no one to wake them up. Kyber could run into the same issue, if
the async depth is limited low enough.

This patchset adds a helper to inform sbitmap about shallow depth
limiting, and handles this from blk-mq-sched.

 block/bfq-iosched.c      |   13 ++++++++++---
 block/blk-mq-sched.c     |   26 ++++++++++++++++++++++++++
 block/blk-mq-sched.h     |    3 +++
 block/blk-mq.c           |    8 +-------
 block/kyber-iosched.c    |   14 ++++++++++----
 include/linux/elevator.h |    2 +-
 include/linux/sbitmap.h  |   11 +++++++++++
 lib/sbitmap.c            |   17 ++++++++++++++++-
 8 files changed, 78 insertions(+), 16 deletions(-)

-- 
Jens Axboe
