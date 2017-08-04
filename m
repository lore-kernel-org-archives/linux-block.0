Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: brking@linux.vnet.ibm.com,
	bart.vanassche@wdc.com
Subject: [PATCHSET v2 0/6] block: more scalable inflight tracking
Date: Fri,  4 Aug 2017 09:04:16 -0600
Message-Id: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

One scaling issue we currently have in the block code is the
inflight accounting. It's based on a per-device atomic count
for reads and writes, which means that even for an mq device
with lots of hardware queues, we end up dirtying a per-device
cacheline for each IO. The issue can easily be observed by
using null_blk:

modprobe null_blk submit_queues=48 queue_mode=2

and running a fio job that has 32 jobs doing sync reads on
the device (average of 3 runs, though deviation is low):

stats		IOPS		usr		sys
------------------------------------------------------
on		 2.6M		 5.4%		94.6%
off		21.0M		33.7%		67.3%

which shows a 10x slowdown with stats enabled. If we look at
the profile for stats on, the top entries are:

37.38%  fio      [kernel.vmlinux]    [k] blk_account_io_done
14.65%  fio      [kernel.vmlinux]    [k] blk_account_io_start
14.29%  fio      [kernel.vmlinux]    [k] part_round_stats_single
11.81%  fio      [kernel.vmlinux]    [k] blk_account_io_completion
 3.62%  fio      [kernel.vmlinux]    [k] part_round_stats
 0.81%  fio      [kernel.vmlinux]    [k] __blkdev_direct_IO_simple

which shows the system time being dominated by the stats accounting.

This patch series replaces the atomic counter with using the tags
hamming weight for tracking infligh counts. This means we don't have
to do anything when IO starts or completes, and for reading the value
we just have to check how many bits we have set in the tag maps on
the queues. This part is limited to 1000 per second (for HZ=1000).
Using this approach, running the same test again results in:

stats		IOPS		usr		sys
------------------------------------------------------
on		20.4M		30.9%		69.0%
off		21.4M		32.4%		67.4%

and doing a profiled run with stats on, the top of stats reporting is
now:

1.23%  fio  [kernel.vmlinux]  [k] blk_account_io_done
0.83%  fio  [kernel.vmlinux]  [k] blk_account_io_start
0.55%  fio  [kernel.vmlinux]  [k] blk_account_io_completion

which is a lot more reasonable. The difference between stats on and
off is now also neglible. Brian also ran a bunch of numbers on
various implementations of this, showing a big win on a real device
on PPC.

You can also download the code here:


git://git.kernel.dk/linux-block mq-inflight.2


Changes since v1:

- Reword commit message for patch #1, to indicate that the race is
  related to when a tag is allocated, not freed.
- Remove redundant init of inflight to 0 in intermediate patch. Didn't
  matter for the end result, since it went away in the last patch.
- Kill part_in_flight_double(). Add a prep patch that just changes
  part_in_flight() to take an array for accounting instead.
- Fix root vs part accounting.
- Since it's related to tag iteration, add a patch to remove the
  sbitmap tags iteration return value. It's unused.

-- 
Jens Axboe
