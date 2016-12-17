Return-Path: <prvs=1159fc908b=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
Subject: [PATCHSET v4] blk-mq-scheduling framework
Date: Fri, 16 Dec 2016 17:12:08 -0700
Message-ID: <1481933536-12844-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

This is version 4 of this patchset, version 3 was posted here:

https://marc.info/?l=linux-block&m=148178513407631&w=2

>From the discussion last time, I looked into the feasibility of having
two sets of tags for the same request pool, to avoid having to copy
some of the request fields at dispatch and completion time. To do that,
we'd have to replace the driver tag map(s) with our own, and augment
that with tag map(s) on the side representing the device queue depth.
Queuing IO with the scheduler would allocate from the new map, and
dispatching would acquire the "real" tag. We would need to change
drivers to do this, or add an extra indirection table to map a real
tag to the scheduler tag. We would also need a 1:1 mapping between
scheduler and hardware tag pools, or additional info to track it.
Unless someone can convince me otherwise, I think the current approach
is cleaner.

I wasn't going to post v4 so soon, but I discovered a bug that led
to drastically decreased merging. Especially on rotating storage,
this release should be fast, and on par with the merging that we
get through the legacy schedulers.

Changes since v3:

- Keep the blk_mq_free_request/__blk_mq_free_request() as the
  interface, and have those functions call the scheduler API
  instead.

- Add insertion merging from unplugging.

- Ensure that RQF_STARTED is cleared when we get a new shadow
  request, or merging will fail if it is already set.

- Improve the blk_mq_sched_init_hctx_data() implementation. From Omar.

- Make the shadow alloc/free interface more usable by schedulers
  that use the software queues. From Omar.

- Fix a bug in the io context code.

- Put the is_shadow() helper in generic code, instead of in mq-deadline.

- Add prep patch that unexports blk_mq_free_hctx_request(), it's not
  used by anyone.

- Remove the magic '256' queue depth from mq-deadline, replace with a
  module parameter, 'queue_depth', that defaults to 256.

- Various cleanups.
