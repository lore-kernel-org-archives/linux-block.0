Return-Path: <axboe@kernel.dk>
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
Date: Tue, 11 Sep 2018 10:49:05 -0600
MIME-Version: 1.0
In-Reply-To: <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/11/18 10:48 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>> Hi,
>>>
>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>
>>> Is this already addressed?
>>
>> Haven't heard about this one before. What kernel did you last use that
>> worked?
> 
> I'm guessing you just need to update the maximum number of policies:
> 
> /*
>  * Maximum number of blkcg policies allowed to be registered concurrently.
>  * Defined here to simplify include dependency.
>  */
> #define BLKCG_MAX_POLS          3

That is my guess too, hence the suggestion to try and disable the
iolatency policy. Just tried here without, and it works, rebooting
with to verify that we're running out of policy slots.

-- 
Jens Axboe
