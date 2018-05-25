Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien.LeMoal@wdc.com,  linux-block@vger.kernel.org,  bgurney@redhat.com
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
References: <20180525211432.20359-1-jmoyer@redhat.com>
	<9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
Date: Fri, 25 May 2018 18:18:36 -0400
In-Reply-To: <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk> (Jens Axboe's
	message of "Fri, 25 May 2018 16:04:09 -0600")
Message-ID: <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Hi, Jens,

Jens Axboe <axboe@kernel.dk> writes:

> On 5/25/18 3:14 PM, Jeff Moyer wrote:
>> Bryan Gurney reported I/O errors when using dm-zoned with a host-managed
>> SMR device.  It turns out he was using CFQ, which is the default.
>> Unfortunately, as of v4.16, only the deadline schedulers work well with
>> host-managed SMR devices.  This series aatempts to switch the elevator
>> to deadline for those devices.
>> 
>> NOTE: I'm not super happy with setting up one iosched and then
>> immediately tearing it down.  I'm open to suggestions on better ways
>> to accomplish this goal.
>
> Let's please not do this, a few years ago I finally managed to kill
> drivers changing the scheduler manually. Why can't this go into a
> udev (or similar) rule? That's where it belongs, imho.

We could do that.  The downside is that distros will have to pick up
udev rules, which they haven't done yet, and the udev rules will have to
be kernel version dependent.  And then later, when this restriction is
lifted, we'll have to update the udev rules.  That also sounds awful to
me.

I understand why you don't like this patch set, but I happen to think
the alternative is worse.  FYI, in Bryan's case, his system actually got
bricked (likely due to buggy firmware).

Ultimately, it's your call of course.

Cheers,
Jeff
