Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: move CAP_SYS_ADMIN check in blkdev_roset()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <1508330318-19456-1-git-send-email-idryomov@gmail.com>
 <20171019001452.GQ21978@ZenIV.linux.org.uk>
 <CAOi1vP9w=kVm-yNQSw5Lt6svRHEhF69SCAJ4vjeT3AoDZPu-cQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fd7f6ce-6e5a-04e8-4ab7-12f0b4eb35e0@kernel.dk>
Date: Wed, 25 Oct 2017 11:25:33 -0700
MIME-Version: 1.0
In-Reply-To: <CAOi1vP9w=kVm-yNQSw5Lt6svRHEhF69SCAJ4vjeT3AoDZPu-cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/2017 11:30 PM, Ilya Dryomov wrote:
> On Thu, Oct 19, 2017 at 2:14 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Wed, Oct 18, 2017 at 02:38:38PM +0200, Ilya Dryomov wrote:
>>> Check for CAP_SYS_ADMIN before calling into the driver, similar to
>>> blkdev_flushbuf().  This is safer and can spare a check in the driver.
>>>
>>> (Currently BLKROSET is overridden by md and rbd, rbd is missing the
>>> check.  md has the check, but it covers a lot more than BLKROSET.)
>>>
>>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>>> ---
>>> Al, this appears to go back to your "[PATCH] block ioctl cleanup",
>>> history commit c6973580141c.  2002 was a long time ago, but still ;)
>>> Was there a reason you made BLKFLSBUF check for CAP_SYS_ADMIN before
>>> ->ioctl() and BLKROSET after?
>>
>> It was a long time ago, indeed...  The funny part is, at the time
>> there had been no ->ioctl() instances with unusual BLKROSET handling
>> left; I really don't remember what had left to the override for
>> those remaining and (assuming it hadn't been a plain and simple braino)
>> the reasons for leaving the check to drivers that might eventually
>> want to add such overrides would be in whatever discussion that
>> had lead to leaving that override...
>>
>> There was a *lot* of patch series (semi)manual reordering/rebasing, so
>> it might have easily been braindamage on conflict resolution during
>> rebase.
>>
>> gendisk work had been literally hundreds of patches all over the
>> drivers/* over the summer and autumn of 2002; I have bits and pieces of
>> email archives from back then, but quick grep doesn't catch any
>> discussions along those lines and they are incomplete ;-/
>>
>> Anyway,
>>         a) I don't see any reason for drivers to relax the checks on
>> BLKROSET and rbd lacking those is almost certainly a bug
>>         b) Acked-by: Al Viro <viro@zeniv.linux.org.uk>
>>         c) I can push it through vfs tree, but it would probably make
>> more sense block one.
> 
> Jens, can you pick this up for 4.15?

Done, thanks.

-- 
Jens Axboe
