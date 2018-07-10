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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
Date: Tue, 10 Jul 2018 08:46:41 -0600
MIME-Version: 1.0
In-Reply-To: <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/9/18 6:05 PM, Bart Van Assche wrote:
> On Mon, 2018-07-09 at 10:34 -0600, Jens Axboe wrote:
>> On 7/9/18 1:54 AM, Matias Bjørling wrote:
>>> For fio, you can use the zone support here:
>>>
>>>    https://github.com/bvanassche/fio
>>>
>>> It is in the process of being upstreamed.
>>
>> In the spirit of making some progress on this, I just don't like how
>> it's done. For example, it should not be necessary to adjust what
>> comes out of the block generator, instead the block generator should
>> be told to do what we need on zbc. This is a key concept. The workload
>> should be defined as such that it works for zoned devices.
> 
> Hello Jens,
> 
> How would you like to see block generation work? I don't see an
> alternative for random I/O other starting from the output of a random
> generator and translating that output into something that is
> appropriate for a zoned block device. Random reads must happen below
> the zone pointer if fio is configured to read below the zone pointer.
> Random writes must happen at the write pointer. The only way I see to
> implement such an I/O pattern is to start from the output of a random
> generator and to adjust the output of that random generator. However,
> I don't have a strong opinion whether adjusting the output of a random
> generator should happen by the caller of get_next_buflen() or inside
> get_next_buflen(). Or is your concern perhaps that the current
> approach interferes with fio job options like bs_unaligned?

The main issue I have with that approach is that the core of fio is
generating the IO patterns, and then you are just changing them as you
see fit. This means that the workload definition and the resulting IO
operations are no longer matched up, since they now also depend on what
you are running on. If I take one workload and run it on a zoned drive,
and then run it on a non-zoned drive, I can't compare the results at
all. This is a showstopper.

There should be no adjusting of the output, rather it should be possible
to write zoned friendly job definitions. It should be possible to run
the same job on a non-zoned drive, and vice versa, and the resulting IO
patterns must be the same.

Fio already has some notion of zones. Maybe that could be extended to
hard zones, and some control of open zones, and patterns within those
zones?

-- 
Jens Axboe
