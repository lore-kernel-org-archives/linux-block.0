Return-Path: <jack@suse.cz>
Date: Thu, 28 Apr 2016 13:54:01 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dchinner@redhat.com, sedat.dilek@gmail.com
Subject: Re: [PATCHSET v5] Make background writeback great again for the
 first time
Message-ID: <20160428115401.GD17362@quack2.suse.cz>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
 <20160427180105.GA17362@quack2.suse.cz>
 <5721021E.8060006@fb.com>
 <20160427203708.GA25397@kernel.dk>
 <20160427205915.GC25397@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160427205915.GC25397@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed 27-04-16 14:59:15, Jens Axboe wrote:
> On Wed, Apr 27 2016, Jens Axboe wrote:
> > On Wed, Apr 27 2016, Jens Axboe wrote:
> > > On 04/27/2016 12:01 PM, Jan Kara wrote:
> > > >Hi,
> > > >
> > > >On Tue 26-04-16 09:55:23, Jens Axboe wrote:
> > > >>Since the dawn of time, our background buffered writeback has sucked.
> > > >>When we do background buffered writeback, it should have little impact
> > > >>on foreground activity. That's the definition of background activity...
> > > >>But for as long as I can remember, heavy buffered writers have not
> > > >>behaved like that. For instance, if I do something like this:
> > > >>
> > > >>$ dd if=/dev/zero of=foo bs=1M count=10k
> > > >>
> > > >>on my laptop, and then try and start chrome, it basically won't start
> > > >>before the buffered writeback is done. Or, for server oriented
> > > >>workloads, where installation of a big RPM (or similar) adversely
> > > >>impacts database reads or sync writes. When that happens, I get people
> > > >>yelling at me.
> > > >>
> > > >>I have posted plenty of results previously, I'll keep it shorter
> > > >>this time. Here's a run on my laptop, using read-to-pipe-async for
> > > >>reading a 5g file, and rewriting it. You can find this test program
> > > >>in the fio git repo.
> > > >
> > > >I have tested your patchset on my test system. Generally I have observed
> > > >noticeable drop in average throughput for heavy background writes without
> > > >any other disk activity and also somewhat increased variance in the
> > > >runtimes. It is most visible on this simple testcases:
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> > > >
> > > >and
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> > > >
> > > >The machine has 4GB of ram, /mnt is an ext3 filesystem that is freshly
> > > >created before each dd run on a dedicated disk.
> > > >
> > > >Without your patches I get pretty stable dd runtimes for both cases:
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> > > >Runtimes: 87.9611 87.3279 87.2554
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> > > >Runtimes: 93.3502 93.2086 93.541
> > > >
> > > >With your patches the numbers look like:
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> > > >Runtimes: 108.183, 97.184, 99.9587
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> > > >Runtimes: 104.9, 102.775, 102.892
> > > >
> > > >I have checked whether the variance is due to some interaction with CFQ
> > > >which is used for the disk. When I switched the disk to deadline, I still
> > > >get some variance although, the throughput is still ~10% lower:
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000
> > > >Runtimes: 100.417 100.643 100.866
> > > >
> > > >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> > > >Runtimes: 104.208 106.341 105.483
> > > >
> > > >The disk is rotational SATA drive with writeback cache, queue depth of the
> > > >disk reported in /sys/block/sdb/device/queue_depth is 1.
> > > >
> > > >So I think we still need some tweaking on the low end of the storage
> > > >spectrum so that we don't lose 10% of throughput for simple cases like
> > > >this.
> > > 
> > > Thanks for testing, Jan! I haven't tried old QD=1 SATA. I wonder if
> > > you are seeing smaller requests, and that is why it both varies and
> > > you get lower throughput? I'll try and setup a test here similar to
> > > yours.
> > 
> > Jan, care to try the below patch? I can't fully reproduce your issue on
> > a SCSI disk limited to QD=1, but I have a feeling this might help. It's
> > a bit of a hack, but the general idea is to allow one more request to
> > build up for QD=1 devices. That eliminates wait time between one request
> > finishing, and the next being submitted.
> 
> That accidentally added a potentially stall, this one is both cleaner
> and should have that fixed.
> 
..
> -	rwb->wb_max = 1 + ((depth - 1) >> min(31U, rwb->scale_step));
> -	rwb->wb_normal = (rwb->wb_max + 1) / 2;
> -	rwb->wb_background = (rwb->wb_max + 3) / 4;
> +	if (rwb->queue_depth == 1) {
> +		rwb->wb_max = rwb->wb_normal = 2;
> +		rwb->wb_background = 1;

This breaks the detection of too big scale_step in scale_up() where we key
of wb_max == 1 value. However even with that fixed no luck :(:

dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
Runtime: 105.126 107.125 105.641

So about the same as before. I'll try to debug this later today...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
