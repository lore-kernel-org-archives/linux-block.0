Return-Path: <prvs=80586c83e0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: [PATCH 0/8] Throttled background buffered writeback v7
Date: Wed, 7 Sep 2016 08:46:42 -0600
Message-ID: <1473259610-3295-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Hi,

Since the dawn of time, our background buffered writeback has sucked.
When we do background buffered writeback, it should have little impact
on foreground activity. That's the definition of background activity...
But for as long as I can remember, heavy buffered writers have not
behaved like that. For instance, if I do something like this:

$ dd if=/dev/zero of=foo bs=1M count=10k

on my laptop, and then try and start chrome, it basically won't start
before the buffered writeback is done. Or, for server oriented
workloads, where installation of a big RPM (or similar) adversely
impacts database reads or sync writes. When that happens, I get people
yelling at me.

Results from some recent testing can be found here:

https://www.facebook.com/axboe/posts/10154074651342933

See previous postings for a bigger description of the patchset. Find
the code here:

git://git.kernel.dk/linux-block.git wb-buf-throttle

Note that I rebase this branch when I collapse patches. The
wb-buf-throttle-v7 will remain the same as this version. I know there
are a bunch of folks running this patchset with success. If there's
any interest in a version that applies cleanly to Linux v4.7, let me
know, and I can provide one. A full patch against 4.8-rc5 can be
found here:

http://brick.kernel.dk/snaps/wb-buf-throttle-v7.patch

Changes since v6

- Improve performance of the stats tracking, by reducing int divisions
  through batching.
- Make blk_mq_stat_get() correctly set the right stat time window.
  Use this through the ->is_current() stat op.
- Change the balance_dirty_pages() triggered 'dirty_sleeping' atomic
  into a time stamp. Use this in the throttling code to know if someone
  has slept in bdp() recently, instead of only knowing if a task is
  block there right now.
- Allow negative scaling. This allows us to have a tighter baseline
  setting for better latencies, while allowing us to go a bit deeper
  in queue depth for improved write performance for cases where we
  don't have a mixed workload.
- Add a wbt timer trace point.
- Changing tracing from nanoseconds to microseconds, with the base
  noted.
- Added/improved code commenting.
- Fix the bug in wbc_to_write_flags(). Spotted by Omar.
- Kill the unused SCALE_BITMAP Kconfig setting. Spotted by Omar.
- Rebased to v4.8-rc5

Changes since v5

- Rebased on top of 4.8-rc4, drop parts of the series that is
  now in mainline.
- Fixes for QD=1 devices, should make them perform better.
- Fix for hang with disabling WBT with IO in flight
- Change in the sync issue/completion logic. Previously we
  used whether this IO was tracked or not (eg was a buffered write),
  this has now been changed to just look at reads. This is a better
  metric, and should improve behavior.
- Add some more comments to the code, explaining how it works.

Changes since v4

- Add some documentation for the two queue sysfs files
- Kill off wb_stats sysfs file. Use the trace points to get this info
  now.
- Various work around making this block layer agnostic. The main code
  now resides in lib/wbt.c and can be plugged into NFS as well, for
  instance.
- Fix an issue with double completions on the block layer side.
- Fix an issue where a long sync issue was disregarded, if the stat
  sample weren't valid.
- Speed up the division in rwb_arm_timer().
- Add logic to scale back up for 'unknown' latency events.
- Don't track sync issue timestamp of wbt is disabled.
- Drop the dirty/writeback page inc/dec patch. We don't need it, and
  it was racy.
- Move block/blk-wb.c to lib/wbt.c

Changes since v3

- Re-do the mm/ writheback parts. Add REQ_BG for background writes,
  and don't overload the wbc 'reason' for writeback decisions.
- Add tracking for when apps are sleeping waiting for a page to complete.
- Change wbc_to_write() to wbc_to_write_cmd().
- Use atomic_t for the balance_dirty_pages() sleep count.
- Add a basic scalable block stats tracking framework.
- Rewrite blk-wb core as described above, to dynamically adapt. This is
  a big change, see the last patch for a full description of it.
- Add tracing to blk-wb, instead of using debug printk's.
- Rebased to 4.6-rc3 (ish)

Changes since v2

- Switch from wb_depth to wb_percent, as that's an easier tunable.
- Add the patch to track device depth on the block layer side.
- Cleanup the limiting code.
- Don't use a fixed limit in the wb wait, since it can change
  between wakeups.
- Minor tweaks, fixups, cleanups.

Changes since v1

- Drop sync() WB_SYNC_NONE -> WB_SYNC_ALL change
- wb_start_writeback() fills in background/reclaim/sync info in
  the writeback work, based on writeback reason.
- Use WRITE_SYNC for reclaim/sync IO
- Split balance_dirty_pages() sleep change into separate patch
- Drop get_request() u64 flag change, set the bit on the request
  directly after-the-fact.
- Fix wrong sysfs return value
- Various small cleanups


 Documentation/block/queue-sysfs.txt |   13 
 block/Kconfig                       |    1 
 block/Makefile                      |    2 
 block/blk-core.c                    |   22 +
 block/blk-mq-sysfs.c                |   47 ++
 block/blk-mq.c                      |   42 ++
 block/blk-mq.h                      |    3 
 block/blk-settings.c                |   15 
 block/blk-stat.c                    |  221 +++++++++++
 block/blk-stat.h                    |   18 
 block/blk-sysfs.c                   |  151 ++++++++
 block/cfq-iosched.c                 |   12 
 drivers/scsi/scsi.c                 |    3 
 fs/buffer.c                         |    2 
 fs/f2fs/data.c                      |    2 
 fs/f2fs/node.c                      |    2 
 fs/gfs2/meta_io.c                   |    3 
 fs/mpage.c                          |    2 
 fs/xfs/xfs_aops.c                   |    7 
 include/linux/backing-dev-defs.h    |    2 
 include/linux/blk_types.h           |   16 
 include/linux/blkdev.h              |   19 +
 include/linux/fs.h                  |    3 
 include/linux/wbt.h                 |  120 ++++++
 include/linux/writeback.h           |   10 
 include/trace/events/wbt.h          |  153 ++++++++
 lib/Kconfig                         |    3 
 lib/Makefile                        |    1 
 lib/wbt.c                           |  679 ++++++++++++++++++++++++++++++++++++
 mm/backing-dev.c                    |    1 
 mm/page-writeback.c                 |    1 
 31 files changed, 1560 insertions(+), 16 deletions(-)

-- 
Jens Axboe
