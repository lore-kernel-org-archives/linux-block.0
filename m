Return-Path: <prvs=63920ef73=Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: "tj@kernel.org" <tj@kernel.org>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "maxg@mellanox.com" <maxg@mellanox.com>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180410135541.GA22340@ming.t460p>
 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
 <20180410143007.GB22340@ming.t460p>
 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
 <20180410152553.GC22340@ming.t460p>
 <20180410153031.GO3126663@devbig577.frc2.facebook.com>
 <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <39a55c61-ea42-4131-0ed4-cfd357e133ce@wdc.com>
Date: Wed, 18 Apr 2018 09:34:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180410215456.GD793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 04/10/18 14:54, tj@kernel.org wrote:
> On Tue, Apr 10, 2018 at 09:46:23PM +0000, Bart Van Assche wrote:
>> On Tue, 2018-04-10 at 14:33 -0700, tj@kernel.org wrote:
>>> +       else
>>> +               rq->missed_completion = true;
>>
>> In this patch I found code that sets rq->missed_completion but no code that
>> clears it. Did I perhaps miss something?
> 
> Ah, yeah, I was moving it out of add_timer but forgot to actully add
> it to the issue path.  Fixed patch below.
> 
> BTW, no matter what we do w/ the request handover between normal and
> timeout paths, we'd need something similar.  Otherwise, while we can
> reduce the window, we can't get rid of it.
> 
> [ ... ]

Hello Tejun,

This patch no longer applies cleanly on Jens' tree. Can you rebase and 
repost it?

Thanks,

Bart.
