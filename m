Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-throttle: ignore discard request size
To: Shaohua Li <shli@kernel.org>
Cc: Shaohua Li <shli@fb.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Kernel-team@fb.com
References: <67ffcf14c2d15622b84c60a493b590dd81a07f51.1503068984.git.shli@fb.com>
 <e2144181-6129-96e2-0e44-66625da2f04a@kernel.dk>
 <20170818162825.GA21653@MacBook-Pro.dhcp.thefacebook.com>
 <16cdee66-a332-3ce4-c393-34c835b76c89@fb.com>
 <20170818191226.x2nxobvsuomc3oh3@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ebf102dd-7d73-4bf5-9fe7-1771fb6dfb2e@kernel.dk>
Date: Fri, 18 Aug 2017 13:15:15 -0600
MIME-Version: 1.0
In-Reply-To: <20170818191226.x2nxobvsuomc3oh3@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:12 PM, Shaohua Li wrote:
> On Fri, Aug 18, 2017 at 01:06:46PM -0600, Jens Axboe wrote:
>> On 08/18/2017 10:28 AM, Shaohua Li wrote:
>>> On Fri, Aug 18, 2017 at 09:35:01AM -0600, Jens Axboe wrote:
>>>> On 08/18/2017 09:13 AM, Shaohua Li wrote:
>>>>> discard request usually is very big and easily use all bandwidth budget
>>>>> of a cgroup. discard request size doesn't really mean the size of data
>>>>> written, so it doesn't make sense to account it into bandwidth budget.
>>>>> This patch ignores discard requests size. It makes sense to account
>>>>> discard request into iops budget though.
>>>>
>>>> Some (most) devices to touch media for a discard operation, but the
>>>> cost tends to be fairly constant and independent of discard size.
>>>> Would it make sense to just treat it as a constant cost? Zero
>>>> cost seems wrong.
>>>
>>> that would be hard to find the cost. Would this make sense?
>>>
>>> min_t(unsigned int, bio->bi_iter.bi_size, queue_max_sectors(q) << 9)
>>
>> It's all going to be approximations, for sure, unfortunately it isn't
>> an exact science. Why not just use a constant small value? If we assume
>> that a 4k and 8M discard end up writing roughly the same to media, then
>> it would follow that just using a smaller constant value (regardless of
>> actual discard command size) would be useful.
> 
> Sounds good. what number do you suggest? queue_max_sectors or a
> random number?

Not sure why you want to go that large? Isn't the idea to throttle on
actual device bandwidth used? In which case a much smaller number should
be a lot closer to reality, say like 64 bytes per discard, regardless
of actual size. That still gives you some throttling instead of just
ignoring it, but at a more reasonable rate.

-- 
Jens Axboe
