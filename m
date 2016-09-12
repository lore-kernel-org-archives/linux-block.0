Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Vivek Goyal
	<vgoyal@redhat.com>
Subject: [PATCH] blk-throttle: fix infinite throttling caused by non-cascading timer wheel
Date: Mon, 12 Sep 2016 14:45:30 +0800
Message-ID: <1473662730-184701-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Due to commit 500462a9de65 ("timers: Switch to a non-cascading wheel"),
the slack of timer increases when the timeout increases:

 So for HZ=250 we end up with the following granularity levels:
  Level Offset   Granularity                  Range
      0      0          4 ms                 0 ms -        252 ms
      1     64         32 ms               256 ms -       2044 ms (256ms - ~2s)
      2    128        256 ms              2048 ms -      16380 ms (~2s   - ~16s)

When the slack is bigger than throtl_slice (100ms), there will be
a problem: throtl_slice_used() will always return true, a new slice
will always be genereated, and the bio will be throttled forever.

The following is a example:

 echo 253:0 512 > /sys/fs/cgroup/blkio/blkio.throttle.read_bps_device
 fio --readonly --direct=1 --filename=/dev/vda --size=4K --rate=4K \
		 --rw=read --ioengine=libaio --iodepth=16 --name 1

 the slack of 8s-timer is about 302ms.

 throtl / [R] bio. bdisp=0 sz=4096 bps=512 iodisp=0 iops=4294967295 queued=0/0
 throtl schedule timer. delay=8000 jiffies=4295784850
 throtl / dispatch nr_queued=1 read=1 write=0, bdisp=0/0, iodisp=0/0
 throtl / [R] new slice start=4295793152 end=4295793252 jiffies=4295793152
 throtl / [R] extend slice start=4295793152 end=4295801200 jiffies=4295793152
 throtl schedule timer. delay=8000 jiffies=4295793152
 throtl / dispatch nr_queued=1 read=1 write=0, bdisp=0/0, iodisp=0/0
 throtl / [R] new slice start=4295801344 end=4295801444 jiffies=4295801344
 throtl / [R] extend slice start=4295801344 end=4295809400 jiffies=4295801344
 throtl schedule timer. delay=8000 jiffies=4295801344

Fix it by checking the delayed dispatch in tg_may_dispatch():
1. If there is any dispatched bio, the time slice must have been used,
   so it's OK to renew the time slice.
2. If there is no queued bio, the time slice must have been expired,
   so it's Ok to renew the time slice.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-throttle.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f1aba26..91f8140 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -591,13 +591,20 @@ static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
 		   tg->slice_end[rw], jiffies);
 }
 
+static bool throtl_is_delayed_disp(struct throtl_grp *tg, bool rw)
+{
+	return (time_after(jiffies, tg->slice_end[rw]) &&
+			!tg->bytes_disp[rw] && !tg->io_disp[rw] &&
+			tg->service_queue.nr_queued[rw]) ? true : false;
+}
+
 /* Determine if previously allocated or extended slice is complete or not */
 static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
 {
 	if (time_in_range(jiffies, tg->slice_start[rw], tg->slice_end[rw]))
 		return false;
 
-	return 1;
+	return true;
 }
 
 /* Trim the used slices and adjust slice start accordingly */
@@ -782,7 +789,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	 * existing slice to make sure it is at least throtl_slice interval
 	 * long since now.
 	 */
-	if (throtl_slice_used(tg, rw))
+	if (throtl_slice_used(tg, rw) && !throtl_is_delayed_disp(tg, rw))
 		throtl_start_new_slice(tg, rw);
 	else {
 		if (time_before(tg->slice_end[rw], jiffies + throtl_slice))
-- 
2.5.5
