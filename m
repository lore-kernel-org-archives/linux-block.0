Return-Path: <prvs=1149acddfc=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>
Subject: [PATCHSET/RFC] blk-mq scheduling framework
Date: Wed, 7 Dec 2016 16:09:54 -0700
Message-ID: <1481152201-27461-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

I hacked up some support for registering blk-mq capable IO schedulers,
and when that was done, I adapted deadline to work with it as a new
mq-deadline scheduler.

Basically this is similar to the legacy scheduling patches I posted
recently, in that we setup a list of fake requests (I called them
shadows) that the IO scheduler works on. We then transform those
into a real blk-mq request, when we have to dispatch to hardware.

There's a hack in place to make this work with the flush/fua
requests, as those bypass the regular software queue insertion.
For now we simply ensure that we allocate a real request for
those. Howeer, I'd prefer if we simply inserted the request as
we usually would, and then start the flush state machinery when
we pull the request out of the queue. That would both be cleaner
from a flush perspective, and from the scheduling side as well.

I'm reusing the existing elevator interface, just augmenting
that with mq_ops and a ->uses_mq so we can tell which is which.
They show up automatically, for instance on a scsi-mq device:

$ cat /sys/block/sda/queue/scheduler 
[mq-deadline] none

vs just a legacy device:

$ cat /sys/block/nullb0/queue/scheduler 
noop deadline [cfq]

Changing schedulers is done in the same way as it always has,
by echoing into the 'scheduler' file. For MQ, there's a 'none'
setting as well that isn't a real scheduler, it simply turns off
the scheduler. Handy for comparison.

Obviously a direct deadline adaptation has performance implications,
so it can be improved. A _real_ MQ scheduler is forth coming, which
will sit on top of this interface. Paolo, for BFQ, this is the
interface you should target. Let me know if you have any questions
about how it works.


 block/Kconfig.iosched    |    6 
 block/Makefile           |    3 
 block/blk-core.c         |    3 
 block/blk-exec.c         |    3 
 block/blk-flush.c        |    7 
 block/blk-mq-sched.c     |  243 ++++++++++++++++++
 block/blk-mq-sched.h     |  168 ++++++++++++
 block/blk-mq-tag.c       |    1 
 block/blk-mq.c           |  241 ++++++++++--------
 block/blk-mq.h           |   33 --
 block/elevator.c         |  140 +++++++---
 block/mq-deadline.c      |  622 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h   |    3 
 include/linux/elevator.h |   30 ++
 14 files changed, 1331 insertions(+), 172 deletions(-)


-- 
Jens Axboe
