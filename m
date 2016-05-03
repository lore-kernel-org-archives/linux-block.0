Return-Path: <jack@suse.cz>
Date: Tue, 3 May 2016 14:17:19 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dchinner@redhat.com, sedat.dilek@gmail.com
Subject: Re: [PATCHSET v5] Make background writeback great again for the
 first time
Message-ID: <20160503121719.GA25436@quack2.suse.cz>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
 <20160427180105.GA17362@quack2.suse.cz>
 <5721021E.8060006@fb.com>
 <20160427203708.GA25397@kernel.dk>
 <20160427205915.GC25397@kernel.dk>
 <20160428115401.GD17362@quack2.suse.cz>
 <57225A91.50002@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57225A91.50002@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu 28-04-16 12:46:41, Jens Axboe wrote:
> >>-	rwb->wb_max = 1 + ((depth - 1) >> min(31U, rwb->scale_step));
> >>-	rwb->wb_normal = (rwb->wb_max + 1) / 2;
> >>-	rwb->wb_background = (rwb->wb_max + 3) / 4;
> >>+	if (rwb->queue_depth == 1) {
> >>+		rwb->wb_max = rwb->wb_normal = 2;
> >>+		rwb->wb_background = 1;
> >
> >This breaks the detection of too big scale_step in scale_up() where we key
> >of wb_max == 1 value. However even with that fixed no luck :(:
> 
> Yeah, I need to look at that. For QD=1, I think the only sensible values for
> max/normal/bg is 2/2/1 and 1/1/1 if we step down.
> 
> >dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
> >Runtime: 105.126 107.125 105.641
> >
> >So about the same as before. I'll try to debug this later today...
> 
> Thanks, I'm very interested in what you find!

OK, so the reason was relatively standard in the end. I was using ext3 (or
more exactly ext4 without delayed allocation) for the test. The throttling
of background writes gave more priority to writes from the journalling
thread which happen with WRITE_SYNC and thus are not throttled. Thus the
journalling thread ended up having to do more data writeback to be able to
commit a transaction (due to requirements of data=ordered mode) and it is
less efficient at that than the normal flusher thread.

So this is an example where throttling background writeback effectively
just pushes more work into another context which does it less efficiently
and indirectly makes everyone wait for it. ext3 has been always sensitive to
issues like this. ext4 is using delayed allocation and thus only data
writes into holes end up being part of a transaction -> simple dd test case
doesn't hit that path. And indeed when I repeat the same test with ext4,
the numbers with and without your patch are exactly the same.

The question remains how common a pattern where throttling of background
writeback delays also something else is. I'll schedule a couple of
benchmarks to measure impact of your patches for a wider range of workloads
(but sadly pretty limited set of hw). If ext3 is the only one seeing
issues, I would be willing to accept that ext3 takes the hit since it is
doing something rather stupid (but inherent in its journal design) and we
have a way to deal with this either by enabling delayed allocation or by
turning off the writeback throttling...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
