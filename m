Return-Path: <prvs=01205f8ab4=axboe@fb.com>
Subject: Re: [PATCH 6/8] block: add scalable completion tracking of requests
To: Jan Kara <jack@suse.cz>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-7-git-send-email-axboe@fb.com>
 <20161108133007.GP32353@quack2.suse.cz>
CC: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <cbd840e8-1807-5cf9-913b-bc62dbc7ac9e@fb.com>
Date: Tue, 8 Nov 2016 08:25:52 -0700
MIME-Version: 1.0
In-Reply-To: <20161108133007.GP32353@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 06:30 AM, Jan Kara wrote:
> On Tue 01-11-16 15:08:49, Jens Axboe wrote:
>> For legacy block, we simply track them in the request queue. For
>> blk-mq, we track them on a per-sw queue basis, which we can then
>> sum up through the hardware queues and finally to a per device
>> state.
>>
>> The stats are tracked in, roughly, 0.1s interval windows.
>>
>> Add sysfs files to display the stats.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>
> This patch looks mostly good to me but I have one concern: You track
> statistics in a fixed 134ms window, stats get cleared at the beginning of
> each window. Now this can interact with the writeback window and latency
> settings which are dynamic and settable from userspace - so if the
> writeback code observation window gets set larger than the stats window,
> things become strange since you'll likely miss quite some observations
> about read latencies. So I think you need to make sure stats window is
> always larger than writeback window. Or actually, why do you have something
> like stats window and don't leave clearing of statistics completely to the
> writeback tracking code?

That's a good point, and there actually used to be a comment to that
effect in the code. I think the best solution here would be to make the
stats code mask available somewhere, and allow a consumer of the stats
to request a larger window.

Similarly, we could make the stat window be driven by the consumer, as
you suggest.

Currently there are two pending submissions that depend on the stats
code. One is this writeback series, and the other one is the hybrid
polling code. The latter does not really care about the window size as
such, since it has no monitoring window of its own, and it wants the
auto-clearing as well.

I don't mind working on additions for this, but I'd prefer if we could
layer them on top of the existing series instead of respinning it.
There's considerable test time on the existing patchset. Would that work
for you? Especially collapsing the stats and wbt windows would require
some re-architecting.

> Also as a side note - nobody currently uses the mean value of the
> statistics. It may be faster to track just sum and count so that mean can
> be computed on request which will be presumably much more rare than current
> situation where we recompute the mean on each batch update. Actually, that
> way you could get rid of the batching as well I assume.

That could be opt-in as well. The poll code uses it. And fwiw, it is
exposed through sysfs as well.

-- 
Jens Axboe
