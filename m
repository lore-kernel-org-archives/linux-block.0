Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Damien.LeMoal@wdc.com, linux-block@vger.kernel.org, bgurney@redhat.com
References: <20180525211432.20359-1-jmoyer@redhat.com>
 <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
Date: Fri, 25 May 2018 22:01:42 -0600
MIME-Version: 1.0
In-Reply-To: <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/25/18 4:18 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 5/25/18 3:14 PM, Jeff Moyer wrote:
>>> Bryan Gurney reported I/O errors when using dm-zoned with a host-managed
>>> SMR device.  It turns out he was using CFQ, which is the default.
>>> Unfortunately, as of v4.16, only the deadline schedulers work well with
>>> host-managed SMR devices.  This series aatempts to switch the elevator
>>> to deadline for those devices.
>>>
>>> NOTE: I'm not super happy with setting up one iosched and then
>>> immediately tearing it down.  I'm open to suggestions on better ways
>>> to accomplish this goal.
>>
>> Let's please not do this, a few years ago I finally managed to kill
>> drivers changing the scheduler manually. Why can't this go into a
>> udev (or similar) rule? That's where it belongs, imho.
> 
> We could do that.  The downside is that distros will have to pick up
> udev rules, which they haven't done yet, and the udev rules will have to
> be kernel version dependent.  And then later, when this restriction is
> lifted, we'll have to update the udev rules.  That also sounds awful to
> me.

They only have to be feature dependent, which isn't that hard. And if I
had to pick between a kernel upgrade and a udev rule package update, the
choice is pretty clear.

> I understand why you don't like this patch set, but I happen to think
> the alternative is worse.  FYI, in Bryan's case, his system actually got
> bricked (likely due to buggy firmware).

I disagree, I think the rule approach is much easier. If the wrong write
location bricked the drive, then I think that user has much larger
issues... That seems like a trivial issue that should have been caught
in basic testing, I would not trust that drive with any data if it
bricks that easily.

-- 
Jens Axboe
