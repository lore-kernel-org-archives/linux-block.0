Subject: Re: [PATCH] blk-throttle: set default latency baseline for harddisk
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, tj@kernel.org, Kernel-team@fb.com,
 Shaohua Li <shli@fb.com>
References: <af8d351c4d0639b4df0dae777cc96944f52751c1.1496777767.git.shli@fb.com>
 <5c403cc9-fbfa-829e-f413-48fa503df6fb@fb.com>
 <20170606221135.mrugl2crbly3r65c@kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <3e683baf-5d02-4f08-7846-6bfd6ccfe465@fb.com>
Date: Wed, 7 Jun 2017 09:09:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170606221135.mrugl2crbly3r65c@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/06/2017 04:11 PM, Shaohua Li wrote:
> On Tue, Jun 06, 2017 at 03:12:12PM -0600, Jens Axboe wrote:
>> On 06/06/2017 01:40 PM, Shaohua Li wrote:
>>> From: Shaohua Li <shli@fb.com>
>>>
>>> hard disk IO latency varies a lot depending on spindle move. The latency
>>> range could be from several microseconds to several milliseconds. It's
>>> pretty hard to get the baseline latency used by io.low.
>>>
>>> We will use a different stragety here. The idea is only using IO with
>>> spindle move to determine if cgroup IO is in good state. For HD, if io
>>> latency is small (< 1ms), we ignore the IO. Such IO is likely from
>>> sequential IO, and is helpless to help determine if a cgroup's IO is
>>> impacted by other cgroups. With this, we only account IO with big
>>> latency. Then we can choose a hardcoded baseline latency for HD (4ms,
>>> which is typical IO latency with seek).  With all these settings, the
>>> io.low latency works for both HD and SSD.
>>
>> I think that makes sense for reads - a quick read is certainly a cache
>> hit, due to a sequential IO hit. But what about for writes? Most are
>> absorbed by the write cache, so most will be < 1ms probably. Let's say
>> an app is doing random writes, the one write we do account will
>> potentially come at a much higher cost than the actual cost of that one
>> write. Simiarly for sequential writes, but the ratio of costs is closer
>> there.
>>
>> Maybe that's OK?
> 
> Good question. So the concern is say we have 10 io, without cache, the 10 io
> will have large latency; but with cache, only the 10th io has a very large
> latency, so we miss accounting some IOs.

Precisely!

> I don't have a good solution for this.  On the other hand, this
> wouldn't occur in workload with sustained IO, so this problem sounds
> not a big deal. We probably can add a check later if collected sample
> count isn't enough, ignore the samples, which I think can mitigate
> this problem partly.

I'm almost wondering if it doesn't just make sense to have fixed costs
for a single spindle. But it probably doesn't make sense to special case
that, and I think you are right in that it works itself out over time
with sustained IO.

I'll add your patch for 4.12.

-- 
Jens Axboe
