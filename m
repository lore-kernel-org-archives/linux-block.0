Return-Path: <prvs=1157cbc043=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
Subject: [PATCHSET v3] blk-mq scheduling framework
Date: Wed, 14 Dec 2016 22:26:01 -0700
Message-ID: <1481779568-10642-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This is version 3 of the blk-mq scheduling framework. Version 2
was posted here:

https://marc.info/?l=linux-block&m=148122805026762&w=2

It's fully stable. In fact I'm running it on my laptop [1]. That may
or may not have been part of a dare. In any case, it's been stable
on that too, and has survived lengthy testing on dedicated test
boxes.

[1] $ cat /sys/block/nvme0n1/queue/scheduler
[mq-deadline] none

I'm still mentally debating whether to shift this over to have
duplicate request tags, one for the scheduler and one for the issue
side. We run into various issues if we do that, but we also get
rid of the shadow request field copying. I think both approaches
have their downsides. I originally considered both, and though that
the shadow request would potentially be the cleanest.

I've rebased this against Linus master branch, since a bunch of
the prep patches are now in, and the general block changes are in
as well.

The patches can be pulled here:

git://git.kernel.dk/linux-block blk-mq-sched.3

Changes since v2:

- Fix the Kconfig single/multi queue sched entry. Suggested by Bart.

- Move the queue ref put into the failure path of the request getting,
  so the caller doesn't have to know about it. Suggested by Bart.

- Add support for IO context management. Needed for the BFQ port.

- Change the anonymous elevator ops union to a named one, since
  old (looking at you, gcc 4.4) compilers don't support named
  initialization of anon unions.

- Constify the blk_mq_ops structure pointers.

- Add generic merging code, so mq-deadline (and others) don't have to
  handle/duplicate that.

- Switched the dispatch hook to list based, so we can move more entries
  at the time, if we want/need to. From Omar.

- Add support for schedulers to continue using the software queues.
  From Omar.

- Ensure that it works with blk-wbt.

- Fix a failure case if we fail registering the MQ elevator. We'd
  fall back to trying noop, which we'd find, but that would not
  work for MQ devices. Fall back to 'none' instead.

- Verified queue ref management.

- Fixed a bunch of bugs, and added a bunch of cleanups.

 block/Kconfig.iosched    |   37 ++
 block/Makefile           |    3 
 block/blk-core.c         |   23 -
 block/blk-exec.c         |    3 
 block/blk-flush.c        |    7 
 block/blk-ioc.c          |    8 
 block/blk-merge.c        |    4 
 block/blk-mq-sched.c     |  394 +++++++++++++++++++++++++++++
 block/blk-mq-sched.h     |  192 ++++++++++++++
 block/blk-mq-tag.c       |    1 
 block/blk-mq.c           |  226 +++++++---------
 block/blk-mq.h           |   28 ++
 block/blk.h              |   26 +
 block/cfq-iosched.c      |    2 
 block/deadline-iosched.c |    2 
 block/elevator.c         |  229 ++++++++++++----
 block/mq-deadline.c      |  638 +++++++++++++++++++++++++++++++++++++++++++++++
 block/noop-iosched.c     |    2 
 drivers/nvme/host/pci.c  |    1 
 include/linux/blk-mq.h   |    6 
 include/linux/blkdev.h   |    2 
 include/linux/elevator.h |   33 ++
 22 files changed, 1635 insertions(+), 232 deletions(-)

-- 
Jens Axboe
