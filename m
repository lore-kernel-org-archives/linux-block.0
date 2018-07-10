Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] null_blk: zone support
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "mb@lightnvm.io"
 <mb@lightnvm.io>, "loberman@redhat.com" <loberman@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
 <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
 <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
Date: Tue, 10 Jul 2018 12:45:47 -0600
MIME-Version: 1.0
In-Reply-To: <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/10/18 10:47 AM, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 08:46 -0600, Jens Axboe wrote:
>> On 7/9/18 6:05 PM, Bart Van Assche wrote:
>>> On Mon, 2018-07-09 at 10:34 -0600, Jens Axboe wrote:
>>>> In the spirit of making some progress on this, I just don't like how
>>>> it's done. For example, it should not be necessary to adjust what
>>>> comes out of the block generator, instead the block generator should
>>>> be told to do what we need on zbc. This is a key concept. The workload
>>>> should be defined as such that it works for zoned devices.
>>>
>>> How would you like to see block generation work? I don't see an
>>> alternative for random I/O other starting from the output of a random
>>> generator and translating that output into something that is
>>> appropriate for a zoned block device. Random reads must happen below
>>> the zone pointer if fio is configured to read below the zone pointer.
>>> Random writes must happen at the write pointer. The only way I see to
>>> implement such an I/O pattern is to start from the output of a random
>>> generator and to adjust the output of that random generator. However,
>>> I don't have a strong opinion whether adjusting the output of a random
>>> generator should happen by the caller of get_next_buflen() or inside
>>> get_next_buflen(). Or is your concern perhaps that the current
>>> approach interferes with fio job options like bs_unaligned?
>>
>> The main issue I have with that approach is that the core of fio is
>> generating the IO patterns, and then you are just changing them as you
>> see fit. This means that the workload definition and the resulting IO
>> operations are no longer matched up, since they now also depend on what
>> you are running on. If I take one workload and run it on a zoned drive,
>> and then run it on a non-zoned drive, I can't compare the results at
>> all. This is a showstopper.
>>
>> There should be no adjusting of the output, rather it should be possible
>> to write zoned friendly job definitions. It should be possible to run
>> the same job on a non-zoned drive, and vice versa, and the resulting IO
>> patterns must be the same.
>>
>> Fio already has some notion of zones. Maybe that could be extended to
>> hard zones, and some control of open zones, and patterns within those
>> zones?
> 
> Hello Jens,
> 
> How about adding a job option that makes it possible to use the zoned
> block device (ZBD) I/O pattern on non-ZBD devices, requiring that the
> zone size is set explicitly for non-ZBD devices and maintaining a write
> pointer not only when performing I/O to a ZBD device but also if a
> ZBD-style I/O pattern is applied to a non-ZBD disk? This should allow to
> apply exactly the same workload to a non-ZBD disk as to a ZBD disk.

It just doesn't make any sense to me. The source of truth is the
generator of the IO, which does exactly what it is told by the job
definition. You're proposing to mangle that somehow, to fit some
restrictions that the underlying device has. That very concept is
foreign, and adding an option to be able to do the same on some other
device is misleading. The difference between the job file and the
workload run can be huge. Consider something really basic:

[randwrites]
bs=4k
rw=randwrite

which would be 100% random 4k writes. If I run this on a zoned device,
then that'd turn into 100% sequential writes. That makes no sense at
all. And if I run it on a different devices, I'd get 100% random writes.
Except if I set some magic option. Sorry, but that concept is just too
ugly to live, it makes zero sense. Put down your zoned hat for a bit and
think about it.

> What I derived from the fio source code is as follows (please correct me
> if I got anything wrong):
> * The purpose of the zonesize, zonerange and zoneskip job options is to
>   limit the I/O range to a single zone with size "zonesize". The I/O
>   pattern for zoned block devices is different: I/O happens in multiple
>   zones simultaneously. The number of zones to which I/O happens is
>   called the number of open zones.

The only difference is that fio currently only has one zone active. When
it finishes one, it goes to the next. See my above suggestion on adding
the notion of open zones, which would extend this to more than 1.

> * The purpose of the random_distribution=zoned{_abs} job option is to
>   allow the user to skew a uniform random distribution. This is another
>   workload pattern than the typical pattern for ZBD drives.

Fio's zones were never intended to be for zoned devices. Don't get hung
up on current use cases, think about what kind of definitions would make
sense for zoned devices.

-- 
Jens Axboe
