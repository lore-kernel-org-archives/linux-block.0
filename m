Return-Path: <axboe@kernel.dk>
Date: Wed, 27 Apr 2016 14:37:08 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, dchinner@redhat.com,
	sedat.dilek@gmail.com
Subject: Re: [PATCHSET v5] Make background writeback great again for the
 first time
Message-ID: <20160427203708.GA25397@kernel.dk>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
 <20160427180105.GA17362@quack2.suse.cz>
 <5721021E.8060006@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5721021E.8060006@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 27 2016, Jens Axboe wrote:
> On 04/27/2016 12:01 PM, Jan Kara wrote:
> >Hi,
> >
> >On Tue 26-04-16 09:55:23, Jens Axboe wrote:
> >>Since the dawn of time, our background buffered writeback has sucked.
> >>When we do background buffered writeback, it should have little impact
> >>on foreground activity. That's the definition of background activity...
> >>But for as long as I can remember, heavy buffered writers have not
> >>behaved like that. For instance, if I do something like this:
> >>
> >>$ dd if=/dev/zero of=foo bs=1M count=10k
> >>
> >>on my laptop, and then try and start chrome, it basically won't start
> >>before the buffered writeback is done. Or, for server oriented
> >>workloads, where installation of a big RPM (or similar) adversely
> >>impacts database reads or sync writes. When that happens, I get people
> >>yelling at me.
> >>
> >>I have posted plenty of results previously, I'll keep it shorter
> >>this time. Here's a run on my laptop, using read-to-pipe-async for
> >>reading a 5g file, and rewriting it. You can find this test program
> >>in the fio git repo.
> >
> >I have tested your patchset on my test system. Generally I have observed
> >noticeable drop in average throughput for heavy background writes without
> >any other disk activity and also somewhat increased variance in the
> >runtimes. It is most visible on this simple testcases:
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> >
> >and
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> >
> >The machine has 4GB of ram, /mnt is an ext3 filesystem that is freshly
> >created before each dd run on a dedicated disk.
> >
> >Without your patches I get pretty stable dd runtimes for both cases:
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> >Runtimes: 87.9611 87.3279 87.2554
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> >Runtimes: 93.3502 93.2086 93.541
> >
> >With your patches the numbers look like:
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> >Runtimes: 108.183, 97.184, 99.9587
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> >Runtimes: 104.9, 102.775, 102.892
> >
> >I have checked whether the variance is due to some interaction with CFQ
> >which is used for the disk. When I switched the disk to deadline, I still
> >get some variance although, the throughput is still ~10% lower:
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> >Runtimes: 100.417 100.643 100.866
> >
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> >Runtimes: 104.208 106.341 105.483
> >
> >The disk is rotational SATA drive with writeback cache, queue depth of the
> >disk reported in /sys/block/sdb/device/queue_depth is 1.
> >
> >So I think we still need some tweaking on the low end of the storage
> >spectrum so that we don't lose 10% of throughput for simple cases like
> >this.
> 
> Thanks for testing, Jan! I haven't tried old QD=1 SATA. I wonder if
> you are seeing smaller requests, and that is why it both varies and
> you get lower throughput? I'll try and setup a test here similar to
> yours.

Jan, care to try the below patch? I can't fully reproduce your issue on
a SCSI disk limited to QD=1, but I have a feeling this might help. It's
a bit of a hack, but the general idea is to allow one more request to
build up for QD=1 devices. That eliminates wait time between one request
finishing, and the next being submitted.


diff --git a/lib/wbt.c b/lib/wbt.c
index 650da911f24f..6b24c8525ace 100644
--- a/lib/wbt.c
+++ b/lib/wbt.c
@@ -93,23 +93,30 @@ void __wbt_done(struct rq_wb *rwb)
 	 * If the device does write back caching, drop further down
 	 * before we wake people up.
 	 */
-	if (rwb->wc && !atomic_read(&rwb->bdi->wb.dirty_sleeping))
+	if (rwb->queue_depth == 1)
+		limit = 2;
+	else if (rwb->wc && !atomic_read(&rwb->bdi->wb.dirty_sleeping))
 		limit = 0;
 	else
 		limit = rwb->wb_normal;
 
+	inflight = atomic_dec_return(&rwb->inflight);
+
 	/*
-	 * Don't wake anyone up if we are above the normal limit. If
-	 * throttling got disabled (limit == 0) with waiters, ensure
-	 * that we wake them up.
+	 * wbt got disabled with IO in flight. Wake up any potential
+	 * waiters, we don't have to do more than that.
 	 */
-	inflight = atomic_dec_return(&rwb->inflight);
-	if (limit && inflight >= limit) {
-		if (!rwb->wb_max)
-			wake_up_all(&rwb->wait);
+	if (!rwb_enabled(rwb)) {
+		wake_up_all(&rwb->wait);
 		return;
 	}
 
+	/*
+	 * Don't wake anyone up if we are above the normal limit.
+	 */
+	if (inflight >= limit)
+		return;
+
 	if (waitqueue_active(&rwb->wait)) {
 		int diff = limit - inflight;
 
@@ -366,6 +373,9 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	} else
 		limit = rwb->wb_normal;
 
+	if (rwb->queue_depth == 1)
+		limit = 2;
+
 	return limit;
 }
 

-- 
Jens Axboe
