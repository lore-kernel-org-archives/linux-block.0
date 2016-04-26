Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30838 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752447AbcDZP4J (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 26 Apr 2016 11:56:09 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <dchinner@redhat.com>, <sedat.dilek@gmail.com>
Subject: [PATCHSET v5] Make background writeback great again for the first time
Date: Tue, 26 Apr 2016 09:55:23 -0600
Message-ID: <1461686131-22999-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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

I have posted plenty of results previously, I'll keep it shorter
this time. Here's a run on my laptop, using read-to-pipe-async for
reading a 5g file, and rewriting it. You can find this test program
in the fio git repo.

4.6-rc3:

$ t/read-to-pipe-async -f ~/5g > 5g-new

Latency percentiles (usec) (READERS)
	50.0000th: 2
	75.0000th: 3
	90.0000th: 5
	95.0000th: 7
	99.0000th: 43
	99.5000th: 77
	99.9000th: 9008
	99.9900th: 91008
	99.9990th: 286208
	99.9999th: 347648
	Over=1251, min=0, max=358081
Latency percentiles (usec) (WRITERS)
	50.0000th: 4
	75.0000th: 8
	90.0000th: 13
	95.0000th: 15
	99.0000th: 32
	99.5000th: 43
	99.9000th: 81
	99.9900th: 2372
	99.9990th: 104320
	99.9999th: 349696
	Over=63, min=1, max=358321
Read rate (KB/sec) : 91859
Write rate (KB/sec): 91859

4.6-rc3 + wb-buf-throttle

Latency percentiles (usec) (READERS)
	50.0000th: 2
	75.0000th: 3
	90.0000th: 5
	95.0000th: 8
	99.0000th: 48
	99.5000th: 79
	99.9000th: 5304
	99.9900th: 22496
	99.9990th: 29408
	99.9999th: 33728
	Over=860, min=0, max=37599
Latency percentiles (usec) (WRITERS)
	50.0000th: 4
	75.0000th: 9
	90.0000th: 14
	95.0000th: 16
	99.0000th: 34
	99.5000th: 45
	99.9000th: 87
	99.9900th: 1342
	99.9990th: 13648
	99.9999th: 21280
	Over=29, min=1, max=30457
Read rate (KB/sec) : 95832
Write rate (KB/sec): 95832

Better throughput and tighter latencies, for both reads and writes.
That's hard not to like.

The above was the why. The how is basically throttling background
writeback. We still want to issue big writes from the vm side of things,
so we get nice and big extents on the file system end. But we don't need
to flood the device with THOUSANDS of requests for background writeback.
For most devices, we don't need a whole lot to get decent throughput.

This adds some simple blk-wb code that keeps limits how much buffered
writeback we keep in flight on the device end. It's all about managing
the queues on the hardware side. The big change in this version is that
it should be pretty much auto-tuning - you no longer have to set a
given percentage of writeback bandwidth. I've implemented something
similar to CoDel to manage the writeback queue. See the last patch
for a full description, but the tldr is that we monitor min latencies
over a window of time, and scale up/down the queue based on that. This
needs a minimum of tunables, and it stays out of the way, if your device
is fast enough. There's a single tunable now, wb_last_usec, that simply
sets this latency target. Most people won't have to touch this, it'll
work pretty well just being in the ballpark.

I welcome testing. If you are sick of Linux bogging down when buffered
writes are happening, then this is for you, laptop or server. The
patchset is fully stable, I have not observed problems. It passes full
xfstest runs, and a variety of benchmarks as well. It works equally well
on blk-mq/scsi-mq, and "classic" setups.

You can also find this in a branch in the block git repo:

git://git.kernel.dk/linux-block.git wb-buf-throttle

Note that I rebase this branch when I collapse patches. The
wb-buf-throttle-v5 will remain the same as this version. I've folded
the device write cache changes into my 4.7 branches, so they are not
a part of this posting. Get the full wb-buf-throttle branch, or apply
the patches here on top of my for-next. A full patch against Linus'
current tree can also be downloaded here:

http://brick.kernel.dk/snaps/wb-buf-throttle-v5.patch

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


 Documentation/block/queue-sysfs.txt             |   22 +
 Documentation/block/writeback_cache_control.txt |    4 
 arch/um/drivers/ubd_kern.c                      |    2 
 block/Kconfig                                   |    1 
 block/Makefile                                  |    2 
 block/blk-core.c                                |   26 +
 block/blk-flush.c                               |   11 
 block/blk-mq-sysfs.c                            |   47 ++
 block/blk-mq.c                                  |   44 +-
 block/blk-mq.h                                  |    3 
 block/blk-settings.c                            |   59 +-
 block/blk-stat.c                                |  185 ++++++++
 block/blk-stat.h                                |   17 
 block/blk-sysfs.c                               |  184 ++++++++
 drivers/block/drbd/drbd_main.c                  |    2 
 drivers/block/loop.c                            |    2 
 drivers/block/mtip32xx/mtip32xx.c               |    6 
 drivers/block/nbd.c                             |    4 
 drivers/block/osdblk.c                          |    2 
 drivers/block/ps3disk.c                         |    2 
 drivers/block/skd_main.c                        |    2 
 drivers/block/virtio_blk.c                      |    6 
 drivers/block/xen-blkback/xenbus.c              |    2 
 drivers/block/xen-blkfront.c                    |    3 
 drivers/ide/ide-disk.c                          |    6 
 drivers/md/bcache/super.c                       |    2 
 drivers/md/dm-table.c                           |   20 
 drivers/md/md.c                                 |    2 
 drivers/md/raid5-cache.c                        |    3 
 drivers/mmc/card/block.c                        |    2 
 drivers/mtd/mtd_blkdevs.c                       |    2 
 drivers/nvme/host/core.c                        |    7 
 drivers/scsi/scsi.c                             |    3 
 drivers/scsi/sd.c                               |    8 
 drivers/target/target_core_iblock.c             |    6 
 fs/block_dev.c                                  |    2 
 fs/buffer.c                                     |    2 
 fs/f2fs/data.c                                  |    2 
 fs/f2fs/node.c                                  |    2 
 fs/gfs2/meta_io.c                               |    3 
 fs/mpage.c                                      |    9 
 fs/xfs/xfs_aops.c                               |    2 
 include/linux/backing-dev-defs.h                |    2 
 include/linux/blk_types.h                       |   12 
 include/linux/blkdev.h                          |   28 +
 include/linux/fs.h                              |    4 
 include/linux/wbt.h                             |   95 ++++
 include/linux/writeback.h                       |   10 
 include/trace/events/wbt.h                      |  122 +++++
 lib/Kconfig                                     |    3 
 lib/Makefile                                    |    1 
 lib/wbt.c                                       |  524 ++++++++++++++++++++++++
 mm/backing-dev.c                                |    1 
 mm/page-writeback.c                             |    2 
 54 files changed, 1429 insertions(+), 96 deletions(-)

-- 
Jens Axboe

