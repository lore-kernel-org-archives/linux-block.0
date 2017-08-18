Return-Path: <prvs=9403985308=axboe@fb.com>
Subject: Re: [PATCH] blk-throttle: ignore discard request size
To: Shaohua Li <shli@fb.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <Kernel-team@fb.com>
References: <67ffcf14c2d15622b84c60a493b590dd81a07f51.1503068984.git.shli@fb.com>
 <e2144181-6129-96e2-0e44-66625da2f04a@kernel.dk>
 <20170818162825.GA21653@MacBook-Pro.dhcp.thefacebook.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <16cdee66-a332-3ce4-c393-34c835b76c89@fb.com>
Date: Fri, 18 Aug 2017 13:06:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170818162825.GA21653@MacBook-Pro.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 10:28 AM, Shaohua Li wrote:
> On Fri, Aug 18, 2017 at 09:35:01AM -0600, Jens Axboe wrote:
>> On 08/18/2017 09:13 AM, Shaohua Li wrote:
>>> discard request usually is very big and easily use all bandwidth budget
>>> of a cgroup. discard request size doesn't really mean the size of data
>>> written, so it doesn't make sense to account it into bandwidth budget.
>>> This patch ignores discard requests size. It makes sense to account
>>> discard request into iops budget though.
>>
>> Some (most) devices to touch media for a discard operation, but the
>> cost tends to be fairly constant and independent of discard size.
>> Would it make sense to just treat it as a constant cost? Zero
>> cost seems wrong.
> 
> that would be hard to find the cost. Would this make sense?
> 
> min_t(unsigned int, bio->bi_iter.bi_size, queue_max_sectors(q) << 9)

It's all going to be approximations, for sure, unfortunately it isn't
an exact science. Why not just use a constant small value? If we assume
that a 4k and 8M discard end up writing roughly the same to media, then
it would follow that just using a smaller constant value (regardless of
actual discard command size) would be useful.

-- 
Jens Axboe
