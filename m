Return-Path: <bgurney@redhat.com>
MIME-Version: 1.0
In-Reply-To: <122bc1d9-a074-7282-6812-aba26f4868f4@wdc.com>
References: <20180525211432.20359-1-jmoyer@redhat.com> <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com> <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
 <122bc1d9-a074-7282-6812-aba26f4868f4@wdc.com>
From: Bryan Gurney <bgurney@redhat.com>
Date: Wed, 30 May 2018 09:45:51 -0400
Message-ID: <CAHhmqcQC8JZh_kL6DMEcwQu69s0havYsJogUgzn6w0pFPZHTbw@mail.gmail.com>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, May 30, 2018 at 2:22 AM, Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> Jens,
>
> On 5/26/18 13:01, Jens Axboe wrote:
>> On 5/25/18 4:18 PM, Jeff Moyer wrote:
>>> Hi, Jens,
>>>
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 5/25/18 3:14 PM, Jeff Moyer wrote:
>>>>> Bryan Gurney reported I/O errors when using dm-zoned with a host-managed
>>>>> SMR device.  It turns out he was using CFQ, which is the default.
>>>>> Unfortunately, as of v4.16, only the deadline schedulers work well with
>>>>> host-managed SMR devices.  This series aatempts to switch the elevator
>>>>> to deadline for those devices.
>>>>>
>>>>> NOTE: I'm not super happy with setting up one iosched and then
>>>>> immediately tearing it down.  I'm open to suggestions on better ways
>>>>> to accomplish this goal.
>>>>
>>>> Let's please not do this, a few years ago I finally managed to kill
>>>> drivers changing the scheduler manually. Why can't this go into a
>>>> udev (or similar) rule? That's where it belongs, imho.
>>>
>>> We could do that.  The downside is that distros will have to pick up
>>> udev rules, which they haven't done yet, and the udev rules will have to
>>> be kernel version dependent.  And then later, when this restriction is
>>> lifted, we'll have to update the udev rules.  That also sounds awful to
>>> me.
>>
>> They only have to be feature dependent, which isn't that hard. And if I
>> had to pick between a kernel upgrade and a udev rule package update, the
>> choice is pretty clear.
>
> Currently, a queue elevator is first initialized with a call to
> elevator_init() from either blk_mq_init_allocated_queue() or
> blk_init_allocated_queue(). When these are called, the device has not
> yet been probed and no information is available. Do you think it is
> reasonable to delay the default elevator bring-up to after some
> information about the device is obtained ?
>
> That would necessitate splitting elevator_init() into a generic elevator
> initialization function setting up the elevator related fields of the
> request queue and a second part setting up the default elevator (e.g.
> elevator_set_default()). Doing so, the function elevator_set_default()
> could be called later in the device initialization sequence, after
> information from the device has been obtained. It would make choosing a
> sane default elevator much cleaner.
>
> Granted, that is in effect very similar to what Jeff's patches do. But
> in a sense, the current code already consider some of the device
> characteristics when setting the default elevator. That is, if the
> device is mq or not. Would it be a stretch to add "is_zoned" as another
> characteristic that is looked at ?
>
> On another note, I noticed that the only two callers of elevator_init()
> are blk_mq_init_allocated_queue() and blk_init_allocated_queue(). Both
> call elevator_init() with a NULL name. I wonder the usefulness of that
> argument. Furthermore, elevator_init() is also exported but I do not see
> any external module user. Is this in purpose or is it the remnant of
> older use of it ? I can send a patch cleaning that up if you feel that
> needs so cleanup.
>
>>
>>> I understand why you don't like this patch set, but I happen to think
>>> the alternative is worse.  FYI, in Bryan's case, his system actually got
>>> bricked (likely due to buggy firmware).
>>
>> I disagree, I think the rule approach is much easier. If the wrong write
>> location bricked the drive, then I think that user has much larger
>> issues... That seems like a trivial issue that should have been caught
>> in basic testing, I would not trust that drive with any data if it
>> bricks that easily.
>
> I think that the bug in this particular case was with the BIOS (probably
> UEFI), not the disk. Disks only answer to trivial requests when probed
> on boot, unless the BIOS is too smart for its own good and doing very
> weird things. Different issue anyway, not related to the kernel.

Actually, the BIOS boot mode was configured to "Legacy" mode (i.e.:
non-UEFI) at the time of the bricking.  I'm pretty confident of this,
because after the BIOS reflash, I can see a different rendering mode
in the GRUB screen of Fedora 28, and when I checked back in the BIOS
setup utility, I saw that the default for the new BIOS image was UEFI.

On the test systems in general, I prefer to use legacy BIOS if I don't
need UEFI.  I'm not sure if this means that I walked into a latent
BIOS bug, though.


Thanks,

Bryan
