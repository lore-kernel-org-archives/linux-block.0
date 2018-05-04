Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] loop: remember whether sysfs_create_group() succeeded
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jack@suse.cz,
 gmazyland@gmail.com
Cc: linux-block@vger.kernel.org
References: <3afa1009-c55e-08e2-32b9-49fde1c587c8@kernel.dk>
 <201805042327.CBF64097.OOVQFtFJFLSHOM@I-love.SAKURA.ne.jp>
 <6bf461ba-4bd0-6709-1605-b0fccd0f105d@kernel.dk>
 <201805042340.AIB51569.HOFQOJLFtVFSMO@I-love.SAKURA.ne.jp>
 <a3c15779-226c-5e26-6be2-68397a8b3d04@kernel.dk>
 <201805050114.GDF05771.JVtFOQMLOSFFHO@I-love.SAKURA.ne.jp>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2a75e5fb-7f29-d372-b87d-a69820fb750c@kernel.dk>
Date: Fri, 4 May 2018 10:27:57 -0600
MIME-Version: 1.0
In-Reply-To: <201805050114.GDF05771.JVtFOQMLOSFFHO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/4/18 10:14 AM, Tetsuo Handa wrote:
> Jens Axboe wrote:
>>> The loop module ignores sysfs_create_group() failure and pretends that
>>> LOOP_SET_FD request succeeded. I guess that the author of commit
>>> ee86273062cbb310 ("loop: add some basic read-only sysfs attributes")
>>> assumed that it is not a fatal error enough to abort LOOP_SET_FD request.
>>>
>>> Do we want to abort LOOP_SET_FD request if sysfs_create_group() failed?
>>
>> Probably safer to retain that behavior.
> 
> OK.
> 
>>
>>>> If that's not easily done, then my next suggestion would be to
>>>> use a loop flag for it, LO_FLAGS_SYSFS_SETUP or something like that.
>>>
>>> Yes, that would be possible.
>>
>> Let's make that change.
> 
> Since LO_FLAGS_* are defined in include/uapi/linux/loop.h as userspace visible
> flags, I feel that using "struct loop_device"->lo_flags for recording whether
> sysfs entry exists might be strange... Anyway, updated patch is shown below.

Hmm yes, I forgot about that, I guess that makes the flags approach
pretty much useless. Let's just go with your v1 in that case.

-- 
Jens Axboe
