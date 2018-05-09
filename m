Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/7] block: consolidate struct request timestamp fields
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <cover.1525856630.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d2af964-b7b7-cb30-fc25-f2db8ff91ce0@kernel.dk>
Date: Wed, 9 May 2018 08:35:58 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1525856630.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 3:08 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Here's the timestamp field rework rebased on for-4.18/block. The only
> conflict was the blk stat bits, which this series removes in favor of
> rq->wbt_flags. No other changes since v2.
> 
> Cover letter from v1:
> 
> Currently, struct request has four timestamp fields:
> 
> - start_time (jiffies), marked at get_request() time and used for
>   iostats
> - issue_stat (ktime nanoseconds, with some bits shared with wbt and
>   io.low), marked at start_request() time and used for accounting the
>   time spent in the device for blk-stats (i.e., wbt, kyber, hybrid
>   polling)
> - start_time_ns (sched_clock nanoseconds), also marked at get_request()
>   time, used for CFQ and BFQ cgroups support
> - io_start_time_ns (sched_clock nanoseconds), also marked at
>   start_request() time and also used for CFQ and BFQ
> 
> Clearly, there's some redundancy here. This patch series consolidates
> these four timestamps into two, both of which are in ktime nanoseconds.
> This shaves off up to 16 bytes from struct request, gets rid of the
> usage of sched_clock(), and actually removes lines of code.
> 
> Patches 1 and 2 do some prep in wbt. Patch 3 does some prep in io.low.
> Patch 4 splits up issue_stat into just a timestamp and separate fields
> to fill a hole in struct request. Patch 5 does some prep in CFQ and BFQ.
> Patch 6 allows us to save a call to ktime_get(). Patch 7 does the final
> consolidation.
> 
> Please take a look. I added a blktest (block/018) to sanity check
> iostats, but other stuff is harder to test so it could use some eyes.
> Thanks!

Thanks Omar, applied.

-- 
Jens Axboe
