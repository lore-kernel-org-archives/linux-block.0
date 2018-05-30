Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
 linux-block@vger.kernel.org, bgurney@redhat.com,
 Hannes Reinecke <hare@suse.de>, Colin Ian King <colin.king@canonical.com>
References: <20180525211432.20359-1-jmoyer@redhat.com>
 <9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
 <x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
 <a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
 <20180530084928.GB29413@infradead.org>
 <71ad1d2e-b4cc-a36d-22ea-86574c76370c@kernel.dk>
 <x496035mbcy.fsf@segfault.boston.devel.redhat.com>
 <191bbfcd-68f3-b93f-b29a-db72331010b6@kernel.dk>
 <x49sh69kuyw.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <368b2fef-7067-2e5c-8196-0d49aac61a0b@kernel.dk>
Date: Wed, 30 May 2018 09:52:58 -0600
MIME-Version: 1.0
In-Reply-To: <x49sh69kuyw.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/30/18 9:45 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 5/30/18 9:06 AM, Jeff Moyer wrote:
>>> Hi, Jens,
>>>
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 5/30/18 2:49 AM, Christoph Hellwig wrote:
>>>>> While I really don't want drivers to change the I/O schedule themselves
>>>>> we have a class of devices (zoned) that don't work at all with certain
>>>>> I/O schedulers.  The kernel not chosing something sane and requiring
>>>>> user workarounds is just silly.
>>>>
>>>> They work just fine for probing and reading purposes. There's absolutely
>>>> no reason why we can't handle these special snowflakes with a udev rule.
>>>
>>> udev rules aren't shipped with the kernel, so it makes it hard to keep
>>> them in sync.  In this instance, I'm not sure anyone made an effort to
>>> notify distributions that a udev rule was even necessary.  (Is there a
>>> way of notifying distributions about kernel changes that require new
>>> udev rules, other than emailing each list individually?)
>>>
>>> From a technical standpoint, I totally agree with you, Jens.  However, I
>>> think the user experience sucks.  4.15 worked by default, 4.16 doesn't.
>>> The result will be bug reports from users (to the drive vendors,
>>> distribution bugzillas, here, etc.).
>>
>> I would imagine that most folks get their updates from a distro of some
>> sort, in which case there's absolutely nothing stopping the distro from
>> shipping updated rules for the 4.16 kernel update.
> 
> The problem is distros have already shipped that kernel.  :)

Ship an update, then! I'm sure that most people would prefer a simple
rule update over a kernel update. And you have to do one of them, to
resolve this anyway.

>> But what's the regression? 4.15 had no zone write locking at all.
> 
> The zone write locking was done in the sd driver prior to 4.16.  See
> commit 39051dd85f287 ("scsi: sd: Remove zone write locking") for where
> it was removed.  That means these devices "just worked" with all I/O
> schedulers.

Gotcha, makes sense.

>>> Moving on, assuming your mind is made up...
>>>
>>> I'm not sure how much logic should go into the udev rule.  As mentioned,
>>> this limitation was introduced in 4.16, and Damien has plans to lift the
>>> restriction in future kernels.  Because distributions tend to cherry
>>> pick changes, making decisions on whether a feature exists based solely
>>> on kernel version is usually not a great thing.  My inclination would be
>>> to just always force deadline for host-managed SMR drives.  These drives
>>> aren't that popular, after all.  Any opinions on this?
>>
>> The problem is that it's tied to an IO scheduler, which ends up causing
>> issues like this, since users are free to select a different scheduler.
>> Then things break. Granted, in this case, some extraordinarily shitty
>> hardware even broke. That is on the hardware, not the kernel, that
>> kind of breakage should not occur.
> 
> If the firmware problem was widespread, I think we'd try to avoid it.  I
> have no reason to believe that is the case, though.
> 
> Damien made the argument that the user should be able to select an I/O
> scheduler that doesn't perform the write locking, because a well-behaved
> application could theoretically make use of it.  I think this is a weak
> argument, given that dm-zoned doesn't even support such a mode.

Sure, the user should be able to select whatever they want. Maybe they
are strictly using it through bsg or a similar interface, in which
case no scheduler or kernel support is really neeeded to drive it.

>> So now we're stuck with this temporary situation which needs a work-around.
>> I don't think it's a terrible idea to have a rule that just sets
>> deadline/mq-deadline for an SMR device regardless of what kernel it is
>> running on. It'll probably never be a bad default.
> 
> OK.  Barring future input to the contrary, I'll work to get updates into
> fedora, at least.  I've CC'd Colin and Hannes.  I'm not sure who else to
> include.
> 
> FYI, below is the udev rule Damien had provided to Bryan.  I'm not sure
> about the KERNEL=="sd[a-z]" bit, that may need modification.  Note: I'm
> no udev expert.

Rule looks fine to me, but I'm also no udev expert.

-- 
Jens Axboe
