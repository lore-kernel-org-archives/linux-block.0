Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] loop: remember whether sysfs_create_group() succeeded
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jack@suse.cz
Cc: linux-block@vger.kernel.org
References: <94eb2c030882b2b1b505610813df@google.com>
 <55ff5960-eaab-5a36-5605-4e2230b77607@I-love.SAKURA.ne.jp>
 <20180502142434.GA10928@kroah.com>
 <201805042047.EFJ26068.OtOJFSLFFQOVHM@I-love.SAKURA.ne.jp>
 <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
 <201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
Date: Fri, 4 May 2018 08:30:39 -0600
MIME-Version: 1.0
In-Reply-To: <201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/4/18 8:27 AM, Tetsuo Handa wrote:
> Jens Axboe wrote:
>> On 5/4/18 5:47 AM, Tetsuo Handa wrote:
>>> >From 626d33de1b70b11ecaf95a9f83f7644998e54cbb Mon Sep 17 00:00:00 2001
>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> Date: Wed, 2 May 2018 23:03:48 +0900
>>> Subject: [PATCH] loop: remember whether sysfs_create_group() succeeded
>>>
>>> syzbot is hitting WARN() triggered by memory allocation fault
>>> injection [1] because loop module is calling sysfs_remove_group()
>>> when sysfs_create_group() failed.
>>> Fix this by remembering whether sysfs_create_group() succeeded.
>>
>> Can we store this locally instead of in the loop_device? Also,
>> naming wise, something like sysfs_init_done would be more readily
>> understandable.
> 
> Whether sysfs entry for this loop device exists is per "struct loop_device"
> flag, isn't it? What does "locally" mean?

I'm assuming this is calling remove in an error path when alloc fails.
So it should be possible to know locally whether this was done or not,
before calling the teardown. Storing this is in the loop_device seems
like a bit of a hack.

If that's not easily done, then my next suggestion would be to
use a loop flag for it, LO_FLAGS_SYSFS_SETUP or something like that.

-- 
Jens Axboe
