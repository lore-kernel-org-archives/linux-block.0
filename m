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
 <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
 <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
Date: Tue, 10 Jul 2018 12:51:55 -0600
MIME-Version: 1.0
In-Reply-To: <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/10/18 12:49 PM, Bart Van Assche wrote:
> On Tue, 2018-07-10 at 12:45 -0600, Jens Axboe wrote:
>> The difference between the job file and the
>> workload run can be huge. Consider something really basic:
>>
>> [randwrites]
>> bs=4k
>> rw=randwrite
>>
>> which would be 100% random 4k writes. If I run this on a zoned device,
>> then that'd turn into 100% sequential writes.
> 
> That's not correct. The ZBD code in the github pull request serializes writes
> per zone, not globally.

That's a totally minor detail. If all my random writes fall within a single
zone, then they'd be 100% sequential. For N open zones, you'd be 100%
sequential within the zone. The point is that the workload as defined and
the workload as run are two totally different things, and THAT is the
problem.

-- 
Jens Axboe
