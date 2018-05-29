Return-Path: <bgurney@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
References: <20180525211432.20359-1-jmoyer@redhat.com> <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com> <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
From: Bryan Gurney <bgurney@redhat.com>
Date: Tue, 29 May 2018 08:14:20 -0400
Message-ID: <CAHhmqcQfVM28jkbtFHGpYHVRkQCejbyycja-JbNQ_dMRkVj86w@mail.gmail.com>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Moyer <jmoyer@redhat.com>, Damien.LeMoal@wdc.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, May 26, 2018 at 12:01 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 5/25/18 4:18 PM, Jeff Moyer wrote:
>> Hi, Jens,
>>
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> On 5/25/18 3:14 PM, Jeff Moyer wrote:
>>>> Bryan Gurney reported I/O errors when using dm-zoned with a host-managed
>>>> SMR device.  It turns out he was using CFQ, which is the default.
>>>> Unfortunately, as of v4.16, only the deadline schedulers work well with
>>>> host-managed SMR devices.  This series aatempts to switch the elevator
>>>> to deadline for those devices.
>>>>
>>>> NOTE: I'm not super happy with setting up one iosched and then
>>>> immediately tearing it down.  I'm open to suggestions on better ways
>>>> to accomplish this goal.
>>>
>>> Let's please not do this, a few years ago I finally managed to kill
>>> drivers changing the scheduler manually. Why can't this go into a
>>> udev (or similar) rule? That's where it belongs, imho.
>>
>> We could do that.  The downside is that distros will have to pick up
>> udev rules, which they haven't done yet, and the udev rules will have to
>> be kernel version dependent.  And then later, when this restriction is
>> lifted, we'll have to update the udev rules.  That also sounds awful to
>> me.
>
> They only have to be feature dependent, which isn't that hard. And if I
> had to pick between a kernel upgrade and a udev rule package update, the
> choice is pretty clear.
>
>> I understand why you don't like this patch set, but I happen to think
>> the alternative is worse.  FYI, in Bryan's case, his system actually got
>> bricked (likely due to buggy firmware).
>
> I disagree, I think the rule approach is much easier. If the wrong write
> location bricked the drive, then I think that user has much larger
> issues... That seems like a trivial issue that should have been caught
> in basic testing, I would not trust that drive with any data if it
> bricks that easily.

To set the record straight, it wasn't the drive that "bricked"; it was
the system motherboard BIOS.

I set up a test to copy some data onto an SMR drive over a weekend
(one of two on the system), and when I came back on Monday morning, I
was greeted with "kernel BUG at block/bio.c:1720!" (which would be
"BUG_ON(atomic_read(&bio->__bi_remaining <= 0);").

After taking a picture of the kernel bug screen, I power cycled the
system, and it just sat there, with fans running, but no power light,
and no other activity (not even a blinking network activity light).

I transplanted the drive and HBA to another test system with identical
hardware, and saw that the SMR drives were running properly.  I
decided to reset the test, thinking, "That _can't_ happen again..."

It happened again.  Same kernel bug, same "fans running, but power
light is off" behavior.  I had two catatonic Xeon workstations in
front of me, which were thankfully both revived with the help of a
chip programmer writing the binary file of the latest BIOS update.

After reaching out to Damien regarding the large amount of "Aborted
command" senses that I was seeing prior to the kernel bug, he
recommended using the "deadline" scheduler for kernel 4.16 and
greater.


Thanks,

Bryan
