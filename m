Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28694 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194AbcFHUvj (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 16:51:39 -0400
From: Michael Callahan <michaelcallahan@fb.com>
To: <linux-block@vger.kernel.org>
CC: Michael Callahan <michaelcallahan@fb.com>, <axboe@fb.com>,
	<coder.callahan@gmail.com>, <kernel-team@fb.com>
Subject: [PATCH 0/4] block: Separating discards from writes in Linux IO statistics
Date: Wed, 8 Jun 2016 16:50:51 -0400
Message-ID: <cover.1464912896.git.michaelcallahan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch set separates block layer statistics for discards from
writes.  Discards are currently bundled with writes in the
various /sys/block/*/stat files as well as in /proc/diskstats.
However discards are nearly always used to mark storage that is
no longer in use.  There are many reasons having discard not
counted with writes is useful:

1) For many non volatile memory devices it is just nice to know
   that discards are enabled and working properly.

2) Discards have different performance characteristics than
   writes.  They are generally much faster and larger and bundling
   them makes performance statistics less meaningful.

3) Discards are not writes in terms of tracking device lifetime.
   If a device supports six device writes per day it is nice to know
   how many writes have actually been written to the device as
   discards do not count against that total.

Separation of discard statistics is accomplished by expanding the
struct diskstat arrays to 3 entries for STAT_READ, STAT_WRITE,
and STAT_DISCARD.  A new rw_stat_group function is then used to
convert from rw_flags (cmd_flags from requests, bi_rw from bios)
into the appropriate stat group which is then tracked as before.
Lastly the new statistics are appended to the current
/sys/bloc/*/stat and /proc/diskstats on output such that they are
the last four entries of each.  These are analogous to the four
read and write statistics.

 * Number of discard ios completed
 * Number of discard ios merged
 * Number of discard sectors completed
 * Milliseconds spent on discard requests.

[before ~]# cat sys/block/nvme0/stat
296550701        0 2372405688 67317193 19672752        0 7972237312
9375167        0  2787238 79718726

[after ~]# cat sys/block/nvme0/stat
296550701        0 2372405688 67317193 18034352        0 4616794112
9125902        0  2787238 79718726  1638400        0 3355443200
249265

Note that the discards have moved out of the write fields to the
end and that the write fields are now smaller by the difference.

Adding the new statistics to the end of /sys/block/*/stat and
/proc/diskstats is backwards compatible with both iostat and
vmstat which pick up just the old fields:

[root@after ~]# iostat -x
Linux 4.5.0_68319_ge5065f4-dirty (##hostname###)        05/17/2016
 _x86_64_        (48 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.41    0.00    0.23    0.01    0.00   99.35

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
sda               0.01     7.50    0.20    3.61    16.65   708.41
190.03     0.09   22.53   1.16   0.44
nvme0n1           0.00     0.00  587.03   35.70  4696.25  9139.08
22.22     0.16    0.24   0.01   0.55


[root@after ~]# vmstat -d
disk- ------------reads------------ ------------writes----------- -----IO------
       total merged sectors      ms  total merged sectors      ms    cur    sec
ram0       0      0       0       0      0      0       0       0      0      0
ram1       0      0       0       0      0      0       0       0      0      0
ram2       0      0       0       0      0      0       0       0      0      0
ram3       0      0       0       0      0      0       0       0      0      0
ram4       0      0       0       0      0      0       0       0      0      0
ram5       0      0       0       0      0      0       0       0      0      0
ram6       0      0       0       0      0      0       0       0      0      0
ram7       0      0       0       0      0      0       0       0      0      0
ram8       0      0       0       0      0      0       0       0      0      0
ram9       0      0       0       0      0      0       0       0      0      0
ram10      0      0       0       0      0      0       0       0      0      0
ram11      0      0       0       0      0      0       0       0      0      0
ram12      0      0       0       0      0      0       0       0      0      0
ram13      0      0       0       0      0      0       0       0      0      0
ram14      0      0       0       0      0      0       0       0      0      0
ram15      0      0       0       0      0      0       0       0      0      0
sda   102903   5247 8408420   47424 1820306 3782041 357153613 43320121
     0   2228
nvme0n1 145633279      0 1165066312 18981333 13107200      0
3355443200 6663655      0   1796
loop0      0      0       0       0      0      0       0       0      0      0
loop1      0      0       0       0      0      0       0       0      0      0
  [chop rest of loop devices]

Comments and suggestions welcome.

Michael Callahan (4):
  block: Add part_stat_read_accum to read across field entries.
  block: Define and use STAT_READ and STAT_WRITE
  block: Add and use a rw_stat_group function for indexing disk_stat
    fields.
  block: Track DISCARD statistics and output them in stat and diskstat.

 Documentation/ABI/testing/procfs-diskstats | 10 ++++++++++
 Documentation/block/stat.txt               | 28 ++++++++++++++++------------
 Documentation/iostats.txt                  | 15 ++++++++++++++-
 block/bio.c                                | 14 +++++++++-----
 block/blk-core.c                           |  9 +++++----
 block/genhd.c                              | 30 +++++++++++++++++++-----------
 block/partition-generic.c                  | 25 +++++++++++++++----------
 drivers/block/drbd/drbd_receiver.c         |  3 +--
 drivers/block/drbd/drbd_req.c              |  4 ++--
 drivers/block/drbd/drbd_worker.c           |  4 +---
 drivers/block/rsxx/dev.c                   |  5 ++---
 drivers/block/zram/zram_drv.c              | 14 +++++++-------
 drivers/md/bcache/request.c                | 10 +++++-----
 drivers/md/dm.c                            |  7 +++----
 drivers/md/md.c                            |  8 ++++----
 drivers/nvdimm/core.c                      |  8 +++++---
 fs/ext4/super.c                            |  5 +++--
 fs/ext4/sysfs.c                            |  6 ++++--
 fs/f2fs/f2fs.h                             |  2 +-
 fs/f2fs/super.c                            |  3 ++-
 include/linux/bio.h                        |  4 ++--
 include/linux/genhd.h                      | 24 ++++++++++++++++++++----
 22 files changed, 150 insertions(+), 88 deletions(-)

-- 
1.9.3

