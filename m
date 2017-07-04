Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: NVMe induced NULL deref in bt_iter()
To: Ming Lei <ming.lei@redhat.com>
Cc: Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <20170703093951.GA28651@ming.t460p>
 <bc6e2ecf-031b-45c0-8fbb-98c12c790ee4@grimberg.me>
 <20170703120348.GB28651@ming.t460p>
 <92224329-0933-4e80-94d6-2ba3c88f3f3e@grimberg.me>
 <20170704080818.GA29053@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <767a5187-29fe-246a-d06f-ed71553f9f91@grimberg.me>
Date: Tue, 4 Jul 2017 12:14:12 +0300
MIME-Version: 1.0
In-Reply-To: <20170704080818.GA29053@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 04/07/17 11:08, Ming Lei wrote:
> On Tue, Jul 04, 2017 at 10:56:23AM +0300, Sagi Grimberg wrote:
>>
>>> There are at least one case in which we have to use stop queues:
>>>
>>> 	- when QUEUE_BUSY(now it becomes BLK_STS_RESOURCE) happens, some drivers
>>> 	need to stop queues for avoiding to hurt CPU, such as virtio-blk, ...
>>
>> Why isn't virtio_blk using blk_mq_delay_run_hw_queue like scsi does?
> 
> IMO it shouldn't be easy to figure out one perfect delay time,

It doesn't needs to be perfect, just something that is sufficient
to not hog the cpu and won't have noticeable effects...

> and it should have been self-adaptive.

But IMO always start the queues on *every* completion is a waste... why
iterating on all the hw queues on each completion?

> Also I think it might be possible to move this kind of stop action into
> blk-mq core code, and not let drivers touch stop state. Finally we
> may kill all stopping in drivers.

That's a good idea!
