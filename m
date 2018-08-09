Return-Path: <axboe@kernel.dk>
Subject: Re: Zoned block device support for fio
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
 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
 <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
 <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
 <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b9e3dd53-4b0d-3d95-ee28-aa4c1dc9b8d7@kernel.dk>
Date: Thu, 9 Aug 2018 15:03:06 -0600
MIME-Version: 1.0
In-Reply-To: <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 8/9/18 2:51 PM, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 12:51 -0600, Jens Axboe wrote:
>> On 7/10/18 12:49 PM, Bart Van Assche wrote:
>>> On Tue, 2018-07-10 at 12:45 -0600, Jens Axboe wrote:
>>>> The difference between the job file and the
>>>> workload run can be huge. Consider something really basic:
>>>>
>>>> [randwrites]
>>>> bs=4k
>>>> rw=randwrite
>>>>
>>>> which would be 100% random 4k writes. If I run this on a zoned device,
>>>> then that'd turn into 100% sequential writes.
>>>
>>> That's not correct. The ZBD code in the github pull request serializes writes
>>> per zone, not globally.
>>
>> That's a totally minor detail. If all my random writes fall within a single
>> zone, then they'd be 100% sequential. For N open zones, you'd be 100%
>> sequential within the zone. The point is that the workload as defined and
>> the workload as run are two totally different things, and THAT is the
>> problem.
> 
> Hello Jens,
> 
> What you proposed in a previous e-mail, namely to use the existing fio zone
> concept for zoned block devices sounds interesting to me. This is something I
> will definitely look further into. This will help to make a given workload
> that is suited for zoned block devices to behave (almost) identical when run
> against a regular block device. Since fio users expect that no zones are
> reset before e.g. a random write test is started, there will always be a small
> difference in behavior between a workload run against a zoned block device and
> a workload run against a regular device if some zones already contain data.
> 
> It's not clear to me how close you want the behavior of fio to be for zoned
> and regular block devices. Do you e.g. want me to introduce a new I/O pattern
> (--rw=...) that causes fio to write sequentially inside a zone and for which
> zones are selected randomly? I don't see any other approach that allows to
> make sure that the same workload definition behaves identically against zoned
> and regular block devices.

Yes exactly. Basically come up with something that just maps fio zones on
top of SMR zones. Then come up with something that allows you to have
sequential writes IO within a zone, and something that allows you to decide
how many zones to use, when to skip between zones, etc.

-- 
Jens Axboe
