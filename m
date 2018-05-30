Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,  Damien.LeMoal@wdc.com,  linux-block@vger.kernel.org,  bgurney@redhat.com
Subject: Re: [PATCH 0/2][RFC] block: default to deadline for SMR devices
References: <20180525211432.20359-1-jmoyer@redhat.com>
	<9756f816-cea7-52cc-e616-54cd7b7d8c75@kernel.dk>
	<x49tvqvz8eb.fsf@segfault.boston.devel.redhat.com>
	<a0bdfb0c-8ed3-12ac-e11b-6204fe3bb665@kernel.dk>
	<20180530084928.GB29413@infradead.org>
	<71ad1d2e-b4cc-a36d-22ea-86574c76370c@kernel.dk>
Date: Wed, 30 May 2018 11:06:37 -0400
In-Reply-To: <71ad1d2e-b4cc-a36d-22ea-86574c76370c@kernel.dk> (Jens Axboe's
	message of "Wed, 30 May 2018 08:22:40 -0600")
Message-ID: <x496035mbcy.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Hi, Jens,

Jens Axboe <axboe@kernel.dk> writes:

> On 5/30/18 2:49 AM, Christoph Hellwig wrote:
>> While I really don't want drivers to change the I/O schedule themselves
>> we have a class of devices (zoned) that don't work at all with certain
>> I/O schedulers.  The kernel not chosing something sane and requiring
>> user workarounds is just silly.
>
> They work just fine for probing and reading purposes. There's absolutely
> no reason why we can't handle these special snowflakes with a udev rule.

udev rules aren't shipped with the kernel, so it makes it hard to keep
them in sync.  In this instance, I'm not sure anyone made an effort to
notify distributions that a udev rule was even necessary.  (Is there a
way of notifying distributions about kernel changes that require new
udev rules, other than emailing each list individually?)

>From a technical standpoint, I totally agree with you, Jens.  However, I
think the user experience sucks.  4.15 worked by default, 4.16 doesn't.
The result will be bug reports from users (to the drive vendors,
distribution bugzillas, here, etc.).

Moving on, assuming your mind is made up...

I'm not sure how much logic should go into the udev rule.  As mentioned,
this limitation was introduced in 4.16, and Damien has plans to lift the
restriction in future kernels.  Because distributions tend to cherry
pick changes, making decisions on whether a feature exists based solely
on kernel version is usually not a great thing.  My inclination would be
to just always force deadline for host-managed SMR drives.  These drives
aren't that popular, after all.  Any opinions on this?

Thanks!
Jeff
